From: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
Subject: [PATCH 2/8] Make git-mailsplit a builtin
Date: Tue, 13 Jun 2006 22:21:46 +0200
Organization: Chalmers
Message-ID: <448F1E5A.7070204@etek.chalmers.se>
References: <448EF791.7070504@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
X-From: git-owner@vger.kernel.org Tue Jun 13 22:21:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqFOg-0006Uv-0k
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 22:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWFMUVw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 13 Jun 2006 16:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWFMUVw
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 16:21:52 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:28558 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932204AbWFMUVv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jun 2006 16:21:51 -0400
Received: from [192.168.0.82] (213.66.93.165) by pne-smtpout2-sn2.hy.skanova.net (7.2.072.1)
        id 44897AB8000E7234; Tue, 13 Jun 2006 22:21:47 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.4) Gecko/20060603 Thunderbird/1.5.0.4 Mnenhy/0.7.4.666
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <448EF791.7070504@etek.chalmers.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21805>

Signed-off-by: Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>
---
 Makefile                           |    5 +--
 mailsplit.c =3D> builtin-mailsplit.c |   71 +++++++++++++++++++++-----=
----------
 builtin.h                          |    2 +
 git.c                              |    3 +-
 4 files changed, 48 insertions(+), 33 deletions(-)

diff --git a/Makefile b/Makefile
index 37b5e40..7bee30d 100644
--- a/Makefile
+++ b/Makefile
@@ -144,7 +144,6 @@ SCRIPTS =3D $(patsubst %.sh,%,$(SCRIPT_SH)
=20
 # The ones that do not have to link with lcrypto, lz nor xdiff.
 SIMPLE_PROGRAMS =3D \
-	git-mailsplit$X \
 	git-stripspace$X git-daemon$X
=20
 # ... and all the rest that could be moved out of bindir to gitexecdir
@@ -165,7 +164,7 @@ PROGRAMS =3D \
 	git-describe$X git-merge-tree$X git-blame$X git-imap-send$X
=20
 BUILT_INS =3D git-log$X git-whatchanged$X git-show$X \
-	git-count-objects$X git-diff$X git-push$X \
+	git-count-objects$X git-diff$X git-push$X git-mailsplit$X \
 	git-grep$X git-add$X git-rm$X git-rev-list$X \
 	git-check-ref-format$X git-rev-parse$X \
 	git-init-db$X git-tar-tree$X git-upload-tar$X git-format-patch$X \
@@ -227,7 +226,7 @@ BUILTIN_OBJS =3D \
 	builtin-read-tree.o builtin-commit-tree.o \
 	builtin-apply.o builtin-show-branch.o builtin-diff-files.o \
 	builtin-diff-index.o builtin-diff-stages.o builtin-diff-tree.o \
-	builtin-cat-file.o
+	builtin-cat-file.o builtin-mailsplit.o
=20
 GITLIBS =3D $(LIB_FILE) $(XDIFF_LIB)
 LIBS =3D $(GITLIBS) -lz
diff --git a/mailsplit.c b/builtin-mailsplit.c
similarity index 85%
rename from mailsplit.c
rename to builtin-mailsplit.c
index 70a569c..e2a0058 100644
--- a/mailsplit.c
+++ b/builtin-mailsplit.c
@@ -12,6 +12,7 @@ #include <sys/stat.h>
 #include <string.h>
 #include <stdio.h>
 #include "cache.h"
+#include "builtin.h"
=20
 static const char git_mailsplit_usage[] =3D
 "git-mailsplit [-d<prec>] [-f<n>] [-b] -o<directory> <mbox>...";
@@ -102,14 +103,48 @@ static int split_one(FILE *mbox, const c
 	exit(1);
 }
=20
-int main(int argc, const char **argv)
+int split_mbox(const char **mbox, const char *dir, int allow_bare, int=
 nr_prec, int skip)
 {
-	int nr =3D 0, nr_prec =3D 4;
+	char *name =3D xmalloc(strlen(dir) + 2 + 3 * sizeof(skip));
+	int ret =3D -1;
+
+	while (*mbox) {
+		const char *file =3D *mbox++;
+		FILE *f =3D !strcmp(file, "-") ? stdin : fopen(file, "r");
+		int file_done =3D 0;
+
+		if ( !f ) {
+			error("cannot open mbox %s", file);
+			goto out;
+		}
+
+		if (fgets(buf, sizeof(buf), f) =3D=3D NULL) {
+			if (f =3D=3D stdin)
+				break; /* empty stdin is OK */
+			error("cannot read mbox %s", file);
+			goto out;
+		}
+
+		while (!file_done) {
+			sprintf(name, "%s/%0*d", dir, nr_prec, ++skip);
+			file_done =3D split_one(f, name, allow_bare);
+		}
+
+		if (f !=3D stdin)
+			fclose(f);
+	}
+	ret =3D skip;
+out:
+	free(name);
+	return ret;
+}
+int cmd_mailsplit(int argc, const char **argv, char **envp)
+{
+	int nr =3D 0, nr_prec =3D 4, ret;
 	int allow_bare =3D 0;
 	const char *dir =3D NULL;
 	const char **argp;
 	static const char *stdin_only[] =3D { "-", NULL };
-	char *name;
=20
 	for (argp =3D argv+1; *argp; argp++) {
 		const char *arg =3D *argp;
@@ -158,31 +193,9 @@ int main(int argc, const char **argv)
 			argp =3D stdin_only;
 	}
=20
-	name =3D xmalloc(strlen(dir) + 2 + 3 * sizeof(nr));
-
-	while (*argp) {
-		const char *file =3D *argp++;
-		FILE *f =3D !strcmp(file, "-") ? stdin : fopen(file, "r");
-		int file_done =3D 0;
-
-		if ( !f )
-			die ("cannot open mbox %s", file);
-
-		if (fgets(buf, sizeof(buf), f) =3D=3D NULL) {
-			if (f =3D=3D stdin)
-				break; /* empty stdin is OK */
-			die("cannot read mbox %s", file);
-		}
-
-		while (!file_done) {
-			sprintf(name, "%s/%0*d", dir, nr_prec, ++nr);
-			file_done =3D split_one(f, name, allow_bare);
-		}
-
-		if (f !=3D stdin)
-			fclose(f);
-	}
+	ret =3D split_mbox(argp, dir, allow_bare, nr_prec, nr);
+	if (ret !=3D -1)
+		printf("%d\n", ret);
=20
-	printf("%d\n", nr);
-	return 0;
+	return ret =3D=3D -1;
 }
diff --git a/builtin.h b/builtin.h
index 885422e..92e1e1b 100644
--- a/builtin.h
+++ b/builtin.h
@@ -49,4 +49,6 @@ extern int cmd_rev_parse(int argc, const
 extern int cmd_write_tree(int argc, const char **argv, char **envp);
 extern int write_tree(unsigned char *sha1, int missing_ok, const char =
*prefix);
=20
+extern int cmd_mailsplit(int argc, const char **argv, char **envp);
+extern int split_mbox(const char **mbox, const char *dir, int allow_ba=
re, int nr_prec, int skip);
 #endif
diff --git a/git.c b/git.c
index 5868fb9..3264c65 100644
--- a/git.c
+++ b/git.c
@@ -179,7 +179,8 @@ static void handle_internal_command(int=20
 		{ "diff-tree", cmd_diff_tree },
 		{ "cat-file", cmd_cat_file },
 		{ "rev-parse", cmd_rev_parse },
-		{ "write-tree", cmd_write_tree }
+		{ "write-tree", cmd_write_tree },
+		{ "mailsplit", cmd_mailsplit }
 	};
 	int i;
=20
--=20
1.4.0
