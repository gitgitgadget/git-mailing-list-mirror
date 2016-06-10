From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/27] upload-pack: move "shallow" sending code out of deepen()
Date: Fri, 10 Jun 2016 19:26:51 +0700
Message-ID: <20160610122714.3341-5-pclouds@gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 14:29:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBLXu-0000Yn-SR
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 14:28:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbcFJM2N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2016 08:28:13 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34072 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932150AbcFJM2L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 08:28:11 -0400
Received: by mail-pf0-f193.google.com with SMTP id 66so3244373pfy.1
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 05:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Emjz3/bOhF6TVIEVPl8IMv3pb2E6JqxlDpNN4isnk8=;
        b=VU5gKNv+EJKusTyZwRo4fw0bgitkFVRbw8ZGMwwA5AT4XGIHCjEB82TflSPS8GAJs9
         kT7vSGF7Fk5X/cLnHfn7eulyyNnP5peSZAevs3IrtOsuL2yeNtw9YeyqEPt6mk2/RrVq
         /l06pTgwA7WyQeqI91yFQ+AtjwPIpy+rFkkvBmXbG6mtk7NOl/z1IeuPsu/u6Qnqz1/x
         FyKJ9hjp0r1h2AoA/ZNB/8zEHxc5OtE8heY3C+D16OCAu+WevPAfNaK5obe4xQyPvE9Y
         mKuSTjGryOLbU9PBkFiEbGhk4rVyDHFdVzmj2kyZu8uOTernTiKuvjklraRwK6WhARE1
         N/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Emjz3/bOhF6TVIEVPl8IMv3pb2E6JqxlDpNN4isnk8=;
        b=IJUOhmg5oi+ROHP6xtK0GqDtljiyIGZTGDV8EeBEB/uO9vYj89JDKvfm2aiCg4YTRU
         CHhrU2LMixRHidPKbQ5fxX5JsSh7rdVQs9izS+azf3BL1/Ee1uh+j+cAOcJtLrJjXRPz
         1c0LLWD+st2NBZZKcbED1I4ogV++HbAXg3ktUmbtYGPqQzf+YtSWYyCsFTA2QmXdhI2s
         gAmytSrTYMOlyuWliJ2IZI+yUxzf+VeRX5mJhC36mLGWF2XNxQd9nIP785MkuVzTNDbo
         DjpB51KRh5aysiqofkWttubrvk20DEbzhAFKsF6ma6PdMIsAyBewJIDdmksPitaSB6YY
         54Jw==
X-Gm-Message-State: ALyK8tLi/itD6hSZsbAO57yILAcdtNOhOdrWFt8ngGzsrrqIOKY+ko3oHVOxcw2LNTZ9tQ==
X-Received: by 10.98.42.73 with SMTP id q70mr2050641pfq.128.1465561690713;
        Fri, 10 Jun 2016 05:28:10 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id s86sm17468167pfi.69.2016.06.10.05.28.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jun 2016 05:28:10 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 10 Jun 2016 19:28:06 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160610122714.3341-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296978>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.8.2.524.g6ff3d78
