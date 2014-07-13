From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 27/31] gc: factor out gc.pruneexpire parsing code
Date: Sun, 13 Jul 2014 11:51:04 +0700
Message-ID: <1405227068-25506-28-git-send-email-pclouds@gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
 <1405227068-25506-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 13 06:55:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6Bp7-0001gA-Hp
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 06:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753103AbaGMEzi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jul 2014 00:55:38 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:38636 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753094AbaGMEzg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 00:55:36 -0400
Received: by mail-pd0-f179.google.com with SMTP id w10so3498942pde.10
        for <git@vger.kernel.org>; Sat, 12 Jul 2014 21:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Ho1ywjC6gmd4pxukSZQS18mT+BeVOf95vNq15+Po6OY=;
        b=EMPZ6Fx4m7EZE3YsX916tinycKRUaDa+O1HksaZ1oe+/UifLFjtZRW5dqglfLE97El
         kuzOrNmT/8yjAhqP+QeeM/ai4W2MQOII6s5bHYTto1Wu8yNqJt/RYVRmX/LUri0klF90
         3qd3ed+926R+H1OJKb/sGc+0Onnq1jaybDKQAasXG355EpKrF7Xx6BEo8+c0KYaYwsaF
         nBB90NbeLggC7PqHPgWyARA82wkErblms+M3S9uevfS69UTYBoJ8c4gyIVyDARMTTu33
         B4Xh225u6z8BxAE6I6yD1ENyrvUk/C7Dp/2BOd0VgyeQb9pQPpF/M82B5WsYMky1dloe
         0gjg==
X-Received: by 10.70.34.6 with SMTP id v6mr8837156pdi.29.1405227336281;
        Sat, 12 Jul 2014 21:55:36 -0700 (PDT)
Received: from lanh ([115.73.227.1])
        by mx.google.com with ESMTPSA id fl6sm28970177pab.43.2014.07.12.21.55.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jul 2014 21:55:35 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jul 2014 11:55:36 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1405227068-25506-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253430>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/gc.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 3bfb990..e38c902 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -55,6 +55,17 @@ static void remove_pidfile_on_signal(int signo)
 	raise(signo);
 }
=20
+static int git_config_date_string(const char **output,
+				  const char *var, const char *value)
+{
+	if (value && strcmp(value, "now")) {
+		unsigned long now =3D approxidate("now");
+		if (approxidate(value) >=3D now)
+			return error(_("Invalid %s: '%s'"), var, value);
+	}
+	return git_config_string(output, var, value);
+}
+
 static int gc_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "gc.packrefs")) {
@@ -84,14 +95,8 @@ static int gc_config(const char *var, const char *va=
lue, void *cb)
 		detach_auto =3D git_config_bool(var, value);
 		return 0;
 	}
-	if (!strcmp(var, "gc.pruneexpire")) {
-		if (value && strcmp(value, "now")) {
-			unsigned long now =3D approxidate("now");
-			if (approxidate(value) >=3D now)
-				return error(_("Invalid %s: '%s'"), var, value);
-		}
-		return git_config_string(&prune_expire, var, value);
-	}
+	if (!strcmp(var, "gc.pruneexpire"))
+		return git_config_date_string(&prune_expire, var, value);
 	return git_default_config(var, value, cb);
 }
=20
--=20
1.9.1.346.ga2b5940
