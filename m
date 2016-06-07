From: tboegi@web.de
Subject: [PATCH v2 2/3] read-cache: factor out get_sha1_from_index() helper
Date: Tue,  7 Jun 2016 17:20:50 +0200
Message-ID: <1465312850-4869-1-git-send-email-tboegi@web.de>
References: <xmqq7fev55qk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 17:14:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAIiT-0004ax-Eq
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 17:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161600AbcFGPOa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jun 2016 11:14:30 -0400
Received: from mout.web.de ([212.227.17.11]:64543 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161555AbcFGPOV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 11:14:21 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0MXpZD-1avdiM1CLv-00WjMl; Tue, 07 Jun 2016 17:14:13
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <xmqq7fev55qk.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:4lofT6+dH//6ccGXRuM1buW6SRWWFKtvjGG8fjI2L1gmVgMSc3V
 DkEvJpJzm41PkcfElyO8W6bl46hbRWHxtCrbIay9TrisMMoUtSO0PFlXWGCyDwBW7uoXKyY
 jx74/VJLKEePrGe2BH5oP5db86JUIZl/mTdRFsM+mVAzOMnBJDocEUM/Az4Tqb6jfkCZCLC
 Vi5sskiIBkdNZAsRVzCdw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gn/2gx463fc=:ZpzZBxP/KCJN49qfhrh/aO
 tpKlUG4oq5SSijPO0YPvb6vH2bUD0hqi3yKqC6OxYguklxu4ewHGc1zMB/CnPFRiOaCgSpLN3
 qhPTHrWHNqGk/CXIcNXpecIYwnQMQolkY+Ez4NZ+gXkS+ZR/lKarRzcyFoSKjQeJF2xQjp0Tb
 yFLQhrZRf+aLpWbQVCsf9SzR0q+uacqJc14k/90dfdI9vsTr9oIcOtfnQio/vDB9ZHkja7zC9
 XB2BOXGWgFvVhW17H9lHh2y03l3Pb0NGmpYWzfjVReEyzp1Gu/oR96+0coPxGE/madNPvJvli
 Lt/XtEDGYkp8YkzWBBGHiMxrVdO+B11t9xinO3t9kilsqY2CMpgkxUbJC54BcG+LOEOatOQE2
 ZEsle3SyZkYdnicPb92Dr+MtcvI8GlnkU21PcRK8osv5d4Yuxk1WIM7ODWXG81WzuxpQkEYh/
 9NbnoGaLHXBNkZ1TLuM+XLfhnPUEXc29iE8AVzmVnenFeiDwHL2fQnFIEPmRkwFhi1WUl65a9
 HJGmi2UosXZjDmhl/13MjxtthVVuS5mKzrWHeVCS4tafuWJhu8tgAC8UuosNzrfxktF/yEV9H
 xZwKZ9zmvGfwlgpOzglQRPwZI/CHq1sO+dWQFAMmW0MWxva4crV1QjSm9IpYQ0ibS8ibi4Yhp
 rRJOtsYeP6xfSqjFir2knMT/AWK/6IUOwMe3MUmsUQyaK8jB2VhQ7Bv/drV4dKFF601XhKfw4
 YbIVIzUkynjKz7UebiqAXY390JCUaLQyE0ZRfmWZAakhEbIMeuCmLGwCMjHtYAk9J4FElIHc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296690>

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
index 6049f86..322ee40 100644
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
@@ -1050,6 +1051,8 @@ static inline void *read_sha1_file(const unsigned=
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
