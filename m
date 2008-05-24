From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH] git-grep: add --color to highlight matches
Date: Sat, 24 May 2008 11:31:19 +0700
Message-ID: <20080524043118.GA23118@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 24 06:32:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzlQX-0003FM-TV
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 06:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbYEXEb0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 May 2008 00:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbYEXEb0
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 00:31:26 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:38269 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195AbYEXEbY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 00:31:24 -0400
Received: by wf-out-1314.google.com with SMTP id 27so795313wfd.4
        for <git@vger.kernel.org>; Fri, 23 May 2008 21:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        bh=60Rrls9wZl5ycm+b/0CV+q4QifI/5xTgktggGaPoNQc=;
        b=T7+dLb71Wxh7n7QR8ncYHZHKPwHrM5xU7m17fViUcyB/UoGviVy1sOT5Eh3dOp+HGdi//5MTdthNCGjaC9edMdvVNKZ9/eWilBkZBDnRJ/xYWRH8rM7jUrx8CnClgelRLoOqMTMIGZ4MNYQRt2sBbYmjQDDXEavZjmEQWVsfTfI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        b=AnKxIfC6IdV8KdbUIosHy51VStiuhpeICfSmU077X7RYBRSah501VT9Ii17G6joiGB/P+stDBAC0HM9HlG6XLuoImAznzaAMfWdsOWHw4+DYSdiDKpdk0pAwNYkfClIaDXrmNyjCNdt6ENIvqWMmOonkcgGl0g+jSEvHtFcirlc=
Received: by 10.142.213.10 with SMTP id l10mr922589wfg.287.1211603484427;
        Fri, 23 May 2008 21:31:24 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.1.117])
        by mx.google.com with ESMTPS id 30sm11459565wfd.1.2008.05.23.21.31.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 23 May 2008 21:31:23 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 24 May 2008 11:31:19 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82794>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-grep.txt |    4 +++
 builtin-grep.c             |    6 +++-
 grep.c                     |   62 ++++++++++++++++++++++++++++++++++++=
+++++---
 grep.h                     |    1 +
 4 files changed, 68 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index a97f055..20ef098 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -16,6 +16,7 @@ SYNOPSIS
 	   [-F | --fixed-strings] [-n]
 	   [-l | --files-with-matches] [-L | --files-without-match]
 	   [-c | --count] [--all-match]
+	   [--color]
 	   [-A <post-context>] [-B <pre-context>] [-C <context>]
 	   [-f <file>] [-e] <pattern>
 	   [--and|--or|--not|(|)|-e <pattern>...] [<tree>...]
@@ -85,6 +86,9 @@ OPTIONS
 	Instead of showing every matched line, show the number of
 	lines that match.
=20
+--color::
+	Show colored matches.
+
 -[ABC] <context>::
 	Show `context` trailing (`A` -- after), or leading (`B`
 	-- before), or both (`C` -- context) lines, and place a
diff --git a/builtin-grep.c b/builtin-grep.c
index ef29910..118ec32 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -386,7 +386,7 @@ static int grep_cache(struct grep_opt *opt, const c=
har **paths, int cached)
 	 * we grep through the checked-out files. It tends to
 	 * be a lot more optimized
 	 */
-	if (!cached) {
+	if (!cached && !opt->color) {
 		hit =3D external_grep(opt, paths, cached);
 		if (hit >=3D 0)
 			return hit;
@@ -708,6 +708,10 @@ int cmd_grep(int argc, const char **argv, const ch=
ar *prefix)
 			opt.relative =3D 0;
 			continue;
 		}
+		if (!strcmp("--color", arg)) {
+			opt.color =3D 1;
+			continue;
+		}
 		if (!strcmp("--", arg)) {
 			/* later processing wants to have this at argv[1] */
 			argv--;
diff --git a/grep.c b/grep.c
index f67d671..7cc05b0 100644
--- a/grep.c
+++ b/grep.c
@@ -247,7 +247,10 @@ static int fixmatch(const char *pattern, char *lin=
e, regmatch_t *match)
 	}
 }
=20
-static int match_one_pattern(struct grep_opt *opt, struct grep_pat *p,=
 char *bol, char *eol, enum grep_context ctx)
