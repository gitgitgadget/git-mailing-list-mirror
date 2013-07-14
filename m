From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 44/46] pathspec: make --literal-pathspecs disable pathspec magic
Date: Sun, 14 Jul 2013 15:36:07 +0700
Message-ID: <1373790969-13000-45-git-send-email-pclouds@gmail.com>
References: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 10:40:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyHrG-0003pR-CV
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 10:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546Ab3GNIki convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jul 2013 04:40:38 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:54838 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549Ab3GNIkf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 04:40:35 -0400
Received: by mail-pb0-f42.google.com with SMTP id un1so10394027pbc.1
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 01:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=zyFQWj0E0v1F2jH2zIlPgRVygmdsOlcwUH8M7zo2OPg=;
        b=xEw0U//xkfV0RczCzK/biRtEAI6iFrB1TlD8XpGqO6hKg2fotTafwW30A+0/WWn4qu
         ypu2Can278PkLm7HS20scWz0wlybSiycJIpn7uhEfUVvbrpl5ik6viewY9gzxbyNYT73
         TNOTUSrlh9kGRIsUfTjTfbB//vFRFXyaWG8CjgMOz3cF2rR6KbGXNQ7as4K3NtrYwj3e
         PVBqGTJQau+1JsFCW78xC20//ihjyws+FqcCOzKy0yN+yEq3c+MAYrgEsbQIgMswW/Ta
         yEpZoIEpiYAmirimwMF26FzYQMzxhfP8TPSHzSBe4MkVta/2Rd1mFHZ1nI1AEETl8jry
         Ep/w==
X-Received: by 10.68.34.97 with SMTP id y1mr1707051pbi.198.1373791235380;
        Sun, 14 Jul 2013 01:40:35 -0700 (PDT)
Received: from lanh ([115.73.210.100])
        by mx.google.com with ESMTPSA id te9sm41722564pab.6.2013.07.14.01.40.32
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 01:40:34 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Jul 2013 15:40:46 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230356>

--literal-pathspecs and its equivalent environment variable are
probably used for scripting. In that setting, pathspec magic may be
unwanted. Disabling globbing in individual pathspec can be done via
:(literal) magic.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git.txt      | 4 ++--
 pathspec.c                 | 2 +-
 t/t6130-pathspec-noglob.sh | 6 ++++++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index b738a40..80139ae 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -450,8 +450,8 @@ help ...`.
 	linkgit:git-replace[1] for more information.
=20
 --literal-pathspecs::
-	Treat pathspecs literally, rather than as glob patterns. This is
-	equivalent to setting the `GIT_LITERAL_PATHSPECS` environment
+	Treat pathspecs literally (i.e. no globbing, no pathspec magic).
+	This is equivalent to setting the `GIT_LITERAL_PATHSPECS` environment
 	variable to `1`.
=20
=20
diff --git a/pathspec.c b/pathspec.c
index 6a16938..b6d8e74 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -103,7 +103,7 @@ static unsigned prefix_pathspec(struct pathspec_ite=
m *item,
 	if (literal_global)
 		global_magic |=3D PATHSPEC_LITERAL;
=20
-	if (elt[0] !=3D ':') {
+	if (elt[0] !=3D ':' || literal_global) {
 		; /* nothing to do */
 	} else if (elt[1] =3D=3D '(') {
 		/* longhand */
diff --git a/t/t6130-pathspec-noglob.sh b/t/t6130-pathspec-noglob.sh
index 49c148e..8551b02 100755
--- a/t/t6130-pathspec-noglob.sh
+++ b/t/t6130-pathspec-noglob.sh
@@ -77,6 +77,12 @@ test_expect_success 'no-glob option matches literall=
y (bracket)' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'no-glob option disables :(literal)' '
+	: >expect &&
+	git --literal-pathspecs log --format=3D%s -- ":(literal)foo" >actual =
&&
+	test_cmp expect actual
+'
+
 test_expect_success 'no-glob environment variable works' '
 	echo star >expect &&
 	GIT_LITERAL_PATHSPECS=3D1 git log --format=3D%s -- "f*" >actual &&
--=20
1.8.2.83.gc99314b
