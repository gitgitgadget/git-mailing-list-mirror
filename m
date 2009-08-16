From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] unpack-trees.c: simplify check_updates() code path when o->update is false
Date: Sun, 16 Aug 2009 12:05:30 +0700
Message-ID: <1250399130-31793-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 16 07:05:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McXwC-00077w-MB
	for gcvg-git-2@gmane.org; Sun, 16 Aug 2009 07:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbZHPFFj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Aug 2009 01:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbZHPFFj
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 01:05:39 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:1726 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111AbZHPFFi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2009 01:05:38 -0400
Received: by wa-out-1112.google.com with SMTP id j5so407262wah.21
        for <git@vger.kernel.org>; Sat, 15 Aug 2009 22:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=zXfi57G/E0OqZ6yzi3lImlBV8qSjMMTfB124/hmkGhI=;
        b=rUAcAg5DUB1UtS74i7APVomphqHJIq2ESzo+TiIUfcvCwBox/W77vp8MlVFiEuKYNw
         DUup+suSpPvsB9fPNc3rvvV/X2o0A7rREkvo7TjXxrd06vZI/KQ6JSX3KDGoU/kgEshB
         D7T9rlW5rQQ+8mfp7CmpgsDFp36eYPALR0DPU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=AnuvP4VCVhqE7BPdhZl22KvdUEA9eXhTHn7X6TRTayfBkruMn6xQ3V+BCRApBz1mJ3
         iVdLxl4uTwjqtkGUo/xWWLdbK6ATAT823HHeEJW5qpu3wwfg4IojcB6Faq2U6TkoYvdR
         /vxhAL54p6Cd5jYO8+YSxbgXEYCd2kAEVE0cE=
Received: by 10.114.169.10 with SMTP id r10mr3449475wae.140.1250399139305;
        Sat, 15 Aug 2009 22:05:39 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.201.30])
        by mx.google.com with ESMTPS id k41sm13684717rvb.10.2009.08.15.22.05.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 Aug 2009 22:05:37 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 16 Aug 2009 12:05:33 +0700
X-Mailer: git-send-email 1.6.3.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126050>

check_updates() is heavily branched by o->update, which makes it quite
difficult to follow. This patch rips "o->update =3D=3D 0" code path out=
 and
put it on top.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 unpack-trees.c |   23 +++++++++++++----------
 1 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 720f7a1..3ee9919 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -75,7 +75,15 @@ static int check_updates(struct unpack_trees_options=
 *o)
 	int i;
 	int errs =3D 0;
=20
-	if (o->update && o->verbose_update) {
+	if (!o->update) {
+		remove_marked_cache_entries(&o->result);
+		remove_scheduled_dirs();
+		for (i =3D 0; i < index->cache_nr; i++)
+			index->cache[i]->ce_flags &=3D ~CE_UPDATE;
+		return 0;
+	}
+
+	if (o->verbose_update) {
 		for (total =3D cnt =3D 0; cnt < index->cache_nr; cnt++) {
 			struct cache_entry *ce =3D index->cache[cnt];
 			if (ce->ce_flags & (CE_UPDATE | CE_REMOVE))
@@ -87,15 +95,13 @@ static int check_updates(struct unpack_trees_option=
s *o)
 		cnt =3D 0;
 	}
=20
-	if (o->update)
-		git_attr_set_direction(GIT_ATTR_CHECKOUT, &o->result);
+	git_attr_set_direction(GIT_ATTR_CHECKOUT, &o->result);
 	for (i =3D 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce =3D index->cache[i];
=20
 		if (ce->ce_flags & CE_REMOVE) {
 			display_progress(progress, ++cnt);
-			if (o->update)
-				unlink_entry(ce);
+			unlink_entry(ce);
 		}
 	}
 	remove_marked_cache_entries(&o->result);
@@ -107,14 +113,11 @@ static int check_updates(struct unpack_trees_opti=
ons *o)
 		if (ce->ce_flags & CE_UPDATE) {
 			display_progress(progress, ++cnt);
 			ce->ce_flags &=3D ~CE_UPDATE;
-			if (o->update) {
-				errs |=3D checkout_entry(ce, &state, NULL);
-			}
+			errs |=3D checkout_entry(ce, &state, NULL);
 		}
 	}
 	stop_progress(&progress);
-	if (o->update)
-		git_attr_set_direction(GIT_ATTR_CHECKIN, NULL);
+	git_attr_set_direction(GIT_ATTR_CHECKIN, NULL);
 	return errs !=3D 0;
 }
=20
--=20
1.6.3.GIT
