From: John Keeping <john@keeping.me.uk>
Subject: log --cherry and merges (was [RFC/PATCH 0/2] merge-base: add
 --merge-child option)
Date: Sun, 19 May 2013 13:40:59 +0100
Message-ID: <20130519124059.GJ27005@serenity.lan>
References: <cover.1368274689.git.john@keeping.me.uk>
 <518FB8DE.7070004@bracey.fi>
 <20130512162823.GK2299@serenity.lan>
 <20130512163317.GL2299@serenity.lan>
 <518FCDDE.9040707@bracey.fi>
 <7vwqr3u9c5.fsf@alter.siamese.dyndns.org>
 <5190F806.6040207@bracey.fi>
 <5190FC97.6020800@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Bracey <kevin@bracey.fi>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun May 19 14:41:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue2vM-0008Vz-Ft
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 14:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754582Ab3ESMlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 08:41:12 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:40582 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113Ab3ESMlL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 08:41:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 2E2EA606516;
	Sun, 19 May 2013 13:41:11 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -10.999
X-Spam-Level: 
X-Spam-Status: No, score=-10.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fZO0Csamh6Qt; Sun, 19 May 2013 13:41:10 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id E61EA6064D3;
	Sun, 19 May 2013 13:41:01 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <5190FC97.6020800@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224884>

On Mon, May 13, 2013 at 04:45:43PM +0200, Michael J Gruber wrote:
> Kevin Bracey venit, vidit, dixit 13.05.2013 16:26:
> > On 13/05/2013 01:22, Junio C Hamano wrote:
> >> Kevin Bracey <kevin@bracey.fi> writes:
> >>
> >>>     git log --ancestry-path --left-right E...F --not $(git merge-base
> >>> --all E F)
> >>>
> >>> which looks like we're having to repeat ourselves because it's not
> >>> paying attention...
> >> You are half wrong; "--left-right" is about "do we show the </>/=
> >> marker in the output?", so it is true that it does not make sense
> >> without "...", but the reverse is not true: A...B does not and
> >> should not imply --left-right.
> >>
> > The repetition I meant is that by the definition of ancestry-path, the 
> > above would seem to be equivalent to
> > 
> >    git log --ancestry-path --left-right E F --not $(git merge-base --all E F) $(git merge-base --all E F)
> > 
> > Anyway, revised separated-out version of the patch follows.
> > 
> > Kevin
> 
> It is certainly true that "git log --cherry" needs much less information
> than what the merge base machinery provides. I've been experimenting
> with that in order to get the speedup which is necessary for replacing
> the "git cherry" code with calls into the revision walker using "--cherry".

I think the revision machinery is the same speed as the "git cherry"
code, it's just that "git cherry" ignores merges and the cherry code in
revision.c doesn't.

Since the patch ID of a merge is just being calculated to its first
parent, I don't think it's meaningful to consider merges for "log
--cherry" but I can't quite convince myself that there's no corner case
where it is.

The following patch makes the revision cherry machinery ignore merges
unconditionally.  With it applied, there's not noticeable difference in
speed between "git cherry" and "git log --cherry".

-- >8 --
diff --git a/revision.c b/revision.c
index a67b615..19d0683 100644
--- a/revision.c
+++ b/revision.c
@@ -640,6 +640,11 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 
 		if (flags & BOUNDARY)
 			continue;
+
+		/* Patch ID is meaningless for merges. */
+		if (commit->parents && commit->parents->next)
+			continue;
+
 		/*
 		 * If we have fewer left, left_first is set and we omit
 		 * commits on the right branch in this loop.  If we have
@@ -661,6 +666,11 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 
 		if (flags & BOUNDARY)
 			continue;
+
+		/* Patch ID is meaningless for merges. */
+		if (commit->parents && commit->parents->next)
+			continue;
+
 		/*
 		 * If we have fewer left, left_first is set and we omit
 		 * commits on the left branch in this loop.
-- 
1.8.3.rc3.372.g721bad8
