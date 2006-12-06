X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Add builtin merge-file, a minimal replacement for RCS merge
Date: Wed, 6 Dec 2006 16:10:34 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612061609430.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 6 Dec 2006 15:10:47 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33469>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GryPy-0008Pj-C8 for gcvg-git@gmane.org; Wed, 06 Dec
 2006 16:10:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933336AbWLFPKi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 10:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933603AbWLFPKi
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 10:10:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:47309 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S933336AbWLFPKg
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 10:10:36 -0500
Received: (qmail invoked by alias); 06 Dec 2006 15:10:35 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp036) with SMTP; 06 Dec 2006 16:10:35 +0100
To: git@vger.kernel.org, junkio@cox.net
Sender: git-owner@vger.kernel.org


merge-file has the same syntax as RCS merge, but supports only the
"-L" option.

For good measure, a test is added, which is quite minimal, though.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	Is it a good sign that the test makes up for 75% of this patch?

 builtin-merge-file.c  |   72 ++++++++++++++
 builtin.h             |    1 +
 git.c                 |    1 +
 t/t6023-merge-file.sh |  251 ++++++++++++++++---------------------------------
 4 files changed, 157 insertions(+), 168 deletions(-)

diff --git a/builtin-merge-file.c b/builtin-merge-file.c
new file mode 100644
index 0000000..11976ea
--- /dev/null
+++ b/builtin-merge-file.c
@@ -0,0 +1,72 @@
+#include "cache.h"
+#include "xdiff/xdiff.h"
+
+static const char merge_file_usage[] =
+"git merge-file [-L name1 [-L orig [-L name2]]] file1 orig_file file2";
+
+static int read_file(mmfile_t *ptr, const char *filename)
+{
+	struct stat st;
+	FILE *f;
+
+	if (stat(filename, &st))
+		return error("Could not stat %s", filename);
+	if ((f = fopen(filename, "rb")) == NULL)
+		return error("Could not open %s", filename);
+	ptr->ptr = xmalloc(st.st_size);
+	if (fread(ptr->ptr, st.st_size, 1, f) != 1)
+		return error("Could not read %s", filename);
+	fclose(f);
+	ptr->size = st.st_size;
+	return 0;
+}
+
+int cmd_merge_file(int argc, char **argv, char **envp)
+{
+	char *names[3];
+	char *buffers[3];
+	mmfile_t mmfs[3], result = {NULL, 0};
+	int ret = 0, i = 0;
+
+	while (argc > 4) {
+		if (!strcmp(argv[1], "-L")) {
+			names[i++] = argv[2];
+			argc -= 2;
+			argv += 2;
+			continue;
+		}
+		usage(merge_file_usage);
+	}
+
+	if (argc != 4)
+		usage(merge_file_usage);
+
+	for (; i < 3; i++)
+		names[i] = argv[i + 1];
+
+	for (i = 0; i < 3; i++)
+		if (read_file(mmfs + i, argv[i + 1]))
+			return -1;
+
+	xpparam_t xpp = {XDF_NEED_MINIMAL};
+	ret = xdl_merge(mmfs + 1, mmfs + 0, names[0], mmfs + 2, names[2],
+			&xpp, XDL_MERGE_ZEALOUS, &result);
+
+	for (i = 0; i < 3; i++)
+		free(mmfs[i].ptr);
+
+	if (ret >= 0) {
+		char *filename = argv[1];
+		FILE *f = fopen(filename, "wb");
+
+		if (!f)
+			ret = error("Could not open %s for writing", filename);
+		else if (fwrite(result.ptr, result.size, 1, f) != 1)
+			ret = error("Could not write to %s", filename);
+		else if (fclose(f))
+			ret = error("Could not close %s", filename);
+		free(result.ptr);
+	}
+
+	return ret;
+}
diff --git a/builtin.h b/builtin.h
index b5116f3..08519e7 100644
--- a/builtin.h
+++ b/builtin.h
@@ -42,6 +42,7 @@ extern int cmd_ls_files(int argc, const char **argv, const char *prefix);
 extern int cmd_ls_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_mailinfo(int argc, const char **argv, const char *prefix);
 extern int cmd_mailsplit(int argc, const char **argv, const char *prefix);
