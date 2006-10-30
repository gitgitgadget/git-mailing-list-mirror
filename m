X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: WARNING: THIS PATCH CAN BREAK YOUR REPO, was Re: [PATCH 2/3] Only repack active packs by skipping over kept packs.
Date: Mon, 30 Oct 2006 15:52:00 -0500
Message-ID: <20061030205200.GA20236@delft.aura.cs.cmu.edu>
References: <20061029093754.GD3847@spearce.org> <Pine.LNX.4.64.0610301332440.11384@xanadu.home> <20061030202611.GA5775@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 30 Oct 2006 20:55:55 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Mail-Followup-To: Shawn Pearce <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20061030202611.GA5775@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30522>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gee7A-0000M6-ET for gcvg-git@gmane.org; Mon, 30 Oct
 2006 21:52:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422644AbWJ3UwH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 15:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422647AbWJ3UwH
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 15:52:07 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:48614 "EHLO
 delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP id S1422646AbWJ3UwE
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 15:52:04 -0500
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 4.63)
 (envelope-from <jaharkes@cs.cmu.edu>) id 1Gee6y-0005rJ-5s; Mon, 30 Oct 2006
 15:52:00 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Mon, Oct 30, 2006 at 03:26:11PM -0500, Shawn Pearce wrote:
> Actually the breakage is easier to reproduce without trashing
> a repository.
> 
> Do the above so you have everything in one pack.  Now use rev-list
> to simulate the object list construction in pack-objects as though
> we were doing a 'git repack -a -d':
> 
>   git-rev-list --objects --all \
>     --unpacked=.git/objects/pack/pack-*.pack \
> 	| wc -l
> 
> gives me 102 (WRONG WRONG WRONG WRONG!!!!!!)

The problem seems to be that as soon as we hit something that is found
in a pack that is not on the ignore list, that object and all it's
parents are marked as uninteresting. So if the kept pack contains a
slice of commits (v1.4.3..v1.4.3.3) the revision walker will only return
the recent stuff (v1.4.3.3..) and drop the older data (..v1.4.3).

The following patch does fix the problem Nicolas reported, but for some
reason I'm still getting only 102 objects (only tags and the commits
they refer to?) with your test.

Jan

----
diff --git a/revision.c b/revision.c
index 280e92b..a69c873 100644
--- a/revision.c
+++ b/revision.c
@@ -418,9 +418,6 @@ static void limit_list(struct rev_info *
 
 		if (revs->max_age != -1 && (commit->date < revs->max_age))
 			obj->flags |= UNINTERESTING;
-		if (revs->unpacked &&
-		    has_sha1_pack(obj->sha1, revs->ignore_packed))
-			obj->flags |= UNINTERESTING;
 		add_parents_to_list(revs, commit, &list);
 		if (obj->flags & UNINTERESTING) {
 			mark_parents_uninteresting(commit);
@@ -1149,17 +1146,18 @@ struct commit *get_revision(struct rev_i
 		 * that we'd otherwise have done in limit_list().
 		 */
 		if (!revs->limited) {
-			if ((revs->unpacked &&
-			     has_sha1_pack(commit->object.sha1,
-					   revs->ignore_packed)) ||
-			    (revs->max_age != -1 &&
-			     (commit->date < revs->max_age)))
+			if (revs->max_age != -1 &&
+			    (commit->date < revs->max_age))
 				continue;
 			add_parents_to_list(revs, commit, &revs->commits);
 		}
 		if (commit->object.flags & SHOWN)
 			continue;
 
+		if (revs->unpacked && has_sha1_pack(commit->object.sha1,
+						    revs->ignore_packed))
+		    continue;
+
 		/* We want to show boundary commits only when their
 		 * children are shown.  When path-limiter is in effect,
