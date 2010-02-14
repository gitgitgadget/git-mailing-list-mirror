From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH/RFC] git diff --submodule: Show detailed dirty status of submodules
Date: Sun, 14 Feb 2010 22:29:40 +0100
Message-ID: <4B786B44.7070103@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 14 22:30:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngm2t-0001K3-9R
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 22:30:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753357Ab0BNV3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 16:29:44 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:54164 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753310Ab0BNV3n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 16:29:43 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id 445FC14E138FC;
	Sun, 14 Feb 2010 22:29:42 +0100 (CET)
Received: from [80.128.108.225] (helo=[192.168.178.26])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #314)
	id 1Ngm28-0006rd-00; Sun, 14 Feb 2010 22:29:40 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX184g1lcKjooDbg3B7Hch1LguWmOKkPHSLnPlEae
	GNHtjqIWysyR4JR+iwsJ+E4GpFj/3XTw3LIcjBN0xS7Z86zrRr
	4Z0CY6uab6TfF1db0mZA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139941>

When encountering a dirty submodule while doing "git diff --submodule"
print an extra line for new untracked content and another for modified
but already tracked content. And if the HEAD of the submodule is equal
to the ref diffed against in the superproject, drop the output which
would just show the same SHA1s and no commit message headlines.

To achieve that, the dirty_submodule bitfield is expanded to two bits.
The output of "git status" inside the submodule is parsed to set the
according bits.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---


I think it makes sense to provide a bit more information about the
kind of dirtiness of a submodule. So here is a patch doing that for
"git diff --submodule", it changes the output from

Submodule sub 5431f52..3f35670-dirty:
  > first line of commit message

to

Submodule sub contains untracked content
Submodule sub contains modified content
Submodule sub 5431f52..3f35670:
  > first line of commit message


The first two lines will only show up when the condition they describe
is met in the submodule, the third line will be dropped when the hashes
are identical and thus no commit headlines follow (I used the term
"content" instead of "files" in the output for new/untracked and
modified entries because a submodule can not only contain files but
other submodules too).

I think it also makes sense to provide the same information in the
status information present in the comment lines when using "git commit"
and in the output of "git status" too, but that will be another patch.

