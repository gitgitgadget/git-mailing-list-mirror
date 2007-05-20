From: "Fernando J. Pereda" <ferdy@gentoo.org>
Subject: [PATCH] Teach mailsplit about Maildir's
Date: Sun, 20 May 2007 20:14:47 +0200
Message-ID: <20070520181447.GA10638@ferdyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 20:15:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hppvp-0000aI-JE
	for gcvg-git@gmane.org; Sun, 20 May 2007 20:15:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757041AbXETSO4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 20 May 2007 14:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757162AbXETSO4
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 14:14:56 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:57025 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757041AbXETSOz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 14:14:55 -0400
Received: by ug-out-1314.google.com with SMTP id 44so973839uga
        for <git@vger.kernel.org>; Sun, 20 May 2007 11:14:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent:sender;
        b=Nxn9t2lRkUC1QWk1Pm1bBy/tu3P6M5BY2jKkgbgHaHNlH+i6Eaq4W+OVKuibeIZgbWCbH7hw1Zr64LZBdOvc7oL8GgKtSPq74GwHljYEQPInokknn612eZSOJjQIaKWq2QtMG6gbZ/nZggSgh9VJZPAmGiaSrvaoDQCsSojT7wU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent:sender;
        b=Hy/LOtHb/9afBWGGdxOxQCqXHr8iAYP4PPXqVZIn1O8TcPBTG2unb3Bobt7vHQqTw0ju9YmS/Aq3BoL/2/NLb+ho46WcnFjZczuztIfUPtUi+Md2g1gxTVts4Cmi47lPbT3IMLrDPv8BkVjzfUQK34qSwlfN0PympFFaGvfs6sQ=
Received: by 10.67.15.15 with SMTP id s15mr2798152ugi.1179684891959;
        Sun, 20 May 2007 11:14:51 -0700 (PDT)
Received: from posidon.ferdyx.org ( [213.96.222.170])
        by mx.google.com with ESMTP id 55sm6207062ugq.2007.05.20.11.14.48;
        Sun, 20 May 2007 11:14:51 -0700 (PDT)
Received: by posidon.ferdyx.org (nbSMTP-1.01-cvs) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	ferdy@ferdyx.org; Sun, 20 May 2007 20:14:49 +0200 (CEST)
Mail-Followup-To: "Fernando J. Pereda" <ferdy@gentoo.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47879>

Signed-off-by: Fernando J. Pereda <ferdy@gentoo.org>
---

	I never got ACK or NACK when I sent it the first time, that's why
	I'm resending this one with (almost) no changes.

 Documentation/git-am.txt        |    8 ++-
 Documentation/git-mailsplit.txt |   13 +++-
 builtin-mailsplit.c             |  122 +++++++++++++++++++++++++++++++=
+------
 builtin.h                       |    2 +-
 4 files changed, 118 insertions(+), 27 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index ba79773..25cf84a 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -12,7 +12,8 @@ SYNOPSIS
 'git-am' [--signoff] [--dotest=3D<dir>] [--keep] [--utf8 | --no-utf8]
          [--3way] [--interactive] [--binary]
          [--whitespace=3D<option>] [-C<n>] [-p<n>]
-         <mbox>...
+         <mbox>|<Maildir>...
+
 'git-am' [--skip | --resolved]
=20
 DESCRIPTION
@@ -23,9 +24,10 @@ current branch.
=20
 OPTIONS
 -------
-<mbox>...::
+<mbox>|<Maildir>...::
 	The list of mailbox files to read patches from. If you do not
-	supply this argument, reads from the standard input.
+	supply this argument, reads from the standard input. If you supply
+	directories, they'll be treated as Maildirs.
=20
 -s, --signoff::
 	Add `Signed-off-by:` line to the commit message, using
diff --git a/Documentation/git-mailsplit.txt b/Documentation/git-mailsp=
lit.txt
index c11d6a5..abb0903 100644
--- a/Documentation/git-mailsplit.txt
+++ b/Documentation/git-mailsplit.txt
@@ -7,12 +7,15 @@ git-mailsplit - Simple UNIX mbox splitter program
=20
 SYNOPSIS
 --------
