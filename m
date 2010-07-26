From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/3] unpack-trees.c: Do not check ce_stage in will_have_skip_worktree()
Date: Mon, 26 Jul 2010 16:08:29 +0700
Message-ID: <1280135310-2347-2-git-send-email-pclouds@gmail.com>
References: <1280135310-2347-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 11:53:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdKNA-0000DI-DA
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 11:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754143Ab0GZJxS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Jul 2010 05:53:18 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:59386 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754021Ab0GZJxR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 05:53:17 -0400
Received: by pvc7 with SMTP id 7so4340275pvc.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 02:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=SpjbjXeDX6NXjvZyAhNH+cYS/tiTu+G3c4nlObVenpA=;
        b=O9IJrN9U4rRKe1HQrfoZzinHAuKVMX+Ps4IbkMKg2OwzSMZLF2nwDo9BGfn+cAoGt1
         xlIY+43/Re3HmD2BpNHwmusk6vPsNhPeo3AmJeyMpLiKNoG3pKgAGn//pkt14r1LJZWa
         QYpHouPrEJIYcwvaVhFV/pDjIILkQWImOIb84=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=KIWA6UF4mIb4nkfpH7ZxEzvCvbAIjEDb/i6d2O/zU5TcNDEHBzZg2Tt1eLp4psu9KI
         rgpkcHgjU283pVrbK3AEUhJuXd0KGWar6Xx+lzu4ItmwePpTQOOyADBYD6hgPi7u2+vA
         GuEqFymk5GTl11vLjdZoX7El3NaLujNW6jsD8=
Received: by 10.142.192.1 with SMTP id p1mr8823993wff.287.1280137979795;
        Mon, 26 Jul 2010 02:52:59 -0700 (PDT)
Received: from dektop ([121.91.36.254])
        by mx.google.com with ESMTPS id 23sm3918975wfa.22.2010.07.26.02.52.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Jul 2010 02:52:59 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon, 26 Jul 2010 16:08:40 +0700
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1280135310-2347-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151825>

The idea of sparse checkout is conflicted entries should always stay
in worktree, regardless $GIT_DIR/info/sparse-checkout. Therefore,
ce_stage(ce) usually means no CE_SKIP_WORKTREE. This is true when all
entries have been merged into the index, and identical staged entries
collapsed.

However, will_have_skip_worktree() since f1f523e (unpack-trees():
ignore worktree check outside checkout area) is also used earlier in
verify_* functions, when entries have not been merged to index yet
and ce_stage() may not be zero. Checking ce_stage() then can make
unnecessary verification on entries outside checkout area and error out=
=2E

This fixes part of test case "read-tree adds to worktree, dirty case".
The error is changed from

error: Untracked working tree file 'sub/added' would be overwritten by =
merge.

before this patch to

grep: sub/added: No such file or directory

which will be addressed in the next patch.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 unpack-trees.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index f2d148c..7ea8c5f 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -135,9 +135,6 @@ static int will_have_skip_worktree(const struct cac=
he_entry *ce, struct unpack_t
 {
 	const char *basename;
=20
-	if (ce_stage(ce))
-		return 0;
-
 	basename =3D strrchr(ce->name, '/');
 	basename =3D basename ? basename+1 : ce->name;
 	return excluded_from_list(ce->name, ce_namelen(ce), basename, NULL, o=
->el) <=3D 0;
@@ -147,7 +144,7 @@ static int apply_sparse_checkout(struct cache_entry=
 *ce, struct unpack_trees_opt
 {
 	int was_skip_worktree =3D ce_skip_worktree(ce);
=20
-	if (will_have_skip_worktree(ce, o))
+	if (!ce_stage(ce) && will_have_skip_worktree(ce, o))
 		ce->ce_flags |=3D CE_SKIP_WORKTREE;
 	else
 		ce->ce_flags &=3D ~CE_SKIP_WORKTREE;
--=20
1.7.1.rc1.69.g24c2f7
