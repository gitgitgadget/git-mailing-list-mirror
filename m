From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: implement `module_name` as a builtin helper
Date: Fri, 07 Aug 2015 14:14:17 -0700
Message-ID: <xmqqa8u2yf6e.fsf@gitster.dls.corp.google.com>
References: <CAGZ79kY=jQSjJUxkznkwwupo527-nT05P_bKXy=GO=E4QjC8tQ@mail.gmail.com>
	<1438808880-9080-1-git-send-email-sbeller@google.com>
	<55C3BA5C.3030404@web.de>
	<xmqqlhdmyhtt.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYtCgYRHuMcxNoi6f9+GYYYCq6aRTdvx4ZKELSuQErkVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 23:14:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNoyO-0007Db-D3
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 23:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946167AbbHGVOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2015 17:14:20 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:34680 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753773AbbHGVOU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2015 17:14:20 -0400
Received: by pdbfa8 with SMTP id fa8so9343007pdb.1
        for <git@vger.kernel.org>; Fri, 07 Aug 2015 14:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=4ZHfIh9TdUlZ/NCXKdp3w/lsa9f51RpQcQlaGriJUiY=;
        b=lMqfQpI+zWqy4TZlXA6htP8Cd8npIowtNXG0V/akwdXJQM5qeOqG39P69O7Kz3bhpk
         MrOPvf1jSd8jxlCrAzJ2na2RCyh07xppYzLiMUhBZ1A7Zr3fSpN3ojfAgyOPWtJPTO7q
         xs1uXJ1oUpIepq9FBxMaji+UI3MwCbBmeLXC4a57QydP1Svat8Jp/bsqWxrndvIipSBd
         K4WJXoP68vryjTrOQ3fGdfLD/YJgYyiIl0Ykcv4cKcL1Cq4+aM70zOg8R6PBFhHV+LFq
         NTXmIb3qFXe9p3QZWHGhQpImw0v6HTFJh5qoc/8/itkMVmPsEoFiJu3Vap2WPFMYsl/x
         /PMg==
X-Received: by 10.70.41.6 with SMTP id b6mr18762891pdl.89.1438982059651;
        Fri, 07 Aug 2015 14:14:19 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6597:23b2:a33a:2b5b])
        by smtp.gmail.com with ESMTPSA id hh3sm11146748pbc.8.2015.08.07.14.14.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 07 Aug 2015 14:14:17 -0700 (PDT)
In-Reply-To: <CAGZ79kYtCgYRHuMcxNoi6f9+GYYYCq6aRTdvx4ZKELSuQErkVQ@mail.gmail.com>
	(Stefan Beller's message of "Fri, 7 Aug 2015 13:49:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275490>

Stefan Beller <sbeller@google.com> writes:

> On Fri, Aug 7, 2015 at 1:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>>
>> This change...
>>
>>>> @@ -723,10 +733,8 @@ int fetch_populated_submodules(const struct argv_array *options,
>>>>              if (!S_ISGITLINK(ce->ce_mode))
>>>>                      continue;
>>>>
>>>> -            name = ce->name;
>>>> -            name_for_path = unsorted_string_list_lookup(&config_name_for_path, ce->name);
>>>> -            if (name_for_path)
>>>> -                    name = name_for_path->util;
>>>> +            name_for_path = submodule_name_for_path(ce->name);
>>>> +            name =  name_for_path ? name_for_path : ce->name;
>>
>> ... interacts with Heiko's cached submodule config work that seems
>> to have stalled.
>
> We can drop that hunk as it only uses the new method
> `submodule_name_for_path` but doesn't change functionality.
> So if you want to keep Heikos work, I'll just resend the patch
> without that hunk.

Does such a result even make sense?  Note that I wasn't talking
about textual conflict.

If we followed what you just said, that patch will try to directly
read the data in config_name_for_path string list, which is removed
by Heiko's series, if I am reading it right.

In the new world order with Heiko's series, the way you grab
submodule configuration data is to call submodule_from_path() or
submodule_from_name() and they allow you to read from .gitmodules
either in a commit (for historical state), the index, or from the
working tree.  Which should be much cleaner and goes in the right
direction in the longer term.

And the best part of the story is that your module_name would be
just calling submodule_from_path() and peeking into a field.

> 2) Come up with a good thread pool abstraction
>    (Started as "[RFC/PATCH 0/4] parallel fetch for submodules" )
>    This abstraction (if done right) will allow us to use it in different places
>    easily. I started it as part of "git fetch --recurse-submodules" because
>    it is submodule related and reasonably sized

I personally think this gives the most bang-for-buck.  Write that
and expose it as "git submodule for-each-parallel", which takes the
shell scriptlet that currently is the loop body of "while read mode
sha1 stage sm_path" in update and clone.  You will have immediate
and large payback.

And you do not even need module_list and module_name written in C in
order to do so.  Not that these two are not trivial to implement, but
the payoff from them is not as large as from for-each-parallel ;-)
