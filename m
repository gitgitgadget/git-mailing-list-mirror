From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] rm: delete .gitmodules entry of submodules removed
 from the work tree
Date: Wed, 10 Apr 2013 16:30:58 -0700
Message-ID: <20130410233058.GI27070@google.com>
References: <5165E1CC.7090004@web.de>
 <CALkWK0mzbgFP7JnCP7=NCA1guGg8ayF-mn7WdJEZyYX5hgePFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Phil Hord <phil.hord@gmail.com>,
	"W. Trevor King" <wking@tremily.us>,
	Peter Collingbourne <peter@pcc.me.uk>,
	John Keeping <john@keeping.me.uk>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 11 01:31:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ4Tu-0004zR-0T
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 01:31:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934790Ab3DJXbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 19:31:05 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:48189 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761256Ab3DJXbD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 19:31:03 -0400
Received: by mail-pa0-f52.google.com with SMTP id fb10so571944pad.11
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 16:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=xr1BBLvjoFx1FBAGDDOLd2TmJd0h/jEqQ9BcnG6Qzm8=;
        b=rr1dDaGmXBryAfOr1ZQdh8r7OkUPwYFS41AUZvjUPuOuZMC5PNraV9aI7k3x0qTCd6
         Vv5jKUrATv+FFEIHatlE6oVN1F9Uh2TwxTbsvz9wXA4rprDeHqYpIrUjlBXXHgY+Fz18
         zIHL3Z98xHjRTyPB5A1Gldf5/DF1/799bR6+I3CWNmvcBC23HC+ip1xje0WfGU1wUYRq
         5hTSQoCj4DCfhixHir0OUVZCQxsHyHeTipWCvWAxswcWwU3sYievaH6nl79Hyvl/6Iql
         EUKI0KTOrmKfCZJNIoQMnaLETxXoLXtCUwlUWN6Z7yWhowkYHQ7iVsLsno5TCPcTsddX
         02iA==
X-Received: by 10.68.102.2 with SMTP id fk2mr5621501pbb.168.1365636663110;
        Wed, 10 Apr 2013 16:31:03 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id u9sm2200293paf.22.2013.04.10.16.31.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Apr 2013 16:31:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0mzbgFP7JnCP7=NCA1guGg8ayF-mn7WdJEZyYX5hgePFw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220795>

Hi,

Thanks for looking it over.

Ramkumar Ramachandra wrote:

> - Why are you hard-coding ".gitmodules" instead of using a simple #define?

Advantage of ".gitmodules": it's obvious what it means.
Advantage of DOT_GITMODULES: protection against spelling errors.

Git has a lot of use of both styles of string constant, for better or
worse.  Consistency means following what the surrounding code does,
and making changes if appropriate in a separate patch.

> - Why are you returning -1, instead of an error() with a message?

I think the idea is that remove_path_from_gitmodules() is idempotent:
if that path isn't listed in gitmodules, that's considered fine and
.gitmodules is left alone, instead of making a user that tries to
first remove a .gitmodules file and then all submodules suffer.

Perhaps a return value of '0 if gitmodules unmodified, 1 if modified'
would make it clearer that this isn't an error condition.

[...]
>> +       path_option = unsorted_string_list_lookup(&config_name_for_path, path);
>> +       if (!path_option) {
>> +               warning(_("Could not find section in .gitmodules where path=%s"), path);
>> +               return -1;
>> +       }
>
> Repetition from your mv series.  Why copy-paste, when you can factor
> it out into a function?

Do you mean that update_path_in_gitmodules should treat newpath ==
NULL as a cue to remove that entry, or something similar?

> Why are you calling warning() and then returning -1?

Sure, "return warning(...)" is a good shortcut.

> warning() not work?)  How is it a warning if you just stop all
> processing and return?

Probably it shouldn't warn in this case.

>> +       strbuf_addstr(&sect, "submodule.");
>> +       strbuf_addstr(&sect, path_option->util);
>
> What do you have against strbuf_addf()?

I think both addf and addstr are pretty clear.  The implementation of
addf is more complicated, which can be relevant in performance-critical
code (not here).

> Why is your variable named "sect"?  Did you mean "section"?

I think both "sect" and "section" are pretty clear.

[...]
>> +               /* Maybe the user already did that, don't error out here */
>> +               warning(_("Could not remove .gitmodules entry for %s"), path);
>> +               return -1;
>
> Maybe the user already did what?  What happens if she didn't do "it"
> and failure is due to some other cause?

git_config_rename_section_in_file() can fail for the following reasons:

 * invalid new section name (NULL is valid, so doesn't apply here)
 * could not lock config file
 * write error
 * could not commit config file

If the old section is missing, it doesn't even fail (it just
returns 0).  So I agree: this should be an error instead of a warning.

Hope that helps,
Jonathan
