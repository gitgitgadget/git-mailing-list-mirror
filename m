From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/3] Mark new entries skip-worktree appropriately
Date: Mon, 26 Jul 2010 16:08:30 +0700
Message-ID: <1280135310-2347-3-git-send-email-pclouds@gmail.com>
References: <1280135310-2347-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 11:53:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdKN2-0000BK-Dx
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 11:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754137Ab0GZJxL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Jul 2010 05:53:11 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:47418 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754021Ab0GZJxK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 05:53:10 -0400
Received: by pxi14 with SMTP id 14so4471560pxi.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 02:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=43F0TWrudXk4QNnobG4N8a7jWspz0+xnPser+CMJoXs=;
        b=s6JphTmh0fgG2ncy1OLebaP9eSzeV5LUcl9r+N5cV7R3ESvRk9+1S0TeixdDpUPAxU
         EAqZuzUiRZac3j+p3FQmv+hxYBwUT+l+y6Mv398gqQ0SlGilDiiAq93rELyGo2qZK9L1
         mA+ytTjaVrPLHvS3i6oANGRBo+sqF2EWKUW/0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=NnmC8Ujoqn2L0dapv6kO6/95Ay/AYHNc1YnuzQORDqnRf42H77692rLJ4vZjOEz1+1
         dC3UGNixptifrV1j3nfzaTyx9VLhaBZJjoQdmOxMjbYtETovfDphxQZM/qdJqLUFPICY
         N6h+ifimVuhjHKobC7iBUerL8JabTi4LTSiVk=
Received: by 10.114.77.11 with SMTP id z11mr10424224waa.112.1280137989788;
        Mon, 26 Jul 2010 02:53:09 -0700 (PDT)
Received: from dektop ([121.91.36.254])
        by mx.google.com with ESMTPS id c10sm6325645wam.1.2010.07.26.02.53.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Jul 2010 02:53:09 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon, 26 Jul 2010 16:08:48 +0700
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1280135310-2347-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151824>

Sparse checkout updates worktree based on the old and new
skip-worktree status when $GIT_DIR/info/sparse-checkout changes:

old =3D ce_skip_worktree(ce);           // current skip-worktree
new =3D will_have_skip_work_tree(ce);   // from $GIT..sparse-checkout
if (old && !new) add_file_back(ce);   // shrink checkout area
if (!old && new) remove_file_out(ce); [1] // enlarge checkout area

New entries after merging will always have skip-worktree unset
(i.e. old =3D 0). If those files are filtered out by
$GIT_DIR/info/sparse-checkout (i.e. new !=3D 0), then case [1] will
happen. But there is nothing to remove because they're new.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1011-read-tree-sparse-checkout.sh |    2 +-
 unpack-trees.c                       |    2 ++
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-s=
parse-checkout.sh
index 885578a..86a6246 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -138,7 +138,7 @@ test_expect_success 'read-tree adds to worktree, ab=
sent case' '
 	test ! -f sub/added
 '
=20
-test_expect_failure 'read-tree adds to worktree, dirty case' '
+test_expect_success 'read-tree adds to worktree, dirty case' '
 	echo init.t > .git/info/sparse-checkout &&
 	git checkout -f removed &&
 	mkdir sub &&
diff --git a/unpack-trees.c b/unpack-trees.c
index 7ea8c5f..f98b1cb 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1091,6 +1091,8 @@ static int merged_entry(struct cache_entry *merge=
, struct cache_entry *old,
 	if (!old) {
 		if (verify_absent(merge, "overwritten", o))
 			return -1;
+		if (!o->skip_sparse_checkout && will_have_skip_worktree(merge, o))
+			update |=3D CE_SKIP_WORKTREE;
 		invalidate_ce_path(merge, o);
 	} else if (!(old->ce_flags & CE_CONFLICTED)) {
 		/*
--=20
1.7.1.rc1.69.g24c2f7
