From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] receive-pack: crash when checking with non-exist HEAD
Date: Thu, 23 Jul 2015 10:49:39 -0700
Message-ID: <xmqqk2tqpxvw.fsf@gitster.dls.corp.google.com>
References: <CANYiYbE3Vy_gtFMKTMw1wHLDhU758nXaJnKaNy6WMNRz0fjUnw@mail.gmail.com>
	<xmqqr3o0q6k7.fsf@gitster.dls.corp.google.com>
	<20150723055817.GA26794@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 23 19:49:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIKcu-0004h5-Dx
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 19:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753571AbbGWRto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 13:49:44 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34410 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752915AbbGWRtn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 13:49:43 -0400
Received: by pacan13 with SMTP id an13so162933119pac.1
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 10:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Y02+Jibdzdxk7O7xPTU1rP850hYD28eHTEoQkY+SX4E=;
        b=txzY+RWazhsJ4LuPMvuNJ4NPwY0FM5hKMjvnx7rAwzhNwc+vG+wbOQepLVMqARsGTd
         oM3MnuqI2CgPeJLlaSU/6TOj3l5ppt/XXXbZXoui3bA3FWYm16LAM7SjbnkoAiPErngt
         fSvSobg8AuRA4nVapmowujVjlqljpCOwRzXA9jG8CN/TIx+qS+oPhtF7UuQmeO8bYQDK
         XSAoMDydpomb6wHomybxiJw48CYLCFd2UOFN4wHIPyWhDG5anDiYeyUYa4vE0KLDU/Ov
         FH2FL0VlqcHHmeiTt5cpMJLLWe3kDDp2Bp/CZFwJN6mO47GaOEhmV87Wl/cmVWoK5Egg
         5wvA==
X-Received: by 10.66.139.234 with SMTP id rb10mr21035344pab.118.1437673783152;
        Thu, 23 Jul 2015 10:49:43 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:156f:a37c:e915:d6df])
        by smtp.gmail.com with ESMTPSA id bu10sm10188774pac.36.2015.07.23.10.49.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 23 Jul 2015 10:49:40 -0700 (PDT)
In-Reply-To: <20150723055817.GA26794@peff.net> (Jeff King's message of "Wed,
	22 Jul 2015 22:58:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274514>

Jeff King <peff@peff.net> writes:

> On Wed, Jul 22, 2015 at 01:30:00PM -0700, Junio C Hamano wrote:
>
>> For example, in order to "git commit" from such a state to create
>> the root commit on that branch, existing unrelated branches whose
>> names collide with the branch must be removed, which would mean one
>> of two things, either (1) you end up losing many unrelated work, or
>> (2) the command refuses to work, not letting you to record the
>> commit.  Neither is satisfactory, but we seem to choose (2), which
>> is at least the safer of the two:
>> 
>>     $ git checkout master
>>     $ git checkout --orphan master/1
>>     $ git commit -m foo
>>     fatal: cannot lock ref 'HEAD': 'refs/heads/master' exists;
>>     cannot create 'refs/heads/master/1'
>
> Yeah, that seems sensible. I think the "way out" for the user here would
> presumably be:
>
>   git symbolic-ref HEAD refs/heads/something-else
>
> though of course they could also rename the other ref.

I would have expected you to say

    git checkout --orphan something-else

which should work and would be more intuitive ;-)

> Right. You'd have to teach the is_refname_available() check to always
> check what HEAD points to, and consider it as "taken", even if the ref
> itself doesn't exist. But what about other symbolic refs? The
> "refs/remotes/origin/HEAD" symref may point to
> "refs/remotes/origin/master" even though "refs/remotes/origin/master/1"
> exists. I doubt that will cause real problems in practice, but it points
> out that special cases like "the value of HEAD is magic and reserved"
> will later end up being insufficient as the code is extended.

Yes, we do not have a handy cache of all symrefs, and it is dubious
if this issue is grave enough to warrant adding one.

> I think I'd be willing to simply punt on the whole thing as being too
> rare to come up in practice.

I tend to agree.
