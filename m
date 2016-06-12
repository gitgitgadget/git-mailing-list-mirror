From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 06/27] upload-pack: move "unshallow" sending code out of deepen()
Date: Sun, 12 Jun 2016 17:53:48 +0700
Message-ID: <20160612105409.22156-7-pclouds@gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
 <20160612105409.22156-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 12 12:55:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bC336-0003Ct-VE
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jun 2016 12:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752965AbcFLKzS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jun 2016 06:55:18 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36330 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbcFLKzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2016 06:55:16 -0400
Received: by mail-pf0-f194.google.com with SMTP id 62so8489299pfd.3
        for <git@vger.kernel.org>; Sun, 12 Jun 2016 03:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=idleMyLE6/9WJhiGywEQkXGjX2vspwJlvKs3USQbNMg=;
        b=W9dmvwQWH9q9PpQ1EQQcGmTiMWO9sH/GbfzGoUN2oE/VD6E8lsfGwoHOOB/LXRhzDk
         mjIHLBBqxDnDUuNPS4pjNHrcsMA65W1qncm0HXII3Cnm/JXdcCUWkPfDKCgcijPL9dix
         VZ/G5TLpI2dg0xFobR1Db/YsT+NSIieRsGh8DEoTJm3YWHI0VpEvS8XgHnOgNc0vuOM+
         ttfEoxlJBbgE8B/f7Q8mK3AdUI8k7++OvaBcUldrJh8pZnCUf+aQOJkvS3Cn9NMBjaYR
         Fo7J0KvYEf6aGzpFbdqfNwHa+36ouHG64SbzsMegSwjpT3bJTBjvbIfEo9R6MlhaZUvR
         Kddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=idleMyLE6/9WJhiGywEQkXGjX2vspwJlvKs3USQbNMg=;
        b=KqnrsFIIOj2M3AKm6j1f0Gm45fJjtPDK7x0ykuzUINWHdiAZG0IMbhgs3riWF0xZc2
         WTh8fSaPsloO5qQXwN+zaRcJrhguP2zXfyJlnTVHtxFgXJqyV1M3UD28IVyeuNb1V2r9
         HbglMK0CBdcxEbkfzjOy8bqFWO6DR7sub4I3WkMHt8XgP+yB2wHkH7uuN3+26mrU/CMl
         pNDN929mgdta00FiH1WhqeR8IiGoEi/WdMT3VK6/OEPIl17y5D2IXAiJhl7Vu3GTAd5W
         qbPPUoUWFmT0tbTgZaGas1YOaRfbLUkgFhuM1bdzWQUPsYNrODCRw67/NNt46/jk0mvC
         jt5g==
X-Gm-Message-State: ALyK8tKzVvWN03ex+9pVj04lHSJxz6OUpOYybR8fWrkck5GHMVlhddWe4mprfcXLp8JVtw==
X-Received: by 10.98.101.71 with SMTP id z68mr14373746pfb.53.1465728915472;
        Sun, 12 Jun 2016 03:55:15 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id bf4sm29870875pac.4.2016.06.12.03.55.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jun 2016 03:55:14 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 12 Jun 2016 17:55:10 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160612105409.22156-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297113>

Also add some more comments in this code because it takes too long to
understand what it does (to me, who should be familiar enough to
understand this code well!)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 upload-pack.c | 43 ++++++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index ee5d20b..73a8b28 100644
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
@@ -588,6 +584,27 @@ static void deepen(int depth, const struct object_=
array *shallows)
 		/* make sure commit traversal conforms to client */
 		register_shallow(object->oid.hash);
 	}
+}
+
+static void deepen(int depth, const struct object_array *shallows)
+{
+	if (depth =3D=3D INFINITE_DEPTH && !is_repository_shallow()) {
+		int i;
+
+		for (i =3D 0; i < shallows->nr; i++) {
+			struct object *object =3D shallows->objects[i].item;
+			object->flags |=3D NOT_SHALLOW;
+		}
+	} else {
+		struct commit_list *result;
+
+		result =3D get_shallow_commits(&want_obj, depth,
+					     SHALLOW, NOT_SHALLOW);
+		send_shallow(result);
+		free_commit_list(result);
+	}
+
+	send_unshallow(shallows);
 	packet_flush(1);
 }
=20
--=20
2.8.2.524.g6ff3d78
