From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/5] unpack-trees: mark new entries skip-worktree appropriately
Date: Sat, 31 Jul 2010 13:14:29 +0700
Message-ID: <1280556869-707-6-git-send-email-pclouds@gmail.com>
References: <1280556869-707-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 31 08:15:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of5MA-0002Hc-DO
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 08:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754872Ab0GaGPd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 02:15:33 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42421 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754536Ab0GaGPb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 02:15:31 -0400
Received: by pvc7 with SMTP id 7so799994pvc.19
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 23:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=fzkvRVndXfxYAPpf1StBYmxn1MZ3zbkOCpSvRyAFr2E=;
        b=iZ+JPbMNutprWO2YF5Tf4WhyWyGmrDytHubBcfG2SMIYfPswFiB/XjmPNQJi+uLGjy
         p1cDIJbWniucwzLeTrKac3qfrl/X8UlPduoNtNCyeIdPgNDIBYNpxYh4rtH6+mPTP2Au
         i4K0BvsCruFeH9KIcuJ170VAz3d7EyrFMzU5I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=uRS8hWSIq9QxTalbye6OPXaGgeLptchLbAI+qJ7MpaO9AcfVHeMpTMzqleZwt4zXWS
         eN5m2kMvc9r5WdrdoGQG2dHr0sovX0Gg/MgT/vUr4d9tzTZ7zWAHL5Ws4YZSPOTBFyzk
         sgnX0Jgt53Dg3y88U2rpTUUKwxnYZO7030Ep4=
Received: by 10.114.74.3 with SMTP id w3mr3680972waa.3.1280556931644;
        Fri, 30 Jul 2010 23:15:31 -0700 (PDT)
Received: from dektop ([123.200.231.45])
        by mx.google.com with ESMTPS id k23sm5379454waf.17.2010.07.30.23.15.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 30 Jul 2010 23:15:30 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sat, 31 Jul 2010 13:15:21 +0700
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1280556869-707-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152314>

Sparse checkout narrows worktree down based on the skip-worktree bit
before and after $GIT_DIR/info/sparse-checkout application. If it does
not have that bit before but does after, a narrow is detected and the
file will be removed from worktree.

New files added by merge, however, does not have skip-worktree bit. If
those files appear to be outside checkout area, the same rule applies:
the file gets removed from worktree even though they don't exist in
worktree.

Just pretend they have skip-worktree before in that case, so the rule
is ignored.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1011-read-tree-sparse-checkout.sh |    2 +-
 unpack-trees.c                       |    2 ++
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-s=
parse-checkout.sh
index 3e01c6e..04d4450 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -146,7 +146,7 @@ test_expect_success 'read-tree adds to worktree, ab=
sent case' '
 	test ! -f sub/added
 '
=20
-test_expect_failure 'read-tree adds to worktree, dirty case' '
+test_expect_success 'read-tree adds to worktree, dirty case' '
 	echo init.t >.git/info/sparse-checkout &&
 	git checkout -f removed &&
 	mkdir sub &&
diff --git a/unpack-trees.c b/unpack-trees.c
index b34ef46..86e6409 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1096,6 +1096,8 @@ static int merged_entry(struct cache_entry *merge=
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
