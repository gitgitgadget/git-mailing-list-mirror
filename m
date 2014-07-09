From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v6 06/32] setup_git_env: use git_pathdup instead of xmalloc + sprintf
Date: Wed,  9 Jul 2014 14:32:51 +0700
Message-ID: <1404891197-18067-7-git-send-email-pclouds@gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 09 09:34:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4mOE-00039r-6R
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 09:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754667AbaGIHeB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jul 2014 03:34:01 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:37320 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754448AbaGIHeA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 03:34:00 -0400
Received: by mail-pa0-f48.google.com with SMTP id et14so8736636pad.35
        for <git@vger.kernel.org>; Wed, 09 Jul 2014 00:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=FYFSKpcMTlhoMrRNUrl9WonEcwEjWeFV6+WYF02q85M=;
        b=uk93TRa0Gp5xbpNpVr+86wM9yRHnaYN/UmIw6VpPZ9Qurn1NyFyunAaRwR8kx/YJ1T
         ZUTNEvINvnZpqG7YmSdbh5X3nPlNlgH9xpu+wOx5IbeIksIdVzQpAiG6ZPk5C8XDHa9I
         x5pLy0nd4RGXMPZCmB+hFMOAFEbP17MU3IYdcGoDB7HN8yZy08XUKdpc9nLgIEP3LLqR
         iw016uIetJ33or1ykaqgwqAmz2Q9L2xJBx6yoNqQmDuCvL4JMB/CDGC2LXF7ZFqsx9EZ
         OYjbWv3a3ebYYDeJdCb0cK8fwoHTXCrPRhIVSHbM4q0sjkt+8Peps8x8juLSDtfR5gpr
         sUOg==
X-Received: by 10.66.232.68 with SMTP id tm4mr13966025pac.114.1404891239766;
        Wed, 09 Jul 2014 00:33:59 -0700 (PDT)
Received: from lanh ([115.73.209.165])
        by mx.google.com with ESMTPSA id dd5sm57906183pbc.85.2014.07.09.00.33.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jul 2014 00:33:59 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 09 Jul 2014 14:33:56 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253081>

=46rom: Jeff King <peff@peff.net>

This is shorter, harder to get wrong, and more clearly
captures the intent.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 environment.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/environment.c b/environment.c
index 4dac5e9..4de7b81 100644
--- a/environment.c
+++ b/environment.c
@@ -135,15 +135,11 @@ static void setup_git_env(void)
 	gitfile =3D read_gitfile(git_dir);
 	git_dir =3D xstrdup(gitfile ? gitfile : git_dir);
 	git_object_dir =3D getenv(DB_ENVIRONMENT);
-	if (!git_object_dir) {
-		git_object_dir =3D xmalloc(strlen(git_dir) + 9);
-		sprintf(git_object_dir, "%s/objects", git_dir);
-	}
+	if (!git_object_dir)
+		git_object_dir =3D git_pathdup("objects");
 	git_index_file =3D getenv(INDEX_ENVIRONMENT);
-	if (!git_index_file) {
-		git_index_file =3D xmalloc(strlen(git_dir) + 7);
-		sprintf(git_index_file, "%s/index", git_dir);
-	}
+	if (!git_index_file)
+		git_index_file =3D git_pathdup("index");
 	git_graft_file =3D getenv(GRAFT_ENVIRONMENT);
 	if (!git_graft_file)
 		git_graft_file =3D git_pathdup("info/grafts");
--=20
1.9.1.346.ga2b5940
