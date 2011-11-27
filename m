From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] checkout,merge: loosen overwriting untracked file check based on info/exclude
Date: Sun, 27 Nov 2011 17:15:32 +0700
Message-ID: <1322388933-6284-1-git-send-email-pclouds@gmail.com>
References: <CACsJy8AXLBNSPmeEJjD1QX2zF1ic+S9kb_+4=EBO9xd07xhAYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Taylor Hedberg <tmhedberg@gmail.com>,
	Bertrand BENOIT <projettwk@users.sourceforge.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 27 11:15:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUbm0-0005Ww-EO
	for gcvg-git-2@lo.gmane.org; Sun, 27 Nov 2011 11:15:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694Ab1K0KPn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Nov 2011 05:15:43 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57005 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358Ab1K0KPm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2011 05:15:42 -0500
Received: by iage36 with SMTP id e36so7187767iag.19
        for <git@vger.kernel.org>; Sun, 27 Nov 2011 02:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=qbXJ+NcNKJOXK7yC/VHTVZxSRDNJ5r8dZ5wPpN5bj2s=;
        b=OvUPAzEPuspPMCBL6grcuXCMTC9/IRyxgQt+ZAEkufCfMfJqLLx6xCO5QBy3kZ5+ig
         UFnhMLot1WmdQUu0dLS1ltaI2noEUCQiIC30ey3JujE69G9eQw3eCT8uoDGi5oD0ExQK
         QrysSxtvBF0iprWJ2ymUSn4bOnjvyCul4Sc20=
Received: by 10.50.47.201 with SMTP id f9mr45282553ign.18.1322388941817;
        Sun, 27 Nov 2011 02:15:41 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.38.204])
        by mx.google.com with ESMTPS id wo4sm73418739igc.5.2011.11.27.02.15.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 Nov 2011 02:15:41 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 27 Nov 2011 17:15:34 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <CACsJy8AXLBNSPmeEJjD1QX2zF1ic+S9kb_+4=EBO9xd07xhAYQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185981>

Back in 1127148 (Loosen "working file will be lost" check in
Porcelain-ish - 2006-12-04), git-checkout.sh learned to quietly
overwrite ignored files. Howver the code only took .gitignore files
into account.

Standard ignored files include all specified in .gitignore files in
working directory _and_ $GIT_DIR/info/exclude. This patch makes sure
ignored files in info/exclude can also be overwritten automatically in
the spirit of the original patch.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c |    2 +-
 builtin/merge.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2a80772..51840b9 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -411,7 +411,7 @@ static int merge_working_tree(struct checkout_opts =
*opts,
 		topts.fn =3D twoway_merge;
 		topts.dir =3D xcalloc(1, sizeof(*topts.dir));
 		topts.dir->flags |=3D DIR_SHOW_IGNORED;
-		topts.dir->exclude_per_dir =3D ".gitignore";
+		setup_standard_excludes(topts.dir);
 		tree =3D parse_tree_indirect(old->commit ?
 					   old->commit->object.sha1 :
 					   EMPTY_TREE_SHA1_BIN);
diff --git a/builtin/merge.c b/builtin/merge.c
index 2870a6a..1387376 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -775,7 +775,7 @@ int checkout_fast_forward(const unsigned char *head=
, const unsigned char *remote
 	memset(&t, 0, sizeof(t));
 	memset(&dir, 0, sizeof(dir));
 	dir.flags |=3D DIR_SHOW_IGNORED;
-	dir.exclude_per_dir =3D ".gitignore";
+	setup_standard_excludes(&dir);
 	opts.dir =3D &dir;
=20
 	opts.head_idx =3D 1;
--=20
1.7.4.74.g639db
