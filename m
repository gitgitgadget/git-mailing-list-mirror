From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 18/46] checkout: convert to use parse_pathspec
Date: Sun, 14 Jul 2013 15:35:41 +0700
Message-ID: <1373790969-13000-19-git-send-email-pclouds@gmail.com>
References: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 10:38:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyHoo-00029b-KX
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 10:38:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016Ab3GNIiG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jul 2013 04:38:06 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:52214 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab3GNIiF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 04:38:05 -0400
Received: by mail-pb0-f43.google.com with SMTP id md12so10310840pbc.16
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 01:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=8etDVWaJkEvLDPimnRbHrLMYaQRetvZPLnm0rYpDldk=;
        b=UfNFihuBxgWaQa1pM/8OnMrPz5ZgRffsmLR70rfiC0GamTZHu0BBLx0TFw4OsJDl7B
         MzJajVpTYCZZ0ycR+pxPklCDlerSzcwtNmf07zDB7Qskx7lqCGf/kop0qbpZTR8OKlzJ
         AlK56lnX/x/3Zx4bCk93OnYQLGpcm6dX4dbAMqcmaFCJTWS2l4NrmAXdg15tyIKKcp2J
         emSVR6MAZl1Ws9gYbAnmJflhZseYBgAsf3mVBHJG7qAA11vsGk/UiCz3YheYEFc9R8QX
         XcvJCG6jbaidGkenJHp1gWhj8+Y/OH2/QtLpcRiBHwAwEikPAuQInBvq8r4FHq8PymHj
         xCCg==
X-Received: by 10.66.232.42 with SMTP id tl10mr49611114pac.159.1373791084625;
        Sun, 14 Jul 2013 01:38:04 -0700 (PDT)
Received: from lanh ([115.73.210.100])
        by mx.google.com with ESMTPSA id z19sm57818882paf.12.2013.07.14.01.38.01
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 01:38:04 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Jul 2013 15:38:16 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230330>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 7fe0bff..6721de2 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -46,7 +46,7 @@ struct checkout_opts {
=20
 	int branch_exists;
 	const char *prefix;
-	const char **pathspec;
+	struct pathspec pathspec;
 	struct tree *source_tree;
 };
=20
@@ -257,20 +257,18 @@ static int checkout_paths(const struct checkout_o=
pts *opts,
=20
 	if (opts->patch_mode)
 		return run_add_interactive(revision, "--patch=3Dcheckout",
-					   opts->pathspec);
+					   opts->pathspec.raw);
=20
 	lock_file =3D xcalloc(1, sizeof(struct lock_file));
=20
 	newfd =3D hold_locked_index(lock_file, 1);
-	if (read_cache_preload(opts->pathspec) < 0)
+	if (read_cache_preload(opts->pathspec.raw) < 0)
 		return error(_("corrupt index file"));
=20
 	if (opts->source_tree)
-		read_tree_some(opts->source_tree, opts->pathspec);
+		read_tree_some(opts->source_tree, opts->pathspec.raw);
=20
-	for (pos =3D 0; opts->pathspec[pos]; pos++)
-		;
-	ps_matched =3D xcalloc(1, pos);
+	ps_matched =3D xcalloc(1, opts->pathspec.nr);
=20
 	/*
 	 * Make sure all pathspecs participated in locating the paths
@@ -304,12 +302,12 @@ static int checkout_paths(const struct checkout_o=
pts *opts,
 		 * match_pathspec() for _all_ entries when
 		 * opts->source_tree !=3D NULL.
 		 */
-		if (match_pathspec(opts->pathspec, ce->name, ce_namelen(ce),
+		if (match_pathspec_depth(&opts->pathspec, ce->name, ce_namelen(ce),
 				   0, ps_matched))
 			ce->ce_flags |=3D CE_MATCHED;
 	}
=20
-	if (report_path_error(ps_matched, opts->pathspec, opts->prefix)) {
+	if (report_path_error(ps_matched, opts->pathspec.raw, opts->prefix)) =
{
 		free(ps_matched);
 		return 1;
 	}
@@ -1002,7 +1000,7 @@ static int switch_unborn_to_new_branch(const stru=
ct checkout_opts *opts)
 static int checkout_branch(struct checkout_opts *opts,
 			   struct branch_info *new)
 {
-	if (opts->pathspec)
+	if (opts->pathspec.nr)
 		die(_("paths cannot be used with switching branches"));
=20
 	if (opts->patch_mode)
@@ -1154,9 +1152,19 @@ int cmd_checkout(int argc, const char **argv, co=
nst char *prefix)
 	}
=20
 	if (argc) {
-		opts.pathspec =3D get_pathspec(prefix, argv);
+		/*
+		 * In patch mode (opts.patch_mode !=3D 0), we pass the
+		 * pathspec to an external program, git-add--interactive.
+		 * Do not accept any kind of magic that that program
+		 * cannot handle. Magic mask is pretty safe to be
+		 * lifted for new magic when opts.patch_mode =3D=3D 0.
+		 */
+		parse_pathspec(&opts.pathspec,
+			       opts.patch_mode =3D=3D 0 ? 0 :
+			       (PATHSPEC_ALL_MAGIC & ~PATHSPEC_FROMTOP),
+			       0, prefix, argv);
=20
-		if (!opts.pathspec)
+		if (!opts.pathspec.nr)
 			die(_("invalid path specification"));
=20
 		/*
@@ -1188,7 +1196,7 @@ int cmd_checkout(int argc, const char **argv, con=
st char *prefix)
 		strbuf_release(&buf);
 	}
=20
-	if (opts.patch_mode || opts.pathspec)
+	if (opts.patch_mode || opts.pathspec.nr)
 		return checkout_paths(&opts, new.name);
 	else
 		return checkout_branch(&opts, &new);
--=20
1.8.2.83.gc99314b
