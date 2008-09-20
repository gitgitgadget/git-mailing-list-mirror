From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/14] ls-files: add options to support sparse checkout
Date: Sat, 20 Sep 2008 17:01:42 +0700
Message-ID: <1221904913-25887-4-git-send-email-pclouds@gmail.com>
References: <1221904913-25887-1-git-send-email-pclouds@gmail.com>
 <1221904913-25887-2-git-send-email-pclouds@gmail.com>
 <1221904913-25887-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 20 12:03:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgzJZ-0001Aq-11
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 12:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbYITKCb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Sep 2008 06:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbYITKCb
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 06:02:31 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:21281 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058AbYITKCa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2008 06:02:30 -0400
Received: by wf-out-1314.google.com with SMTP id 27so880198wfd.4
        for <git@vger.kernel.org>; Sat, 20 Sep 2008 03:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ZBv6U+iZiip+PFnkz/VetzvPRxyd2VN3RTtQS2KSK4M=;
        b=qSsgYV2D/NqtOQeGzMuBrfExOHnHq0d6uk9zzCHZqm9NYuyPqr3g20xqqKzcfwpkGX
         F0CxFp4akRKpLYCYlamOvAzw5FLe4YfRiv6ipzMwZaCc6wJCbch/r0CSHd5VYabjTbyQ
         FN6eVnk0UH1XY+OlEVhs9H7mfu2h/yYeEsJbo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ZlVhjCUCIZt/xUVG7g0Yb/hfOZJ4D8sUDhKkJqdYdnq07AZkBgvZwpWiBz0zwBm4g3
         XYHcKvzY9O3rniOsgLp4jz4jpCNd6PHBciKkxvf21OpeWiJ/98rAGFgzIUPLXx56vOLm
         SxkSlMqc28HqlPJomdBMzGe+G23idc+PYVXOI=
Received: by 10.142.223.20 with SMTP id v20mr455807wfg.81.1221904949640;
        Sat, 20 Sep 2008 03:02:29 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.36.54])
        by mx.google.com with ESMTPS id 27sm3585897wfa.2.2008.09.20.03.02.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Sep 2008 03:02:28 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 20 Sep 2008 17:02:19 +0700
X-Mailer: git-send-email 1.6.0.96.g2fad1.dirty
In-Reply-To: <1221904913-25887-3-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96342>

The first option to be introduced is --sparse, which puts ls-files
in "sparse mode". In this mode, cached entries are divided into
 - checkout entries: shown by --cached (new behavior with --sparse)
 - no-checkout entries: show by --no-checkout (new option)
 - orphaned entries: shown by --orphaned (new option)

Orphaned entries are themselves no-checkout ones but for some reasons
still be present in working directory.

While at it, fix "--deleted" running out of checkout area.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-ls-files.txt |   24 +++++++++++++++++++++-
 builtin-ls-files.c             |   41 ++++++++++++++++++++++++++++++++=
++++---
 2 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-file=
s.txt
index 9f85d60..1de68e2 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -10,8 +10,9 @@ SYNOPSIS
 --------
 [verse]
 'git ls-files' [-z] [-t] [-v]
-		(--[cached|deleted|others|ignored|stage|unmerged|killed|modified])\*
+		(--[cached|deleted|others|ignored|stage|unmerged|killed|modified|orp=
haned|no-checkout])\*
 		(-[c|d|o|i|s|u|k|m])\*
+		[--sparse]
 		[-x <pattern>|--exclude=3D<pattern>]
 		[-X <file>|--exclude-from=3D<file>]
 		[--exclude-per-directory=3D<file>]
@@ -32,7 +33,9 @@ OPTIONS
 -------
 -c::
 --cached::
-	Show cached files in the output (default)
+	Show cached files in the output (default). When used with --sparse,
+	show only cached files that are marked "checkout", no-checkout
+	entries will be excluded.
=20
 -d::
 --deleted::
@@ -72,6 +75,21 @@ OPTIONS
 	to file/directory conflicts for checkout-index to
 	succeed.
=20
+--no-checkout::
+	Show no-checkout entries. This option implies --sparse.
+
+--orphaned::
+	Show orphaned entries. Orphaned entries are no-checkout
+	entries that are present in working directory. This option
+	implies --sparse.
+
+--sparse::
+	When --sparse is passed, cached files will be divided into two
+	parts: checkout entries and no-checkout entries.
+	--cached will only show checkout entries.
+	No-checkout entries can be shown using --orphaned or
+	--no-checkout (or both).
+
 -z::
 	\0 line termination on output.
=20
@@ -107,6 +125,8 @@ OPTIONS
 	Identify the file status with the following tags (followed by
 	a space) at the start of each line:
 	H::	cached
