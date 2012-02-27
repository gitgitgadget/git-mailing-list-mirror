From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/11] parse_object: special code path for blobs to avoid putting whole object in memory
Date: Mon, 27 Feb 2012 14:55:08 +0700
Message-ID: <1330329315-11407-5-git-send-email-pclouds@gmail.com>
References: <1330329315-11407-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 08:56:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1vRb-00073I-32
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 08:56:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141Ab2B0H4W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 02:56:22 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56349 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704Ab2B0H4V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 02:56:21 -0500
Received: by mail-pz0-f46.google.com with SMTP id d14so834292dae.19
        for <git@vger.kernel.org>; Sun, 26 Feb 2012 23:56:21 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.222.72 as permitted sender) client-ip=10.68.222.72;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.222.72 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.222.72])
        by 10.68.222.72 with SMTP id qk8mr37401535pbc.1.1330329381734 (num_hops = 1);
        Sun, 26 Feb 2012 23:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=7lebsHxzz6VmqIp4GlvkUqB+tXpTkaIje4HMLOtQAi4=;
        b=UcWZMwHqMzL6Z9CYeX3qIZRnHZ1ewfwmU9lZZDzhRUPrt+5TAGWIklQ+ltuJaJgQHE
         IeyXHQShpiGFaxr+889l458DZBdh6HEW85PPA6q79V7wbQB7RSrnXz5K4hdi3TWZTa03
         cZCOHeDZjTHmqD03TjmefGiSZlhpaoCYKbl3A=
Received: by 10.68.222.72 with SMTP id qk8mr31747109pbc.1.1330329381697;
        Sun, 26 Feb 2012 23:56:21 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id y9sm12054510pbi.3.2012.02.26.23.56.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 26 Feb 2012 23:56:20 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 27 Feb 2012 14:55:57 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1330329315-11407-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191609>


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
1.7.3.1.256.g2539c.dirty
