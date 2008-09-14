From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/16] update-index: refactor mark_valid() in preparation for new options
Date: Sun, 14 Sep 2008 20:07:52 +0700
Message-ID: <1221397685-27715-4-git-send-email-pclouds@gmail.com>
References: <1221397685-27715-1-git-send-email-pclouds@gmail.com>
 <1221397685-27715-2-git-send-email-pclouds@gmail.com>
 <1221397685-27715-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 14 15:09:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KerML-0005o4-50
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 15:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753970AbYINNIh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Sep 2008 09:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753950AbYINNIh
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 09:08:37 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:21050 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753921AbYINNIg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2008 09:08:36 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1590748wfd.4
        for <git@vger.kernel.org>; Sun, 14 Sep 2008 06:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=CSBj1t5NDsVWzoYivRAyQgy0gjk/AehLdvyvU96jnSk=;
        b=Hroy641yjKtV5mBBdNcCZhIjkUC+En6qsBfEMiWBk9aQDg3eiBvrpEtv1xLEfBVg83
         ZpOP+/+Mi5+t9tttyWTLTBPk1c8DyKGtEvDJZtM5xeg5dujALEg3bD0jWBL0aMCFvT70
         gNp6LisaDGFZBS1RVJ4SCIXc3Kur9T5ocVmH4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=EpnNnez5QdHpi5WBCL39jJK1k4aIvSZyfDoOPBMiplVFCFMCmMYXmzi3R4yWRKe5tq
         zt1OlmJJhITbWHqnCsxfDOq0h3NsjgUUaKezKgXyIXVstwAHwNHzywhpfMTZC65Jg1hD
         Yl+GW8zB43ym5497qIT5juOFIebPYStxyrfHg=
Received: by 10.142.245.6 with SMTP id s6mr2257181wfh.157.1221397716488;
        Sun, 14 Sep 2008 06:08:36 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.40.147])
        by mx.google.com with ESMTPS id 22sm20090105wfi.14.2008.09.14.06.08.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Sep 2008 06:08:35 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 14 Sep 2008 20:08:28 +0700
X-Mailer: git-send-email 1.6.0.96.g2fad1.dirty
In-Reply-To: <1221397685-27715-3-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95830>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-update-index.c |   24 ++++++++++--------------
 1 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/builtin-update-index.c b/builtin-update-index.c
index ce83224..f63a34e 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -24,8 +24,8 @@ static int info_only;
 static int force_remove;
 static int verbose;
 static int mark_valid_only;
-#define MARK_VALID 1
-#define UNMARK_VALID 2
+#define MARK_FLAG 1
+#define UNMARK_FLAG 2
=20
 static void report(const char *fmt, ...)
 {
@@ -40,19 +40,15 @@ static void report(const char *fmt, ...)
 	va_end(vp);
 }
=20
-static int mark_valid(const char *path)
+static int mark_ce_flags(const char *path, int flag, int mark)
 {
 	int namelen =3D strlen(path);
 	int pos =3D cache_name_pos(path, namelen);
 	if (0 <=3D pos) {
-		switch (mark_valid_only) {
-		case MARK_VALID:
-			active_cache[pos]->ce_flags |=3D CE_VALID;
-			break;
-		case UNMARK_VALID:
-			active_cache[pos]->ce_flags &=3D ~CE_VALID;
-			break;
-		}
+		if (mark)
+			active_cache[pos]->ce_flags |=3D flag;
+		else
+			active_cache[pos]->ce_flags &=3D ~flag;
 		cache_tree_invalidate_path(active_cache_tree, path);
 		active_cache_changed =3D 1;
 		return 0;
@@ -276,7 +272,7 @@ static void update_one(const char *path, const char=
 *prefix, int prefix_length)
 		goto free_return;
 	}
 	if (mark_valid_only) {
-		if (mark_valid(p))
+		if (mark_ce_flags(p, CE_VALID, mark_valid_only =3D=3D MARK_FLAG))
 			die("Unable to mark file %s", path);
 		goto free_return;
 	}
@@ -649,11 +645,11 @@ int cmd_update_index(int argc, const char **argv,=
 const char *prefix)
 				continue;
 			}
 			if (!strcmp(path, "--assume-unchanged")) {
-				mark_valid_only =3D MARK_VALID;
+				mark_valid_only =3D MARK_FLAG;
 				continue;
 			}
 			if (!strcmp(path, "--no-assume-unchanged")) {
-				mark_valid_only =3D UNMARK_VALID;
+				mark_valid_only =3D UNMARK_FLAG;
 				continue;
 			}
 			if (!strcmp(path, "--info-only")) {
--=20
1.6.0.96.g2fad1.dirty
