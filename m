From: tboegi@web.de
Subject: [PATCH v5 1/2] read-cache: factor out get_sha1_from_index() helper
Date: Thu, 19 May 2016 16:21:18 +0200
Message-ID: <1463667678-25969-1-git-send-email-tboegi@web.de>
References: <573A993F.8020205@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 16:16:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3Ok4-0005hb-Gy
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 16:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbcESOPy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 May 2016 10:15:54 -0400
Received: from mout.web.de ([212.227.17.12]:62245 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754608AbcESOPu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 10:15:50 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MgwZQ-1bGXuP2gFM-00M2XO; Thu, 19 May 2016 16:15:41
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <573A993F.8020205@web.de>
X-Provags-ID: V03:K0:iYdWlrP0UG48BQvYAQnzEvYh9r9lh+wgDyLoOPt1a7jdS6olxHL
 a1Hx8BCpwJcetOd46Q5o2UsvUTfddF8PYuVYAH5Qmx6XwTgEQljXh5D1Mr3sV2aaQPSY9zG
 ZMYkMegJvqEY7RsY5n+Isz3h5NWXBJGAVz0lVWGz2+Ym6K841Z29bswDn2Y5VHH7irtYgO1
 0Sqwk3c3WG5A+0+lC5zcg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BYfwiJPSZT4=:vxmfgz3NIR/r6g2liF8mkx
 qzb+LbAS/NoyJB0kFE+8HNkRbWXZU/N6pZiyycsuBhrQLGmni6oAo5K4UbZmdvRrY79MQp0gP
 5NQfkhMhA7OlcCEikw42JuAcCPxfSw80Dq8DIj4/E5z/7LxK4qeinxZw/pf8Pza2YGBVQopvS
 5vMz6MtYzBaxGSnKYCn+ghjyEMgJYBCgePN/5Ii1t2IYOdiSLa6Ngg8TDKKCTZOPBZF+MtRxF
 I0HWhjA4ZFSf8kXKwh55BvPa0KT7xGPVArbLwv9vzqjt8uYxLNczkw3JMYJm7MnmdPWq1NpGe
 f9pyCS0bsdXrkAVtUibJMWqcqkWJ2cD68R4FvjiJPJfE35is4B6gx2ULaOpRycp8MdmZCLLYS
 0jMqjtQK9eSqcu7x0eCwtQQckDOIPncLFi3exBglRc0MGrcJfyMbONqo5MhkHk7x6+gk1aI8w
 0+zjPh0ObmhjcMliar5pz/r2QDQur8jDdRJruQNlOMF6f5Qnb6maho2CIFw7PA0p/sXSJnlHZ
 pqYLD7oKYzrO2ANdpFvZwQZoRs5IBztHoBFwSPZEAfFl+lS8SakGbEbUspttAocQIVCDabZJr
 odUWUZJ1fUAvXxfOQoD1lZZ75TyriHe6Rsg5HdL2hVXijbn++X3qHp46l6XNDBLm4kocUovEi
 LEP9H2nZIV+9/cToK4Sz76DG+BaHDHLCVzpKydnbqm13mD5n7wQocmPRcI3/OylJDINBz7JZX
 SjZ0N6TJrZAP36j6JJSKzChOt3lUTnYy5f+yjJrIcItFTs1RH7obcGX+XmYiltdLD5iJZntT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295062>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

=46actor out the retrieval of the sha1 for a given path in
read_blob_data_from_index() into the function get_sha1_from_index().

This will be used in the next commit, when convert.c can do the
analyze for "text=3Dauto" without slurping the whole blob into memory
at once.

Add a wrapper definition get_sha1_from_cache().

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 cache.h      |  3 +++
 read-cache.c | 29 ++++++++++++++++++-----------
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/cache.h b/cache.h
index 160f8e3..15a2a10 100644
--- a/cache.h
+++ b/cache.h
@@ -379,6 +379,7 @@ extern void free_name_hash(struct index_state *ista=
te);
 #define unmerge_cache_entry_at(at) unmerge_index_entry_at(&the_index, =
at)
 #define unmerge_cache(pathspec) unmerge_index(&the_index, pathspec)
 #define read_blob_data_from_cache(path, sz) read_blob_data_from_index(=
&the_index, (path), (sz))
+#define get_sha1_from_cache(path)  get_sha1_from_index (&the_index, (p=
ath))
 #endif
=20
 enum object_type {
@@ -1038,6 +1039,8 @@ static inline void *read_sha1_file(const unsigned=
 char *sha1, enum object_type *
 	return read_sha1_file_extended(sha1, type, size, LOOKUP_REPLACE_OBJEC=
T);
 }
=20
+const unsigned char *get_sha1_from_index(struct index_state *istate, c=
onst char *path);
+
 /*
  * This internal function is only declared here for the benefit of
  * lookup_replace_object().  Please do not call it directly.
diff --git a/read-cache.c b/read-cache.c
index d9fb78b..a3ef967 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2263,13 +2263,27 @@ int index_name_is_other(const struct index_stat=
e *istate, const char *name,
=20
 void *read_blob_data_from_index(struct index_state *istate, const char=
 *path, unsigned long *size)
 {
-	int pos, len;
+	const unsigned char *sha1;
 	unsigned long sz;
 	enum object_type type;
 	void *data;
=20
-	len =3D strlen(path);
-	pos =3D index_name_pos(istate, path, len);
+	sha1 =3D get_sha1_from_index(istate, path);
+	if (!sha1)
+		return NULL;
+	data =3D read_sha1_file(sha1, &type, &sz);
+	if (!data || type !=3D OBJ_BLOB) {
+		free(data);
+		return NULL;
+	}
+	if (size)
+		*size =3D sz;
+	return data;
+}
+
+const unsigned char *get_sha1_from_index(struct index_state *istate, c=
onst char *path)
+{
+	int pos =3D index_name_pos(istate, path, strlen(path));
 	if (pos < 0) {
 		/*
 		 * We might be in the middle of a merge, in which
@@ -2285,14 +2299,7 @@ void *read_blob_data_from_index(struct index_sta=
te *istate, const char *path, un
 	}
 	if (pos < 0)
 		return NULL;
-	data =3D read_sha1_file(istate->cache[pos]->sha1, &type, &sz);
-	if (!data || type !=3D OBJ_BLOB) {
-		free(data);
-		return NULL;
-	}
-	if (size)
-		*size =3D sz;
-	return data;
+	return (istate->cache[pos]->sha1);
 }
=20
 void stat_validity_clear(struct stat_validity *sv)
--=20
2.0.0.rc1.6318.g0c2c796
