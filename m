X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] merge-recursive: add/add really is modify/modify with an
 empty base
Date: Wed, 13 Dec 2006 04:05:39 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612130402300.2807@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061207101707.GA19139@spearce.org>
 <Pine.LNX.4.63.0612100056090.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0612100114440.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmz5w5tuw.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612122347590.2807@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vvekgog0r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 13 Dec 2006 03:05:51 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vvekgog0r.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34180>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuKRK-00037y-D1 for gcvg-git@gmane.org; Wed, 13 Dec
 2006 04:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932368AbWLMDFq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 22:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbWLMDFq
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 22:05:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:44401 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932368AbWLMDFq
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 22:05:46 -0500
Received: (qmail invoked by alias); 13 Dec 2006 03:05:44 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp027) with SMTP; 13 Dec 2006 04:05:44 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org


Unify the handling for cases C (add/add) and D (modify/modify).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Tue, 12 Dec 2006, Junio C Hamano wrote:

	> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
	> 
	> > How about this: if there is an add/add conflict, we treat it 
	> > as if there _was_ an empty file, and we let the shiny new 
	> > xdl_merge() find the _true_ conflicts, _instead of_ removing 
	> > the file from the index, adding both files with different 
	> > "~blabla" markers appended to their file names to the working 
	> > directory.
	> 
	> I was not thinking about this t6024 test failure problem but was
	> wondering about doing exactly that in merge-recursive to match
	> the "two file merge" magic we have in git-merge-one-file.sh

	As can be seen with the test case, the result is more pleasing.

 merge-recursive.c          |   44 +++++++++++++++-----------------------------
 t/t6024-recursive-merge.sh |   12 +++++++++++-
 2 files changed, 26 insertions(+), 30 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 7d203a6..5bec599 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -610,6 +610,12 @@ static void fill_mm(const unsigned char *sha1, mmfile_t *mm)
 	unsigned long size;
 	char type[20];
 
+	if (!hashcmp(sha1, null_sha1)) {
+		mm->ptr = xstrdup("");
+		mm->size = 0;
+		return;
+	}
+
 	mm->ptr = read_sha1_file(sha1, type, &size);
 	if (!mm->ptr || strcmp(type, blob_type))
 		die("unable to read blob object %s", sha1_to_hex(sha1));
@@ -1045,38 +1051,17 @@ static int process_entry(const char *path, struct stage_data *entry,
 			output("Adding %s", path);
 			update_file(1, sha, mode, path);
 		}
-	} else if (!o_sha && a_sha && b_sha) {
-		/* Case C: Added in both (check for same permissions). */
-		if (sha_eq(a_sha, b_sha)) {
-			if (a_mode != b_mode) {
-				clean_merge = 0;
-				output("CONFLICT: File %s added identically in both branches, "
-				       "but permissions conflict %06o->%06o",
-				       path, a_mode, b_mode);
-				output("CONFLICT: adding with permission: %06o", a_mode);
-				update_file(0, a_sha, a_mode, path);
-			} else {
-				/* This case is handled by git-read-tree */
-				assert(0 && "This case must be handled by git-read-tree");
-			}
-		} else {
-			const char *new_path1, *new_path2;
-			clean_merge = 0;
-			new_path1 = unique_path(path, branch1);
-			new_path2 = unique_path(path, branch2);
-			output("CONFLICT (add/add): File %s added non-identically "
-			       "in both branches. Adding as %s and %s instead.",
-			       path, new_path1, new_path2);
-			remove_file(0, path, 0);
-			update_file(0, a_sha, a_mode, new_path1);
-			update_file(0, b_sha, b_mode, new_path2);
-		}
-
-	} else if (o_sha && a_sha && b_sha) {
+	} else if (a_sha && b_sha) {
+		/* Case C: Added in both (check for same permissions) and */
 		/* case D: Modified in both, but differently. */
+		const char *reason = "content";
 		struct merge_file_info mfi;
 		struct diff_filespec o, a, b;
 
+		if (!o_sha) {
+			reason = "add/add";
+			o_sha = (unsigned char *)null_sha1;
+		}
 		output("Auto-merging %s", path);
 		o.path = a.path = b.path = (char *)path;
 		hashcpy(o.sha1, o_sha);
@@ -1093,7 +1078,8 @@ static int process_entry(const char *path, struct stage_data *entry,
 			update_file(1, mfi.sha, mfi.mode, path);
 		else {
 			clean_merge = 0;
-			output("CONFLICT (content): Merge conflict in %s", path);
+			output("CONFLICT (%s): Merge conflict in %s",
+					reason, path);
 
 			if (index_only)
 				update_file(0, mfi.sha, mfi.mode, path);
diff --git a/t/t6024-recursive-merge.sh b/t/t6024-recursive-merge.sh
index 9416c27..964010e 100644
--- a/t/t6024-recursive-merge.sh
+++ b/t/t6024-recursive-merge.sh
@@ -58,9 +58,19 @@ GIT_AUTHOR_DATE="2006-12-12 23:00:08" git commit -m F
 
 test_expect_failure "combined merge conflicts" "git merge -m final G"
 
+cat > expect << EOF
+<<<<<<< HEAD/a1
+F
+=======
+G
+>>>>>>> 26f86b677eb03d4d956dbe108b29cb77061c1e73/a1
+EOF
+
+test_expect_success "result contains a conflict" "diff -u expect a1"
+
 git ls-files --stage > out
 cat > expect << EOF
-100644 f70f10e4db19068f79bc43844b49f3eece45c4e8 1	a1
+100644 f16f906ab60483c100d1241dfc39868de9ec9fcb 1	a1
 100644 cf84443e49e1b366fac938711ddf4be2d4d1d9e9 2	a1
 100644 fd7923529855d0b274795ae3349c5e0438333979 3	a1
 EOF
-- 
