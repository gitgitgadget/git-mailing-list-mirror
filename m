From: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
Subject: [PATCH 3/8] Make git-mailinfo a builtin
Date: Tue, 13 Jun 2006 22:21:50 +0200
Organization: Chalmers
Message-ID: <448F1E5E.3060802@etek.chalmers.se>
References: <448EF791.7070504@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
X-From: git-owner@vger.kernel.org Tue Jun 13 22:22:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqFOg-0006Uv-J2
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 22:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWFMUVy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 13 Jun 2006 16:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWFMUVy
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 16:21:54 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:28558 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932205AbWFMUVx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jun 2006 16:21:53 -0400
Received: from [192.168.0.82] (213.66.93.165) by pne-smtpout2-sn2.hy.skanova.net (7.2.072.1)
        id 44897AB8000E723A; Tue, 13 Jun 2006 22:21:50 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.4) Gecko/20060603 Thunderbird/1.5.0.4 Mnenhy/0.7.4.666
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <448EF791.7070504@etek.chalmers.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21807>

Signed-off-by: Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>
---
 Makefile                         |   12 ++---
 mailinfo.c =3D> builtin-mailinfo.c |   85 ++++++++++++++++++++++------=
----------
 builtin.h                        |    6 +++
 git.c                            |    3 +
 4 files changed, 62 insertions(+), 44 deletions(-)

diff --git a/Makefile b/Makefile
index 7bee30d..e64d943 100644
--- a/Makefile
+++ b/Makefile
@@ -151,7 +151,7 @@ PROGRAMS =3D \
 	git-checkout-index$X git-clone-pack$X \
 	git-convert-objects$X git-fetch-pack$X git-fsck-objects$X \
 	git-hash-object$X git-index-pack$X git-local-fetch$X \
-	git-mailinfo$X git-merge-base$X \
+	git-merge-base$X \
 	git-merge-index$X git-mktag$X git-mktree$X git-pack-objects$X git-pat=
ch-id$X \
 	git-peek-remote$X git-prune-packed$X git-receive-pack$X \
 	git-send-pack$X git-shell$X \
@@ -166,7 +166,7 @@ PROGRAMS =3D \
 BUILT_INS =3D git-log$X git-whatchanged$X git-show$X \
 	git-count-objects$X git-diff$X git-push$X git-mailsplit$X \
 	git-grep$X git-add$X git-rm$X git-rev-list$X \
-	git-check-ref-format$X git-rev-parse$X \
+	git-check-ref-format$X git-rev-parse$X git-mailinfo$X \
 	git-init-db$X git-tar-tree$X git-upload-tar$X git-format-patch$X \
 	git-ls-files$X git-ls-tree$X git-get-tar-commit-id$X \
 	git-read-tree$X git-commit-tree$X git-write-tree$X \
@@ -223,7 +223,7 @@ BUILTIN_OBJS =3D \
 	builtin-rm.o builtin-init-db.o builtin-rev-parse.o \
 	builtin-tar-tree.o builtin-upload-tar.o \
 	builtin-ls-files.o builtin-ls-tree.o builtin-write-tree.o \
-	builtin-read-tree.o builtin-commit-tree.o \
+	builtin-read-tree.o builtin-commit-tree.o builtin-mailinfo.o \
 	builtin-apply.o builtin-show-branch.o builtin-diff-files.o \
 	builtin-diff-index.o builtin-diff-stages.o builtin-diff-tree.o \
 	builtin-cat-file.o builtin-mailsplit.o
@@ -486,7 +486,7 @@ strip: $(PROGRAMS) git$X
 git$X: git.c common-cmds.h $(BUILTIN_OBJS) $(GITLIBS)
 	$(CC) -DGIT_VERSION=3D'"$(GIT_VERSION)"' \
 		$(ALL_CFLAGS) -o $@ $(filter %.c,$^) \
-		$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
+		$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS) $(LIB_4_ICONV)
=20
 builtin-help.o: common-cmds.h
=20
@@ -563,10 +563,6 @@ git-%$X: %.o $(GITLIBS)
 	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIB_FILE) $(SIMPLE_LIB)
