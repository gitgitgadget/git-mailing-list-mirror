From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/PATCH] worktree: replace "checkout --to" with "worktree new"
Date: Thu, 2 Jul 2015 14:45:23 -0400
Message-ID: <CAPig+cR2tn6G0N1sSsrkP_Lo_U_hjLYi08qEsMr+gcsjheaX7A@mail.gmail.com>
References: <1435640202-95945-1-git-send-email-sunshine@sunshineco.com>
	<xmqqr3orakex.fsf@gitster.dls.corp.google.com>
	<CAPig+cRLpJK-C7MApH1vigZS=gmHNeo6RL3S2wXv4B-TFfnq4g@mail.gmail.com>
	<CACsJy8BdvLiM8Ki=N1k-fBrqqoEONhjwcN6jzGUk=3NPRRujQw@mail.gmail.com>
	<CAPig+cT=U6LxpJuUMaCd-x=gQPvh89SDNUo12+2_3uYb_q3=Og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 20:45:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAjUH-0003Fm-L5
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 20:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbbGBSp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 14:45:26 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:35626 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819AbbGBSpY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 14:45:24 -0400
Received: by ykdy1 with SMTP id y1so76572199ykd.2
        for <git@vger.kernel.org>; Thu, 02 Jul 2015 11:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=FpEy+mJBCIvi2v0dmPVCz52ooSJ12w/MOf/tY+7Xm5o=;
        b=Kh7nCrhFGUkmTCXM/CBljB9Xl8b7ygZujTFEDwQlSwROv7JPuKGV/gyBsgmu9K6g0X
         Q9gwCtkARDMP7n5nm8yNoh11lHqbF5G6Ho21ExNNewiUUjauqTx8OyRIZnfuWYtZEJWR
         CnEsI9qog+EfVbTWvVAau5yCDeLI9wSsybCpxJ788/841N8g1Q7WFhDfXCYeHD0xKJQH
         Y8kMv9mA/Unc+K3/m6AaeUmCxdEudi2ASuKfabjFLtI3bt3XWHsTrHyrFzW5mhbr3qGi
         ToqVfG64M8Pz0JheHkSl5dQXqBjhvGFMBnRUdq5xisobcwmoj/2yGZU9GRiscTs9lcgR
         ymUQ==
X-Received: by 10.170.75.194 with SMTP id r185mr40142008ykr.69.1435862723326;
 Thu, 02 Jul 2015 11:45:23 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Thu, 2 Jul 2015 11:45:23 -0700 (PDT)
In-Reply-To: <CAPig+cT=U6LxpJuUMaCd-x=gQPvh89SDNUo12+2_3uYb_q3=Og@mail.gmail.com>
X-Google-Sender-Auth: 2K3A2lsihc6sPvVeYMLE3C0M6wo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273269>

On Wed, Jul 1, 2015 at 10:52 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> However, there are still a few bits of
> code which want to know that the checkout is happening in a new
> worktree. I haven't examined them closely yet to diagnose if this
> specialized knowledge can be eliminated. Perhaps you can weight in. In
> particular:
>
> checkout_paths:
>     if (opts->new_worktree)
>         die(_("'%s' cannot be used with updating paths"), "--to");
>
> merge_working_tree:
>     tree = parse_tree_indirect(old->commit &&
>         !opts->new_worktree_mode ?
>             old->commit->object.sha1 :
>             EMPTY_TREE_SHA1_BIN);
>
> switch_branches:
>     if (!opts->quiet && !old.path && old.commit &&
>         new->commit != old.commit && !opts->new_worktree_mode)
>             orphaned_commit_warning(old.commit, new->commit);

There's another instance: 3473ad0 (checkout: don't require a work tree
when checking out into a new one, 2014-11-30) added this:

    if (!new_worktree)
        setup_work_tree();

which the "worktree add" patch changed to:

    setup_work_tree();

which doesn't hurt (since setup_work_tree() protects itself against
multiple invocations) but isn't semantically clean. If I understand
correctly, I think a better approach would be to move the
setup_work_tree() call to worktree.c just before it invokes
git-checkout, and revert 3473ad0 entirely (including this bit):

    - { "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
    +{ "checkout", cmd_checkout, RUN_SETUP },

so that git-checkout once again requires a worktree.
