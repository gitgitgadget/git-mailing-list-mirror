From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/12] dir.c: keep track of where patterns came from
Date: Mon, 15 Oct 2012 13:28:02 +0700
Message-ID: <1350282486-4646-8-git-send-email-pclouds@gmail.com>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
 <1350282486-4646-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Adam Spiers <git@adamspiers.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 08:29:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNeBC-0001Qw-9j
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 08:29:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753183Ab2JOG3X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 02:29:23 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:55849 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821Ab2JOG3W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 02:29:22 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so4544170pad.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 23:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=256YbXDMIza7SfESeKYadSmTuOT9Qw4SpXp6BKN86EI=;
        b=PbwjVcnuZ9P4auBd57ICo0hzFYH/0oFbeOc9cF3ASfQQ5Rl3PnF2TRm/D9m1Wgsq8S
         yNr3u1hKXZkHOlqRv78BQgjl5vuJzarfEOsksac9IN8/tbLitmTudtc46c7s4JYHGC3z
         Iz5cIns13FpFi/WFGmmjnwpk2wYfy1nDy0TVZsuoJ2hvpFyU5t7Q/+fjp3SV3kpk+DIc
         D7Gx1Nh93QzRXQ+1QgozSCDXo19SAyJgfZT0MEguNyuAVaSwDPHfmKAQzR4cOkkBwPp8
         GnkSaxwkAfAfxPaHSUBFwmjz111x3U1D4aVDntCp3NQaYXEoDxNH9E8Ppg9uV3gDcrXM
         uWyQ==
Received: by 10.68.220.169 with SMTP id px9mr35156544pbc.14.1350282562382;
        Sun, 14 Oct 2012 23:29:22 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id oe5sm8585484pbb.8.2012.10.14.23.29.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 23:29:21 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Oct 2012 13:29:12 +0700
X-Mailer: git-send-email 1.8.0.rc0.29.g1fdd78f
In-Reply-To: <1350282486-4646-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207719>

=46rom: Adam Spiers <git@adamspiers.org>

=46or exclude patterns read in from files, the filename is stored toget=
her
with the corresponding line number (counting starting at 1).

=46or exclude patterns provided on the command line, the sequence numbe=
r
is negative, with counting starting at -1, so for example the 2nd
pattern provided via --exclude would be numbered -2.  This allows any
future consumers of that data to easily distinguish between exclude
patterns from files vs. from the CLI.

Signed-off-by: Adam Spiers <git@adamspiers.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clean.c    |  2 +-
 builtin/ls-files.c |  3 ++-
 dir.c              | 26 ++++++++++++++++++++------
 dir.h              |  5 ++++-
 4 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 0c7b3d0..f618231 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -99,7 +99,7 @@ int cmd_clean(int argc, const char **argv, const char=
 *prefix)
=20
 	for (i =3D 0; i < exclude_list.nr; i++)
 		add_exclude(exclude_list.items[i].string, "", 0,
-			    &dir.exclude_list[EXC_CMDL]);
+			    &dir.exclude_list[EXC_CMDL], "--exclude option", -(i+1));
=20
 	pathspec =3D get_pathspec(prefix, argv);
=20
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index ef7f99a..db3c081 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -35,6 +35,7 @@ static int error_unmatch;
 static char *ps_matched;
 static const char *with_tree;
 static int exc_given;
+static int exclude_args;
=20
 static const char *tag_cached =3D "";
 static const char *tag_unmerged =3D "";
@@ -423,7 +424,7 @@ static int option_parse_exclude(const struct option=
 *opt,
 	struct exclude_list *list =3D opt->value;
=20
 	exc_given =3D 1;
-	add_exclude(arg, "", 0, list);
+	add_exclude(arg, "", 0, list, "--exclude option", --exclude_args);
=20
 	return 0;
 }
diff --git a/dir.c b/dir.c
index 84ab826..81a5dd5 100644
--- a/dir.c
+++ b/dir.c
@@ -347,7 +347,8 @@ void parse_exclude_pattern(const char **pattern,
 }