+static int match_one_pattern_1(struct grep_opt *opt, struct grep_pat *=
p,
+			       char *bol, char *eol,
+			       enum grep_context ctx, int eflags,
+			       int *rm_so, int *rm_eo)
 {
 	int hit =3D 0;
 	int at_true_bol =3D 1;
@@ -261,7 +264,7 @@ static int match_one_pattern(struct grep_opt *opt, =
struct grep_pat *p, char *bol
 	if (!opt->fixed) {
 		regex_t *exp =3D &p->regexp;
 		hit =3D !regexec(exp, bol, ARRAY_SIZE(pmatch),
-			       pmatch, 0);
+			       pmatch, eflags);
 	}
 	else {
 		hit =3D !fixmatch(p->pattern, bol, pmatch);
@@ -298,9 +301,20 @@ static int match_one_pattern(struct grep_opt *opt,=
 struct grep_pat *p, char *bol
 			goto again;
 		}
 	}
+	if (hit) {
+		if (rm_so)
+			*rm_so =3D pmatch[0].rm_so;
+		if (rm_eo)
+			*rm_eo =3D pmatch[0].rm_eo;
+	}
 	return hit;
 }
=20
+static int match_one_pattern(struct grep_opt *opt, struct grep_pat *p,=
 char *bol, char *eol, enum grep_context ctx)
+{
+	return match_one_pattern_1(opt, p, bol, eol, ctx, 0, NULL, NULL);
+}
+
 static int match_expr_eval(struct grep_opt *o,
 			   struct grep_expr *x,
 			   char *bol, char *eol,
@@ -365,6 +379,42 @@ static int match_line(struct grep_opt *opt, char *=
bol, char *eol,
 	return 0;
 }
=20
+static void show_line_colored(struct grep_opt *opt, char *bol, char *e=
ol,
+			      const char *name, unsigned lno, char sign)
+{
+	struct grep_pat *p;
+	int rm_so, rm_eo, eflags =3D 0;
+	int ch;
+
+	if (opt->pathname)
+		printf("%s%c", name, sign);
+	if (opt->linenum)
+		printf("%d%c", lno, sign);
+
+	ch =3D *eol;
+	*eol =3D 0;
+	while (bol < eol) {
+		for (p =3D opt->pattern_list; p; p =3D p->next) {
+			if (match_one_pattern_1(opt, p, bol, eol, GREP_CONTEXT_BODY, eflags=
, &rm_so, &rm_eo))
+				break;
+		}
+
+		/* No match, break the loop */
+		if (!p ||
+		    (rm_so < 0) || (eol - bol) <=3D rm_so ||
+		    (rm_eo < 0) || (eol - bol) < rm_eo)
+			break;
+
+		printf("%.*s\033[31m\033[1m%.*s\033[m",
+		       rm_so, bol,
+		       rm_eo-rm_so, bol+rm_so);
+		bol +=3D rm_eo;
+		eflags =3D REG_NOTBOL;
+	}
+	printf("%s\n", bol);
+	*eol =3D ch;
+}
+
 static int grep_buffer_1(struct grep_opt *opt, const char *name,
 			 char *buf, unsigned long size, int collect_hits)
 {
@@ -466,8 +516,12 @@ static int grep_buffer_1(struct grep_opt *opt, con=
st char *name,
 			}
 			if (last_shown && lno !=3D last_shown + 1)
 				printf(hunk_mark);
-			if (!opt->count)
-				show_line(opt, bol, eol, name, lno, ':');
+			if (!opt->count) {
+				if (opt->color)
+					show_line_colored(opt, bol, eol, name, lno, ':');
+				else
+					show_line(opt, bol, eol, name, lno, ':');
+			}
 			last_shown =3D last_hit =3D lno;
 		}
 		else if (last_hit &&
diff --git a/grep.h b/grep.h
index d252dd2..979f7d0 100644
--- a/grep.h
+++ b/grep.h
@@ -68,6 +68,7 @@ struct grep_opt {
 	unsigned extended:1;
 	unsigned relative:1;
 	unsigned pathname:1;
+	unsigned color:1;
 	int regflags;
 	unsigned pre_context;
 	unsigned post_context;
--=20
1.5.5.GIT
