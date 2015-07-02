From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] worktree: replace "checkout --to" with "worktree new"
Date: Thu, 2 Jul 2015 19:50:22 +0700
Message-ID: <CACsJy8CYtey9d6dFhf+bKCPe0aKzm1GNURDR0sJ4NNEmdZeLGQ@mail.gmail.com>
References: <1435640202-95945-1-git-send-email-sunshine@sunshineco.com>
 <xmqqr3orakex.fsf@gitster.dls.corp.google.com> <CAPig+cRLpJK-C7MApH1vigZS=gmHNeo6RL3S2wXv4B-TFfnq4g@mail.gmail.com>
 <CACsJy8BdvLiM8Ki=N1k-fBrqqoEONhjwcN6jzGUk=3NPRRujQw@mail.gmail.com>
 <CAPig+cT=U6LxpJuUMaCd-x=gQPvh89SDNUo12+2_3uYb_q3=Og@mail.gmail.com> <CACsJy8Dce4ErwaRM7zTgLmRzcHxKOr4J8St46urettr5R4DbVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 14:51:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAdxQ-0006nS-Nb
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 14:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753692AbbGBMvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 08:51:01 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:33971 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753624AbbGBMux (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 08:50:53 -0400
Received: by igcsj18 with SMTP id sj18so160803266igc.1
        for <git@vger.kernel.org>; Thu, 02 Jul 2015 05:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ni0PcHDATirFigz1w90EKuKnq4Z/+Xp7Lw86LKUPyGQ=;
        b=AKOEGP6WZWEZd/tW1rbKmWnmD3Jzy+8zM/tXQyRC8J2CK7k1MYbsdXPPyFMOO+GYuj
         t6d7S+StQhvgLAVP5B3gzy2vY9ea3cdXTVIEHWTixjaWhfwFm7G0FR0k97TP4Qe9E3Bf
         SxFlz4/P4tNTxXSJFKqpRvMdB+tkNi+mvbSDMr9mPBYvv3HYhzJEs0oikYGlOMZabFPl
         kU2sy8fx5sg4wAUz0D/wvEQajBWMelZ5HXj5izzmUsDIyFy6B4iU9IKhBt7XFz672zKE
         Sdr4K7w0NMnITEPbFn789jFxLT8qmjSnvMx2Dg+Vgr2h5Fdxgle1Fdt4WAgmSwM/7vlq
         H67w==
X-Received: by 10.50.142.98 with SMTP id rv2mr13995996igb.41.1435841451795;
 Thu, 02 Jul 2015 05:50:51 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Thu, 2 Jul 2015 05:50:22 -0700 (PDT)
In-Reply-To: <CACsJy8Dce4ErwaRM7zTgLmRzcHxKOr4J8St46urettr5R4DbVg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273226>

On Thu, Jul 2, 2015 at 7:41 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> merge_working_tree:
>>     tree = parse_tree_indirect(old->commit &&
>>         !opts->new_worktree_mode ?
>>             old->commit->object.sha1 :
>>             EMPTY_TREE_SHA1_BIN);
>
> I think it's to make sure empty sha-1 is used with --to. If
> old->commit->object.sha1 is used and it's something, a real two way
> merge may happen probably with not-so-fun consequences. If it's empty
> sha1, the effect is like "reset --hard", silent and reliable..
>
>> switch_branches:
>>     if (!opts->quiet && !old.path && old.commit &&
>>         new->commit != old.commit && !opts->new_worktree_mode)
>>             orphaned_commit_warning(old.commit, new->commit);
>
> to suppress misleading warning if old.commit happens to be something.

Actually you may be right about not reverting these. We prepare the
new worktree with a valid HEAD, that would make "old" valid and may
trigger things if "git checkout" is used to populate the worktree. To
suppress those "things", we need new_worktree_mode or something
similar.

Unless we want to borrow fancy checkout options for "git worktree
add", we probably should just export checkout() function from clone.c
and use it instead of "git checkout". Much more lightweight and
simpler (it's one-way merge). Then we can revert checkout.c to the
version before "--to".
-- 
Duy
