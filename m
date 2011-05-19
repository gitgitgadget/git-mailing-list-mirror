From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/8] revert: Improve error handling by cascading errors
 upwards
Date: Thu, 19 May 2011 13:03:47 -0500
Message-ID: <20110519180314.GA26248@elie>
References: <1305100822-20470-1-git-send-email-artagnon@gmail.com>
 <1305100822-20470-2-git-send-email-artagnon@gmail.com>
 <20110511095949.GA2676@elie>
 <20110519091831.GA28723@ramkum.desktop.amazon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 19 20:04:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN7Zr-0001t8-25
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 20:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933701Ab1ESSD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 14:03:58 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62057 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933642Ab1ESSD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 14:03:57 -0400
Received: by iwn34 with SMTP id 34so2396749iwn.19
        for <git@vger.kernel.org>; Thu, 19 May 2011 11:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=3rtDRG4rNvijv9Jpq36I3px/+dsv4rzSflCt1Covzec=;
        b=BuerUiBFqAyuVcb12ZbFbW+B8wI97LYSYEKyXAwduMgD9i/E9Xd+5zA7HuHaDaqC9m
         MMIrq1UfrF5NPfCU876qdhJu7Kzqj+bMeY2/D/m15xLpAL7KqexYONRki6QtuTM29YsF
         e1BpukeSyQjSUb8XEEWsiyx0vEwHAgLjOMQ7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Tbaui4uwjXLp0kQ6ri3CFq66kQj95nqFigsfosC61ysSROrLMNiA2NOvCVu/ELQVFd
         XfgMdYtMNcys+nLkizC5iv515XFtIyKQ+9IphKFrRtO7b/hlAWiu67gDA4bR9H/ObJyx
         A9qtQ3ldvof/u+D+r8mpW3UjTAWEp+QDPZ9kc=
Received: by 10.231.187.232 with SMTP id cx40mr2642325ibb.73.1305828236721;
        Thu, 19 May 2011 11:03:56 -0700 (PDT)
Received: from elie (adsl-69-209-63-133.dsl.chcgil.sbcglobal.net [69.209.63.133])
        by mx.google.com with ESMTPS id 4sm1182932ibc.15.2011.05.19.11.03.53
        (version=SSLv3 cipher=OTHER);
        Thu, 19 May 2011 11:03:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110519091831.GA28723@ramkum.desktop.amazon.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173985>

Ramkumar Ramachandra wrote:

> I'm preparing a large series dedicated to solving error-handling
> issues before getting to the sequencer series.  I plan to post some
> quick-and-dirty diffs of various things and ask for feedback.

Sounds good.  I wonder if there's a good way to test this (maybe I'll
try making an XS module so Git.pm can take advantage of similar
changes).

> Jonathan Nieder writes:
>> Ramkumar Ramachandra wrote:

>>> @@ -418,19 +434,19 @@ static int do_pick_commit(void)
>>>  		struct commit_list *p;
>>>  
>>>  		if (!mainline)
>>> -			die(_("Commit %s is a merge but no -m option was given."),
>>> -			    sha1_to_hex(commit->object.sha1));
>>> +			return error(_("Commit %s is a merge but no -m option was given."),
>>> +				sha1_to_hex(commit->object.sha1));
>>
>> This is not a conflict but an error in usage.
[...]
> For this part, I think the correct way to handle the usage error is to
> print a message like this:
>
>     usage: cherry-pick: Commit b8bf32 is a merge but no -m option was given.
>
> And exit with status 129. Is this acceptable?

On second thought, status 128 seems appropriate --- the caller made a
mistake, but it's more analagous to merging with a dirty index than
(i.e., the command was not able to be fulfilled as desired) than to
misspelling a command-line option (i.e., broken script).  I suppose
treating it as an error (as in your "return error") would work, and
the caller can transform -1 to exit(128).

Sorry for the thinko.
