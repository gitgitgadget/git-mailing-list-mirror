From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/5] i18n: keep the last \n even when text is poisoned
Date: Thu,  8 Mar 2012 16:16:34 +0700
Message-ID: <1331198198-22409-2-git-send-email-pclouds@gmail.com>
References: <1331198198-22409-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 10:17:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5ZTX-0008M2-Tj
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 10:17:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755954Ab2CHJR3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 04:17:29 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54679 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755550Ab2CHJRT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 04:17:19 -0500
Received: by mail-pz0-f46.google.com with SMTP id r28so259341daj.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 01:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=/AwXSLHu05F0tn+c2hQs1Bnjlmc3UtLxBkiPSwUyd3o=;
        b=O/52jkx26IlL4Pk+dKQ3yLip4sgcBDGkoR5XlW3rjBsyjc5ePScuMlNniU8k2/Lrwu
         5M3IQDQ2bZ2yjKEYn4ynyyGphNWepzPXmxWZHiWRxVsCdLvodoAufBZ3xrTrzZP5vpt0
         BtfEgkkmSBtBlHYX6uhnjV/+oZ0cdDLnjyPT0bai/DVPp26a27IUQbTmqx2z9B6EU18r
         wFs0R3LNu4Run+SQQGLXT75Md7XHn2DC2avwxV4o+ITiI3qy/DvFhD8QzI2QiXV4CCzD
         57Am9M/YQYqEME0g3KPgo7R4a+Gd3FwfTjWvkTtBjpR+CPOjIHaetMUrmqnOf5IammiF
         3PTg==
Received: by 10.68.233.98 with SMTP id tv2mr8367627pbc.51.1331198239716;
        Thu, 08 Mar 2012 01:17:19 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id vy2sm2304965pbb.48.2012.03.08.01.17.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 08 Mar 2012 01:17:18 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 08 Mar 2012 16:16:49 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1331198198-22409-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192541>

This helps maintain the layout somewhat when translatable text is
poisoned.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 gettext.c |   10 ++++++++++
 gettext.h |    6 ++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/gettext.c b/gettext.c
index f75bca7..60bc2ad 100644
--- a/gettext.c
+++ b/gettext.c
@@ -24,6 +24,16 @@ int use_gettext_poison(void)
 		poison_requested =3D getenv("GIT_GETTEXT_POISON") ? 1 : 0;
 	return poison_requested;
 }
+
+const char *poison_text(const char *msgid)
+{
+	int len =3D strlen(msgid);
+	if (len && msgid[len-1] =3D=3D '\n')
+		return "# GETTEXT POISON #\n";
+	else
+		return "# GETTEXT POISON #";
+}
+
 #endif
=20
 #ifndef NO_GETTEXT
diff --git a/gettext.h b/gettext.h
index 57ba8bb..2313c84 100644
--- a/gettext.h
+++ b/gettext.h
@@ -38,20 +38,22 @@ static inline void git_setup_gettext(void)
=20
 #ifdef GETTEXT_POISON
 extern int use_gettext_poison(void);
+extern const char *poison_text(const char *msgid);
 #else
 #define use_gettext_poison() 0
+#define poison_text(x) NULL
 #endif
=20
 static inline FORMAT_PRESERVING(1) const char *_(const char *msgid)
 {
-	return use_gettext_poison() ? "# GETTEXT POISON #" : gettext(msgid);
+	return use_gettext_poison() ? poison_text(msgid) : gettext(msgid);
 }
=20
 static inline FORMAT_PRESERVING(1) FORMAT_PRESERVING(2)
 const char *Q_(const char *msgid, const char *plu, unsigned long n)
 {
 	if (use_gettext_poison())
-		return "# GETTEXT POISON #";
+		return poison_text(msgid);
 	return ngettext(msgid, plu, n);
 }
=20
--=20
1.7.3.1.256.g2539c.dirty
