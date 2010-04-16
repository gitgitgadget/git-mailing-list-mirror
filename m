From: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20=28Grubba=29?= 
	<grubba@grubba.org>
Subject: [PATCH RFC 1/5] sha1_file: Added index_blob().
Date: Fri, 16 Apr 2010 18:09:58 +0200
Message-ID: <9cc199debaae326856b1fb904663711421ffce64.1271432034.git.grubba@grubba.org>
References: <cover.1271432034.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20 (Grubba) ?= 
	<grubba@grubba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 16 18:43:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2odt-0005I4-4w
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 18:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758565Ab0DPQnT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Apr 2010 12:43:19 -0400
Received: from mail.roxen.com ([212.247.29.220]:59791 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757979Ab0DPQnP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 12:43:15 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id B831B6280FF
	for <git@vger.kernel.org>; Fri, 16 Apr 2010 18:10:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
X-Amavis-Alert: BAD HEADER, Duplicate header field: "In-Reply-To"
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hxsl8FJ0Zufc for <git@vger.kernel.org>;
	Fri, 16 Apr 2010 18:10:05 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id 5F44A628220
	for <git@vger.kernel.org>; Fri, 16 Apr 2010 18:10:05 +0200 (CEST)
Received: from shipon.roxen.com (localhost [127.0.0.1])
	by shipon.roxen.com (8.13.8+Sun/8.13.8) with ESMTP id o3GGA5XM021792;
	Fri, 16 Apr 2010 18:10:05 +0200 (CEST)
Received: (from grubba@localhost)
	by shipon.roxen.com (8.13.8+Sun/8.13.8/Submit) id o3GGA5mJ021791;
	Fri, 16 Apr 2010 18:10:05 +0200 (CEST)
X-Mailer: git-send-email 1.7.0.4.369.g81e89
In-Reply-To: <cover.1271432034.git.grubba@grubba.org>
In-Reply-To: <cover.1271432034.git.grubba@grubba.org>
References: <cover.1271432034.git.grubba@grubba.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145079>

When conversion attributes have changed, it
is useful to be able to easily reconvert an
existing blob.

Signed-off-by: Henrik Grubbstr=C3=B6m <grubba@grubba.org>
---
 cache.h     |    1 +
 sha1_file.c |   19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 5eb0573..1fe2d7d 100644
--- a/cache.h
+++ b/cache.h
@@ -494,6 +494,7 @@ extern int ie_match_stat(const struct index_state *=
, struct cache_entry *, struc
 extern int ie_modified(const struct index_state *, struct cache_entry =
*, struct stat *, unsigned int);
=20
 extern int ce_path_match(const struct cache_entry *ce, const char **pa=
thspec);
+extern int index_blob(unsigned char *dst_sha1, const unsigned char *sr=
c_sha1, int write_object, const char *path);
 extern int index_fd(unsigned char *sha1, int fd, struct stat *st, int =
write_object, enum object_type type, const char *path);
 extern int index_path(unsigned char *sha1, const char *path, struct st=
at *st, int write_object);
 extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *=
st);
diff --git a/sha1_file.c b/sha1_file.c
index ff65328..c162321 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2434,6 +2434,25 @@ static int index_mem(unsigned char *sha1, void *=
buf, size_t size,
=20
 #define SMALL_FILE_SIZE (32*1024)
=20
+int index_blob(unsigned char *dst_sha1, const unsigned char *src_sha1,
+	       int write_object, const char *path)
+{
+	void *buf;
+	unsigned long buflen =3D 0;
+	int ret;
+
+	memcpy(dst_sha1, src_sha1, 20);
+	buf =3D read_object_with_reference(src_sha1, typename(OBJ_BLOB),
+					 &buflen, dst_sha1);
+	if (!buf)
+		return 0;
+
+	ret =3D index_mem(dst_sha1, buf, buflen, write_object, OBJ_BLOB, path=
);
+	free(buf);
+
+	return ret;
+}
+
 int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_o=
bject,
 	     enum object_type type, const char *path)
 {
--=20
1.7.0.4.369.g81e89
