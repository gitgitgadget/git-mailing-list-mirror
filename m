From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 04/27] upload-pack: move "shallow" sending code out of deepen()
Date: Sun, 12 Jun 2016 17:53:46 +0700
Message-ID: <20160612105409.22156-5-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun Jun 12 12:55:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bC32y-00038J-Jh
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jun 2016 12:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651AbcFLKzI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jun 2016 06:55:08 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35550 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbcFLKzH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2016 06:55:07 -0400
Received: by mail-pf0-f193.google.com with SMTP id t190so8463502pfb.2
        for <git@vger.kernel.org>; Sun, 12 Jun 2016 03:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Emjz3/bOhF6TVIEVPl8IMv3pb2E6JqxlDpNN4isnk8=;
        b=QX4aX2/zGaoBiulCnyzQUIFmLMAJmhU3eFKUn8BiGGHZEJimwxVyPsgnYBif1VS/Ji
         n8N8iAsUq5vIgviIhFg0q75raxrKlZysHeZ6uPGgqOwUtoLlowuwijwwBv82ZVXMQqz7
         CtQ4giaZR+YmLRpF1D8KHXpBQaIteo/J6/ZQ8kqQWf/uw5ku75RMSfjns4VJNMLX8cOI
         vOhpR519Tu9p6r85raMzJSuOBVeaMmGWFzk6erxkjAfd3ZO+ctLzr26KXN/UBy2p1pk8
         J0Czt/DrguwgBP4AccxUYGKOQQLTZN2thxvolj/l5Ek2sNW1g54DDdzQujcQJC1+RgU2
         M+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Emjz3/bOhF6TVIEVPl8IMv3pb2E6JqxlDpNN4isnk8=;
        b=ZEpNppEZzun8fkODz+oELdKmbLRS1rODsT/Y5Exh8aD00NrRfOWFD63Eyep1kj/c/j
         YMTWy0xPOjPIpLfSa9iY8TpLSAAy2LgT2LsxCtsRVDPtWVXxinIT4rnBSeeKevh457/s
         Ops2ZCqZBoLli1F5941/Eb5MHbKb3kU+57JUpvaaCHi0H2Ld1hCGpp3QfeNayXLtRm4p
         s6BFLvUQ8IB+7xeElkjjX0B6OalFRVlCPPK91hI/AXKNCxmR4FgOn8ospiXeQeOiPBeV
         55GJHxch46CQ5wBo4Rx4wHtSc4+PVcBfR+NeClANIb/VMvRI7RcveWzk+1DrdkxDiFLe
         M+Yg==
X-Gm-Message-State: ALyK8tKUFyaDvy8qiOtxgH5cYv/LPlDWEaCT4o4qbBK9ro8V/Rkwy7EMuwL/mhjxhjLq7A==
X-Received: by 10.98.97.71 with SMTP id v68mr14682301pfb.138.1465728906108;
        Sun, 12 Jun 2016 03:55:06 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id v62sm121438pfv.50.2016.06.12.03.55.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jun 2016 03:55:05 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 12 Jun 2016 17:55:01 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160612105409.22156-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297112>

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
