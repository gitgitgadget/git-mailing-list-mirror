From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 27/32] gc: factor out gc.pruneexpire parsing code
Date: Sun, 28 Sep 2014 08:22:41 +0700
Message-ID: <1411867366-3821-28-git-send-email-pclouds@gmail.com>
References: <xmqqk34r9z3r.fsf@gitster.dls.corp.google.com>
 <1411867366-3821-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 28 03:25:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XY3Es-0002mX-K8
	for gcvg-git-2@plane.gmane.org; Sun, 28 Sep 2014 03:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753498AbaI1BZT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Sep 2014 21:25:19 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:46402 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183AbaI1BZS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2014 21:25:18 -0400
Received: by mail-pd0-f182.google.com with SMTP id y10so3253297pdj.41
        for <git@vger.kernel.org>; Sat, 27 Sep 2014 18:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=RDd9eCnZwaCCKxAMeDucPH64F4wFp7IK2waarTTLUjM=;
        b=fxYpfuC1BegNLsDbo3UoZdyFr06g9i/NzCjE9g6n+JR5doSgmiNDTDIIakVl91BDRS
         nmEG7wg+LVU2XJIpafs0A9qtkmZKv8dLqo0K/V9aZs0vb1AzCGiVhvOVGIbWab0Lf067
         bz6MgFCQJ0a3DRsfeHocf0O+HoN7Dw0yIZifeqfzAfXm0+nM1+2KIe6zdKbAXGL0BTUV
         cCQLXrR6hmXFmte4MK66okP6gx23Y0KfpQawvwM8wpQAxPJFdLxq61mQyH+1A8dDs0r7
         srJmODMUrR7VdcrbbjiLuFDaRhDB9pDv56ZhDBmLivfgrdi34EHfJqL8XzS9lbX/1YrQ
         JCdg==
X-Received: by 10.68.252.138 with SMTP id zs10mr45228167pbc.13.1411867518308;
        Sat, 27 Sep 2014 18:25:18 -0700 (PDT)
Received: from lanh ([115.73.212.224])
        by mx.google.com with ESMTPSA id k2sm8518968pdl.90.2014.09.27.18.25.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Sep 2014 18:25:17 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 28 Sep 2014 08:25:21 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1411867366-3821-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257586>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/gc.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index b690929..849a87c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -55,6 +55,17 @@ static void remove_pidfile_on_signal(int signo)
 	raise(signo);
 }
=20
+static void git_config_date_string(const char *key, const char **outpu=
t)
+{
+	if (git_config_get_string_const(key, output))
+		return;
+	if (strcmp(*output, "now")) {
+		unsigned long now =3D approxidate("now");
+		if (approxidate(*output) >=3D now)
+			git_die_config(key, _("Invalid %s: '%s'"), key, *output);
+	}
+}
+
 static void gc_config(void)
 {
 	const char *value;
@@ -71,16 +82,7 @@ static void gc_config(void)
 	git_config_get_int("gc.auto", &gc_auto_threshold);
 	git_config_get_int("gc.autopacklimit", &gc_auto_pack_limit);
 	git_config_get_bool("gc.autodetach", &detach_auto);
-
-	if (!git_config_get_string_const("gc.pruneexpire", &prune_expire)) {
-		if (strcmp(prune_expire, "now")) {
-			unsigned long now =3D approxidate("now");
-			if (approxidate(prune_expire) >=3D now) {
-				git_die_config("gc.pruneexpire", _("Invalid gc.pruneexpire: '%s'")=
,
-						prune_expire);
-			}
-		}
-	}
+	git_config_date_string("gc.pruneexpire", &prune_expire);
 	git_config(git_default_config, NULL);
 }
=20
--=20
2.1.0.rc0.78.gc0d8480
