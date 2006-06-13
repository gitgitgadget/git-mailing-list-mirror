From: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
Subject: [PATCH 4/8] Make git-stripspace a builtin
Date: Tue, 13 Jun 2006 22:21:53 +0200
Organization: Chalmers
Message-ID: <448F1E61.9080509@etek.chalmers.se>
References: <448EF791.7070504@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
X-From: git-owner@vger.kernel.org Tue Jun 13 22:22:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqFOo-0006XX-5e
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 22:22:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWFMUV7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 13 Jun 2006 16:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWFMUV6
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 16:21:58 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:28558 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932206AbWFMUV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jun 2006 16:21:57 -0400
Received: from [192.168.0.82] (213.66.93.165) by pne-smtpout2-sn2.hy.skanova.net (7.2.072.1)
        id 44897AB8000E7252; Tue, 13 Jun 2006 22:21:54 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.4) Gecko/20060603 Thunderbird/1.5.0.4 Mnenhy/0.7.4.666
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <448EF791.7070504@etek.chalmers.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21808>

Signed-off-by: Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>
---
 Makefile                             |    6 +++---
 stripspace.c =3D> builtin-stripspace.c |   16 +++++++++++-----
 builtin.h                            |    6 ++++--
 git.c                                |    3 ++-
 4 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index e64d943..181255f 100644
--- a/Makefile
+++ b/Makefile
@@ -144,7 +144,7 @@ SCRIPTS =3D $(patsubst %.sh,%,$(SCRIPT_SH)
=20
 # The ones that do not have to link with lcrypto, lz nor xdiff.
 SIMPLE_PROGRAMS =3D \
-	git-stripspace$X git-daemon$X
+	git-daemon$X
=20
 # ... and all the rest that could be moved out of bindir to gitexecdir
 PROGRAMS =3D \
@@ -165,7 +165,7 @@ PROGRAMS =3D \
=20
 BUILT_INS =3D git-log$X git-whatchanged$X git-show$X \
 	git-count-objects$X git-diff$X git-push$X git-mailsplit$X \
-	git-grep$X git-add$X git-rm$X git-rev-list$X \
+	git-grep$X git-add$X git-rm$X git-rev-list$X git-stripspace$X \
 	git-check-ref-format$X git-rev-parse$X git-mailinfo$X \
 	git-init-db$X git-tar-tree$X git-upload-tar$X git-format-patch$X \
 	git-ls-files$X git-ls-tree$X git-get-tar-commit-id$X \
@@ -226,7 +226,7 @@ BUILTIN_OBJS =3D \
 	builtin-read-tree.o builtin-commit-tree.o builtin-mailinfo.o \
 	builtin-apply.o builtin-show-branch.o builtin-diff-files.o \
 	builtin-diff-index.o builtin-diff-stages.o builtin-diff-tree.o \
-	builtin-cat-file.o builtin-mailsplit.o
+	builtin-cat-file.o builtin-mailsplit.o builtin-stripspace.o
=20
 GITLIBS =3D $(LIB_FILE) $(XDIFF_LIB)
 LIBS =3D $(GITLIBS) -lz
diff --git a/stripspace.c b/builtin-stripspace.c
similarity index 76%
rename from stripspace.c
rename to builtin-stripspace.c
index 65a6346..2ce1264 100644
--- a/stripspace.c
+++ b/builtin-stripspace.c
@@ -1,6 +1,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <ctype.h>
+#include "builtin.h"
=20
 /*
  * Remove empty lines from the beginning and end.
@@ -28,21 +29,21 @@ static int cleanup(char *line)
 	return 1;
 }
=20
-int main(int argc, char **argv)
+void stripspace(FILE *in, FILE *out)
 {
 	int empties =3D -1;
 	int incomplete =3D 0;
 	char line[1024];
=20
-	while (fgets(line, sizeof(line), stdin)) {
+	while (fgets(line, sizeof(line), in)) {
 		incomplete =3D cleanup(line);
=20
 		/* Not just an empty line? */
 		if (line[0] !=3D '\n') {
 			if (empties > 0)
-				putchar('\n');
+				fputc('\n', out);
 			empties =3D 0;
-			fputs(line, stdout);
+			fputs(line, out);
 			continue;
 		}
 		if (empties < 0)
@@ -50,6 +51,11 @@ int main(int argc, char **argv)
 		empties++;
 	}
 	if (incomplete)
-		putchar('\n');
+		fputc('\n', out);
+}
+
+int cmd_stripspace(int argc, const char **argv, char **envp)
+{
+	stripspace(stdin, stdout);
 	return 0;
 }
diff --git a/builtin.h b/builtin.h
index 979e0cd..c934d7a 100644
--- a/builtin.h
+++ b/builtin.h
@@ -55,6 +55,8 @@ extern int cmd_mailsplit(int argc, const
 extern int split_mbox(const char **mbox, const char *dir, int allow_ba=
re, int nr_prec, int skip);
=20
 extern int cmd_mailinfo(int argc, const char **argv, char **envp);
-extern int mailinfo(FILE *in, FILE *out, int ks, char *encoding,
-		    const char *msg, const char *patch);
+extern int mailinfo(FILE *in, FILE *out, int ks, char *encoding, const=
 char *msg, const char *patch);
+
+extern int cmd_stripspace(int argc, const char **argv, char **envp);
+extern void stripspace(FILE *in, FILE *out);
 #endif
diff --git a/git.c b/git.c
index 1e216de..31196f5 100644
--- a/git.c
+++ b/git.c
@@ -181,7 +181,8 @@ static void handle_internal_command(int=20
 		{ "rev-parse", cmd_rev_parse },
 		{ "write-tree", cmd_write_tree },
 		{ "mailsplit", cmd_mailsplit },
-		{ "mailinfo", cmd_mailinfo }
+		{ "mailinfo", cmd_mailinfo },
+		{ "stripspace", cmd_stripspace }
 	};
 	int i;
=20
--=20
1.4.0
