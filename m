From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 19/26] apply: move up gitdir setup to run_builtin()
Date: Tue, 16 Feb 2010 23:05:10 +0700
Message-ID: <1266336317-607-20-git-send-email-pclouds@gmail.com>
References: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 17:16:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhQ6E-0006OQ-3H
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 17:16:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757186Ab0BPQQ1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2010 11:16:27 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:44480 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757168Ab0BPQQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 11:16:25 -0500
Received: by yxe38 with SMTP id 38so4325811yxe.4
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 08:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=K6dJ6ypxxDU4wEGp43Jo1vwOlBNg0wROYxF98WcVVk0=;
        b=gSB1xLN/T3pp9znA8+fVPCzJ7MJqXqLbEgHDUz56kduEENK7Jrzo5j0MEj6KQhcHSY
         j1DDbLfhLeoTsdCo2ekttLP5XEO9zy8OsM7iyVfkxyYNSCjpntWWxs7FWFM95A/v6OUM
         NeS9S34UdB0Ia38T3r/yTsDYEH6lMU3UOuhBw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=gpe/9874m93fCmuxzQg1e9F4xEan96EuQ9AEZ+oNOcLinaQeKbbjN0RlmaFsKoY5Pu
         TOQSKv/Dt5cO4ejejQcgNjRESQgvVElYB+ZlmrQqCN0x0pTFDgPEpC6m9XLPGSap3SSp
         9ycU6Z3B2laSw6exPphETaLDR0FjxNEvIvSsE=
Received: by 10.101.10.40 with SMTP id n40mr4522536ani.215.1266336601763;
        Tue, 16 Feb 2010 08:10:01 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.207.162])
        by mx.google.com with ESMTPS id 8sm2856179ywg.19.2010.02.16.08.09.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 08:10:01 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 16 Feb 2010 23:07:19 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140122>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-apply.c |   13 ++++++-------
 git.c           |    2 +-
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 2a1004d..44bb74f 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -26,7 +26,7 @@
  *  --cached updates only the cache without ever touching the working =
tree.
  */
 static const char *prefix;
-static int prefix_length =3D -1;
+static int prefix_length;
 static int newfd =3D -1;
=20
 static int unidiff_zero;
@@ -2441,7 +2441,7 @@ static int apply_binary(struct image *img, struct=
 patch *patch)
 		return 0; /* deletion patch */
 	}
=20
-	if (has_sha1_file(sha1)) {
+	if (startup_info->have_repository && has_sha1_file(sha1)) {
 		/* We already have the postimage */
 		enum object_type type;
 		unsigned long size;
@@ -3512,11 +3512,10 @@ static int option_parse_directory(const struct =
option *opt,
 	return 0;
 }
=20
-int cmd_apply(int argc, const char **argv, const char *unused_prefix)
+int cmd_apply(int argc, const char **argv, const char *prefix_)
 {
 	int i;
 	int errs =3D 0;
-	int is_not_gitdir;
 	int binary;
 	int force_apply =3D 0;
=20
@@ -3589,7 +3588,7 @@ int cmd_apply(int argc, const char **argv, const =
char *unused_prefix)
 		OPT_END()
 	};
=20
-	prefix =3D setup_git_directory_gently(&is_not_gitdir);
+	prefix =3D prefix_;
 	prefix_length =3D prefix ? strlen(prefix) : 0;
 	git_config(git_apply_config, NULL);
 	if (apply_default_whitespace)
@@ -3604,10 +3603,10 @@ int cmd_apply(int argc, const char **argv, cons=
t char *unused_prefix)
 		apply =3D apply_verbosely =3D 1;
 	if (!force_apply && (diffstat || numstat || summary || check || fake_=
ancestor))
 		apply =3D 0;
-	if (check_index && is_not_gitdir)
+	if (check_index && !startup_info->have_repository)
 		die("--index outside a repository");
 	if (cached) {
-		if (is_not_gitdir)
+		if (!startup_info->have_repository)
 			die("--cached outside a repository");
 		check_index =3D 1;
 	}
diff --git a/git.c b/git.c
index ee596bb..96ccedd 100644
--- a/git.c
+++ b/git.c
@@ -307,7 +307,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 		{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 		{ "annotate", cmd_annotate, RUN_SETUP },
-		{ "apply", cmd_apply },
+		{ "apply", cmd_apply, RUN_SETUP_GENTLY },
 		{ "archive", cmd_archive, RUN_SETUP_GENTLY },
 		{ "bisect--helper", cmd_bisect__helper, RUN_SETUP | NEED_WORK_TREE }=
,
 		{ "blame", cmd_blame, RUN_SETUP },
--=20
1.7.0.195.g637a2
