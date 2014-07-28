From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 6/9] index-helper: add --strict
Date: Mon, 28 Jul 2014 19:03:12 +0700
Message-ID: <1406548995-28549-7-git-send-email-pclouds@gmail.com>
References: <1406548995-28549-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 28 14:04:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBjfG-00033O-VF
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 14:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752661AbaG1MEW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jul 2014 08:04:22 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36631 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbaG1MEV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 08:04:21 -0400
Received: by mail-pa0-f49.google.com with SMTP id hz1so10244781pad.8
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 05:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=p9w2HWXlDnX0/+3Sk2YpD8W8bv6EjkiFOgAUo1zLhpI=;
        b=RfvE0Pe/ZhUtuk8xU2jw/ok+C1FPh+ImNAJc6OtuhjyUr2Gi8vLT9GwKkVp7zMgug/
         rlVnhB9wqntKtIyItA7H3qKQf1zcQFacOgoIqg0MZYmC2PEqnOxf4RnnFPlFyN+z3S3H
         /Utm58wve+sXxHSjeFkAszYzcn+ZnNDS9kbi05Ga2D7voSXD0L9BewctEXi+evyXrkji
         /Jvn/pWNDml0GuYndQO67wilMu0MtCMUJ6UICyPZWINZvStpOkU8jt7QLIZBL9UTcTd9
         VvGGGwfbwCOFz+7vKvpj5O1nvPl4TVIqA1pIIa5OpxgsHqbz0nkdr6erFStbi5K+amSC
         ScpQ==
X-Received: by 10.66.218.137 with SMTP id pg9mr13707391pac.28.1406549061538;
        Mon, 28 Jul 2014 05:04:21 -0700 (PDT)
Received: from lanh ([115.73.211.176])
        by mx.google.com with ESMTPSA id vk5sm17471270pbc.44.2014.07.28.05.04.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jul 2014 05:04:21 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Jul 2014 19:04:24 +0700
X-Mailer: git-send-email 2.1.0.rc0.66.gb9187ad
In-Reply-To: <1406548995-28549-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254320>

There's are "holes" in the index-helper approach because the shared
memory is not verified again by git. If $USER is compromised, shared
memory could be modified. But then they can already modify
$GIT_DIR/index. A more realistic risk is some bugs in index-helper
produce corrupt shared memory. --strict is added to avoid that

Strictly speaking there's still a very small gap where corrupt shared
memory could still be read by git: after we write the trailing SHA-1 in
the shared memory (thus signaling "this shm is ready") and before
verify_shm() detects an error.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-index-helper.txt |  9 ++++++++
 cache.h                            |  1 +
 index-helper.c                     | 47 ++++++++++++++++++++++++++++++=
++++++++
 read-cache.c                       |  9 +++++---
 4 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-index-helper.txt b/Documentation/git-ind=
ex-helper.txt
index da41c4d..406856d 100644
--- a/Documentation/git-index-helper.txt
+++ b/Documentation/git-index-helper.txt
@@ -22,6 +22,15 @@ OPTIONS
 	Exit if the cached index is not accessed for `<n>`
 	minutes. Specify 0 to wait forever. Default is 10.
=20
+--strict::
+--no-strict::
+	Strict mode makes index-helper verify the shared memory after
+	it's created. If the result does not match what's read from
+	$GIT_DIR/index, the shared memory is destroyed. This makes
+	index-helper take more than double the amount of time required
+	for reading an index, but because it will happen in the
+	background, it's not noticable. `--strict` is enabled by default.
+
 NOTES
 -----
 On UNIX-like systems, $GIT_DIR/index-helper.pid contains the process
