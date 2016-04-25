From: tboegi@web.de
Subject: [PATCH v7 05/10] read-cache: factor out get_sha1_from_index() helper
Date: Mon, 25 Apr 2016 18:56:34 +0200
Message-ID: <1461603394-30795-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 18:52:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aujkS-0000Rw-Li
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 18:52:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933161AbcDYQwY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Apr 2016 12:52:24 -0400
Received: from mout.web.de ([212.227.17.12]:60304 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933134AbcDYQwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 12:52:16 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0M8i11-1bgwTV15z1-00wEKh; Mon, 25 Apr 2016 18:52:14
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:hqLSSP7gBtio1fLpDQLo1XgT7vK/j/skuHSthbFvWxfZRilSl9a
 kIfMPjW1mqY/U2RACz28/eiFoWgMc2y69z0jQTU/jpH9MeuMOdqH6kEO6+KYH71yVtA6qA9
 Qa/1vrdgm5cLCo5P9VTwyIpWXLQJhOEQXiSYUdHdiOecA8MD9SkHJwHj9nz3AQAnedIgcWZ
 j48Hz2X9Y4TtNUHSvpUXg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hg+kYFf/DnQ=:MVo6517rGrhbd23d6zaNyp
 dwWxSvK/Tq4JweWMeAbiCfdhXsUUn758p3bM5wPKkCKR1+mkRQG6fgM9qlUcyuG92VCleq+PF
 mi/Eea/GbXFEXo9kFZL3UbLgeKt1C6bBwFIkdt9tbG5NxnPi+gHk6c67pLxp8rTsXRkQ0rWKX
 RmINMnmTWH6xtygAjpqWwAkk8P/TmTgDhHYcB5mUr289BAQqtI+FLk7/cnWIHDQtNj2U9ot9S
 VrxnFlJMu8uE03VxLUMRprl4t/z3EM+Z+3PoYiEBDb2jZRe/s/9TNyaGscQdtbiUVFoMlET3B
 6kL95ZDghyJLTZHqLhJXJlSj0svehmzUFbfPmIn4vqb5DbxGWqSO2UYS1IMNHAi79S+K7hKWJ
 ItER2RBS+Dj6ix8W1chFR4BdJsCLgjp1MuD14c3t5AWmpOJFPGkFJGp9tIL5EXjbAd2yCS4DY
 E0TZHTq1pdGCS9nWHRkLls2Zl9ild3INH79KUz8F5HbRy93UGxYbSdYdNz4KBQLvzlegSuriX
 eYnQMArfCp0tVDUuwNtOR2Y6Q2Y0Fr2wwPg7RIktqpF71XaIhwT/i7cQXmgen0bDKs6vWk3eT
 XBSAQG2cKlMVztkhWVyDAdkyJOj7uxEYDQYuv31Dr+iQWP4Ts82ocQSD4J9pHmCAQLXrdjI17
 SqZq26KRsfXpgFeFsDSOiSy7xBAkML5MhsaiZuRuCAdip5XRO1VgDQQW6AwIjZ7mkfaW7Bhe/
 r0TVe/CamroM7FqAlOtHqvzow+suEdbzc1t8LOnnqOKW5Q0foSu3lybOSYir8vYKfdzF9Boj 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292516>

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
index b829410..bd1210a 100644
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
@@ -1008,6 +1009,8 @@ static inline void *read_sha1_file(const unsigned=
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
