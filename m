From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/2] status: refactor output format to represent "default"
Date: Thu, 18 Oct 2012 08:57:59 +0700
Message-ID: <1350525480-30395-1-git-send-email-pclouds@gmail.com>
References: <1350404569-9787-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 18 03:58:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOfNY-0001td-Dw
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 03:58:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753572Ab2JRB6N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Oct 2012 21:58:13 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46482 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446Ab2JRB6K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 21:58:10 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so7830523pbb.19
        for <git@vger.kernel.org>; Wed, 17 Oct 2012 18:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=6dCtwAjrXIxseZxaYhnxvdBWphQTmzfT3eDP7dkMN6s=;
        b=u/Gah15Ml2sgUOKLQHCUh/gvDEr8VaDHp0nJf0mCZRY5ZryE2x9gP/sTIqsN27KTOm
         CHCaSDfdV2lnn+Qa3vp2Cqs7eDVhp2kFK98kzG9NDfvUpP3/m90sHlDTVz17R0gkwIkG
         B01UU9ZgATayziTJYFgZjZUbhH2Ysm6h7rjMX+kymd5plZpTtRr7MJwNbtEoD8fYNqin
         dx8P1lxCQUq1UJC8IVTzxWqp/37tRqmrWgiFYK5O1lzeyUWc6AMMmNNcujlL8nu6e36H
         BZ6U34OuqcyUB36CQilj6LPbuVUf8e48cwsBR06diY9MZF3e9c6zXTX5jZU3ImFLGTeM
         HLCg==
Received: by 10.66.81.231 with SMTP id d7mr55225780pay.50.1350525490122;
        Wed, 17 Oct 2012 18:58:10 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id tw2sm12174863pbc.34.2012.10.17.18.58.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Oct 2012 18:58:08 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 18 Oct 2012 08:58:01 +0700
X-Mailer: git-send-email 1.8.0.rc2.32.g1729c8c
In-Reply-To: <1350404569-9787-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207949>

=46rom: Jeff King <peff@peff.net>

When deciding which output format to use, we default an
internal enum to STATUS_FORMAT_LONG and modify it if
"--porcelain" or "--short" is given. If this enum is set to
LONG, then we know the user has not specified any format,
and we can kick in default behaviors. This works because
there is no "--long" which they could use to explicitly
specify LONG.

Let's expand the enum to have an explicit STATUS_FORMAT_NONE,
in preparation for adding "--long". Then we can distinguish
between LONG and NONE when setting other defaults. There are
two such cases:

  1. The user has asked for NUL termination. With NONE, we
     currently default to turning on the porcelain mode.
     With an explicit --long, we would in theory use NUL
     termination with the long mode, but it does not support
     it. So we can just complain and die.

  2. When an output format is given to "git commit", we
     default to "--dry-run". This behavior would now kick in
     when "--long" is given, too.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Two die()s with --long are moved to the next patch where --long is
 introduced.

 builtin/commit.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index a17a5df..984e29c 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -112,10 +112,11 @@ static const char *only_include_assumed;
 static struct strbuf message =3D STRBUF_INIT;
=20
 static enum {
+	STATUS_FORMAT_NONE =3D 0,
 	STATUS_FORMAT_LONG,
 	STATUS_FORMAT_SHORT,
 	STATUS_FORMAT_PORCELAIN
-} status_format =3D STATUS_FORMAT_LONG;
+} status_format;
=20
 static int opt_parse_m(const struct option *opt, const char *arg, int =
unset)
 {
@@ -454,6 +455,7 @@ static int run_status(FILE *fp, const char *index_f=
ile, const char *prefix, int
 	case STATUS_FORMAT_PORCELAIN:
 		wt_porcelain_print(s);
 		break;
+	case STATUS_FORMAT_NONE:
 	case STATUS_FORMAT_LONG:
 		wt_status_print(s);
 		break;
@@ -1058,9 +1060,11 @@ static int parse_and_validate_options(int argc, =
const char *argv[],
 	if (all && argc > 0)
 		die(_("Paths with -a does not make sense."));
=20
-	if (s->null_termination && status_format =3D=3D STATUS_FORMAT_LONG)
-		status_format =3D STATUS_FORMAT_PORCELAIN;
-	if (status_format !=3D STATUS_FORMAT_LONG)
+	if (s->null_termination) {
+		if (status_format =3D=3D STATUS_FORMAT_NONE)
+			status_format =3D STATUS_FORMAT_PORCELAIN;
+	}
+	if (status_format !=3D STATUS_FORMAT_NONE)
 		dry_run =3D 1;
=20
 	return argc;
@@ -1186,8 +1190,10 @@ int cmd_status(int argc, const char **argv, cons=
t char *prefix)
 			     builtin_status_usage, 0);
 	finalize_colopts(&s.colopts, -1);
=20
-	if (s.null_termination && status_format =3D=3D STATUS_FORMAT_LONG)
-		status_format =3D STATUS_FORMAT_PORCELAIN;
+	if (s.null_termination) {
+		if (status_format =3D=3D STATUS_FORMAT_NONE)
+			status_format =3D STATUS_FORMAT_PORCELAIN;
+	}
=20
 	handle_untracked_files_arg(&s);
 	if (show_ignored_in_status)
@@ -1216,6 +1222,7 @@ int cmd_status(int argc, const char **argv, const=
 char *prefix)
 	case STATUS_FORMAT_PORCELAIN:
 		wt_porcelain_print(&s);
 		break;
+	case STATUS_FORMAT_NONE:
 	case STATUS_FORMAT_LONG:
 		s.verbose =3D verbose;
 		s.ignore_submodule_arg =3D ignore_submodule_arg;
--=20
1.8.0.rc2.32.g1729c8c
