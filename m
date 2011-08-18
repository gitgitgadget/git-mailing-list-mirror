From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/5] log: decorate "replaced" on to replaced commits
Date: Thu, 18 Aug 2011 19:29:38 +0700
Message-ID: <1313670578-2939-6-git-send-email-pclouds@gmail.com>
References: <1313593326-12077-1-git-send-email-pclouds@gmail.com>
 <1313670578-2939-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 14:30:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qu1k0-0001c5-80
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 14:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755960Ab1HRMa0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Aug 2011 08:30:26 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:41218 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755555Ab1HRMaY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 08:30:24 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so2928610pzk.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 05:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ThbZR6LJXN0FyaiR1kI97coTBSUqGwfc44d9AFQbkfE=;
        b=gpS0Xzu8H4B+wz09FOfw5Oc5Ck+3CcHNTo/FuMLiOrtnQURR6J0X4Ot3bcKPuuOP9D
         npBV/kTSkje9EoYhg7GajGMAD4033PLQ+w/9o329usSgJhbvM2TRk7leKwSjAgDiLKur
         XvQi2LYYIH/+C0AjYFSmmtvtUaAPEghaDA2fw=
Received: by 10.143.97.21 with SMTP id z21mr377570wfl.316.1313670624607;
        Thu, 18 Aug 2011 05:30:24 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.228.117])
        by mx.google.com with ESMTPS id v2sm1438323pbi.83.2011.08.18.05.30.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Aug 2011 05:30:23 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 18 Aug 2011 19:30:18 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1313670578-2939-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179593>

Old code also decorates "new" commits with "refs/replace/SHA1". This
is now gone, but I guess no one will miss it.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 log-tree.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 5605244..b982b9f 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -92,8 +92,22 @@ static void add_name_decoration(enum decoration_type=
 type, const char *name, str
=20
 static int add_ref_decoration(const char *refname, const unsigned char=
 *sha1, int flags, void *cb_data)
 {
-	struct object *obj =3D parse_object(sha1);
+	struct object *obj;
 	enum decoration_type type =3D DECORATION_NONE;
+
+	if (!prefixcmp(refname, "refs/replace/")) {
+		unsigned char original_sha1[20];
+		if (get_sha1_hex(refname + 13, original_sha1)) {
+			warning("invalid replace ref %s", refname);
+			return 0;
+		}
+		obj =3D parse_object(original_sha1);
+		if (obj && (obj->type =3D=3D OBJ_COMMIT || obj->type =3D=3D OBJ_TAG)=
)
+			add_name_decoration(DECORATION_GRAFTED, "replaced", obj);
+		return 0;
+	}
+
+	obj =3D parse_object(sha1);
 	if (!obj)
 		return 0;
=20
--=20
1.7.4.74.g639db
