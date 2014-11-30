From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 27/34] gc: factor out gc.pruneexpire parsing code
Date: Sun, 30 Nov 2014 15:24:52 +0700
Message-ID: <1417335899-27307-28-git-send-email-pclouds@gmail.com>
References: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 09:29:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XuztB-0000Ry-Rw
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 09:29:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942AbaK3I3u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2014 03:29:50 -0500
Received: from mail-pd0-f177.google.com ([209.85.192.177]:41741 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbaK3I3t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 03:29:49 -0500
Received: by mail-pd0-f177.google.com with SMTP id ft15so8888747pdb.22
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 00:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=L8qTQGE3eMH1FrEXPto565iqfS1bc+oWLKmfBmxkRjY=;
        b=s6dmcKzGJIKdRjIsPepVRKRZk7jANwKqpXsd5/nGWD+HPiN0mXxTanQ1TxzI219i+P
         l6tfwDlGVDEuaAAsdFP1f9WG8oVUbqT0R8qVC6cQj8elHZ/YY2ZJ9gl24XzmJ9Owa9T+
         oIYmnGwKy07F4d7I8LmzLIfBFkh6UiCETSZr+hTqnQOISOM+PCHu78fkTBtM2l7HYNqn
         FcK5iqoYK3XyPV0KYznulTrJfQdch3L8DRJPgj4wuOSwiVuKqNZurSh1Fgrr43E1wDb4
         XOFKEyGmZiVJNWPpkWl213+BNkTOCrL6+Uo5ZAC7qCRgVSKko4dIycrDYJOyyPdUI8xv
         PEGw==
X-Received: by 10.70.55.40 with SMTP id o8mr87369009pdp.87.1417336189141;
        Sun, 30 Nov 2014 00:29:49 -0800 (PST)
Received: from lanh ([115.73.247.22])
        by mx.google.com with ESMTPSA id ps2sm14337703pdb.62.2014.11.30.00.29.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2014 00:29:48 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Nov 2014 15:29:47 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260414>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/gc.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 0e65eff..0728650 100644
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
