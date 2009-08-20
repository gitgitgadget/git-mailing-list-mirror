From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [RFC PATCH v4 01/19] update-index: refactor mark_valid() in preparation for new options
Date: Thu, 20 Aug 2009 20:46:55 +0700
Message-ID: <1250776033-12395-2-git-send-email-pclouds@gmail.com>
References: <1250776033-12395-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 20 15:47:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Me7zR-0006kO-6W
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 15:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754612AbZHTNr1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Aug 2009 09:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754610AbZHTNr0
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 09:47:26 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:44339 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754476AbZHTNr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 09:47:26 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1591323rvb.1
        for <git@vger.kernel.org>; Thu, 20 Aug 2009 06:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=xszVVnTb/SRFcHn3V4FCzqy1J/Lz6bHf15vooGMSAto=;
        b=AgdlNQmOplAEJfub2bNDyoFSeQ9kvqin1NgmcCX9IzKy1GsFBI7DvCYlmr3XLi/o1R
         0vmQ5MEEzqtil6TDQB1LAHJwH77utZygsf06zmCA07C28PT1tEuRb7c+0hJqigJHdDa6
         9E+O6m/oDIR4p/vGULCYC7RM0/MJA89tOvolE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=u3L5mh5yH5kBD2s0KWiXeMvWSDl9kpfMB3YMxhBosQIAGjGUtbrFeelHafRTxroAVk
         7/q+pZjA8XuAJGHqfGa1DG8vLzvXbzievFOyXTvvkdBkZLX8JJ3ykNzS1xBg1bKG49j5
         s02+vdhpVZHXDWmJX4p38YPM6lbvYcLDAyQRg=
Received: by 10.140.208.16 with SMTP id f16mr4369822rvg.131.1250776047556;
        Thu, 20 Aug 2009 06:47:27 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.241.222])
        by mx.google.com with ESMTPS id 21sm185513pzk.15.2009.08.20.06.47.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 Aug 2009 06:47:26 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 20 Aug 2009 20:47:21 +0700
X-Mailer: git-send-email 1.6.3.GIT
In-Reply-To: <1250776033-12395-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126622>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-update-index.c |   24 ++++++++++--------------
 1 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/builtin-update-index.c b/builtin-update-index.c
index 92beaaf..f1b6c8e 100644
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
@@ -647,11 +643,11 @@ int cmd_update_index(int argc, const char **argv,=
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
1.6.3.GIT
