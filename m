From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3] status: refactor output format to represent "default" and add --long
Date: Thu, 18 Oct 2012 21:15:50 +0700
Message-ID: <1350569750-26304-1-git-send-email-pclouds@gmail.com>
References: <20121018020308.GA24484@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 18 16:16:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOqtg-0002Fn-66
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 16:16:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756063Ab2JROQQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Oct 2012 10:16:16 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62352 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755810Ab2JROQP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 10:16:15 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so8399121pbb.19
        for <git@vger.kernel.org>; Thu, 18 Oct 2012 07:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=EaXCRK978LcA60hMW9zer/rZ2SPw+k3FyN2Uv3xnGyw=;
        b=W/TU3aQ69jeSCGGooecRmZ0LN39r2cMJERUXidF9/n4U+FVDMh8uOciNx+iRHJfm08
         82geydpUsnEThgy6VSQSCwF6rJdUSimAUL2ZouJTIE0OuVnzX9qP6mpK72HHJmHWwdLa
         mT+lTxIgtgih0JucNjAB1k6xHwpHsTx6kIGv+FFK5dcXugcu4hx5wdlM3qqz2A5ELwhn
         LXEoXGRhpRB73PxH+6YcGYREiPI5+EOXTW3sIuwG8YYauYYk7VCaxi5adSetTyfH1HTf
         GsRmQf5hMxov+5HgYKsK2iyaTcJGrJrDcxxlpt84URq6HjykrBIh5oXmV5pklCGTF65/
         +Bfg==
Received: by 10.68.218.10 with SMTP id pc10mr31897388pbc.47.1350569774878;
        Thu, 18 Oct 2012 07:16:14 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.44.221])
        by mx.google.com with ESMTPS id po4sm14308456pbb.13.2012.10.18.07.16.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Oct 2012 07:16:12 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 18 Oct 2012 21:15:51 +0700
X-Mailer: git-send-email 1.8.0.rc2.22.gad9383a
In-Reply-To: <20121018020308.GA24484@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208005>

=46rom: Jeff King <peff@peff.net>

When deciding which output format to use, we default an internal enum
to STATUS_FORMAT_LONG and modify it if "--porcelain" or "--short" is
given. If this enum is set to LONG, then we know the user has not
specified any format, and we can kick in default behaviors. This works
because there is no "--long" which they could use to explicitly
specify LONG.

Let's expand the enum to have an explicit STATUS_FORMAT_NONE, in
preparation for adding "--long", which can be used to override --short
or --porcelain. Then we can distinguish between LONG and NONE when
setting other defaults. There are two such cases:

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
 On Thu, Oct 18, 2012 at 9:03 AM, Jeff King <peff@peff.net> wrote:
 > I think that is fine to split it like this, but you would want to up=
date
 > the commit message above. Probably just remove those two cases and s=
ay
 > something like:
 >
 >   Note that you cannot actually trigger STATUS_FORMAT_LONG, as we do
 >   not yet have "--long"; that will come in a follow-on patch.
 >
 > And then move the reasoning for how "--long" works with each case in=
to
 > the commit message of the next patch.

 Nope, it's hard to split the explanation in two (at least to me),
 which may mean that the split does not make sense.

 Documentation/git-commit.txt |  4 ++++
 Documentation/git-status.txt |  3 +++
 builtin/commit.c             | 29 +++++++++++++++++++++++------
 3 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.tx=
t
index 9594ac8..3acf2e7 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -109,6 +109,10 @@ OPTIONS
 	format. See linkgit:git-status[1] for details. Implies
 	`--dry-run`.
=20
+--long::
+	When doing a dry-run, give the output in a the long-format.
+	Implies `--dry-run`.
+
 -z::
 --null::
 	When showing `short` or `porcelain` status output, terminate
diff --git a/Documentation/git-status.txt b/Documentation/git-status.tx=
t
index 67e5f53..9f1ef9a 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -38,6 +38,9 @@ OPTIONS
 	across git versions and regardless of user configuration. See
 	below for details.
=20
+--long::
+	Give the output in the long-format. This is the default.
+
 -u[<mode>]::
 --untracked-files[=3D<mode>]::
 	Show untracked files.
diff --git a/builtin/commit.c b/builtin/commit.c
index a17a5df..1dd2ec5 100644
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
@@ -1058,9 +1060,13 @@ static int parse_and_validate_options(int argc, =
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
+		else if (status_format =3D=3D STATUS_FORMAT_LONG)
+			die(_("--long and -z are incompatible"));
+	}
+	if (status_format !=3D STATUS_FORMAT_NONE)
 		dry_run =3D 1;
=20
 	return argc;
@@ -1159,6 +1165,9 @@ int cmd_status(int argc, const char **argv, const=
 char *prefix)
 		OPT_SET_INT(0, "porcelain", &status_format,
 			    N_("machine-readable output"),
 			    STATUS_FORMAT_PORCELAIN),
+		OPT_SET_INT(0, "long", &status_format,
+			    N_("show status in long format (default)"),
+			    STATUS_FORMAT_LONG),
 		OPT_BOOLEAN('z', "null", &s.null_termination,
 			    N_("terminate entries with NUL")),
 		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg,
@@ -1186,8 +1195,12 @@ int cmd_status(int argc, const char **argv, cons=
t char *prefix)
 			     builtin_status_usage, 0);
 	finalize_colopts(&s.colopts, -1);
=20
-	if (s.null_termination && status_format =3D=3D STATUS_FORMAT_LONG)
-		status_format =3D STATUS_FORMAT_PORCELAIN;
+	if (s.null_termination) {
+		if (status_format =3D=3D STATUS_FORMAT_NONE)
+			status_format =3D STATUS_FORMAT_PORCELAIN;
+		else if (status_format =3D=3D STATUS_FORMAT_LONG)
+			die(_("--long and -z are incompatible"));
+	}
=20
 	handle_untracked_files_arg(&s);
 	if (show_ignored_in_status)
@@ -1216,6 +1229,7 @@ int cmd_status(int argc, const char **argv, const=
 char *prefix)
 	case STATUS_FORMAT_PORCELAIN:
 		wt_porcelain_print(&s);
 		break;
+	case STATUS_FORMAT_NONE:
 	case STATUS_FORMAT_LONG:
 		s.verbose =3D verbose;
 		s.ignore_submodule_arg =3D ignore_submodule_arg;
@@ -1386,6 +1400,9 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
 		OPT_BOOLEAN(0, "branch", &s.show_branch, N_("show branch information=
")),
 		OPT_SET_INT(0, "porcelain", &status_format,
 			    N_("machine-readable output"), STATUS_FORMAT_PORCELAIN),
+		OPT_SET_INT(0, "long", &status_format,
+			    N_("show status in long format (default)"),
+			    STATUS_FORMAT_LONG),
 		OPT_BOOLEAN('z', "null", &s.null_termination,
 			    N_("terminate entries with NUL")),
 		OPT_BOOLEAN(0, "amend", &amend, N_("amend previous commit")),
--=20
1.8.0.rc2.22.gad9383a