=20
-git-mailinfo$X: mailinfo.o $(LIB_FILE)
-	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
-		$(LIB_FILE) $(SIMPLE_LIB) $(LIB_4_ICONV)
-
 git-local-fetch$X: fetch.o
 git-ssh-fetch$X: rsh.o fetch.o
 git-ssh-upload$X: rsh.o
diff --git a/mailinfo.c b/builtin-mailinfo.c
similarity index 94%
rename from mailinfo.c
rename to builtin-mailinfo.c
index 5b6c215..6e30758 100644
--- a/mailinfo.c
+++ b/builtin-mailinfo.c
@@ -12,8 +12,9 @@ #include <iconv.h>
 #endif
 #include "git-compat-util.h"
 #include "cache.h"
+#include "builtin.h"
=20
-static FILE *cmitmsg, *patchfile;
+static FILE *cmitmsg, *patchfile, *fin, *fout;
=20
 static int keep_subject =3D 0;
 static char *metainfo_charset =3D NULL;
@@ -49,7 +50,7 @@ static int bogus_from(char *line)
=20
 	/* This is fallback, so do not bother if we already have an
 	 * e-mail address.
-	 */=20
+	 */
 	if (*email)
 		return 0;
=20
@@ -311,12 +312,12 @@ static char *cleanup_subject(char *subje
 			if (remove <=3D len *2) {
 				subject =3D p+1;
 				continue;
-			}=09
+			}
 			break;
 		}
 		return subject;
 	}
-}		=09
+}
=20
 static void cleanup_space(char *buf)
 {
@@ -638,7 +639,7 @@ static void handle_info(void)
 	cleanup_space(email);
 	cleanup_space(sub);
=20
-	printf("Author: %s\nEmail: %s\nSubject: %s\nDate: %s\n\n",
+	fprintf(fout, "Author: %s\nEmail: %s\nSubject: %s\nDate: %s\n\n",
 	       name, email, sub, date);
 }
=20
@@ -675,7 +676,7 @@ static int handle_commit_msg(int *seen)
 			continue;
=20
 		fputs(line, cmitmsg);
-	} while (fgets(line, sizeof(line), stdin) !=3D NULL);
+	} while (fgets(line, sizeof(line), fin) !=3D NULL);
 	fclose(cmitmsg);
 	cmitmsg =3D NULL;
 	return 0;
@@ -696,7 +697,7 @@ static void handle_patch(void)
 		decode_transfer_encoding(line);
 		fputs(line, patchfile);
 		patch_lines++;
-	} while (fgets(line, sizeof(line), stdin) !=3D NULL);
+	} while (fgets(line, sizeof(line), fin) !=3D NULL);
 }
=20
 /* multipart boundary and transfer encoding are set up for us, and we
@@ -709,7 +710,7 @@ static int handle_multipart_one_part(int
 {
 	int n =3D 0;
=20
-	while (fgets(line, sizeof(line), stdin) !=3D NULL) {
+	while (fgets(line, sizeof(line), fin) !=3D NULL) {
 	again:
 		n++;
 		if (is_multipart_boundary(line))
@@ -730,7 +731,7 @@ static void handle_multipart_body(void)
 	int part_num =3D 0;
=20
 	/* Skip up to the first boundary */
