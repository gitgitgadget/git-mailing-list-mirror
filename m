X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add builtin merge-file, a minimal replacement for RCS
 merge
Date: Wed, 6 Dec 2006 16:26:06 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612061621420.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0612061609430.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 6 Dec 2006 15:27:24 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.63.0612061609430.28348@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33472>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gryfx-0002kw-RS for gcvg-git@gmane.org; Wed, 06 Dec
 2006 16:27:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935686AbWLFP0P (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 10:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935706AbWLFP0N
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 10:26:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:38534 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S935686AbWLFP0I
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 10:26:08 -0500
Received: (qmail invoked by alias); 06 Dec 2006 15:26:06 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp042) with SMTP; 06 Dec 2006 16:26:06 +0100
To: git@vger.kernel.org, junkio@cox.net
Sender: git-owner@vger.kernel.org

Oops. Here is a corrected patch:

 Makefile              |    1 
 builtin-merge-file.c  |   72 ++++++++++++++++++++++++++++++
 builtin.h             |    1 
 git.c                 |    1 
 t/t6023-merge-file.sh |  116 +++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 191 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index cf69242..81cc7c4 100644
--- a/Makefile
+++ b/Makefile
@@ -275,6 +283,7 @@ BUILTIN_OBJS = \
 	builtin-ls-tree.o \
 	builtin-mailinfo.o \
 	builtin-mailsplit.o \
+	builtin-merge-file.o \
 	builtin-mv.o \
 	builtin-name-rev.o \
 	builtin-pack-objects.o \
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
index 357330e..cb5a7ef 100644
--- a/git.c
+++ b/git.c
@@ -242,6 +252,7 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 		{ "ls-tree", cmd_ls_tree, RUN_SETUP },
 		{ "mailinfo", cmd_mailinfo },
 		{ "mailsplit", cmd_mailsplit },
+		{ "merge-file", cmd_merge_file },
 		{ "mv", cmd_mv, RUN_SETUP },
 		{ "name-rev", cmd_name_rev, RUN_SETUP },
 		{ "pack-objects", cmd_pack_objects, RUN_SETUP },
diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
new file mode 100644
index 0000000..5d9b6f3
--- /dev/null
+++ b/t/t6023-merge-file.sh
@@ -0,0 +1,116 @@
+#!/bin/sh
+
+test_description='RCS merge replacement: merge-file'
+. ./test-lib.sh
+
+cat > orig.txt << EOF
+Dominus regit me,
+et nihil mihi deerit.
+In loco pascuae ibi me collocavit,
+super aquam refectionis educavit me;
+animam meam convertit,
+deduxit me super semitas jusitiae,
+propter nomen suum.
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
+Nam et si ambulavero in medio umbrae mortis,
+non timebo mala, quoniam tu mecum es:
+virga tua et baculus tuus ipsa me consolata sunt.
+EOF
+
+cat > new2.txt << EOF
+Dominus regit me, et nihil mihi deerit.
+In loco pascuae ibi me collocavit,
+super aquam refectionis educavit me;
+animam meam convertit,
+deduxit me super semitas jusitiae,
+propter nomen suum.
+EOF
+
+cat > new3.txt << EOF
+DOMINUS regit me,
+et nihil mihi deerit.
+In loco pascuae ibi me collocavit,
+super aquam refectionis educavit me;
+animam meam convertit,
+deduxit me super semitas jusitiae,
+propter nomen suum.
+EOF
+
+cat > new4.txt << EOF
+Dominus regit me, et nihil mihi deerit.
+In loco pascuae ibi me collocavit,
+super aquam refectionis educavit me;
+animam meam convertit,
+deduxit me super semitas jusitiae,
+EOF
+echo -n "propter nomen suum." >> new4.txt
+
+cp new1.txt test.txt
+test_expect_success "merge without conflict" \
+	"git-merge-file test.txt orig.txt new2.txt"
+
+cp new1.txt test2.txt
+test_expect_success "merge without conflict (missing LF at EOF)" \
+	"git-merge-file test2.txt orig.txt new2.txt"
+
+test_expect_success "merge result added missing LF" \
+	"diff -u test.txt test2.txt"
+
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
+EOF
+
+test_expect_success "expected conflict markers" "diff -u test.txt expect.txt"
+
+cp backup.txt test.txt
+test_expect_failure "merge with conflicts, using -L" \
+	"git-merge-file -L 1 -L 2 test.txt orig.txt new3.txt"
+
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
+
+test_expect_success "expected conflict markers, with -L" \
+	"diff -u test.txt expect.txt"
+
+test_done
+
