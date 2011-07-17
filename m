From: Kunal Gangakhedkar <kunal.gangakhedkar@gmail.com>
Subject: Re: [PATCH] merge: Preserve ORIG_HEAD if already up-to-date with remote.
Date: Sun, 17 Jul 2011 22:01:24 +0530
Message-ID: <201107172201.25242.kunal.gangakhedkar@gmail.com>
References: <1307950525-8011-1-git-send-email-kunal.gangakhedkar@gmail.com> <1307950525-8011-2-git-send-email-kunal.gangakhedkar@gmail.com> <7vy614j99n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 17 18:31:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiUFp-0006xO-Lf
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jul 2011 18:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756034Ab1GQQbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jul 2011 12:31:36 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:35309 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754462Ab1GQQbf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2011 12:31:35 -0400
Received: by pzk3 with SMTP id 3so3307408pzk.5
        for <git@vger.kernel.org>; Sun, 17 Jul 2011 09:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding:message-id;
        bh=vDwRBPyLZHkplRDQuh+i23GUCk4Nnydo8V7GLP1m+Mg=;
        b=PZ8FIUTp/jY2Vgvl26AKtYZFKz3D6oRciFXNgeg6DPtRkbO4NZqpFcKMH5fH6s/tr8
         6twwr/bJbt4G9e7K18EFyaTJozLVuB5GbybcIjDptsLZDoZFqQjQ1ZDs0jVmXdwWNWpD
         CwIds75kH5yPZL5jLgxTdmrVZYUyC+tudVdMQ=
Received: by 10.68.38.227 with SMTP id j3mr15825pbk.378.1310920295347;
        Sun, 17 Jul 2011 09:31:35 -0700 (PDT)
Received: from plutonium.localnet (triband-mum-120.60.37.62.mtnl.net.in [120.60.37.62])
        by mx.google.com with ESMTPS id m7sm1976313pbk.38.2011.07.17.09.31.30
        (version=SSLv3 cipher=OTHER);
        Sun, 17 Jul 2011 09:31:32 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.36-2-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <7vy614j99n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177304>

On Wednesday 15 Jun 2011 4:44:28 am Junio C Hamano wrote:
> Kunal Gangakhedkar <kunal.gangakhedkar@gmail.com> writes:
> > Do not update ORIG_HEAD ref to current HEAD if the repo is already
> > in-sync with the remote.
> > 
> > Otherwise, it becomes difficult to keep track of last set of changes.
> > 
> > With this patch, it's possible to do a diffstat/log for last set of
> > changes even after a pull/merge that returns 'Already up-to-date'.
> 
> I am not sure what you mean.  If you are behind remote A and remote B is
> behind remote A, i.e.
> 
> 	You -- (fast forwards) --> B -- (fast forwards) --> A
> 
> then you should be able to expect these:
> 	: point zero
> 
> 	$ git pull A
>         $ git diff/log ORIG_HEAD.. ;# shows how your tree and history
>         			    # are updated wrt point zero above
> 
> 	: point one
> 
> 	$ git pull B
>         $ git diff/log ORIG_HEAD.. ;# shows how your tree and history
>         			    # are updated wrt point one above
> 
> If your patch is to stop recording ORIG_HEAD for the second "git pull"
> above, I fail to see how that could be a good change.
> 
> If you want to drive "pull" from a script (e.g. cron) and want to have
> precise control of what happens depending on how HEAD is updated, your
> script has enough freedom and flexibility to do so before running "pull",
> I think.  E.g.
> 
> 	. $(git --exec-path)/git-sh-setup
> 
> 	CURRENT=$(git rev-parse HEAD^0) || die "Eh? No Head?"
>         git pull || die "pull fails"
>         UPDATED=$(git rev-parse HEAD^0)
>         if test "$CURRENT" = "$UPDATED"
>         then
> 		exit 0; # nothing happened
> 	fi
> 	git shortlog --no-merges $CURRENT..$UPDATED
>         git diff --stat --summary $CURRENT..$UPDATED

Sorry, got caught up in butt-load of work..

Well, that's not what I meant.
The default diffstat at the end of merge/ff/pull already gives the required 
info.

The problem comes when the remote _does not_ have updates since last pull.
With a 'git pull' next time around (i.e. with no updates in the remote), 
ORIG_HEAD is moved to the current HEAD and the range of commits in the last 
changeset are lost. That is, I can no longer figure out the contents of the 
last changeset.

To give an example, let's track the following sequence:

	$ git clone git://url/of/super-awesome/project.git  	(0)
		.... hack hack hack in remote ....
		.... remote is fast-forwarded ...
	$ git pull									(1)
		... you got the changes ....
		.... hack hack hack in remote ....
		.... remote is fast-forwarded ...
	$ git pull									(2)
		... you got the changes ....
		... now, everybody is on vacation, so, no updates in remote ...
	$ git pull									(3)
		... you get 'Already up-to-date.' message ...
		... everybody is still on vacation, so, no updates in remote  ...
	$ git pull									(4) 
		... you get 'Already up-to-date.' message ...

In the current situation, at the end of (3) above, ORIG_HEAD is moved to the 
then HEAD. So, after (3), if I try to do 
	git diff/log ORIG_HEAD..
I'd get an empty changeset - i.e. I've lost the *last updated* changeset 
information.

What my patch does is keep ORIG_HEAD at its current state in (3) - so that 
changeset info is still available after (3) until there is an update in 
tracked branch of remote. At which point, ORIG_HEAD will be forwarded again
to the then HEAD and HEAD will point to the newly merged HEAD to reflect the 
changes from remote.

This way, the *latest* changeset is always available for inspection whether 
there's been an update in remote or not. I can safely do 
	git diff/log ORIG_HEAD..
after (4) as well and I'd still get the required information.

I've included config/cmdline options in the patch to force-update ORIG_HEAD so 
that current behavior is retained.

Please let me know if it makes sense.

I've written a simple test script for the functionality, but I'm not sure how 
to name it. Currently, in my working copy, it's called 
	t5555-merge-preserve-orig-head.sh
If that's fine, I'll send it in another patch for review. Otherwise, please 
suggest a good name for it.

Thanks,
Kunal
