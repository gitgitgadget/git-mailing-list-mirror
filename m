From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/6] clone: write detached HEAD in bare repositories
Date: Sun,  8 Jan 2012 18:46:24 +0700
Message-ID: <1326023188-15559-2-git-send-email-pclouds@gmail.com>
References: <1325771380-18862-1-git-send-email-pclouds@gmail.com>
 <1326023188-15559-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 08 12:47:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjrDV-0000Yq-7C
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 12:47:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753162Ab2AHLrH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jan 2012 06:47:07 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39267 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814Ab2AHLrF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 06:47:05 -0500
Received: by mail-iy0-f174.google.com with SMTP id h11so5239138iae.19
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 03:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=I4S0tWBS4sQvzsMpCzLfycuEIwnyBhyUIlMPVBfuio8=;
        b=aXosO3+xSeOjJmM5d7nJ6DOVe6iykZ05+zR6jlA2h3Z8QTOMIwmj+mcXjGgBdoj+P1
         L0EZfMEosD9fcmuT5xDH2g6mVUAYD0zsB32qCFRax1hRHEJep8m5ENK/ATwfeYYzvZ0S
         42rbDXUN5pO1gye+Muu73tMMMaJIRKSJSIKuw=
Received: by 10.43.54.10 with SMTP id vs10mr12188971icb.13.1326023225433;
        Sun, 08 Jan 2012 03:47:05 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.35.243])
        by mx.google.com with ESMTPS id py4sm9486920igc.2.2012.01.08.03.47.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 08 Jan 2012 03:47:04 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 08 Jan 2012 18:46:38 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1326023188-15559-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188100>

If we don't write, HEAD is still at refs/heads/master as initialized
by init-db, which may or may not match remote's HEAD.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clone.c  |    9 +++------
 t/t5601-clone.sh |   25 ++++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 86db954..8dde1ea 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -720,12 +720,9 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 		}
 	} else if (remote_head) {
 		/* Source had detached HEAD pointing somewhere. */
-		if (!option_bare) {
-			update_ref(reflog_msg.buf, "HEAD",
-				   remote_head->old_sha1,
-				   NULL, REF_NODEREF, DIE_ON_ERR);
-			our_head_points_at =3D remote_head;
-		}
+		update_ref(reflog_msg.buf, "HEAD", remote_head->old_sha1,
+			   NULL, REF_NODEREF, DIE_ON_ERR);
+		our_head_points_at =3D remote_head;
 	} else {
 		/* Nothing to checkout out */
 		if (!option_no_checkout)
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 49821eb..e0b8db6 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -12,7 +12,10 @@ test_expect_success setup '
 		cd src &&
 		>file &&
 		git add file &&
-		git commit -m initial
+		git commit -m initial &&
+		echo 1 >file &&
+		git add file &&
+		git commit -m updated
 	)
=20
 '
@@ -88,6 +91,26 @@ test_expect_success 'clone --mirror' '
=20
 '
=20
+test_expect_success 'clone --mirror with detached HEAD' '
+
+	( cd src && git checkout HEAD^ && git rev-parse HEAD >../expected ) &=
&
+	git clone --mirror src mirror.detached &&
+	( cd src && git checkout - ) &&
+	GIT_DIR=3Dmirror.detached git rev-parse HEAD >actual &&
+	test_cmp expected actual
+
+'
+
+test_expect_success 'clone --bare with detached HEAD' '
+
+	( cd src && git checkout HEAD^ && git rev-parse HEAD >../expected ) &=
&
+	git clone --bare src bare.detached &&
+	( cd src && git checkout - ) &&
+	GIT_DIR=3Dbare.detached git rev-parse HEAD >actual &&
+	test_cmp expected actual
+
+'
+
 test_expect_success 'clone --bare names the local repository <name>.gi=
t' '
=20
 	git clone --bare src &&
--=20
1.7.8.36.g69ee2
