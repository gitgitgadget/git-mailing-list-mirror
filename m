From: tboegi@web.de
Subject: [PATCH v7 1/2] read-cache: factor out get_sha1_from_index() helper
Date: Sat, 21 May 2016 12:01:46 +0200
Message-ID: <1463824906-10190-1-git-send-email-tboegi@web.de>
References: <xmqqk2iphcqe.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 11:56:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b43du-0002Gb-5l
	for gcvg-git-2@plane.gmane.org; Sat, 21 May 2016 11:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbcEUJ4K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2016 05:56:10 -0400
Received: from mout.web.de ([212.227.15.4]:59148 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751666AbcEUJ4J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2016 05:56:09 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0Lbrk4-1bnGHB1tWG-00jIcm; Sat, 21 May 2016 11:56:05
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <xmqqk2iphcqe.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:PL779izP3I5Pd1zaomKkUZWRrbCg1viyxk2twIDmr2bx5XVhIOx
 pocPYQjhCgRxSfvH5C33uUG1bWCF1ePrVNFVwlyFoxaMGM64XS8d8w1uhY2kyl9UibzU5PT
 r/caUWiga65Jwo2A4RaQwLbtwXp8LLa7zliJBgsmQbrOYTuLRYXsmRgVejUDqsWzFU6egK4
 U2gTm86wBmubla3Z9eEFg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:J5j0doXx/9k=:+5s/4lJp7DG+8uZ7AqhUBD
 bQVoxYvl7/k9iTY+8OsGBi4vs6ksp4L45on/AxO1HdXcXepyDJlU49fbpKQjjuwW0MKX3R8TT
 GISTdS2Jt4h7U4bDmbMlaLzr6hvPFukoQ9w2NYQUZ4AkJhbojri21fsAsrfUEzdDhBh+j0H0o
 VDmxVGxmzSYQzuQ8RZupkjGA521DSZRWq/xrnG3JByNxeGuxP802ZEqJjLqMSk2ykcz5vaBSR
 pjOVWMfftmPrJSXLH0z74uiwsFjgWsywtJSEI9cBrDgCexx6Y77ZhZHeDgNqCLxeTG2zzI4k7
 VWMMdIxAwl4BcHQ0SaJPfVrOs4tg6hM3HFG/YHhtzxsdoa74UkEKWHsRvah0XgGkmmJPXWfWS
 PZj+u+svbqsgtzavKneEFnLdnVViPJPhXf4NLyJYSCXIvCDzC7lPpjO6FPOna+Li+iVueK7RL
 2ckRGUWw1joNFlijjdzn7vPrDM6AEdpX0cVj/otPz7Bk/fNU/XMT/MBS2XcxqYom6+FNwMo5L
 rXLAew3g6ybhuuhOU2BbDT+wkdaD+vyi+rwDvmS36BA+NaQLrWDLEs/7Jq3YIJpXFu1trQe4q
 IjSxwkfnmyYawgfszcoMRSOdHz+vpW8cxlFEvt4hT+sApdkSJEJBI9U8YRIOgwBzxwfHlz2wd
 Ouzjn+L57y6xxSoxfabGi+W1f25TENPXrrlM9sGY8ladJzlgdINDkKcN96vzNjCbrVm5r0KIH
 h23yYwETOTN/eGeYn+ZOxI7Ci12hkmZUk6TqzQEr9v+/+cvJEoZ/ZElk4refW7hCbAhIvWP3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295225>

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
