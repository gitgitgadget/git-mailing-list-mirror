From: tboegi@web.de
Subject: [PATCH v6 1/2] read-cache: factor out get_sha1_from_index() helper
Date: Fri, 20 May 2016 19:12:24 +0200
Message-ID: <1463764344-21643-1-git-send-email-tboegi@web.de>
References: <xmqqk2iphcqe.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 19:16:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3ntZ-0003FJ-6y
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 19:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756145AbcETRHP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 May 2016 13:07:15 -0400
Received: from mout.web.de ([212.227.17.11]:60086 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755260AbcETRHN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 13:07:13 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MV4TZ-1b4cJ31kJp-00YNNg; Fri, 20 May 2016 19:07:04
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <xmqqk2iphcqe.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:78KRLa/sht1XPjHl94rpsFLMXeTULefwio959nt08GJzRXrQFUL
 MNApfMkoTafoXhheWVSC0IWZI6sUScOrSXNP4XfcE27mwViXvbeonydz3RWtehZd87lmQ5B
 /lMDurtPbE0O/O81u5gqZipYPxwnjoxEL4BYiKsHD/Y8tPkChkV6Nm6hJXw8B7hfQiyCMd2
 HmbqWkVUUXE+I/IlzFK+A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7mN6Jv7Tlys=:J33/QMjJ6XMGJTcXOLxi6H
 aS1Dc1ZWyn5TSOF9kvdFcM6+ftK8iVTW4IZV26MQhe/Yl+ZeRPD+/V059mRkVxtJWhRvNQOXk
 vPRGEehe4B1CzWIDyS6xPGXNKa4Djqmkb2GKBaRY2e/+Th5f2hztGUI3slnUlKqTUUQw+HlpU
 908Shiql0o+6leFWkp5wDR93iYiB6HiubE+dRaOus5bepg7ekaKEBkU90YNdseyNdhd0/QSjr
 zPJlggAq5lSF5s5ovsvkwuHhpK47HfqGqC73kXRJFg1XKkHRRy4KFwo3XeQqhoZaiKXT34RTh
 c7ZeEx9h+WdlGcRNwqaYrCJo5RUQNj1P1OAt2l4F51ZpCZHJkQkKHCtsFpnZiAPRmICExB3hc
 tTJ6YMAlaV/IwgEkmhunY9N4898rFkEgOSYW2lnzDqKCLlaHqCxFUsQ4SC/6VDmMDjU8uo81o
 tVRL3D2+h85930raeX18KLubrCdZAP5IWZjt5TCHGZg26Br7ELE1BsGcq9lgmYEt1nlf+Nul0
 kk7ecsfpM7r0ZX1HRuGUoZSTHp6XW9PdJZ8icBtX5It7QROxObUO++pZv28KIZyCKahucjznD
 lOgaPzCwj52TJMIunOWEJCzn8HdDS522VJ0w92sO3d9wNNT4PHF92wgMB4O5P+2GxGWNbo1m3
 J64e8KjC6U4Xv2TdyyxtkdU8yP7fO3O3xoAqFIYRjXqg468zngAxhWTwLzXcWJqBtipV+12Va
 SHlFLzskVmAhh1xp14tjBNwfDyaHLU1fIIfbFJxEklt492E7rNlP2HyPjPR5mkJol41unnH/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295189>

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
