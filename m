From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/26] upload-pack: move "unshallow" sending code out of deepen()
Date: Wed, 13 Apr 2016 19:54:50 +0700
Message-ID: <1460552110-5554-7-git-send-email-pclouds@gmail.com>
References: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 14:55:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKKq-00046X-Aa
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 14:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030585AbcDMMzo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 08:55:44 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36675 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030495AbcDMMzl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 08:55:41 -0400
Received: by mail-pa0-f65.google.com with SMTP id k3so3874634pav.3
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 05:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0X5rlKKneJTWh+gSCqCbyLEKnMlEhSWt5Ql479j/Hx4=;
        b=umMc3MgV8z5l6ZAMx/TlZFdWei/AB/t19T5SbsIkEbvWVGwgsnnSbiL4nKs3H8/ikh
         9/svm3d2TrfAMAwrbi5lCxNo9ZnfklwPFEqM0SzU1PngevfryqRHBqiQJ0J4Ips6rJWx
         g19tPMfJOySrPU2IHTqLSw74JQQem9YufZzk0WIrsHbUA2LWBiXLTv0azvgnP9YHZE5q
         QfnaW2cf4gaTqxlyj+yahSm78ycD1mVH5af7pa+Vt3lonfBNpitG8xzQd6AZ6sxrnme5
         oObjD/uzvQT+G33oiLKgoEjzqlS4zCS79ea3So7Arfkx1JzIXjT0QkyqXQh0HPwjyVR6
         6lDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0X5rlKKneJTWh+gSCqCbyLEKnMlEhSWt5Ql479j/Hx4=;
        b=Zyd8LIi1mq1zNEq6JxCZVFp13JSwzZ1oZ5frg2uKGc5iDCZLEWh+vdkoZuAwDvr8YC
         VqwprdZJbyBGeMJ/xsMJjkq1S8CiLQqSlWk3p5VDRqQLNEHvblo08cEupYlOvov41nc7
         9EOnRTwykznxNn4peM+fOp8mtwWqpAxZP6DgiiLXEJC8PlCxfOuBKIvUH9YZ0+8flMPI
         SG085dRf4OuQnHiJLJIbat3dURdYQ2lryxPZ5fpc5AI6dREVzZsRAhcJiFZ663Jr+Wbl
         3wBu15elmCcqfHiaefHcCLRazckF3hDmC1vAnvrypHvWavwgRxDCJK/WCRT0Hp9rgjJ+
         X7UQ==
X-Gm-Message-State: AOPr4FUqcTdWDKMBwI+Qh5caWWqNddIpsnby68x6A2mwHktPHegl1FYImh7f7kX1i3Q/6w==
X-Received: by 10.66.231.73 with SMTP id te9mr12956468pac.62.1460552140863;
        Wed, 13 Apr 2016 05:55:40 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id q20sm51036472pfi.63.2016.04.13.05.55.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 05:55:39 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 19:55:47 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291399>

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
2.8.0.rc0.210.gd302cd2