+	-::	no-checkout entries
+	O::	orphaned entries
 	M::	unmerged
 	R::	removed/deleted
 	C::	modified/changed
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 068f424..873de15 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -20,6 +20,9 @@ static int show_unmerged;
 static int show_modified;
 static int show_killed;
 static int show_valid_bit;
+static int show_orphaned;
+static int show_no_checkout;
+static int sparse_checkout;
 static int line_terminator =3D '\n';
=20
 static int prefix_len;
@@ -35,6 +38,8 @@ static const char *tag_removed =3D "";
 static const char *tag_other =3D "";
 static const char *tag_killed =3D "";
 static const char *tag_modified =3D "";
+static const char *tag_orphaned =3D "";
+static const char *tag_no_checkout =3D "";
=20
=20
 /*
@@ -235,7 +240,7 @@ static void show_files(struct dir_struct *dir, cons=
t char *prefix)
 		if (show_killed)
 			show_killed_files(dir);
 	}
-	if (show_cached | show_stage) {
+	if (show_cached | show_stage | show_orphaned | show_no_checkout) {
 		for (i =3D 0; i < active_nr; i++) {
 			struct cache_entry *ce =3D active_cache[i];
 			int dtype =3D ce_to_dtype(ce);
@@ -245,6 +250,16 @@ static void show_files(struct dir_struct *dir, con=
st char *prefix)
 				continue;
 			if (ce->ce_flags & CE_UPDATE)
 				continue;
+			if (sparse_checkout && ce_no_checkout(ce)) {
+				struct stat st;
+				if (show_no_checkout)
+					show_ce_entry(tag_no_checkout, ce);
+				if (show_orphaned && !lstat(ce->name, &st))
+					show_ce_entry(tag_orphaned, ce);
+				continue;
+			}
+			if (!(show_cached | show_stage))
+				continue;
 			show_ce_entry(ce_stage(ce) ? tag_unmerged : tag_cached, ce);
 		}
 	}
@@ -257,7 +272,7 @@ static void show_files(struct dir_struct *dir, cons=
t char *prefix)
 			if (excluded(dir, ce->name, &dtype) !=3D dir->show_ignored)
 				continue;
 			err =3D lstat(ce->name, &st);
-			if (show_deleted && err)
+			if (show_deleted && err && ce_checkout(ce))
 				show_ce_entry(tag_removed, ce);
 			if (show_modified && ce_modified(ce, &st, 0))
 				show_ce_entry(tag_modified, ce);
@@ -423,7 +438,8 @@ int report_path_error(const char *ps_matched, const=
 char **pathspec, int prefix_
 }
=20
 static const char ls_files_usage[] =3D
-	"git ls-files [-z] [-t] [-v] (--[cached|deleted|others|stage|unmerged=
|killed|modified])* "
+	"git ls-files [-z] [-t] [-v] (--[cached|deleted|others|stage|unmerged=
|killed|modified|orphaned|no-checkout])* "
+	"[ --sparse ] "
 	"[ --ignored ] [--exclude=3D<pattern>] [--exclude-from=3D<file>] "
 	"[ --exclude-per-directory=3D<filename> ] [--exclude-standard] "
 	"[--full-name] [--abbrev] [--] [<file>]*";
@@ -457,6 +473,8 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *prefix)
 			tag_modified =3D "C ";
 			tag_other =3D "? ";
 			tag_killed =3D "K ";
+			tag_orphaned =3D "O ";
+			tag_no_checkout =3D "- ";
 			if (arg[1] =3D=3D 'v')
 				show_valid_bit =3D 1;
 			continue;
@@ -465,6 +483,21 @@ int cmd_ls_files(int argc, const char **argv, cons=
t char *prefix)
 			show_cached =3D 1;
 			continue;
 		}
+		if (!strcmp(arg, "--sparse")) {
+			sparse_checkout =3D 1;
+			continue;
+		}
+		if (!strcmp(arg, "--orphaned")) {
+			show_orphaned =3D 1;
+			sparse_checkout =3D 1;
+			require_work_tree =3D 1;
+			continue;
+		}
+		if (!strcmp(arg, "--no-checkout")) {
+			show_no_checkout =3D 1;
+			sparse_checkout =3D 1;
+			continue;
+		}
 		if (!strcmp(arg, "-d") || !strcmp(arg, "--deleted")) {
 			show_deleted =3D 1;
 			continue;
@@ -593,7 +626,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *prefix)
=20
 	/* With no flags, we default to showing the cached files */
 	if (!(show_stage | show_deleted | show_others | show_unmerged |
-	      show_killed | show_modified))
+	      show_killed | show_modified | show_orphaned | show_no_checkout)=
)
 		show_cached =3D 1;
=20
 	read_cache();
--=20
1.6.0.96.g2fad1.dirty
