From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/PATCH] worktree: replace "checkout --to" with "worktree new"
Date: Wed, 1 Jul 2015 13:13:16 -0400
Message-ID: <CAPig+cRLpJK-C7MApH1vigZS=gmHNeo6RL3S2wXv4B-TFfnq4g@mail.gmail.com>
References: <1435640202-95945-1-git-send-email-sunshine@sunshineco.com>
	<xmqqr3orakex.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 19:13:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZALZa-0008DD-Tu
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 19:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534AbbGARNT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 13:13:19 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:36758 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753AbbGARNR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 13:13:17 -0400
Received: by ykdr198 with SMTP id r198so44999673ykd.3
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 10:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=N3YF7GL7U/kIlqamAo2AsJ4PAOKriPHg7Et/VTV9bwU=;
        b=U3/ktk4TuawGAB2Aphr+riJQatBdxgmpTvsZhqgILEMO1VVlv6H7x2gz47mD1SZmxG
         6O96imwXhb66BiZ/0ar8tT4UEienX49GP9ey7ge7IMNps6dtwZqqVIyLxPYmvneHBnL/
         IcSr0nWZhnd7Z4aQ9Kp5aYoBS0dUgo1RE8n7u8EkrPk9qe0058V1jGxa8LDJEENkWHKY
         mn4DvGSr/3tb/8quezJkTNtNMFaanwvtiXELsIyDnrMSh+nsNNqTkSfovE9reNjlr2RM
         8bpo6/8UtBKewRa5H7eCq2HPQeXYGtODbS+QHpiCT8PTtaWBLS8Mb74WqJKu3p2BelPG
         +DBQ==
X-Received: by 10.13.207.1 with SMTP id r1mr33828949ywd.166.1435770796097;
 Wed, 01 Jul 2015 10:13:16 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Wed, 1 Jul 2015 10:13:16 -0700 (PDT)
In-Reply-To: <xmqqr3orakex.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: tIdkqmR8mL4vFzM8lGSQGIi-ER0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273165>

On Wed, Jul 1, 2015 at 12:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> From: Eric Sunshine <sunshine@sunshineco.com>
>
> The command "git checkout --to <path>" is something of an anachronism,
> encompassing functionality somewhere between "checkout" and "clone".
> The introduction of the git-worktree command, however, provides a proper
> and intuitive place to house such functionality. Consequently,
> re-implement "git checkout --to" as "git worktree add".
>
> As a side-effect, linked worktree creation becomes much more
> discoverable with its own dedicated command, whereas `--to` was easily
> overlooked amid the plethora of options recognized by git-checkout.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * Duy seems to think "worktree add" is coming, too, so here is a
>    trivial tweak of your patch from the last month, with test
>    adjustments to 7410 I sent earlier squashed in.

Thanks. I was planning on re-rolling to use the new name ("add" rather
than "new") and to squash in the t7410 fix. Plus, I think the changes
I had to make to prepare_linked_checkout() in order to move it to
worktree.c should become separate preparatory patches so that the
actual relocation can become pure code movement (as much as possible).

Also, I was planning on including Duy's patch in the re-roll since it
missed a s/prune --worktrees/worktree prune/ in
Documentation/git-checkout.txt.

>    I noticed GIT_CHECKOUT_NEW_WORKTREE environment variabl that does
>    not seem to be documented.  Is this something we still need?
>    The log message of 529fef20 (checkout: support checking out into
>    a new working directory, 2014-11-30) does not tell us much.

Yes, it's still used for the same purpose as before the conversion: as
a private signal to the sub git-checkout invocation that it's
operating on a new worktree. When defined, it sets the
'new_worktree_mode' flag in checkout.c, and there are still a few bits
of code which apparently need to know about it. It would be nice to
eliminate this special knowledge from checkout.c, however, I'm not yet
familiar enough with the checkout code to determine if doing so is
viable.

For the re-roll, I was planning on renaming it to
GIT_NEW_WORKTREE_MODE or something (or add a private command-line
option to checkout, but that may be overkill).
