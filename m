From: tboegi@web.de
Subject: [PATCH v8 05/10] read-cache: factor out get_sha1_from_index() helper
Date: Fri, 29 Apr 2016 17:02:00 +0200
Message-ID: <1461942120-16101-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 16:57:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw9rX-0006yu-CI
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 16:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753943AbcD2O5k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Apr 2016 10:57:40 -0400
Received: from mout.web.de ([212.227.15.4]:58358 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753910AbcD2O5a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 10:57:30 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0MPJya-1b0XZP3FvU-004Opn; Fri, 29 Apr 2016 16:57:27
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:SRbxJMV9zrbp7wKGPMqXsfKniQvLGDaHn3WCiH3mEvgeu5FjaA1
 w5lJn1SPqVrLszuGAn2Y2H9Y1o7k+9Y3ldyOMw+IDwdu24Puip3Shak927h7MJAhUZwX4BI
 wMgQPp9Aj9Z+QoC0iQJTu89oKUT9t36Qpjo6LsnwLmpUqQV2PNmZ/ZvdSOia46XP0tpiGju
 5NpcpHO7CgDXz9DYhTgEw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JKrButfjo6k=:RIQWYlFFIupxfK9kgj0NBb
 U2brg9lhLby3zlVg9NhTZy/NVcqQS6v5ZjzESLo7rtWEkWLirXWNQMOZ7IMlKHD6J15Ftmym6
 usLzhFFX4A++rLkFkW90iHPegetd5GcjAA+5K3tNu+FS8m87DX97TCYXPrSLlqVC/RBiXrzi4
 eMTGZOUg45THB3lFboMPCAz1ogH1oo0cKvJUH7sMKdVdIiiv8FKwUSPTUiwVjm+OgDKiuBfDq
 cyHsaF/Zww4d1CbQRfMxxST2eocYvB8yNWs0Vx52fAp4sw3iJ0PJ3qeucqlAugE9IfjbwXHqb
 yoZauG/QgiQQJzvLK4MWr0wIRHvN8GK/fdE4KoeCPZl+pKZTddMZyUd1iE48XccHvoGOKR/1d
 amEUB4pcvSL3vDISymJBZ40H17T25FUr81UBbhvbHCBqOzs1EttMKV2/BgoWib9oQiswZkjkw
 O9K1/AxcWwOq6jnhqndaXKcddpO1hRemGJkkLQurLc5UmQoX2Rbfj38LqUc0LASzAoY81Wf4i
 JVLRlbI6rLsVaeXiLLpu8N3mkZvnQaORVGsGOllzKYCcKD8GT41acuXPRtErQeJw0d5byDmPw
 bWyH7QfKMhALAZ6q6jzpOl8jTc3OuVxx2w52nCCXL6VtoJq301I80Nu1jvXjKOh4xKRXu9NKj
 EnTV/trernvz5aIe3zLXHGX4R7w0P9tJXXFVjC1j1ppO3X9y4zqUD9lHthBBB7uZsHvfKcroJ
 uGdwOTmsNT0EimN4Nt60DXfnBHvM9JdJOhEhN8go9UpQMkhd3pfXOHI73JzgMeLL2skPIpD9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293014>

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
2.7.0.992.g0c2c796
