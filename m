From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] checkout,merge: disallow overwriting ignored files with --no-overwrite-ignore
Date: Sun, 27 Nov 2011 17:15:33 +0700
Message-ID: <1322388933-6284-2-git-send-email-pclouds@gmail.com>
References: <CACsJy8AXLBNSPmeEJjD1QX2zF1ic+S9kb_+4=EBO9xd07xhAYQ@mail.gmail.com>
 <1322388933-6284-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Taylor Hedberg <tmhedberg@gmail.com>,
	Bertrand BENOIT <projettwk@users.sourceforge.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 27 11:15:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUbmA-0005Yq-TY
	for gcvg-git-2@lo.gmane.org; Sun, 27 Nov 2011 11:15:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752852Ab1K0KPy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Nov 2011 05:15:54 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57005 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752291Ab1K0KPx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2011 05:15:53 -0500
Received: by mail-iy0-f174.google.com with SMTP id e36so7187767iag.19
        for <git@vger.kernel.org>; Sun, 27 Nov 2011 02:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=lqMCNhHbfphJk6G0JE9lS1psV32QZPRBxtRZqV1iqgg=;
        b=EmBKT60mkBZUv5K084WaOwcULseSGjBSGvMNEG/g3pZB9HlNf5lBdSwXBzJ+U0/DJf
         gxq0FEKnOdXS3xZMOhprzUGvVbKyq5bbE9nZTK0oroF8KBPKMkOAfAd6UcuryHjw7NKd
         g2wdgR1ho+mkeV9PkyGPnPvH/6ns7tn0NwZkU=
Received: by 10.50.88.199 with SMTP id bi7mr45417423igb.45.1322388953512;
        Sun, 27 Nov 2011 02:15:53 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.38.204])
        by mx.google.com with ESMTPS id wo4sm73419951igc.5.2011.11.27.02.15.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 Nov 2011 02:15:52 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 27 Nov 2011 17:15:41 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1322388933-6284-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185982>

Ignored files usually are generated files (e.g. .o files) and can be
safely discarded. However sometimes users may have important files in
working directory, but still want a clean "git status", so they mark
them as ignored files. But in this case, these files should not be
overwritten without asking first.

Enable this use case with --no-overwrite-ignore, where git only sees
tracked and untracked files, no ignored files. Those who mix
discardable ignored files with important ones may have to sort it out
themselves.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c |   11 ++++++++---
 builtin/merge.c    |   12 ++++++++----
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 51840b9..5f9474d 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -34,6 +34,7 @@ struct checkout_opts {
 	int force_detach;
 	int writeout_stage;
 	int writeout_error;
+	int overwrite_ignore;
=20
 	/* not set by parse_options */
 	int branch_exists;
@@ -409,9 +410,11 @@ static int merge_working_tree(struct checkout_opts=
 *opts,
 		topts.gently =3D opts->merge && old->commit;
 		topts.verbose_update =3D !opts->quiet;
 		topts.fn =3D twoway_merge;
-		topts.dir =3D xcalloc(1, sizeof(*topts.dir));
-		topts.dir->flags |=3D DIR_SHOW_IGNORED;
-		setup_standard_excludes(topts.dir);
+		if (opts->overwrite_ignore) {
+			topts.dir =3D xcalloc(1, sizeof(*topts.dir));
+			topts.dir->flags |=3D DIR_SHOW_IGNORED;
+			setup_standard_excludes(topts.dir);
+		}
 		tree =3D parse_tree_indirect(old->commit ?
 					   old->commit->object.sha1 :
 					   EMPTY_TREE_SHA1_BIN);
@@ -926,6 +929,7 @@ int cmd_checkout(int argc, const char **argv, const=
 char *prefix)
 			    3),
 		OPT__FORCE(&opts.force, "force checkout (throw away local modificati=
ons)"),
 		OPT_BOOLEAN('m', "merge", &opts.merge, "perform a 3-way merge with t=
he new branch"),
+		OPT_BOOLEAN(0, "overwrite-ignore", &opts.overwrite_ignore, "update i=
gnored files (default)"),
 		OPT_STRING(0, "conflict", &conflict_style, "style",
 			   "conflict style (merge or diff3)"),
 		OPT_BOOLEAN('p', "patch", &patch_mode, "select hunks interactively")=
,
@@ -937,6 +941,7 @@ int cmd_checkout(int argc, const char **argv, const=
 char *prefix)
=20
 	memset(&opts, 0, sizeof(opts));
 	memset(&new, 0, sizeof(new));
+	opts.overwrite_ignore =3D 1;
=20
 	gitmodules_config();
 	git_config(git_checkout_config, &opts);
diff --git a/builtin/merge.c b/builtin/merge.c
index 1387376..07102c4 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -48,6 +48,7 @@ static int show_diffstat =3D 1, shortlog_len, squash;
 static int option_commit =3D 1, allow_fast_forward =3D 1;
 static int fast_forward_only, option_edit;
 static int allow_trivial =3D 1, have_message;
+static int overwrite_ignore =3D 1;
 static struct strbuf merge_msg;
 static struct commit_list *remoteheads;
 static struct strategy **use_strategies;
@@ -207,6 +208,7 @@ static struct option builtin_merge_options[] =3D {
 	OPT_BOOLEAN(0, "abort", &abort_current_merge,
 		"abort the current in-progress merge"),
 	OPT_SET_INT(0, "progress", &show_progress, "force progress reporting"=
, 1),
+	OPT_BOOLEAN(0, "overwrite-ignore", &overwrite_ignore, "update ignored=
 files (default)"),
 	OPT_END()
 };
=20
@@ -773,10 +775,12 @@ int checkout_fast_forward(const unsigned char *he=
ad, const unsigned char *remote
 	memset(&trees, 0, sizeof(trees));
 	memset(&opts, 0, sizeof(opts));
 	memset(&t, 0, sizeof(t));
-	memset(&dir, 0, sizeof(dir));
-	dir.flags |=3D DIR_SHOW_IGNORED;
-	setup_standard_excludes(&dir);
-	opts.dir =3D &dir;
+	if (overwrite_ignore) {
+		memset(&dir, 0, sizeof(dir));
+		dir.flags |=3D DIR_SHOW_IGNORED;
+		setup_standard_excludes(&dir);
+		opts.dir =3D &dir;
+	}
=20
 	opts.head_idx =3D 1;
 	opts.src_index =3D &the_index;
--=20
1.7.4.74.g639db
