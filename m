From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 04/10] parse_object: special code path for blobs to avoid putting whole object in memory
Date: Sun,  4 Mar 2012 19:59:50 +0700
Message-ID: <1330865996-2069-5-git-send-email-pclouds@gmail.com>
References: <1330329315-11407-1-git-send-email-pclouds@gmail.com>
 <1330865996-2069-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 04 14:03:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4B5Z-0003aH-Qv
	for gcvg-git-2@plane.gmane.org; Sun, 04 Mar 2012 14:03:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753899Ab2CDNCq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Mar 2012 08:02:46 -0500
Received: from mail-pz0-f52.google.com ([209.85.210.52]:42943 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864Ab2CDNCj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2012 08:02:39 -0500
Received: by mail-pz0-f52.google.com with SMTP id p12so3847615dad.11
        for <git@vger.kernel.org>; Sun, 04 Mar 2012 05:02:38 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.211.168 as permitted sender) client-ip=10.68.211.168;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.211.168 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.211.168])
        by 10.68.211.168 with SMTP id nd8mr37478958pbc.25.1330866158830 (num_hops = 1);
        Sun, 04 Mar 2012 05:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=mwMI520AT0FL6oUTQB5VFzV58Ev7QP3EiFBmfZhRrkQ=;
        b=h9cg1LWcMa4kQzvrOrOzOGoxmDj4uQNM7R6ZLLgdx3nYk/eRhOGSOnVYURSQvff21d
         iclV70UBLGgkiUDnK0nTY71kWPQLgyjthUJ7k34pYlPgOappNMtIpFDOrj36sl8rVRZX
         HWOxpMl8YZtFDgU3jujGblOL2yqiVxMwXwXjxFA0u3knj51MDBCKaZDLtyf73297nSAN
         PPxFYXLV898EyVAw2f3ixt3yZqCrXTFpRFkVDeffZ8kBQJRRXQbR19DyoaNUmo9D4Dn8
         tw8+LK7d0Kykl31XYuyayXXc0zwIfYTL4ByMxkoLERd8Ekim4m41LQHOXWUNrxCniqaq
         t50Q==
Received: by 10.68.211.168 with SMTP id nd8mr32003305pbc.25.1330866158673;
        Sun, 04 Mar 2012 05:02:38 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.34.94])
        by mx.google.com with ESMTPS id y3sm10432534pbr.46.2012.03.04.05.02.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 04 Mar 2012 05:02:37 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 04 Mar 2012 20:00:31 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1330865996-2069-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192156>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 object.c    |   11 +++++++++++
 sha1_file.c |   33 ++++++++++++++++++++++++++++++++-
 2 files changed, 43 insertions(+), 1 deletions(-)

diff --git a/object.c b/object.c
index 6b06297..0498b18 100644
--- a/object.c
+++ b/object.c
@@ -198,6 +198,17 @@ struct object *parse_object(const unsigned char *s=
ha1)
 	if (obj && obj->parsed)
 		return obj;
=20
+	if ((obj && obj->type =3D=3D OBJ_BLOB) ||
+	    (!obj && has_sha1_file(sha1) &&
+	     sha1_object_info(sha1, NULL) =3D=3D OBJ_BLOB)) {
+		if (check_sha1_signature(repl, NULL, 0, NULL) < 0) {
+			error("sha1 mismatch %s\n", sha1_to_hex(repl));
+			return NULL;
+		}
+		parse_blob_buffer(lookup_blob(sha1), NULL, 0);
+		return lookup_object(sha1);
+	}
+
 	buffer =3D read_sha1_file(sha1, &type, &size);
 	if (buffer) {
 		if (check_sha1_signature(repl, buffer, size, typename(type)) < 0) {
diff --git a/sha1_file.c b/sha1_file.c
index f9f8d5e..a77ef0a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -19,6 +19,7 @@
 #include "pack-revindex.h"
 #include "sha1-lookup.h"
 #include "bulk-checkin.h"
+#include "streaming.h"
=20
 #ifndef O_NOATIME
 #if defined(__linux__) && (defined(__i386__) || defined(__PPC__))
@@ -1149,7 +1150,37 @@ static const struct packed_git *has_packed_and_b=
ad(const unsigned char *sha1)
 int check_sha1_signature(const unsigned char *sha1, void *map, unsigne=
d long size, const char *type)
 {
 	unsigned char real_sha1[20];
-	hash_sha1_file(map, size, type, real_sha1);
+	enum object_type obj_type;
+	struct git_istream *st;
+	git_SHA_CTX c;
+	char hdr[32];
+	int hdrlen;
+
+	if (map) {
+		hash_sha1_file(map, size, type, real_sha1);
+		return hashcmp(sha1, real_sha1) ? -1 : 0;
+	}
+
+	st =3D open_istream(sha1, &obj_type, &size, NULL);
+	if (!st)
+		return -1;
+
+	/* Generate the header */
+	hdrlen =3D sprintf(hdr, "%s %lu", typename(obj_type), size) + 1;
+
+	/* Sha1.. */
+	git_SHA1_Init(&c);
+	git_SHA1_Update(&c, hdr, hdrlen);
+	for (;;) {
+		char buf[1024 * 16];
+		ssize_t readlen =3D read_istream(st, buf, sizeof(buf));
+
+		if (!readlen)
+			break;
+		git_SHA1_Update(&c, buf, readlen);
+	}
+	git_SHA1_Final(real_sha1, &c);
+	close_istream(st);
 	return hashcmp(sha1, real_sha1) ? -1 : 0;
 }
=20
--=20
1.7.8.36.g69ee2
