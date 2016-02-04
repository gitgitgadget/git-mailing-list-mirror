From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 07/25] upload-pack: move "unshallow" sending code out of deepen()
Date: Thu,  4 Feb 2016 16:03:43 +0700
Message-ID: <1454576641-29615-8-git-send-email-pclouds@gmail.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 10:05:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRFqc-0005t0-3u
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 10:05:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965428AbcBDJE4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 04:04:56 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34819 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965407AbcBDJEx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 04:04:53 -0500
Received: by mail-pf0-f179.google.com with SMTP id 65so38474424pfd.2
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 01:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=N6T2kBDlEq08495jSTFDGg6R89PWZLJrrvysJDCgT38=;
        b=ik62dC4gSM+BHrpXW4mppfZ7NNE+ziSUj+62kdNAJJHVlc/4+40oRQUcBOnXG0ZyKk
         Z2Uj2+d91ywcdlTHKsZLnbngcsj6ZWMo/3r/Av5rrA20sJNy2YDndzwPXjBOOMqIHqNd
         whiQfmN97btJm6oThPMyHIwkQ0jJJePAer7Z9Ppy4BsIKMOTFzNI+9+XT1e4SsyDp9mv
         civZDa3pCSqo/T05oCOLlT5SRK8CDd3lJWfSyBEjdha46+OtBUKr58xnxEjvlXAQHHjE
         undOZUm0xKr41HRUzmf0G42CkCnDpUOaRLeyf0F3kJCRciwQuQVhAMQvcxmbfUZYGg7d
         Snfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=N6T2kBDlEq08495jSTFDGg6R89PWZLJrrvysJDCgT38=;
        b=lEVQ6O0WElOAAXmSZxYxVaD6W4p0XE0MoW1+1mq/id4quID8dcEx7PI/GVR94IPbcl
         t2YfW2E518CmOMDoh7NidxIoJt5r2PbKTRU/XjnmoLtVSUIwi/hSsvNLV88KKl6vY8R3
         jEhYZ+AaiChYE2mv/OYeqCdWPlyJ3zTF4iMSmnOU2OgAyyPQlZbAUdtncbGcvYlSDBIX
         fpaHEL5QXNIpZW5LemvOLdjUhLHaaZxhkEkCDCAnjLXHzz56HvfVlssTm2/cwzWNV04m
         QHNqGMruIfAmJL3GvcIukCHYGvwoQUmRmeEe9A80m9Yynvk4vS36xBxvDoM9gb8JnrlW
         tcQw==
X-Gm-Message-State: AG10YORAnx3jMKI/JVuBXEb2ezZPEg/DorHgzifWbJeOXaUrCqKBs9/KPPYQ6MWA8jbzOA==
X-Received: by 10.98.89.78 with SMTP id n75mr9225841pfb.120.1454576692700;
        Thu, 04 Feb 2016 01:04:52 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id b28sm15410881pfd.24.2016.02.04.01.04.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2016 01:04:51 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 04 Feb 2016 16:05:05 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285421>

Also add some more comments in this code because it takes too long to
understand what it does (to me, who should be familiar enough to
understand this code well!)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
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
2.7.0.377.g4cd97dd
