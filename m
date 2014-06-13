From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/32] unpack-trees: be specific what part of the index has changed
Date: Fri, 13 Jun 2014 19:19:30 +0700
Message-ID: <1402661991-14977-12-git-send-email-pclouds@gmail.com>
References: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 14:21:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvQTy-0003Pa-Us
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 14:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752284AbaFMMVO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2014 08:21:14 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:64548 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271AbaFMMVN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 08:21:13 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so621833pdj.22
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 05:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=bkKHWozwImPUrq7SVces/uzyjEWz5GoHIrrtMYE/j74=;
        b=n6xUt+ie8yR+R5FCtRkTqcfYO02Ge/0m1vptP/MsdxsLPr63fYxY4he+oFZpHzxKGA
         ysz46iWqU9+RsBMEba5Hyq0rGTXOslNv4PASFGaocuxDZwNEjTrPKIsF6Zii3IkkSQIO
         1dZmM7ecXzmJfA2uo17UK/bJcIzCYHLdNJUPBL6tFQuUhcaqTX8nRpQSXOAmDKMaZaGL
         f1bvI+RZ3XuIlSBLINorDuLJFqrfBucV1O7O5bDU6QFk3CZjTubRO9c3jXT+dNtlM4Q6
         p6LdElYCHbdXlsyJXUqHQS9j4Yx83w7omh1Iyh75giz+b25MyV3knDhq8MNKO11TPv4P
         k44A==
X-Received: by 10.66.231.139 with SMTP id tg11mr2817017pac.87.1402662073167;
        Fri, 13 Jun 2014 05:21:13 -0700 (PDT)
Received: from lanh ([115.73.228.145])
        by mx.google.com with ESMTPSA id jb5sm3381873pbd.73.2014.06.13.05.21.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jun 2014 05:21:12 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 13 Jun 2014 19:21:12 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251568>

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
