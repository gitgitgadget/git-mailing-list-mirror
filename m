From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] diff --follow: do call diffcore_std() as necessary
Date: Fri, 13 Aug 2010 12:46:55 -0700
Message-ID: <7veie2jnww.fsf_-_@alter.siamese.dyndns.org>
References: <AANLkTikPhWgeeLBV3dbLZ5UM3UDmkOmpqrmwqPmGfn7Z@mail.gmail.com>
 <7vhbiyl8ji.fsf@alter.siamese.dyndns.org>
 <7vpqxmjphl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bo Yang <struggleyb.nku@gmail.com>,
	Constantine Plotnikov <constantine.plotnikov@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 13 21:47:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok0Dm-0006SX-BZ
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 21:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555Ab0HMTrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Aug 2010 15:47:12 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34270 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003Ab0HMTrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 15:47:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 21DB1CBA1F;
	Fri, 13 Aug 2010 15:47:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0EnPmvNCPpd29GcUXteFvMxoHoQ=; b=fmlvVr
	+NlV7958oRxLoN4DFliY1OSzn4rej2cgfxZdv7iKzHzuYacMABvzGkXi0ypHpFCO
	tbBCBrHwT7HpHkgKyYnoiaVv9FS+9xShsA/5JQCDzaMfK8xyZw20Ma9Pa1M4DIKS
	JSkgpbQS+HChCzDU4Z9od2cMdDJC6iodpSD9g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I66Dp72JDDSRLze370Jyj2Rhk0bYQDwG
	MgOMiRqzfuIe2WadomaZyuK26rJEVcPGbRr3K+fX/sUFr/XuxupAD5KQ9EoezwTv
	o8j3LQwa5TYW66PX2p3LCmJOShswVGB3tbZ699V1ReiuVh1ADi552wMfwf+h1aiz
	EtUzAudY8iA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D281ACBA1C;
	Fri, 13 Aug 2010 15:47:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A4FF7CBA18; Fri, 13 Aug
 2010 15:46:57 -0400 (EDT)
In-Reply-To: <7vpqxmjphl.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 13 Aug 2010 12\:12\:54 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8B56222E-A713-11DF-B957-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153488>

Usually, diff frontends populate the output queue with filepairs without
any rename information and call diffcore_std() to sort the renames out.
When --follow is in effect, however, diff-tree family of frontend has a
hack that looks like this:

    diff-tree frontend
    -> diff_tree_sha1()
       . populate diff_queued_diff
       . if --follow is in effect and there is only one change that
         creates the target path, then
       -> try_to_follow_renames()
	  -> diff_tree_sha1() with no pathspec but with -C
	  -> diffcore_std() to find renames
	  . if rename is found, tweak diff_queued_diff and put a
	    single filepair that records the found rename there
    -> diffcore_std()
       . tweak elements on diff_queued_diff by
       - rename detection
       - path ordering
       - pickaxe filtering

We need to skip parts of the second call to diffcore_std() that is related
to rename detection, and do so only when try_to_follow_renames() did find
a rename.  Earlier 1da6175 (Make diffcore_std only can run once before a
diff_flush, 2010-05-06) tried to deal with this issue incorrectly; it
unconditionally disabled any second call to diffcore_std().

This hopefully fixes the breakage.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This time with a proposed commit message for a change.  Still seems to
   pass the test in 0cdca13 (Make git log --follow find copies among
   unmodified files., 2010-05-06), presumably added for 1da6175.

 diff.c      |   27 +++++++++++++--------------
 diff.h      |    3 +++
 diffcore.h  |    2 --
 tree-diff.c |   11 +++++++++++
 4 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/diff.c b/diff.c
index bf65892..9300492 100644
--- a/diff.c
+++ b/diff.c
@@ -4064,25 +4064,24 @@ void diffcore_fix_diff_index(struct diff_options *options)
 
 void diffcore_std(struct diff_options *options)
 {
-	/* We never run this function more than one time, because the
-	 * rename/copy detection logic can only run once.
-	 */
-	if (diff_queued_diff.run)
-		return;
-
 	if (options->skip_stat_unmatch)
 		diffcore_skip_stat_unmatch(options);
-	if (options->break_opt != -1)
-		diffcore_break(options->break_opt);
-	if (options->detect_rename)
-		diffcore_rename(options);
-	if (options->break_opt != -1)
-		diffcore_merge_broken();
+	if (!options->found_follow) {
+		/* See try_to_follow_renames() in tree-diff.c */
+		if (options->break_opt != -1)
+			diffcore_break(options->break_opt);
+		if (options->detect_rename)
+			diffcore_rename(options);
+		if (options->break_opt != -1)
+			diffcore_merge_broken();
+	}
 	if (options->pickaxe)
 		diffcore_pickaxe(options->pickaxe, options->pickaxe_opts);
 	if (options->orderfile)
 		diffcore_order(options->orderfile);
-	diff_resolve_rename_copy();
+	if (!options->found_follow)
+		/* See try_to_follow_renames() in tree-diff.c */
+		diff_resolve_rename_copy();
 	diffcore_apply_filter(options->filter);
 
 	if (diff_queued_diff.nr && !DIFF_OPT_TST(options, DIFF_FROM_CONTENTS))
@@ -4090,7 +4089,7 @@ void diffcore_std(struct diff_options *options)
 	else
 		DIFF_OPT_CLR(options, HAS_CHANGES);
 
-	diff_queued_diff.run = 1;
+	options->found_follow = 0;
 }
 
 int diff_result_code(struct diff_options *opt, int status)
diff --git a/diff.h b/diff.h
index 063d10a..6fff024 100644
--- a/diff.h
+++ b/diff.h
@@ -126,6 +126,9 @@ struct diff_options {
 	/* this is set by diffcore for DIFF_FORMAT_PATCH */
 	int found_changes;
 
+	/* to support internal diff recursion by --follow hack*/
+	int found_follow;
+
 	FILE *file;
 	int close_file;
 
diff --git a/diffcore.h b/diffcore.h
index 05ebc11..8b3241a 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -91,13 +91,11 @@ struct diff_queue_struct {
 	struct diff_filepair **queue;
 	int alloc;
 	int nr;
-	int run;
 };
 #define DIFF_QUEUE_CLEAR(q) \
 	do { \
 		(q)->queue = NULL; \
 		(q)->nr = (q)->alloc = 0; \
-		(q)->run = 0; \
 	} while (0)
 
 extern struct diff_queue_struct diff_queued_diff;
diff --git a/tree-diff.c b/tree-diff.c
index 5b68c08..cd659c6 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -359,6 +359,7 @@ static void try_to_follow_renames(struct tree_desc *t1, struct tree_desc *t2, co
 	diff_tree_release_paths(&diff_opts);
 
 	/* Go through the new set of filepairing, and see if we find a more interesting one */
+	opt->found_follow = 0;
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 
@@ -376,6 +377,16 @@ static void try_to_follow_renames(struct tree_desc *t1, struct tree_desc *t2, co
 			diff_tree_release_paths(opt);
 			opt->paths[0] = xstrdup(p->one->path);
 			diff_tree_setup_paths(opt->paths, opt);
+
+			/*
+			 * The caller expects us to return a set of vanilla
+			 * filepairs to let a later call to diffcore_std()
+			 * it makes to sort the renames out (among other
+			 * things), but we already have found renames
+			 * ourselves; signal diffcore_std() not to muck with
+			 * rename information.
+			 */
+			opt->found_follow = 1;
 			break;
 		}
 	}
-- 
1.7.2.1.186.gffe84
