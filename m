From: tboegi@web.de
Subject: [PATCH v6 05/10] read-cache: factor out get_sha1_from_index() helper
Date: Fri, 22 Apr 2016 16:53:50 +0200
Message-ID: <1461336830-5185-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 16:50:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atcPC-0003Or-Ja
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 16:50:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754233AbcDVOtp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Apr 2016 10:49:45 -0400
Received: from mout.web.de ([212.227.17.11]:63628 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754150AbcDVOtm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 10:49:42 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0MYO45-1bFuWT1C5J-00VCmp; Fri, 22 Apr 2016 16:49:40
 +0200
X-Mailer: git-send-email 2.8.0.rc2.2.g1a4d45a.dirty
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:OzAi08qIwC0xCwLcmkBdnw4ao/mtlHxWzppIdz5CRqGA4Tn38a8
 +mrwuGYTYC8dcw1pb6GmW2EWIv863q4MG965+YMGca6OcKxb6CLTLbt6Yzdd32pYYlMK/9a
 IYMd2B5GMaXBo1K9QfmN0guUk7UQ9ozo/SUM0Rt/Ekaz3M3Fla0/wfleL4SaCR+i02EzXzG
 K3ZNTZslCm8/QrIlJdqyQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NJQiKUMfwP4=:Fkf5+hklYARdp4n/+4AOxn
 6kDnZtw176Ka9NmZPD2swyBUOrpdMi4dd4d38BnmGOaVZbxDIVgdZynbFnVSqKI7OmS0B7RU6
 8B5OascjJyoTu9JsKWCUEkSm3Hx5VXqyYX5fkGinYqKZSvit1SlvQRD+kEryPTvd8O8Kzx7xd
 RW/UWFd9Iy12gNigtmB90x5BLtK4yauLCpoxwRTpzvLhYrqdgkOQ0dXeENY4340Srwvm6fu/h
 2fwajJHIcHXUNXpsu1VQyPHyz2/0RyvOhY607bjrVqBWGVo8z8GgG0kUUUm1svA0qNreK0On7
 J2lvNld9TBRnFofQqOHaXNpw5N34LKlg0wEPjr7gFy79V245wSuUTNSj4j5PFTPnoPMqyN8as
 poJ1SFDINkN5PJ4NKL3BUkjMyjpyzJuoL0HUtLa4RxiXJkR4fwjXFd7emM3Ai0ny/vfoJGuTn
 JyqU16Ivm8cm0/bt0CkvshTm0TRv5e9kr/V9by+xOBZJbGogPQkMMmvxXGSHt3CybGEwfJKOJ
 Jkuuo8WxHg4jP3aKKluKJO4laqv8gRiY0y8Prjndgsh4bGylIO9V8pl2kK0izy0J5N6/wp7s1
 l2hn++Van3yiZLBD4+Jo5SXjyjalgiAugsDcqcK6E5loLBHYQ8uxJ4hIkdqMVeNl6MLxa5FRJ
 OpIMXdTMAQwNTfvv8ZHKSEenk82x/6g3jN6/XDUmIjwwqFU8G3eu6nYYAQYOcd6P+S5iWO8Gc
 XTWY50HiNqv44hIH5gVEdfHzAiGX53BvMZa/6mobAisy1LR56pP0poYXsxwQZ1j397T6BlDu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292214>

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
index 2711048..867ceb5 100644
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
@@ -1040,6 +1041,8 @@ static inline void *read_sha1_file(const unsigned=
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
2.8.0.rc2.2.g1a4d45a.dirty
