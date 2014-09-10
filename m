From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 27/32] gc: factor out gc.pruneexpire parsing code
Date: Thu, 11 Sep 2014 05:42:03 +0700
Message-ID: <1410388928-32265-28-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
 <1410388928-32265-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 11 00:44:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRqcu-0002SC-JJ
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 00:44:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422AbaIJWod convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Sep 2014 18:44:33 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:46320 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753361AbaIJWoc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 18:44:32 -0400
Received: by mail-pd0-f176.google.com with SMTP id y13so8301933pdi.7
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 15:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=g+Lz+YElhuLLUZQj3E724Uy1x20kFWs2nNw7F4B9Hh4=;
        b=uGJhD3S4/+UsPdBSyzxAVH64ZlwW01t0dxYV7I6ydFQonYNmbpDRhyDTZs0+T0wbLq
         z8z9eNDJf2QAX/UwwVabwFeqCrZnEMCHwbfM+IByizhwN7ccKgKuuT31gczY2DlNvrjv
         tN1MdIywp27BYdBnDNzRFuXTgdggU2kOX9zeH/vNMtY4+7Hhd910H4ZzDytPLhlLQpYQ
         aOPubaUXsmBW+CX8ybvF+EOPW9GC00F1PxuTYhWGvGW+k6+hYBMEnBa/psUL2by+GsGk
         lKnOl7BUcNgxF9QodRZ2ZVt24pPpmiceonmZDwEzBixUFxzlUeXNuxm/g6gYmZ+S/TC2
         OI6A==
X-Received: by 10.66.189.68 with SMTP id gg4mr32659608pac.48.1410389071822;
        Wed, 10 Sep 2014 15:44:31 -0700 (PDT)
Received: from lanh ([115.73.197.210])
        by mx.google.com with ESMTPSA id d3sm8163927pbu.18.2014.09.10.15.44.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Sep 2014 15:44:31 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 11 Sep 2014 05:44:51 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1410388928-32265-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256804>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.1.0.rc0.78.gc0d8480
