From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 02/10] clone: write detached HEAD in bare repositories
Date: Tue, 10 Jan 2012 16:56:59 +0700
Message-ID: <1326189427-20800-3-git-send-email-pclouds@gmail.com>
References: <1326023188-15559-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 10:57:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkYSc-000575-Kq
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 10:57:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755818Ab2AJJ5i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jan 2012 04:57:38 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:49885 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754529Ab2AJJ5h (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2012 04:57:37 -0500
Received: by mail-tul01m020-f174.google.com with SMTP id wo16so5292866obc.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 01:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=DE7QCtQVX9Xy572AGCLTmvp7UjLRgo7M6zhk2yuGDgk=;
        b=I8VmSafhHN41oc+AqU5budbKavoJg4383sl82pIi5u/VrI5MytOf6QHpMCmODqrnH4
         /z/2tBOGYMq1jeT4t/olwUPtRvqREfc/wDszBdmyFPp+cjuZFEX6k3tVXLMV0lGo4htM
         lRBMnPs/QNium2B+0qDUcXcS9UlOXNCquW/gY=
Received: by 10.50.181.169 with SMTP id dx9mr1465094igc.0.1326189456693;
        Tue, 10 Jan 2012 01:57:36 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id l35sm261463869ibj.0.2012.01.10.01.57.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Jan 2012 01:57:35 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 10 Jan 2012 16:57:27 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1326023188-15559-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188234>

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
1.7.3.1.256.g2539c.dirty