What do you think?


 diff-lib.c                |   16 ++++++++--------
 diffcore.h                |    4 +++-
 submodule.c               |   39 ++++++++++++++++++++++++++++++++++-----
 submodule.h               |    2 +-
 t/t4041-diff-submodule.sh |   17 +++++++++++------
 5 files changed, 57 insertions(+), 21 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index d7e13cb..15ca7cd 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -180,10 +180,10 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 		changed = ce_match_stat(ce, &st, ce_option);
 		if (S_ISGITLINK(ce->ce_mode)
 		    && !DIFF_OPT_TST(&revs->diffopt, IGNORE_SUBMODULES)
-		    && (!changed || (revs->diffopt.output_format & DIFF_FORMAT_PATCH))
-		    && is_submodule_modified(ce->name)) {
-			changed = 1;
-			dirty_submodule = 1;
+		    && (!changed || (revs->diffopt.output_format & DIFF_FORMAT_PATCH))) {
+			dirty_submodule = is_submodule_modified(ce->name);
+			if (dirty_submodule)
+				changed = 1;
 		}
 		if (!changed) {
 			ce_mark_uptodate(ce);
@@ -243,10 +243,10 @@ static int get_stat_data(struct cache_entry *ce,
 		changed = ce_match_stat(ce, &st, 0);
 		if (S_ISGITLINK(ce->ce_mode)
 		    && !DIFF_OPT_TST(diffopt, IGNORE_SUBMODULES)
-		    && (!changed || (diffopt->output_format & DIFF_FORMAT_PATCH))
-		    && is_submodule_modified(ce->name)) {
-			changed = 1;
-			*dirty_submodule = 1;
+		    && (!changed || (diffopt->output_format & DIFF_FORMAT_PATCH))) {
+			*dirty_submodule = is_submodule_modified(ce->name);
+			if (*dirty_submodule)
+				changed = 1;
 		}
 		if (changed) {
 			mode = ce_mode_from_stat(ce, st.st_mode);
diff --git a/diffcore.h b/diffcore.h
index 66687c3..fcd00bf 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -42,7 +42,9 @@ struct diff_filespec {
 #define DIFF_FILE_VALID(spec) (((spec)->mode) != 0)
 	unsigned should_free : 1; /* data should be free()'ed */
 	unsigned should_munmap : 1; /* data should be munmap()'ed */
-	unsigned dirty_submodule : 1;  /* For submodules: its work tree is dirty */
+	unsigned dirty_submodule : 2;  /* For submodules: its work tree is dirty */
+#define DIRTY_SUBMODULE_UNTRACKED 1
+#define DIRTY_SUBMODULE_MODIFIED  2

 	struct userdiff_driver *driver;
 	/* data should be considered "binary"; -1 means "don't know yet" */
diff --git a/submodule.c b/submodule.c
index 7d70c4f..47734ed 100644
--- a/submodule.c
+++ b/submodule.c
@@ -5,6 +5,7 @@
 #include "commit.h"
 #include "revision.h"
 #include "run-command.h"
+#include "diffcore.h"

 static int add_submodule_odb(const char *path)
 {
@@ -85,13 +86,21 @@ void show_submodule_summary(FILE *f, const char *path,
 			message = "(revision walker failed)";
 	}

+	if (dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
+		fprintf(f, "Submodule %s contains untracked content\n", path);
+	if (dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
+		fprintf(f, "Submodule %s contains modified content\n", path);
+
+	if (!hashcmp(one, two)) {
+		strbuf_release(&sb);
+		return;
+	}
+
 	strbuf_addf(&sb, "Submodule %s %s..", path,
 			find_unique_abbrev(one, DEFAULT_ABBREV));
 	if (!fast_backward && !fast_forward)
 		strbuf_addch(&sb, '.');
 	strbuf_addf(&sb, "%s", find_unique_abbrev(two, DEFAULT_ABBREV));
-	if (dirty_submodule)
-		strbuf_add(&sb, "-dirty", 6);
 	if (message)
 		strbuf_addf(&sb, " %s\n", message);
 	else
@@ -121,9 +130,9 @@ void show_submodule_summary(FILE *f, const char *path,
 	strbuf_release(&sb);
 }

-int is_submodule_modified(const char *path)
+unsigned is_submodule_modified(const char *path)
 {
-	int len;
+	ssize_t len;
 	struct child_process cp;
 	const char *argv[] = {
 		"status",
@@ -132,6 +141,8 @@ int is_submodule_modified(const char *path)
 	};
 	char *env[4];
 	struct strbuf buf = STRBUF_INIT;
+	unsigned dirty_submodule = 0;
+	const char *line, *next_line;

 	strbuf_addf(&buf, "%s/.git/", path);
 	if (!is_directory(buf.buf)) {
@@ -160,6 +171,24 @@ int is_submodule_modified(const char *path)
 		die("Could not run git status --porcelain");

 	len = strbuf_read(&buf, cp.out, 1024);
+	line = buf.buf;
+	while (len > 2) {
+		if ((line[0] == '?') && (line[1] == '?')) {
+			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
+			if (dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
+				break;
+		} else {
+			dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
+			if (dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
+				break;
+		}
+		next_line = strchr(line, '\n');
+		if (!next_line)
+			break;
+		next_line++;
+		len -= (next_line - line);
+		line = next_line;
+	}
 	close(cp.out);

 	if (finish_command(&cp))
@@ -169,5 +198,5 @@ int is_submodule_modified(const char *path)
 	free(env[1]);
 	free(env[2]);
 	strbuf_release(&buf);
-	return len != 0;
+	return dirty_submodule;
 }
diff --git a/submodule.h b/submodule.h
index 2336965..267881c 100644
--- a/submodule.h
+++ b/submodule.h
@@ -5,6 +5,6 @@ void show_submodule_summary(FILE *f, const char *path,
 		unsigned char one[20], unsigned char two[20],
 		unsigned dirty_submodule,
 		const char *del, const char *add, const char *reset);
-int is_submodule_modified(const char *path);
+unsigned is_submodule_modified(const char *path);

 #endif
diff --git a/t/t4041-diff-submodule.sh b/t/t4041-diff-submodule.sh
index 4643054..11b1997 100755
--- a/t/t4041-diff-submodule.sh
+++ b/t/t4041-diff-submodule.sh
@@ -201,7 +201,7 @@ test_expect_success 'submodule contains untracked content' "
 	echo new > sm1/new-file &&
 	git diff-index -p --submodule=log HEAD >actual &&
 	diff actual - <<-EOF
-Submodule sm1 $head6..$head6-dirty:
+Submodule sm1 contains untracked content
 EOF
 "

@@ -209,7 +209,8 @@ test_expect_success 'submodule contains untracked and modifed content' "
 	echo new > sm1/foo6 &&
 	git diff-index -p --submodule=log HEAD >actual &&
 	diff actual - <<-EOF
-Submodule sm1 $head6..$head6-dirty:
+Submodule sm1 contains untracked content
+Submodule sm1 contains modified content
 EOF
 "

@@ -217,7 +218,7 @@ test_expect_success 'submodule contains modifed content' "
 	rm -f sm1/new-file &&
 	git diff-index -p --submodule=log HEAD >actual &&
 	diff actual - <<-EOF
-Submodule sm1 $head6..$head6-dirty:
+Submodule sm1 contains modified content
 EOF
 "

@@ -235,7 +236,8 @@ test_expect_success 'modified submodule contains untracked content' "
 	echo new > sm1/new-file &&
 	git diff-index -p --submodule=log HEAD >actual &&
 	diff actual - <<-EOF
-Submodule sm1 $head6..$head8-dirty:
+Submodule sm1 contains untracked content
+Submodule sm1 $head6..$head8:
   > change
 EOF
 "
@@ -244,7 +246,9 @@ test_expect_success 'modified submodule contains untracked and modifed content'
 	echo modification >> sm1/foo6 &&
 	git diff-index -p --submodule=log HEAD >actual &&
 	diff actual - <<-EOF
-Submodule sm1 $head6..$head8-dirty:
+Submodule sm1 contains untracked content
+Submodule sm1 contains modified content
+Submodule sm1 $head6..$head8:
   > change
 EOF
 "
@@ -253,7 +257,8 @@ test_expect_success 'modified submodule contains modifed content' "
 	rm -f sm1/new-file &&
 	git diff-index -p --submodule=log HEAD >actual &&
 	diff actual - <<-EOF
-Submodule sm1 $head6..$head8-dirty:
+Submodule sm1 contains modified content
+Submodule sm1 $head6..$head8:
   > change
 EOF
 "
-- 
1.7.0.173.g684e9