-'git-mailsplit' [-b] [-f<nn>] [-d<prec>] -o<directory> [--] [<mbox>...=
]
+'git-mailsplit' [-b] [-f<nn>] [-d<prec>] -o<directory> [--] [<mbox>|<M=
aildir>...]
=20
 DESCRIPTION
 -----------
-Splits a mbox file into a list of files: "0001" "0002" ..  in the spec=
ified
-directory so you can process them further from there.
+Splits a mbox file or a Maildir into a list of files: "0001" "0002" ..=
  in the
+specified directory so you can process them further from there.
+
+IMPORTANT: Maildir splitting relies upon filenames being sorted to out=
put
+patches in the correct order.
=20
 OPTIONS
 -------
@@ -20,6 +23,10 @@ OPTIONS
 	Mbox file to split.  If not given, the mbox is read from
 	the standard input.
=20
+<Maildir>::
+	Root of the Maildir to split. This directory should contain the cur, =
tmp
+	and new subdirectories.
+
 <directory>::
 	Directory in which to place the individual messages.
=20
diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
index 3bca855..1d096d6 100644
--- a/builtin-mailsplit.c
+++ b/builtin-mailsplit.c
@@ -6,9 +6,10 @@
  */
 #include "cache.h"
 #include "builtin.h"
+#include "path-list.h"
=20
 static const char git_mailsplit_usage[] =3D
-"git-mailsplit [-d<prec>] [-f<n>] [-b] -o<directory> <mbox>...";
+"git-mailsplit [-d<prec>] [-f<n>] [-b] -o<directory> <mbox>|<Maildir>.=
=2E.";
=20
 static int is_from_line(const char *line, int len)
 {
@@ -96,44 +97,106 @@ static int split_one(FILE *mbox, const char *name,=
 int allow_bare)
 	exit(1);
 }
=20
-int split_mbox(const char **mbox, const char *dir, int allow_bare, int=
 nr_prec, int skip)
