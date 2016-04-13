From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/26] upload-pack: move "shallow" sending code out of deepen()
Date: Wed, 13 Apr 2016 19:54:48 +0700
Message-ID: <1460552110-5554-5-git-send-email-pclouds@gmail.com>
References: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 14:56:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKL7-0004Fa-Ni
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 14:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030254AbcDMMzd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 08:55:33 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35547 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966192AbcDMMza (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 08:55:30 -0400
Received: by mail-pa0-f67.google.com with SMTP id zy2so3920942pac.2
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 05:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d+kmSkygVDLPJW84wEkfh40aoiBEoTX0t1rCkhe25n8=;
        b=NqQyhS7I4QqEF2HTRZ9ZLTdNZTIlF2Dl/gmeUW2EpGVBdG2dQjomWJCcdcKRWdLVl+
         OQbZrr0xvOaomSiVc/JPCpF9hglKtIQwtogq+vK1zEj+we5eHAcJrL52qoHajA+V+9K+
         cSzayemkfzcYnvnl0dOlBSjogLx7Qy4jugS3Kk5LImEdS/jh/HJ1S9c9iVk2GWKZBw3Y
         p7IVZND3Dn+kxtLHbz6GAqeBaePr+KIQBun2SuiPe3l9GSgo5Vq3nWRwET1Pv9P2PwJx
         HrTRl7F73puk748AKUwm3gZxdOoInyzavCA7oNSbvzPnZLiHge1ZdLRz+HKacdjdZpLl
         rWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d+kmSkygVDLPJW84wEkfh40aoiBEoTX0t1rCkhe25n8=;
        b=KVIYykj4/cOS75Q9QZ04pPD7v5EqigLiRwMjtXFv87knDBK528S9g31MktepjaiSgi
         xVF/zmKB8WXEIjYw1KdNvoYtiFVoWHxGG1UR8gSenfigLkLj4NqPza+TD0EPPCq4vugJ
         rdHyFoKgqPhVnupuz5fl+wNL3MV5/YvfNinDeIcTllp3XOJH4XcnGYihudNEwZcDfvKc
         oBn1WMzz6GZjYeQrYSIQxG65MNsyFV0hYOUAbDPavR1TORDStIfAN2PalgcD9hSo7ttB
         d0ToIo5oPcjwwsl9zPA8vAhOxx/l82ClmEjzkG2L1eN4mwIPNQPd+Il6JzRQSfZYb+nk
         A80g==
X-Gm-Message-State: AOPr4FVf+D3INnXEqSk9mvakmgSE75r7fpXtT1o75Ij0C34vM0wD8H4I+qABqVOU5EFj/g==
X-Received: by 10.66.149.36 with SMTP id tx4mr12667782pab.64.1460552130180;
        Wed, 13 Apr 2016 05:55:30 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id r191sm51064124pfr.36.2016.04.13.05.55.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 05:55:28 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 19:55:36 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291403>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 upload-pack.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 97ed620..0eb9a0b 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -538,6 +538,20 @@ error:
 	}
 }
=20
+static void send_shallow(struct commit_list *result)
+{
+	while (result) {
+		struct object *object =3D &result->item->object;
+		if (!(object->flags & (CLIENT_SHALLOW|NOT_SHALLOW))) {
+			packet_write(1, "shallow %s",
+				     oid_to_hex(&object->oid));
+			register_shallow(object->oid.hash);
+			shallow_nr++;
+		}
+		result =3D result->next;
+	}
+}
+
 static void deepen(int depth, const struct object_array *shallows)
 {
 	struct commit_list *result =3D NULL, *backup =3D NULL;
@@ -551,16 +565,7 @@ static void deepen(int depth, const struct object_=
array *shallows)
 		backup =3D result =3D
 			get_shallow_commits(&want_obj, depth,
 					    SHALLOW, NOT_SHALLOW);
-	while (result) {
-		struct object *object =3D &result->item->object;
-		if (!(object->flags & (CLIENT_SHALLOW|NOT_SHALLOW))) {
-			packet_write(1, "shallow %s",
-				     oid_to_hex(&object->oid));
-			register_shallow(object->oid.hash);
-			shallow_nr++;
-		}
-		result =3D result->next;
-	}
+	send_shallow(result);
 	free_commit_list(backup);
 	for (i =3D 0; i < shallows->nr; i++) {
 		struct object *object =3D shallows->objects[i].item;
--=20
2.8.0.rc0.210.gd302cd2