-	while (fgets(line, sizeof(line), stdin) !=3D NULL)
+	while (fgets(line, sizeof(line), fin) !=3D NULL)
 		if (is_multipart_boundary(line)) {
 			part_num =3D 1;
 			break;
@@ -739,7 +740,7 @@ static void handle_multipart_body(void)
 		return;
 	/* We are on boundary line.  Start slurping the subhead. */
 	while (1) {
-		int hdr =3D read_one_header_line(line, sizeof(line), stdin);
+		int hdr =3D read_one_header_line(line, sizeof(line), fin);
 		if (!hdr) {
 			if (handle_multipart_one_part(&seen) < 0)
 				return;
@@ -762,7 +763,7 @@ static void handle_body(void)
 {
 	int seen =3D 0;
=20
-	if (line[0] || fgets(line, sizeof(line), stdin) !=3D NULL) {
+	if (line[0] || fgets(line, sizeof(line), fin) !=3D NULL) {
 		handle_commit_msg(&seen);
 		handle_patch();
 	}
@@ -773,10 +774,45 @@ static void handle_body(void)
 	}
 }
=20
+int mailinfo(FILE *in, FILE *out, int ks, char *encoding,
+	     const char *msg, const char *patch)
+{
+	keep_subject =3D ks;
+	metainfo_charset =3D encoding;
+	fin =3D in;
+	fout =3D out;
+
+	cmitmsg =3D fopen(msg, "w");
+	if (!cmitmsg) {
+		perror(msg);
+		return -1;
+	}
+	patchfile =3D fopen(patch, "w");
+	if (!patchfile) {
+		perror(patch);
+		fclose(cmitmsg);
+		return -1;
+	}
+	while (1) {
+		int hdr =3D read_one_header_line(line, sizeof(line), fin);
+		if (!hdr) {
+			if (multipart_boundary[0])
+				handle_multipart_body();
+			else
+				handle_body();
+			handle_info();
+			break;
+		}
+		check_header_line(line);
+	}
+
+	return 0;
+}
+
 static const char mailinfo_usage[] =3D
 	"git-mailinfo [-k] [-u | --encoding=3D<encoding>] msg patch <mail >in=
fo";
=20
-int main(int argc, char **argv)
+int cmd_mailinfo(int argc, const char **argv, char **envp)
 {
 	/* NEEDSWORK: might want to do the optional .git/ directory
 	 * discovery
@@ -797,27 +833,6 @@ int main(int argc, char **argv)
=20
 	if (argc !=3D 3)
 		usage(mailinfo_usage);
-	cmitmsg =3D fopen(argv[1], "w");
-	if (!cmitmsg) {
-		perror(argv[1]);
-		exit(1);
-	}
-	patchfile =3D fopen(argv[2], "w");
-	if (!patchfile) {
-		perror(argv[2]);
-		exit(1);
-	}
-	while (1) {
-		int hdr =3D read_one_header_line(line, sizeof(line), stdin);
-		if (!hdr) {
-			if (multipart_boundary[0])
-				handle_multipart_body();
-			else
-				handle_body();
-			handle_info();
-			break;
-		}
-		check_header_line(line);
-	}
-	return 0;
+
+	return !!mailinfo(stdin, stdout, keep_subject, metainfo_charset, argv=
[1], argv[2]);
 }
diff --git a/builtin.h b/builtin.h
index 92e1e1b..979e0cd 100644
--- a/builtin.h
+++ b/builtin.h
@@ -1,6 +1,8 @@
 #ifndef BUILTIN_H
 #define BUILTIN_H
=20
+#include <stdio.h>
+
 #ifndef PATH_MAX
 # define PATH_MAX 4096
 #endif
@@ -51,4 +53,8 @@ extern int write_tree(unsigned char *sha
=20
 extern int cmd_mailsplit(int argc, const char **argv, char **envp);
 extern int split_mbox(const char **mbox, const char *dir, int allow_ba=
re, int nr_prec, int skip);
+
+extern int cmd_mailinfo(int argc, const char **argv, char **envp);
+extern int mailinfo(FILE *in, FILE *out, int ks, char *encoding,
+		    const char *msg, const char *patch);
 #endif
diff --git a/git.c b/git.c
index 3264c65..1e216de 100644
--- a/git.c
+++ b/git.c
@@ -180,7 +180,8 @@ static void handle_internal_command(int=20
 		{ "cat-file", cmd_cat_file },
 		{ "rev-parse", cmd_rev_parse },
 		{ "write-tree", cmd_write_tree },
-		{ "mailsplit", cmd_mailsplit }
+		{ "mailsplit", cmd_mailsplit },
+		{ "mailinfo", cmd_mailinfo }
 	};
 	int i;
=20
--=20
1.4.0