+static int populate_maildir_list(struct path_list *list, const char *p=
ath)
 {
-	char *name =3D xmalloc(strlen(dir) + 2 + 3 * sizeof(skip));
+	DIR *dir;
+	struct dirent *dent;
+
+	if ((dir =3D opendir(path)) =3D=3D NULL) {
+		error("cannot diropen %s (%s)", path, strerror(errno));
+		return -1;
+	}
+
+	while ((dent =3D readdir(dir)) !=3D NULL) {
+		if (dent->d_name[0] =3D=3D '.')
+			continue;
+		path_list_insert(dent->d_name, list);
+	}
+
+	closedir(dir);
+
+	return 1;
+}
+
+static int split_maildir(const char *maildir, const char *dir,
+	int nr_prec, int skip)
+{
+	char file[PATH_MAX];
+	char curdir[PATH_MAX];
+	char name[PATH_MAX];
 	int ret =3D -1;
+	struct path_list list =3D {NULL, 0, 0, 1};
=20
-	while (*mbox) {
-		const char *file =3D *mbox++;
-		FILE *f =3D !strcmp(file, "-") ? stdin : fopen(file, "r");
-		int file_done =3D 0;
+	snprintf(curdir, sizeof(curdir), "%s/cur", maildir);
+	if (populate_maildir_list(&list, curdir) < 0)
+		goto out;
=20
-		if ( !f ) {
-			error("cannot open mbox %s", file);
+	int i;
+	for (i =3D 0; i < list.nr; i++) {
+		snprintf(file, sizeof(file), "%s/%s", curdir, list.items[i].path);
+		FILE *f =3D fopen(file, "r");
+		if (!f) {
+			error("cannot open mail %s (%s)", file, strerror(errno));
 			goto out;
 		}
=20
 		if (fgets(buf, sizeof(buf), f) =3D=3D NULL) {
-			if (f =3D=3D stdin)
-				break; /* empty stdin is OK */
-			error("cannot read mbox %s", file);
+			error("cannot read mail %s (%s)", file, strerror(errno));
 			goto out;
 		}
=20
-		while (!file_done) {
-			sprintf(name, "%s/%0*d", dir, nr_prec, ++skip);
-			file_done =3D split_one(f, name, allow_bare);
+		sprintf(name, "%s/%0*d", dir, nr_prec, ++skip);
+		split_one(f, name, 1);
+
+		fclose(f);
+	}
+
+	path_list_clear(&list, 1);
+
+	ret =3D skip;
+out:
+	return ret;
+}
+
+int split_mbox(const char *file, const char *dir, int allow_bare,
+		int nr_prec, int skip)
+{
+	char name[PATH_MAX];
+	int ret =3D -1;
+
+	FILE *f =3D !strcmp(file, "-") ? stdin : fopen(file, "r");
+	int file_done =3D 0;
+
+	if (!f) {
+		error("cannot open mbox %s", file);
+		goto out;
+	}
+
+	if (fgets(buf, sizeof(buf), f) =3D=3D NULL) {
+		/* empty stdin is OK */
+		if (f !=3D stdin) {
+			error("cannot read mbox %s", file);
+			goto out;
 		}
+		file_done =3D 1;
+	}
=20
-		if (f !=3D stdin)
-			fclose(f);
+	while (!file_done) {
+		sprintf(name, "%s/%0*d", dir, nr_prec, ++skip);
+		file_done =3D split_one(f, name, allow_bare);
 	}
+
+	if (f !=3D stdin)
+		fclose(f);
+
 	ret =3D skip;
 out:
-	free(name);
 	return ret;
 }
+
 int cmd_mailsplit(int argc, const char **argv, const char *prefix)
 {
-	int nr =3D 0, nr_prec =3D 4, ret;
+	int nr =3D 0, nr_prec =3D 4, ret =3D 0;
 	int allow_bare =3D 0;
 	const char *dir =3D NULL;
 	const char **argp;
@@ -186,7 +249,26 @@ int cmd_mailsplit(int argc, const char **argv, con=
st char *prefix)
 			argp =3D stdin_only;
 	}
=20
-	ret =3D split_mbox(argp, dir, allow_bare, nr_prec, nr);
+	while (*argp) {
+		const char *arg =3D *argp++;
+		struct stat argstat;
+
+		if (arg[0] =3D=3D '-' && arg[1] =3D=3D 0) {
+			ret |=3D split_mbox(arg, dir, allow_bare, nr_prec, nr);
+			continue;
+		}
+
+		if (stat(arg, &argstat) =3D=3D -1) {
+			error("cannot stat %s (%s)", arg, strerror(errno));
+			return 1;
+		}
+
+		if (S_ISDIR(argstat.st_mode))
+			ret |=3D split_maildir(arg, dir, nr_prec, nr);
+		else
+			ret |=3D split_mbox(arg, dir, allow_bare, nr_prec, nr);
+	}
+
 	if (ret !=3D -1)
 		printf("%d\n", ret);
=20
diff --git a/builtin.h b/builtin.h
index d3f3a74..39290d1 100644
--- a/builtin.h
+++ b/builtin.h
@@ -8,7 +8,7 @@ extern const char git_usage_string[];
=20
 extern void help_unknown_cmd(const char *cmd);
 extern int mailinfo(FILE *in, FILE *out, int ks, const char *encoding,=
 const char *msg, const char *patch);
-extern int split_mbox(const char **mbox, const char *dir, int allow_ba=
re, int nr_prec, int skip);
+extern int split_mbox(const char *file, const char *dir, int allow_bar=
e, int nr_prec, int skip);
 extern void stripspace(FILE *in, FILE *out);
 extern int write_tree(unsigned char *sha1, int missing_ok, const char =
*prefix);
 extern void prune_packed_objects(int);
--=20
1.5.2


--=20
=46ernando J. Pereda Garcimart=EDn
20BB BDC3 761A 4781 E6ED  ED0B 0A48 5B0C 60BD 28D4
