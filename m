From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/7] parse_object: avoid putting whole blob in core
Date: Wed,  7 Mar 2012 17:54:18 +0700
Message-ID: <1331117661-19378-5-git-send-email-pclouds@gmail.com>
References: <7vty21twqc.fsf@alter.siamese.dyndns.org>
 <1331117661-19378-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 07 11:53:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5EUy-0003DF-Gi
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 11:53:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755460Ab2CGKxX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Mar 2012 05:53:23 -0500
Received: from mail-pz0-f52.google.com ([209.85.210.52]:64743 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755433Ab2CGKxV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 05:53:21 -0500
Received: by mail-pz0-f52.google.com with SMTP id p12so7761663dad.11
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 02:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=IhES7oHikxL/rB9U8pPjm+z7rhE3EtX1zGnlI8NBdYQ=;
        b=ydutHbhRebFmf2Y9ERIkZKSCI8ITkISI8tME+PMeWWsr2rHv4d4c/tlqkha7RCucTG
         LuDZpI6rS9SBtRlkZv0vy3FySRQFZ1NVKaeTtlgrNkdLL7xhQw8G8vhIFPN6OP9dK/dj
         c7SbDd6vVe8EfERYmNE8NNwHxgM5i4TziVTkCvCmNhGSrXoE+YQT74Qw+yvdi4v70/60
         S2flqEZ8j2vMXbk1QJsz+79v+Tu7Vz5d66bO+NiFmSzqTNqpLunPu5CNUkAKYny8jG8/
         sniL8eKW9sf0tHbABpKiKPfP/71PAeFGS/O74iOnwBLCkpYRRERV6InwKMrD1iz4wUU0
         fIQw==
Received: by 10.68.220.196 with SMTP id py4mr2903462pbc.166.1331117600808;
        Wed, 07 Mar 2012 02:53:20 -0800 (PST)
Received: from tre ([115.74.59.10])
        by mx.google.com with ESMTPS id k2sm584481pba.28.2012.03.07.02.53.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 07 Mar 2012 02:53:19 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Wed, 07 Mar 2012 17:54:51 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1331117661-19378-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192439>

Traditionally, all the callers of check_sha1_signature() first
called read_sha1_file() to prepare the whole object data in core,
and called this function.  The function is used to revalidate what
we read from the object database actually matches the object name we
used to ask for the data from the object database.

Update the API to allow callers to pass NULL as the object data, and
have the function read and hash the object data using streaming API
to recompute the object name, without having to hold everything in
core at the same time.  This is most useful in parse_object() that
parses a blob object, because this caller does not have to keep the
actual blob data around in memory after a "struct blob" is returned.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 object.c    |   11 +++++++++++
 sha1_file.c |   42 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 51 insertions(+), 2 deletions(-)

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
index 4f06a0e..ad314f0 100644
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
@@ -1146,10 +1147,47 @@ static const struct packed_git *has_packed_and_=
bad(const unsigned char *sha1)
 	return NULL;
 }
=20
-int check_sha1_signature(const unsigned char *sha1, void *map, unsigne=
d long size, const char *type)
+/*
+ * With an in-core object data in "map", rehash it to make sure the
+ * object name actually matches "sha1" to detect object corruption.
+ * With "map" =3D=3D NULL, try reading the object named with "sha1" us=
ing
+ * the streaming interface and rehash it to do the same.
+ */
+int check_sha1_signature(const unsigned char *sha1, void *map,
+			 unsigned long size, const char *type)
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
