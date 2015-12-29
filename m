From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/20] upload-pack: move "unshallow" sending code out of deepen()
Date: Tue, 29 Dec 2015 19:10:27 +0700
Message-ID: <1451391043-28093-5-git-send-email-pclouds@gmail.com>
References: <1451391043-28093-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 13:11:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDt7c-0006D4-Qf
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 13:11:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753302AbbL2MLV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Dec 2015 07:11:21 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33783 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217AbbL2MLU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 07:11:20 -0500
Received: by mail-pa0-f42.google.com with SMTP id cy9so123703961pac.0
        for <git@vger.kernel.org>; Tue, 29 Dec 2015 04:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=7CqiCbcr0hrwA8EEg8E7atXu/YzYiRvkqT7MG7M/L5I=;
        b=XOMwE4Ql6gjohsaOMcdhkjnxXRtP0Npjef0Ulq8wVh43SWHHf+7fTCioMp1PuXUUdi
         jSMgmhwQgGiKXWM7LX6jA8AY7H/BHio0vK2HtIqowSV7+Wx3+YXYImOieY2hKG1zw6Sq
         LZ/oSO0dxHRFqH1hJwHDVbHZf49wFPPFCcYTUDV02ZPmbPkY3Fk0oBN3VTRkC9wErj9d
         ApdlxStKxeDFIYU4C+QLGsSofwlG9/RYGMNERgLE8lOrmP2VJkw1T+wDGe8rrqmws6ct
         nID1/733z01Tt++Ng8YLUc5fDhwZ1qszyyn2IWow3sUJL29IZn5j2D/k7jABd5xMHkgJ
         jdWg==
X-Received: by 10.66.250.165 with SMTP id zd5mr11990676pac.9.1451391079853;
        Tue, 29 Dec 2015 04:11:19 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id y84sm42192677pfi.93.2015.12.29.04.11.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Dec 2015 04:11:18 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 29 Dec 2015 19:11:15 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1451391043-28093-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283113>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 upload-pack.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 4774f78..4bb104c 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -552,21 +552,10 @@ static void send_shallow(struct commit_list *resu=
lt)
 	}
 }
=20
-static void deepen(int depth, const struct object_array *shallows)
+static void send_unshallow(const struct object_array *shallows)
 {
-	struct commit_list *result =3D NULL;
 	int i;
-	if (depth =3D=3D INFINITE_DEPTH && !is_repository_shallow())
-		for (i =3D 0; i < shallows->nr; i++) {
-			struct object *object =3D shallows->objects[i].item;
-			object->flags |=3D NOT_SHALLOW;
-		}
-	else
-		result =3D
-			get_shallow_commits(&want_obj, depth,
-					    SHALLOW, NOT_SHALLOW);
-	send_shallow(result);
-	free_commit_list(result);
+
 	for (i =3D 0; i < shallows->nr; i++) {
 		struct object *object =3D shallows->objects[i].item;
 		if (object->flags & NOT_SHALLOW) {
@@ -589,6 +578,24 @@ static void deepen(int depth, const struct object_=
array *shallows)
 		/* make sure commit traversal conforms to client */
 		register_shallow(object->oid.hash);
 	}
+}
+
+static void deepen(int depth, const struct object_array *shallows)
+{
+	struct commit_list *result =3D NULL;
+	int i;
+	if (depth =3D=3D INFINITE_DEPTH && !is_repository_shallow())
+		for (i =3D 0; i < shallows->nr; i++) {
+			struct object *object =3D shallows->objects[i].item;
+			object->flags |=3D NOT_SHALLOW;
+		}
+	else
+		result =3D
+			get_shallow_commits(&want_obj, depth,
+					    SHALLOW, NOT_SHALLOW);
+	send_shallow(result);
+	free_commit_list(result);
+	send_unshallow(shallows);
 	packet_flush(1);
 }
=20
--=20
2.3.0.rc1.137.g477eb31
