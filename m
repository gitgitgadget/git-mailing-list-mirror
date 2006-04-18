From: Junio C Hamano <junkio@cox.net>
Subject: Re: Log message printout cleanups
Date: Mon, 17 Apr 2006 22:52:03 -0700
Message-ID: <7vd5ffig70.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0604161433000.3701@g5.osdl.org>
	<7vbqv1oxie.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604171149330.3701@g5.osdl.org>
	<7vodyzkehq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604171647380.3701@g5.osdl.org>
	<7vejzvka09.fsf@assigned-by-dhcp.cox.net>
	<7v7j5nk9bf.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604171751540.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 18 07:52:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVj8Q-0005iF-OQ
	for gcvg-git@gmane.org; Tue, 18 Apr 2006 07:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWDRFwI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Apr 2006 01:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWDRFwI
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 01:52:08 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:15563 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751340AbWDRFwH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Apr 2006 01:52:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060418055206.IXKH17757.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 18 Apr 2006 01:52:06 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18847>

Linus Torvalds <torvalds@osdl.org> writes:

> There's actually something _wrong_ with "git log --stat". 
>
> What happens is that "git log" will enable "rev.combine_merges" by 
> default, and that means that together with "--stat" ignoring merges by 
> default, it will _instead_ generate a "--cc" diff for that merge.
>
> I'll leave that up to you, I'm getting pretty fed up with "git log" right 
> now ;)

The primary problem is that the code in "next" was before the
"fancy diffstat for combined" work by Johannes; it punts and
always shows the patch output even when stat is asked for.

I think this does what both of us want.  One thing I noticed is
that log-tree-diff-flush does "---\n" under --patch-with-stat
but not under --stat; I matched that here.

-- >8 --
combine-diff: show diffstat with the first parent.

Even under combine-diff, asking for stat (either with --stat or
--patch-with-stat) gives you diffstat for the first parent.

While the combined patch is useful to highlight the complexity
and interaction of the parts touched by all branches when
reviewing a merge commit, diffstat is a tool to assess the
extent of damage the merge brings in, and showing stat with the
first parent is more sensible than clever per-parent diffstat.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 combine-diff.c |   24 +++++++++++++++++++-----
 1 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index aef9006..27f6f57 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -831,10 +831,11 @@ void show_combined_diff(struct combine_d
 	case DIFF_FORMAT_NAME:
 		show_raw_diff(p, num_parent, rev);
 		return;
-
-	default:
 	case DIFF_FORMAT_PATCH:
 		show_patch_diff(p, num_parent, dense, rev);
+		return;
+	default:
+		return;
 	}
 }
 
@@ -847,10 +848,13 @@ void diff_tree_combined_merge(const unsi
 	struct commit_list *parents;
 	struct combine_diff_path *p, *paths = NULL;
 	int num_parent, i, num_paths;
+	int do_diffstat;
 
+	do_diffstat = (opt->output_format == DIFF_FORMAT_DIFFSTAT ||
+		       opt->with_stat);
 	diffopts = *opt;
-	diffopts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diffopts.with_raw = 0;
+	diffopts.with_stat = 0;
 	diffopts.recursive = 1;
 
 	/* count parents */
@@ -864,14 +868,24 @@ void diff_tree_combined_merge(const unsi
 	     parents;
 	     parents = parents->next, i++) {
 		struct commit *parent = parents->item;
+		/* show stat against the first parent even
+		 * when doing combined diff.
+		 */
+		if (i == 0 && do_diffstat)
+			diffopts.output_format = DIFF_FORMAT_DIFFSTAT;
+		else
+			diffopts.output_format = DIFF_FORMAT_NO_OUTPUT;
 		diff_tree_sha1(parent->object.sha1, commit->object.sha1, "",
 			       &diffopts);
 		diffcore_std(&diffopts);
 		paths = intersect_paths(paths, i, num_parent);
 
-		if (diffopts.with_stat && rev->loginfo)
-			show_log(rev, rev->loginfo, "---\n");
+		if (do_diffstat && rev->loginfo)
+			show_log(rev, rev->loginfo,
+				 opt->with_stat ? "---\n" : "\n");
 		diff_flush(&diffopts);
+		if (opt->with_stat)
+			putchar('\n');
 	}
 
 	/* find out surviving paths */