+extern int cmd_merge_file(int argc, const char **argv, const char *prefix);
 extern int cmd_mv(int argc, const char **argv, const char *prefix);
 extern int cmd_name_rev(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_objects(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index 63a4747..cb5a7ef 100644
--- a/git.c
+++ b/git.c
@@ -252,6 +252,7 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 		{ "ls-tree", cmd_ls_tree, RUN_SETUP },
 		{ "mailinfo", cmd_mailinfo },
 		{ "mailsplit", cmd_mailsplit },
+		{ "merge-file", cmd_merge_file },
 		{ "mv", cmd_mv, RUN_SETUP },
 		{ "name-rev", cmd_name_rev, RUN_SETUP },
 		{ "pack-objects", cmd_pack_objects, RUN_SETUP },
diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
index 53246f2..5d9b6f3 100644
--- a/t/t6023-merge-file.sh
+++ b/t/t6023-merge-file.sh
@@ -11,191 +11,106 @@ super aquam refectionis educavit me;
 animam meam convertit,
 deduxit me super semitas jusitiae,
 propter nomen suum.
+EOF
+
+cat > new1.txt << EOF
+Dominus regit me,
+et nihil mihi deerit.
+In loco pascuae ibi me collocavit,
+super aquam refectionis educavit me;
+animam meam convertit,
+deduxit me super semitas jusitiae,
+propter nomen suum.
 Nam et si ambulavero in medio umbrae mortis,
 non timebo mala, quoniam tu mecum es:
 virga tua et baculus tuus ipsa me consolata sunt.
-Parasti in conspectu meo mensam,
-adversus eos qui tribulant me;
-impinguasti in oleo caput meum,
-et calix meus inebrians quam praeclarus est!
-Et misericordia tua subsequetur me omnibus diebus vitae meae,
-et ut inhabitem in domo Domini in longitudinem dierum.
 EOF
 
-cp orig.txt with-empty-lines.txt
-git apply --unidiff-zero << EOF
---- with-empty-lines.txt
-+++ with-empty-lines.txt
-@@ -3,0 +3 @@
-+
-@@ -5,0 +6 @@
-+
-@@ -8,0 +10 @@
-+
-@@ -11,0 +14 @@
-+
-@@ -15,0 +19 @@
-+
-@@ -17,0 +22 @@
-+
+cat > new2.txt << EOF
+Dominus regit me, et nihil mihi deerit.
+In loco pascuae ibi me collocavit,
+super aquam refectionis educavit me;
+animam meam convertit,
+deduxit me super semitas jusitiae,
+propter nomen suum.
 EOF
 
-(cat orig.txt; echo; echo "Psalmus David") > with-reference.txt
-
-cp orig.txt different-capitalisation.txt
-git apply --unidiff-zero << EOF
---- different-capitalisation.txt
-+++ different-capitalisation.txt
-@@ -3,2 +3,2 @@
--In loco pascuae ibi me collocavit,
--super aquam refectionis educavit me;
-+in loco pascuae ibi me collocavit.
-+Super aquam refectionis educavit me;
-@@ -6 +6 @@
--deduxit me super semitas jusitiae,
-+Deduxit me super semitas jusitiae,
-@@ -10 +10 @@
--virga tua et baculus tuus ipsa me consolata sunt.
-+Virga tua et baculus tuus ipsa me consolata sunt.
-@@ -13 +13 @@
--impinguasti in oleo caput meum,
-+Impinguasti in oleo caput meum,
-@@ -16 +16 @@
--et ut inhabitem in domo Domini in longitudinem dierum.
-+Et ut inhabitem in domo Domini in longitudinem dierum.
+cat > new3.txt << EOF
+DOMINUS regit me,
+et nihil mihi deerit.
+In loco pascuae ibi me collocavit,
+super aquam refectionis educavit me;
+animam meam convertit,
+deduxit me super semitas jusitiae,
+propter nomen suum.
 EOF
 
-cp orig.txt with-numbers.txt
-git apply --unidiff-zero << EOF
---- with-numbers.txt
-+++ with-numbers.txt
-@@ -1 +1 @@
--Dominus regit me,
-+1. Dominus regit me,
-@@ -3 +3 @@
--In loco pascuae ibi me collocavit,
-+2. In loco pascuae ibi me collocavit,
-@@ -5 +5 @@
--animam meam convertit,
-+3. animam meam convertit,
-@@ -8 +8 @@
--Nam et si ambulavero in medio umbrae mortis,
-+4. Nam et si ambulavero in medio umbrae mortis,
-@@ -11 +11 @@
--Parasti in conspectu meo mensam,
-+5. Parasti in conspectu meo mensam,
-@@ -15 +15 @@
--Et misericordia tua subsequetur me omnibus diebus vitae meae,
-+6. Et misericordia tua subsequetur me omnibus diebus vitae meae,
+cat > new4.txt << EOF
+Dominus regit me, et nihil mihi deerit.
+In loco pascuae ibi me collocavit,
+super aquam refectionis educavit me;
+animam meam convertit,
+deduxit me super semitas jusitiae,
 EOF
+echo -n "propter nomen suum." >> new4.txt
 
-# Excusez-moi, je n'ai clavier avec des accents...
-
-cp orig.txt avec-francais.txt
-git apply --unidiff-zero << EOF
---- avec-francais.txt
-+++ avec-francais.txt
-@@ -3,0 +3,3 @@
-+
-+Le Seigneur est mon berger,
-+je ne manquerai de rien.
-@@ -5,0 +8,3 @@
-+
-+Il me met au repos dans des pres d'herbe fraiche,
-+il me conduit au calme pres de l'eau.
-@@ -8,0 +14,4 @@
-+
-+Il ranime mes forces,
-+il me guide sur la bonne voie,
-+parce qu'il est le berger d'Israel.
-@@ -11,0 +21,4 @@
-+
-+Meme si je passe par la vallee obscure,
-+je ne redoute aucun mal, Seigneur, car tu m'accompagnes.
-+Tu me conduis, tu me defends, voila ce qui me rassure.
-@@ -15,0 +29,5 @@
-+
-+Face a ceux qui me veulent du mal,
-+tu prepares un banquet pour moi.
-+Tu m'accueilles en versant sur ma teete un peu d'huile parfumee.
-+Tu remplis ma coupe jusqu'au bord.
-@@ -17,0 +35,5 @@
-+
-+Oui, tous les jours de ma vie,
-+ta bonte, ta generosite me suivront pas a pas.
-+Seigneur, je reviendrai dans ta maison
-+aussi longtemps que je vivrai.
-EOF
+cp new1.txt test.txt
+test_expect_success "merge without conflict" \
+	"git-merge-file test.txt orig.txt new2.txt"
 
-cp with-numbers.txt with-empty-lines-and-numbers-conflict.txt
-git apply --unidiff-zero << EOF
---- with-empty-lines-and-numbers-conflict.txt
-+++ with-empty-lines-and-numbers-conflict.txt
-@@ -2,0 +3,4 @@
-+<<<<<<< new.txt
-+
-+In loco pascuae ibi me collocavit,
-+=======
-@@ -3,0 +8 @@
-+>>>>>>> with-numbers.txt
-@@ -4,0 +10,4 @@
-+<<<<<<< new.txt
-+
-+animam meam convertit,
-+=======
-@@ -5,0 +15 @@
-+>>>>>>> with-numbers.txt
-@@ -7,0 +18,4 @@
-+<<<<<<< new.txt
-+
-+Nam et si ambulavero in medio umbrae mortis,
-+=======
-@@ -8,0 +23 @@
-+>>>>>>> with-numbers.txt
-@@ -10,0 +26,4 @@
-+<<<<<<< new.txt
-+
-+Parasti in conspectu meo mensam,
-+=======
-@@ -11,0 +31 @@
-+>>>>>>> with-numbers.txt
-@@ -14,0 +35,4 @@
-+<<<<<<< new.txt
-+
-+Et misericordia tua subsequetur me omnibus diebus vitae meae,
-+=======
-@@ -15,0 +40 @@
-+>>>>>>> with-numbers.txt
-@@ -16,0 +42 @@
-+
-EOF
+cp new1.txt test2.txt
+test_expect_success "merge without conflict (missing LF at EOF)" \
+	"git-merge-file test2.txt orig.txt new2.txt"
+
+test_expect_success "merge result added missing LF" \
+	"diff -u test.txt test2.txt"
 
-cp with-numbers.txt with-empty-lines-and-numbers.txt
-git apply --unidiff-zero << EOF
---- with-empty-lines-and-numbers.txt
-+++ with-empty-lines-and-numbers.txt
-@@ -2,0 +3 @@
-+
-@@ -4,0 +6 @@
-+
-@@ -7,0 +10 @@
-+
-@@ -10,0 +14 @@
-+
-@@ -14,0 +19 @@
-+
+cp test.txt backup.txt
+test_expect_failure "merge with conflicts" \
+	"git-merge-file test.txt orig.txt new3.txt"
+
+cat > expect.txt << EOF
+<<<<<<< test.txt
+Dominus regit me, et nihil mihi deerit.
+=======
+DOMINUS regit me,
+et nihil mihi deerit.
+>>>>>>> new3.txt
+In loco pascuae ibi me collocavit,
+super aquam refectionis educavit me;
+animam meam convertit,
+deduxit me super semitas jusitiae,
+propter nomen suum.
+Nam et si ambulavero in medio umbrae mortis,
+non timebo mala, quoniam tu mecum es:
+virga tua et baculus tuus ipsa me consolata sunt.
 EOF
 
-cp with-empty-lines.txt new.txt
-test_expect_failure "merge empty-lines and numbers" \
-	"git-merge-file new.txt orig.txt with-numbers.txt"
+test_expect_success "expected conflict markers" "diff -u test.txt expect.txt"
+
+cp backup.txt test.txt
+test_expect_failure "merge with conflicts, using -L" \
+	"git-merge-file -L 1 -L 2 test.txt orig.txt new3.txt"
 
-test_expect_success "conflict markers of failed merge" \
-	"diff -u new.txt with-empty-lines-and-numbers-conflict.txt"
+cat > expect.txt << EOF
+<<<<<<< 1
+Dominus regit me, et nihil mihi deerit.
+=======
+DOMINUS regit me,
+et nihil mihi deerit.
+>>>>>>> new3.txt
+In loco pascuae ibi me collocavit,
+super aquam refectionis educavit me;
+animam meam convertit,
+deduxit me super semitas jusitiae,
+propter nomen suum.
+Nam et si ambulavero in medio umbrae mortis,
+non timebo mala, quoniam tu mecum es:
+virga tua et baculus tuus ipsa me consolata sunt.
+EOF
 
-cp with-empty-lines-and-numbers.txt new.txt
-test_expect_success "merge with title" \
-	"git-merge-file new.txt orig.txt with-reference.txt"
+test_expect_success "expected conflict markers, with -L" \
+	"diff -u test.txt expect.txt"
 
 test_done
 
-- 
1.4.4.1.g064f-dirty
