From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [RFC] Patches exchange is bad?
Date: Thu, 18 Aug 2005 12:16:59 +0100
Message-ID: <tnxbr3v336c.fsf@arm.com>
References: <20050818100023.80893.qmail@web26310.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 18 13:18:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5iP9-0007Yt-U9
	for gcvg-git@gmane.org; Thu, 18 Aug 2005 13:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbVHRLRs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 07:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbVHRLRs
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 07:17:48 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:51376 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S932190AbVHRLRr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2005 07:17:47 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j7IBGdOU021150;
	Thu, 18 Aug 2005 12:16:39 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch2.emea.arm.com [10.1.255.58])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id MAA23876;
	Thu, 18 Aug 2005 12:17:32 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.144]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Thu, 18 Aug 2005 12:17:31 +0100
To: Marco Costalba <mcostalba@yahoo.it>
In-Reply-To: <20050818100023.80893.qmail@web26310.mail.ukl.yahoo.com> (Marco
 Costalba's message of "Thu, 18 Aug 2005 03:00:23 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 18 Aug 2005 11:17:31.0883 (UTC) FILETIME=[6D2453B0:01C5A3E6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Marco Costalba <mcostalba@yahoo.it> wrote:
> Catalin Marinas wrote:
>>That's how you would normally do development on Linux using StGIT -
>>clone the mainline kernel, create patches in your StGIT tree and submit
>>them either via e-mail or ask the gatekeeper to pull directly from your
>>tree (assuming that you only push those patches that need to be merged).
>>Doing a 'stg pull' would retrieve the latest changes from the mainline
>>kernel (including the changes made by your patches which were merged
>>upstream).
>
> If I uderstand correctly you never commit patches from StGIT stack directly
> in your base git repository, in this example git HEAD, but you always round 
> trip to MAIN.

One usually doesn't maintain MAIN. That's an example for the Linux
kernel development where you can't control what get merged into MAIN.

There is a bit of confusion here since you said in a previous e-mail
that more people can commit to the stable branch. In this case, you
would need a separate repository for stable with a maintainer pulling
changes from others.

> Then you don't have two git repository: HEAD and MAIN
>
> Infact there is only one git repository, MAIN, cloned on your box
> and called HEAD and with a StGIT stack added on top.

The StGIT usage idea is that you only know what patches you have on
top of a main repository. Since you expect your patches to be merged
upstream or just updated every time the main repository changes, it
might not make sense to commit the patches onto the base.

If you want to keep a stable branch (and only you comitting to it), I
would recommend having separate branches for stable and development in
the same tree (and avoid having separate trees) rather than directly
modifying the base. StGIT doesn't support this directly (didn't think
anyone would ask) but you can do the following steps:

1. Use 'stg clone <remote repository>' to create the initial
   clone. The 'master' branch will be used for development. You can
   use 'git-init-db' and 'stg init' if you don't follow a remote
   repository

2. 'git checkout -b stable' will create the stable branch. This will
   initially be the same as the master one since there are not patches
   applied to the master stack

3. switch back to the devel branch with 'git checkout master' and do
   the normal StGIT development (create patches, commit them etc.). If
   you are tracking a remote respository, you could pull the latest
   changes with 'stg pull'

4. Once you have a set of patches applied and your stack is stable
   (some patches can be unapplied, they don't affect the head of the
   development branch), you can switch to the stable branch with 'stg
   checkout stable' and merge the changes in master with
   'git-resolve-script'.

   I think it might make more sense to simply do a 'cp
   .git/refs/heads/master .git/refs/heads/stable' instead of the
   previous paragraph since the stable branch doesn't have additional
   data from what's in master. The remote repository tracking is done
   via master.

5. You can advance the base of the stack to what's in stable with an
   'stg pull stable' but it's not clear for me whether this makes any
   sense since you lose the StGIT patches already added to stable and
   you will might later get conflicts when pulling the changes from
   the remote repository you are tracking.

For the 2, 3 and 4 steps above I will add a 'snapshot' command to
StGIT but I'm not sure why one would want step 5 since this would mean
that the devel branch needs to track both the remote repository and
the stable branch.

Some questions: do you track a remote repository? Do you need a stable
repository or branch where more people can update? If you track the
remote repository, do you want the latest remote changes merged into
the stable branch directly (i.e. is the stable branch tracking the
remote repository)?

I need a bit more clarification about your work flow.

-- 
Catalin
