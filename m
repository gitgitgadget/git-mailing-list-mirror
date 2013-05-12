From: John Keeping <john@keeping.me.uk>
Subject: Re: [RFC/PATCH 0/2] merge-base: add --merge-child option
Date: Sun, 12 May 2013 17:58:29 +0100
Message-ID: <20130512165829.GM2299@serenity.lan>
References: <cover.1368274689.git.john@keeping.me.uk>
 <518FB8DE.7070004@bracey.fi>
 <20130512162823.GK2299@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Sun May 12 18:58:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbZbm-0005V3-Bb
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 18:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754656Ab3ELQ6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 12:58:46 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:36254 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754539Ab3ELQ6p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 May 2013 12:58:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 42CE6606576;
	Sun, 12 May 2013 17:58:45 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -11
X-Spam-Level: 
X-Spam-Status: No, score=-11 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kXga7vjEyMVg; Sun, 12 May 2013 17:58:44 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 5977F60656A;
	Sun, 12 May 2013 17:58:42 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id B4BF7161E2DC;
	Sun, 12 May 2013 17:58:41 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rYFCMLhTl2A7; Sun, 12 May 2013 17:58:40 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id C256E161E415;
	Sun, 12 May 2013 17:58:31 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20130512162823.GK2299@serenity.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224053>

On Sun, May 12, 2013 at 05:28:24PM +0100, John Keeping wrote:
> However, this doesn't seem to make a difference to the time taken when I
> add in --cherry-mark (which is why I was partially correct in the
> parallel thread - it doesn't have the effect on cherry-mark that I want
> it to):
> 
>     $ time git rev-list --ancestry-path --left-right --count --cherry-mark \
>             origin/master...git-gui/master 
>     2056    5       0
> 
>     real    0m32.266s
>     user    0m31.522s
>     sys     0m0.749s
> 
>     $ time git rev-list  --left-right --count --cherry-mark \
>             origin/master...git-gui/master
>     31959   5       0
> 
>     real    0m32.140s
>     user    0m31.337s
>     sys     0m0.807s
> 
> This seems to be caused by the code in revision.c::limit_list() which
> does the cherry detection then limits to left/right and only then
> applies the ancestry path.  I haven't looked further than that, but is
> there any reason not to apply the ancestry path restriction before
> looking for patch-identical commits?

With the patch below, the --ancestry-path version drops to under 2
seconds.

I'm not sure if this is a good idea though.  It helps me say "I know
nothing that isn't on the ancestry path can be patch-identical, so don't
bother checking if it is" but it regresses users who want the full
cherry-pick check while only limiting the output.

Perhaps we need --cherry-no-uninteresting to apply the first 3 hunks of
the patch at runtime :-S

-- >8 --
diff --git a/revision.c b/revision.c
index de3b058..d721d83 100644
--- a/revision.c
+++ b/revision.c
@@ -837,7 +837,7 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 	for (p = list; p; p = p->next) {
 		struct commit *commit = p->item;
 		unsigned flags = commit->object.flags;
-		if (flags & BOUNDARY)
+		if (flags & (BOUNDARY | UNINTERESTING))
 			;
 		else if (flags & SYMMETRIC_LEFT)
 			left_count++;
@@ -858,7 +858,7 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 		struct commit *commit = p->item;
 		unsigned flags = commit->object.flags;
 
-		if (flags & BOUNDARY)
+		if (flags & (BOUNDARY | UNINTERESTING))
 			continue;
 		/*
 		 * If we have fewer left, left_first is set and we omit
@@ -879,7 +879,7 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 		struct patch_id *id;
 		unsigned flags = commit->object.flags;
 
-		if (flags & BOUNDARY)
+		if (flags & (BOUNDARY | UNINTERESTING))
 			continue;
 		/*
 		 * If we have fewer left, left_first is set and we omit
@@ -1103,17 +1103,18 @@ static int limit_list(struct rev_info *revs)
 		show(revs, newlist);
 		show_early_output = NULL;
 	}
-	if (revs->cherry_pick || revs->cherry_mark)
-		cherry_pick_list(newlist, revs);
-
-	if (revs->left_only || revs->right_only)
-		limit_left_right(newlist, revs);
 
 	if (bottom) {
 		limit_to_ancestry(bottom, newlist);
 		free_commit_list(bottom);
 	}
 
+	if (revs->cherry_pick || revs->cherry_mark)
+		cherry_pick_list(newlist, revs);
+
+	if (revs->left_only || revs->right_only)
+		limit_left_right(newlist, revs);
+
 	/*
 	 * Check if any commits have become TREESAME by some of their parents
 	 * becoming UNINTERESTING.
