From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 43/45] pathspec: make --literal-pathspecs disable pathspec magic
Date: Sun,  9 Jun 2013 13:26:16 +0700
Message-ID: <1370759178-1709-44-git-send-email-pclouds@gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 08:29:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlZ8D-00026n-0A
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 08:29:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753169Ab3FIG3d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 02:29:33 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:39533 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753091Ab3FIG3c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 02:29:32 -0400
Received: by mail-pb0-f42.google.com with SMTP id un1so2012948pbc.15
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 23:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=CAhB8n+PrX9P+aySL/JcLgo5tcICCKTr8ADv4LS6bww=;
        b=SFJx25Xyq9C56jjsGwcDfeAGijRETlFhRAS4fwut705R3UCE0gWTKxi0RHWItoU0aD
         1k+hs7E94Ucj4x4yrh7hqLxdfFdTSVCfFR32daRBdsQo6Afo/Hc964X0BHLNSpKLaluD
         SuFnOUmf+FHB6MQ2DVIgIT/1YHtUZvR1Czd2yGeoQGUTwFT7qMeP3b4txCO8DZ651Ipj
         FlmrjEJv5NevM7/kRn9rANVDNwYwfnogXnoEU8g0wALH8caXLiZsEs+jI4IZRzQZkGvb
         EGwpwcbIkVRjfPEFK+c5dExjwEy29e2JVPbf+hHH0nk3+VLL6G7UTQfoOpLj3i9+xcLk
         HnZw==
X-Received: by 10.68.136.230 with SMTP id qd6mr5001170pbb.112.1370759371986;
        Sat, 08 Jun 2013 23:29:31 -0700 (PDT)
Received: from lanh ([115.73.237.130])
        by mx.google.com with ESMTPSA id ov2sm5506349pbc.34.2013.06.08.23.29.28
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 23:29:31 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Jun 2013 13:31:02 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226935>

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
index 68f1ee6..a3fbc59 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -448,8 +448,8 @@ help ...`.
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
index cc6545f..9802829 100644
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
