From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 02/10] clone: write detached HEAD in bare repositories
Date: Mon, 16 Jan 2012 16:46:08 +0700
Message-ID: <1326707176-8045-3-git-send-email-pclouds@gmail.com>
References: <1326439322-15648-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 10:46:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rmj9M-0002h2-NN
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 10:46:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753888Ab2APJqo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Jan 2012 04:46:44 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55465 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801Ab2APJqn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 04:46:43 -0500
Received: by iagf6 with SMTP id f6so2315494iag.19
        for <git@vger.kernel.org>; Mon, 16 Jan 2012 01:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=iL8a3trsFjvLVEnf3qeHuDgqFhNTUG0kbq9GJc/rSA0=;
        b=O+l/1j9T+22x7C/gRzNnUyzo0ttb7O2Bno2N9MkUaiH6n0heixQVTeFBq9x0b4P4IW
         TdbyjL/pmYkx47D6L5Sdf0XloaQDEO/+Ah7zHR7yEic02mzb0S8varfWrB7vNXjHvqYS
         eIO5gThEAHPaR7x/jaFEv5hdd1piazUwCq9eg=
Received: by 10.42.117.193 with SMTP id u1mr10012090icq.24.1326707203183;
        Mon, 16 Jan 2012 01:46:43 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id py9sm32297072igc.2.2012.01.16.01.46.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Jan 2012 01:46:41 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 16 Jan 2012 16:46:33 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1326439322-15648-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188617>

If we don't write, HEAD is still at refs/heads/master as initialized
by init-db, which may or may not match remote's HEAD.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clone.c  |    9 +++------
 t/t5601-clone.sh |   25 ++++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 9dcc5fe..91862f7 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -764,12 +764,9 @@ int cmd_clone(int argc, const char **argv, const c=
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
