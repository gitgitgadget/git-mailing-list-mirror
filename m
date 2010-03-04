From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH RESEND] git diff --submodule: Show detailed dirty status of
 submodules
Date: Thu, 04 Mar 2010 22:20:33 +0100
Message-ID: <4B902421.9090402@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 05 02:22:46 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnIYP-0002eH-LM
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 22:25:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351Ab0CDVUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Mar 2010 16:20:42 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:58666 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756547Ab0CDVUj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Mar 2010 16:20:39 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id A79EB151F1108;
	Thu,  4 Mar 2010 22:20:37 +0100 (CET)
Received: from [80.128.93.64] (helo=[192.168.178.26])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NnITF-0005Fk-00; Thu, 04 Mar 2010 22:20:37 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+Lne7McF83fc60NXbUv3daDQDhreJE1jQeSj93
	DPHIvoOwsvbG8piq8EkuUwfHIgc2RM+5ayd+am3+LICPky8BOV
	DvE3PzWKpdCTItxhWlKw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141547>

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


As i didn't receive any responses two weeks ago, here is a resend.


 diff-lib.c                |   16 ++++++++--------
 diffcore.h                |    4 +++-
 submodule.c               |   40 +++++++++++++++++++++++++++++++++++-----
 submodule.h               |    2 +-
 t/t4041-diff-submodule.sh |   17 +++++++++++------
 5 files changed, 58 insertions(+), 21 deletions(-)

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
index 5d286e4..714ca97 100644
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
@@ -121,9 +130,10 @@ void show_submodule_summary(FILE *f, const char *path,
 	strbuf_release(&sb);
 }

-int is_submodule_modified(const char *path)
+unsigned is_submodule_modified(const char *path)
 {
-	int len, i;
+	int i;
+	ssize_t len;
 	struct child_process cp;
 	const char *argv[] = {
 		"status",
@@ -132,6 +142,8 @@ int is_submodule_modified(const char *path)
 	};
 	const char *env[LOCAL_REPO_ENV_SIZE + 3];
 	struct strbuf buf = STRBUF_INIT;
+	unsigned dirty_submodule = 0;
+	const char *line, *next_line;

 	for (i = 0; i < LOCAL_REPO_ENV_SIZE; i++)
 		env[i] = local_repo_env[i];
@@ -161,6 +173,24 @@ int is_submodule_modified(const char *path)
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
@@ -169,5 +199,5 @@ int is_submodule_modified(const char *path)
 	for (i = LOCAL_REPO_ENV_SIZE; env[i]; i++)
 		free((char *)env[i]);
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
1.7.0.1.335.g17865.dirty