diff --git a/cache.h b/cache.h
index 4266771..0f515e5 100644
--- a/cache.h
+++ b/cache.h
@@ -307,6 +307,7 @@ struct index_state {
 	struct cache_time timestamp;
 	unsigned name_hash_initialized : 1,
 		 keep_mmap : 1,
+		 always_verify_trailing_sha1 : 1,
 		 initialized : 1;
 	struct hashmap name_hash;
 	struct hashmap dir_hash;
diff --git a/index-helper.c b/index-helper.c
index 8fa0af9..c82d307 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -13,6 +13,7 @@ struct index_shm {
=20
 static struct index_shm shm_index;
 static struct index_shm shm_base_index;
+static int to_verify =3D 1;
=20
 static void free_index_shm(struct index_shm *is)
 {
@@ -68,6 +69,48 @@ static void share_index(struct index_state *istate, =
struct index_shm *is)
 	hashcpy((unsigned char *)new_mmap + istate->mmap_size - 20, is->sha1)=
;
 }
=20
+static int verify_shm(void)
+{
+	int i;
+	struct index_state istate;
+	memset(&istate, 0, sizeof(istate));
+	istate.always_verify_trailing_sha1 =3D 1;
+	i =3D read_index(&istate);
+	if (i !=3D the_index.cache_nr)
+		goto done;
+	for (; i < the_index.cache_nr; i++) {
+		struct cache_entry *base, *ce;
+		/* namelen is checked separately */
+		const unsigned int ondisk_flags =3D
+			CE_STAGEMASK | CE_VALID | CE_EXTENDED_FLAGS;
+		unsigned int ce_flags, base_flags, ret;
+		base =3D the_index.cache[i];
+		ce =3D istate.cache[i];
+		if (ce->ce_namelen !=3D base->ce_namelen ||
+		    strcmp(ce->name, base->name)) {
+			warning("mismatch at entry %d", i);
+			break;
+		}
+		ce_flags =3D ce->ce_flags;
+		base_flags =3D base->ce_flags;
+		/* only on-disk flags matter */
+		ce->ce_flags   &=3D ondisk_flags;
+		base->ce_flags &=3D ondisk_flags;
+		ret =3D memcmp(&ce->ce_stat_data, &base->ce_stat_data,
+			     offsetof(struct cache_entry, name) -
+			     offsetof(struct cache_entry, ce_stat_data));
+		ce->ce_flags =3D ce_flags;
+		base->ce_flags =3D base_flags;
+		if (ret) {
+			warning("mismatch at entry %d", i);
+			break;
+		}
+	}
+done:
+	discard_index(&istate);
+	return i =3D=3D the_index.cache_nr;
+}
+
 static void refresh(int sig)
 {
 	the_index.keep_mmap =3D 1;
@@ -76,6 +119,8 @@ static void refresh(int sig)
 	if (the_index.split_index && the_index.split_index->base)
 		share_index(the_index.split_index->base, &shm_base_index);
 	share_index(&the_index, &shm_index);
+	if (to_verify && !verify_shm())
+		cleanup_shm();
 	discard_index(&the_index);
 }
=20
@@ -123,6 +168,8 @@ int main(int argc, char **argv)
 	struct option options[] =3D {
 		OPT_INTEGER(0, "exit-after", &idle_in_minutes,
 			    N_("exit if not used after some minutes")),
+		OPT_BOOL(0, "strict", &to_verify,
+			 "verify shared memory after creating"),
 		OPT_END()
 	};
=20
diff --git a/read-cache.c b/read-cache.c
index 4bd2abe..d6eb17f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1568,9 +1568,12 @@ int do_read_index(struct index_state *istate, co=
nst char *path, int must_exist)
=20
 	istate->mmap =3D mmap;
 	istate->mmap_size =3D mmap_size;
-	if (try_shm(istate) &&
-	    verify_hdr(istate->mmap, istate->mmap_size) < 0)
-		goto unmap;
+	if (try_shm(istate)) {
+		if (verify_hdr(istate->mmap, istate->mmap_size) < 0)
+			goto unmap;
+	} else if (istate->always_verify_trailing_sha1 &&
+		   verify_hdr(istate->mmap, istate->mmap_size) < 0)
+			goto unmap;
 	hdr =3D mmap =3D istate->mmap;
 	mmap_size =3D istate->mmap_size;
 	if (!istate->keep_mmap)
--=20
2.1.0.rc0.66.gb9187ad
