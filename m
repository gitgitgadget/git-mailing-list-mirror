From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 02/10] clone: write detached HEAD in bare repositories
Date: Fri, 13 Jan 2012 14:21:54 +0700
Message-ID: <1326439322-15648-3-git-send-email-pclouds@gmail.com>
References: <1326189427-20800-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 08:22:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlbTA-0007vD-G0
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 08:22:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778Ab2AMHWc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jan 2012 02:22:32 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:37541 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752214Ab2AMHWb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jan 2012 02:22:31 -0500
Received: by mail-tul01m020-f174.google.com with SMTP id va7so1808457obc.19
        for <git@vger.kernel.org>; Thu, 12 Jan 2012 23:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=DE7QCtQVX9Xy572AGCLTmvp7UjLRgo7M6zhk2yuGDgk=;
        b=nIePaxRlJSu7FVGBeegawOAPFuBjY3WpSzOPUzBQf3R6415Tcr35+YFw5IgS7ZqOSP
         dL9WwDNXO4CTJpQBzLH7d2ya6KS7dRyLfIwt0oqG7P8N15JBjpj4zNA3Xu8rkWJIpKlE
         0M1Das1QZY8PGxH56AlktYgRADVsgWG4oAfrg=
Received: by 10.50.190.196 with SMTP id gs4mr1472748igc.14.1326439351224;
        Thu, 12 Jan 2012 23:22:31 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id bj3sm5088324igb.4.2012.01.12.23.22.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Jan 2012 23:22:30 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 13 Jan 2012 14:22:21 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1326189427-20800-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188499>

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
