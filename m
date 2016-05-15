From: tboegi@web.de
Subject: [PATCH v1 2/3] read-cache: factor out get_sha1_from_index() helper
Date: Sun, 15 May 2016 08:38:17 +0200
Message-ID: <1463294297-20215-1-git-send-email-tboegi@web.de>
References: <20160513134953.GE2345@dinwoodie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 08:33:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1pbu-0006Ld-Eh
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 08:33:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608AbcEOGdB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 May 2016 02:33:01 -0400
Received: from mout.web.de ([212.227.17.12]:65319 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752383AbcEOGdA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 02:33:00 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0Lx7Ab-1bdikY2zjl-016fY8; Sun, 15 May 2016 08:32:55
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <20160513134953.GE2345@dinwoodie.org>
X-Provags-ID: V03:K0:vNT8IQZNzGKYBM9jb48sK3DI0U3N1NoUSQfUphf62TL8k2T5Ck4
 fzm70KmkwqrJHDmpxCVhrGmIPConxBl7ga0HzUgTSeW2nCfkoO4w9YUtI8ozFFJ+2jDKN3O
 obUCO+sraXW849n1fK84+D8kSC3+FPD4dIjh4txGjBW84rndkSmaN2nFdbSZVPQp8mWtsdH
 JvUCnEdhdSCYtFyF1jkNQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mX9JDeK+gbM=:kPwHhYm8tnHdSl7xnOCZhj
 3Y+jVm9oZIMPWiEAMsIhjsqjqzPhC8DO77rIU7BlUBiyE3AXITATGhul0qB2uw22mdP46rpko
 kmwS1lp9k/6wyTL2WyqC9JuAqTHTM0N/fVsXqHGniMVBj6wf/Xk7UORpO+6nTWrl/uBqAQDdc
 ZWFSFu0zYrkBNlMCG/oz3l0phnBH5f8geQVOdjTbk0CRpc8+cMuPa8uJ8wm6D73/1VT0mEpG6
 U6X6fTl+6bMbhasPfLxqHRIkRH4lxmeglZ1TQ3ls0iS/dLfYX/PotloeA9iNdY5LC8g7IkOFt
 wY0WrUisAzMktC4cVsYWIv/ZncrIybyUhZwhjpaKOEYnusBRNBG2oef20AdVPlmCOGFJpTc1l
 4BZqDcl+B96gUPRAJQf0y4ox2KaBmAZSqiCs8Ff7D7elxvWSdPmg3wjMqN2/miSoV9yNgg2N2
 /ggMBrZxE2BufiJCRAPnPuNkzFLk56tiTcS4yc/Yu6WpTEtrCoVeut9nvbwmj02tzXtVCOZq3
 VUEgbVcbBEb3GbUK2LcpQRqvIL2D3k9pU8iNQ9AgQx8wFthvk0FmDuBYyf/RukZ7ZK8EQNJwd
 2GXPcYx7Rjg4oUZlVr/nUX9IAEXX0SZfNLUvBkp20EAUUm7tp8ZGnfy24nIcMzbsLvJHcpGF6
 CJZ71vDGJBGDK+f+bSyQy4Shr7AqhsWEvL9dGV7QJd4pwRE1TIpJrROamYuIKrTKC07Iouc4N
 CPCKnx1NCunGAA2v9iVZ2bOzIibsbAYZGgyMcotR1OZMpRUbH2N/m4VsaVTK4tMuQ2i+lhka 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294638>

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