=20
 void add_exclude(const char *string, const char *base,
-		 int baselen, struct exclude_list *el)
+		 int baselen, struct exclude_list *el,
+		 const char *src, int srcpos)
 {
 	struct exclude *x;
 	int patternlen;
@@ -371,6 +372,8 @@ void add_exclude(const char *string, const char *ba=
se,
 	x->base =3D base;
 	x->baselen =3D baselen;
 	x->flags =3D flags;
+	x->src =3D src;
+	x->srcpos =3D srcpos;
 	ALLOC_GROW(el->excludes, el->nr + 1, el->alloc);
 	el->excludes[el->nr++] =3D x;
 }
@@ -418,7 +421,7 @@ int add_excludes_from_file_to_list(const char *fnam=
e,
 				   int check_index)
 {
 	struct stat st;
-	int fd, i;
+	int fd, i, lineno =3D 1;
 	size_t size =3D 0;
 	char *buf, *entry;
=20
@@ -461,8 +464,10 @@ int add_excludes_from_file_to_list(const char *fna=
me,
 		if (buf[i] =3D=3D '\n') {
 			if (entry !=3D buf + i && entry[0] !=3D '#') {
 				buf[i - (i && buf[i-1] =3D=3D '\r')] =3D 0;
-				add_exclude(entry, base, baselen, el);
+				add_exclude(entry, base, baselen, el,
+					    fname, lineno);
 			}
+			lineno++;
 			entry =3D buf + i + 1;
 		}
 	}
@@ -493,8 +498,10 @@ static void prep_exclude(struct dir_struct *dir, c=
onst char *base, int baselen)
 		    !strncmp(dir->basebuf, base, stk->baselen))
 			break;
 		dir->exclude_stack =3D stk->prev;
-		while (stk->exclude_ix < el->nr)
-			free(el->excludes[--el->nr]);
+		while (stk->exclude_ix < el->nr) {
+			struct exclude *exclude =3D el->excludes[--el->nr];
+			free(exclude);
+		}
 		free(stk->filebuf);
 		free(stk);
 	}
@@ -521,7 +528,14 @@ static void prep_exclude(struct dir_struct *dir, c=
onst char *base, int baselen)
 		memcpy(dir->basebuf + current, base + current,
 		       stk->baselen - current);
 		strcpy(dir->basebuf + stk->baselen, dir->exclude_per_dir);
-		add_excludes_from_file_to_list(dir->basebuf,
+
+		/*
+		 * dir->basebuf gets reused by the traversal, but we
+		 * need fname to remain unchanged to ensure the src
+		 * member of each struct exclude correctly back-references
+		 * its source file.
+		 */
+		add_excludes_from_file_to_list(strdup(dir->basebuf),
 					       dir->basebuf, stk->baselen,
 					       &stk->filebuf, el, 1);
 		dir->exclude_stack =3D stk;
diff --git a/dir.h b/dir.h
index 02ac0bf..3921aa9 100644
--- a/dir.h
+++ b/dir.h
@@ -23,6 +23,9 @@ struct exclude_list {
 		const char *base;
 		int baselen;
 		int flags;
+		const char *src;
+		int srcpos; /* counting starts from 1 for line numbers in ignore fil=
es,
+			       and from -1 decrementing for patterns from CLI (--exclude) *=
/
 	} **excludes;
 };
=20
@@ -112,7 +115,7 @@ extern int add_excludes_from_file_to_list(const cha=
r *fname, const char *base, i
 extern void add_excludes_from_file(struct dir_struct *, const char *fn=
ame);
 extern void parse_exclude_pattern(const char **string, int *patternlen=
, int *flags, int *nowildcardlen);
 extern void add_exclude(const char *string, const char *base,
-			int baselen, struct exclude_list *el);
+			int baselen, struct exclude_list *el, const char *src, int srcpos);
 extern void free_excludes(struct exclude_list *el);
 extern int file_exists(const char *);
=20
--=20
1.8.0.rc0.29.g1fdd78f
