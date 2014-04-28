From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/32] unpack-trees: be specific what part of the index has changed
Date: Mon, 28 Apr 2014 17:55:32 +0700
Message-ID: <1398682553-11634-12-git-send-email-pclouds@gmail.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 12:55:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WejDu-0001x2-Ay
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 12:55:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755356AbaD1Kzg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 06:55:36 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:47897 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755340AbaD1Kzd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 06:55:33 -0400
Received: by mail-pd0-f170.google.com with SMTP id x10so2187091pdj.29
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 03:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=bkKHWozwImPUrq7SVces/uzyjEWz5GoHIrrtMYE/j74=;
        b=Ej6QZJuntPSFDne84LT1uBB3tUa+OpmEGEcs37pzwsitv+vPCUvkUrpcym2WnBqUlF
         Zp6T+GglD8IszFLACzrCxcVEwJy5RzlSXKskLOZHMSb/L8rAs0q8XzeFJ/PC84kz+gWa
         jgW6jMSVgpoSEPB4YEoiuZIC9kBkSbVvmIczVj1FhI3ziRj25EwrEB/vmmdDD2EO+RuR
         68ROwyXl6RyQKtirr836Z+udxiOlopG63/WtH/GI70s9dmZlBLi/f5S/LZcESJuuVjto
         6YXOedpntX3vX7I0WpMjLsJ27eiz2f41to0zSliwprt7ANo5rrAstbSm6M3qorLf7jR0
         4s8g==
X-Received: by 10.68.161.101 with SMTP id xr5mr1507906pbb.168.1398682532376;
        Mon, 28 Apr 2014 03:55:32 -0700 (PDT)
Received: from lanh ([115.73.231.31])
        by mx.google.com with ESMTPSA id f5sm89650275pat.11.2014.04.28.03.55.29
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 03:55:31 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Apr 2014 17:56:59 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247278>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 unpack-trees.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 97fc995..a722685 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -246,7 +246,9 @@ static int verify_absent_sparse(const struct cache_=
entry *ce,
 				enum unpack_trees_error_types,
 				struct unpack_trees_options *o);
=20
-static int apply_sparse_checkout(struct cache_entry *ce, struct unpack=
_trees_options *o)
+static int apply_sparse_checkout(struct index_state *istate,
+				 struct cache_entry *ce,
+				 struct unpack_trees_options *o)
 {
 	int was_skip_worktree =3D ce_skip_worktree(ce);
=20
@@ -254,6 +256,8 @@ static int apply_sparse_checkout(struct cache_entry=
 *ce, struct unpack_trees_opt
 		ce->ce_flags |=3D CE_SKIP_WORKTREE;
 	else
 		ce->ce_flags &=3D ~CE_SKIP_WORKTREE;
+	if (was_skip_worktree !=3D ce_skip_worktree(ce))
+		istate->cache_changed |=3D CE_ENTRY_CHANGED;
=20
 	/*
 	 * if (!was_skip_worktree && !ce_skip_worktree()) {
@@ -1131,7 +1135,7 @@ int unpack_trees(unsigned len, struct tree_desc *=
t, struct unpack_trees_options
 				ret =3D -1;
 			}
=20
-			if (apply_sparse_checkout(ce, o)) {
+			if (apply_sparse_checkout(&o->result, ce, o)) {
 				if (!o->show_all_errors)
 					goto return_failed;
 				ret =3D -1;
--=20
1.9.1.346.ga2b5940
