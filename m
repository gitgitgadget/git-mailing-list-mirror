From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 27/32] gc: factor out gc.pruneexpire parsing code
Date: Sat, 30 Aug 2014 15:33:57 +0700
Message-ID: <1409387642-24492-28-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 10:36:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNe98-0003IS-W0
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 10:36:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbaH3IgU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Aug 2014 04:36:20 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:49515 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280AbaH3IgS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 04:36:18 -0400
Received: by mail-pd0-f178.google.com with SMTP id y13so2067416pdi.37
        for <git@vger.kernel.org>; Sat, 30 Aug 2014 01:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=g+Lz+YElhuLLUZQj3E724Uy1x20kFWs2nNw7F4B9Hh4=;
        b=Ka7FkPZsh1iPqqAoo8QPU1PpQJBOvFFYknfFvBMJMA4ep4JJZci7HsPZ2xNlpws46E
         WWUt72lLyzRz5h23GLBOGH9fJfsCpLENB4rEX7FlUhQtDbO3iqR5JaYIYfSst1YmeX29
         qAYCXCFtmdt48ggU+/hO6KIeekBZGb2zy/pQ3VuvaBlA4Qg78YRdQoLxOv3Oqgpvh5X1
         gHRcImnc8JQ9jzWsSEbUEN1b/fgjbmACABjmiEAd4wNbNWtbu4cG1v9eLBn/+Gvk+G1e
         +6Z3brcP1MTdsBI88teXv86GenkYODBWLpM6CwICUfRoIn8CN1w78jp0sOxIjiJ2Q7vB
         fbpA==
X-Received: by 10.70.87.225 with SMTP id bb1mr22224578pdb.67.1409387778094;
        Sat, 30 Aug 2014 01:36:18 -0700 (PDT)
Received: from lanh ([115.73.195.142])
        by mx.google.com with ESMTPSA id h8sm3223476pdn.27.2014.08.30.01.36.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Aug 2014 01:36:17 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 30 Aug 2014 15:36:27 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256238>

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
