From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/27] upload-pack: move "unshallow" sending code out of deepen()
Date: Fri, 10 Jun 2016 19:26:53 +0700
Message-ID: <20160610122714.3341-7-pclouds@gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 14:29:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBLY2-0000ef-Sc
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 14:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554AbcFJM2W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2016 08:28:22 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34272 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932150AbcFJM2V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 08:28:21 -0400
Received: by mail-pa0-f67.google.com with SMTP id ug1so5025803pab.1
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 05:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NtT2LNFpbJaQTal/v2ennl2Z4jJy3Wfp5Yo6EDSVROY=;
        b=OiafA2VuznuYedcApIwTLrsVTrN3skqRu2KBwUZWPFs3yjqsYyYx8gAT/MQIyGWYf9
         R7w4+sKMrzkg7697U4mVP052JxTSc49PJeI0j/Tu7kYprb1Qo7xyfn0R57OUvAACG3El
         DCcW4sxkanPRFkXv261nd7L81V+aDG52+Z/oQzcof/0fIH0JjfByZyJJ7TZL//fcTY+r
         BDxcp8dirhhsst1SBzOyaLRmQZMzK9gq8rLubICmLKVM/w+YjiyClrwh77cBX7BR0dK4
         93CHQfcLEj+SVz/xB48si27bRBP6EyvzGQiZYyazxiEZ0loEKC8I9/eXcATRPsLZGpFh
         2HUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NtT2LNFpbJaQTal/v2ennl2Z4jJy3Wfp5Yo6EDSVROY=;
        b=AlytzXfxOJU0Oe2h/n2vwkbzQMGhtXvH+xLTd4iA/U99YF692zu3LyXKpjabL9MIei
         TqwplOXimgJYxALgjHB98ira1a815DZ9XFzLAWjRjrX62ZtDRc3vkdWsUFJPHVnNaIG3
         QzL9ZHNIzDrxvQ399df+iPvJQLsNQvBEaQ2Gs2EO7rcJ2WkrdEdzvgZ+eBpbNkcVc5dy
         lXlNGcjPaZr7IvmbLxnFachhZHl7rXrG8IJtzEqlTo6FiKZoXLjjS/OvTzxoC0QIB7ms
         xXUWJhNYM8iwOEYS9LVSQ8hp75ROXyD6OkJcgNGxk0TVqldPGSLwrGitrapauzhtY1+i
         POnA==
X-Gm-Message-State: ALyK8tJY2OSQEgeJnAtVTQD4REXkQhOK4bvLyiUEhiZ/hn3EApTKqqPDpbFUyBUD5NF74A==
X-Received: by 10.66.237.175 with SMTP id vd15mr2012403pac.139.1465561700558;
        Fri, 10 Jun 2016 05:28:20 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id hk7sm17508908pad.25.2016.06.10.05.28.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jun 2016 05:28:19 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 10 Jun 2016 19:28:15 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160610122714.3341-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296980>

Also add some more comments in this code because it takes too long to
understand what it does (to me, who should be familiar enough to
understand this code well!)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 upload-pack.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index ee5d20b..bfb7985 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -552,20 +552,10 @@ static void send_shallow(struct commit_list *resu=
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
-		result =3D get_shallow_commits(&want_obj, depth,
-					     SHALLOW, NOT_SHALLOW);
-	send_shallow(result);
-	free_commit_list(result);
+
 	for (i =3D 0; i < shallows->nr; i++) {
 		struct object *object =3D shallows->objects[i].item;
 		if (object->flags & NOT_SHALLOW) {
@@ -573,7 +563,13 @@ static void deepen(int depth, const struct object_=
array *shallows)
 			packet_write(1, "unshallow %s",
 				     oid_to_hex(&object->oid));
 			object->flags &=3D ~CLIENT_SHALLOW;
-			/* make sure the real parents are parsed */
+			/*
+			 * We want to _register_ "object" as shallow, but we
+			 * also need to traverse object's parents to deepen a
+			 * shallow clone. Unregister it for now so we can
+			 * parse and add the parents to the want list, then
+			 * re-register it.
+			 */
 			unregister_shallow(object->oid.hash);
 			object->parsed =3D 0;
 			parse_commit_or_die((struct commit *)object);
@@ -588,6 +584,23 @@ static void deepen(int depth, const struct object_=
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
+		result =3D get_shallow_commits(&want_obj, depth,
+					     SHALLOW, NOT_SHALLOW);
+	send_shallow(result);
+	free_commit_list(result);
+	send_unshallow(shallows);
 	packet_flush(1);
 }
=20
--=20
2.8.2.524.g6ff3d78
