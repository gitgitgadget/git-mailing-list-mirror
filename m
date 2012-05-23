From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 4/6] index-pack: use streaming interface for collision test on large blobs
Date: Wed, 23 May 2012 21:09:49 +0700
Message-ID: <1337782191-10091-4-git-send-email-pclouds@gmail.com>
References: <1337172630-23679-1-git-send-email-pclouds@gmail.com>
 <1337782191-10091-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 23 16:14:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXCKa-0001ky-VM
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 16:14:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524Ab2EWOOZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 May 2012 10:14:25 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:59120 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932221Ab2EWOOW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 10:14:22 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so9808350dad.19
        for <git@vger.kernel.org>; Wed, 23 May 2012 07:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=G7OvJIp337VxL5zM39YJrkMV3hHQiPha44N6arA0UKE=;
        b=MnQJNkuo7I92uCvGPButPqiJ06GJfK4wBr0VIcI1etWhW57V0OLD+M0cDWO3ch/gQ5
         tTKDY60SOdIqe7DLkIkKhZcPDobtzYECCL9QDtYkXRUvxNAejVSm6kDFs0eoKNz9EiWv
         rjp7aRUf14fbbgDmdUcSLH2uw342PMsoSGA7ixRiBsMn5D5q61JNPVopJH39xNZQdlxB
         35mw+tftFa1eQZ3xGVmrT71WBUPMunpTr6cfsxlJzzo6LFSjk8vgGv4jhXxosXPP/KGi
         IUJH2yoyG1aLymUS5oPP2R82iQVlVpKm3DtaOlW3IYWwKNdXU6hcKVyG09OgazeRq0pf
         xgmA==
Received: by 10.68.228.170 with SMTP id sj10mr10626269pbc.106.1337782462206;
        Wed, 23 May 2012 07:14:22 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.52.77])
        by mx.google.com with ESMTPS id ku7sm1982556pbc.31.2012.05.23.07.14.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 May 2012 07:14:21 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 23 May 2012 21:10:22 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1337782191-10091-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198289>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 the use of sha1_object_info() instead of has_sha1_file() is the cause
 of 6/6 as it is called on non-existent objects too.

 builtin/index-pack.c   | 83 ++++++++++++++++++++++++++++++++++++++++++=
+++++---
 t/t5300-pack-object.sh |  5 +++
 2 files changed, 83 insertions(+), 5 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 9129299..05b1d35 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -9,6 +9,7 @@
 #include "progress.h"
 #include "fsck.h"
 #include "exec_cmd.h"
+#include "streaming.h"
 #include "thread-utils.h"
=20
 static const char index_pack_usage[] =3D
@@ -621,21 +622,94 @@ static void find_delta_children(const union delta=
_base *base,
 	*last_index =3D last;
 }
=20
+struct compare_data {
+	struct object_entry *entry;
+	struct git_istream *st;
+	unsigned char *buf;
+	unsigned long buf_size;
+};
+
+static int compare_objects(const unsigned char *buf, unsigned long siz=
e,
+			   void *cb_data)
+{
+	struct compare_data *data =3D cb_data;
+
+	if (data->buf_size < size) {
+		free(data->buf);
+		data->buf =3D xmalloc(size);
+		data->buf_size =3D size;
+	}
+
+	while (size) {
+		ssize_t len =3D read_istream(data->st, data->buf, size);
+		if (len =3D=3D 0)
+			die(_("SHA1 COLLISION FOUND WITH %s !"),
+			    sha1_to_hex(data->entry->idx.sha1));
+		if (len < 0)
+			die(_("unable to read %s"),
+			    sha1_to_hex(data->entry->idx.sha1));
+		if (memcmp(buf, data->buf, len))
+			die(_("SHA1 COLLISION FOUND WITH %s !"),
+			    sha1_to_hex(data->entry->idx.sha1));
+		size -=3D len;
+		buf +=3D len;
+	}
+	return 0;
+}
+
+static int check_collison(struct object_entry *entry)
+{
+	struct compare_data data;
+	enum object_type type;
+	unsigned long size;
+
+	if (entry->size <=3D big_file_threshold || entry->type !=3D OBJ_BLOB)
+		return -1;
+
+	memset(&data, 0, sizeof(data));
+	data.entry =3D entry;
+	data.st =3D open_istream(entry->idx.sha1, &type, &size, NULL);
+	if (!data.st)
+		return -1;
+	if (size !=3D entry->size || type !=3D entry->type)
+		die(_("SHA1 COLLISION FOUND WITH %s !"),
+		    sha1_to_hex(entry->idx.sha1));
+	unpack_data(entry, compare_objects, &data);
+	close_istream(data.st);
+	free(data.buf);
+	return 0;
+}
+
 static void sha1_object(const void *data, struct object_entry *obj_ent=
ry,
 			unsigned long size, enum object_type type,
 			const unsigned char *sha1)
 {
 	void *new_data =3D NULL;
+	int collision_test_needed =3D 1;
+	enum object_type has_type;
+	unsigned long has_size;
=20
 	assert(data || obj_entry);
=20
 	read_lock();
-	if (has_sha1_file(sha1)) {
+	has_type =3D sha1_object_info(sha1, &has_size);
+	read_unlock();
+
+	if (has_type < 0)
+		collision_test_needed =3D 0;
+	if (collision_test_needed && !data) {
+		read_lock();
+		if (!check_collison(obj_entry))
+			collision_test_needed =3D 0;
+		read_unlock();
+	}
+	if (collision_test_needed) {
 		void *has_data;
-		enum object_type has_type;
-		unsigned long has_size;
+		if (has_type !=3D type || has_size !=3D size)
+			die(_("SHA1 COLLISION FOUND WITH %s !"), sha1_to_hex(sha1));
 		if (!data)
 			data =3D new_data =3D get_data_from_pack(obj_entry);
+		read_lock();
 		has_data =3D read_sha1_file(sha1, &has_type, &has_size);
 		read_unlock();
 		if (!has_data)
@@ -644,8 +718,7 @@ static void sha1_object(const void *data, struct ob=
ject_entry *obj_entry,
 		    memcmp(data, has_data, size) !=3D 0)
 			die(_("SHA1 COLLISION FOUND WITH %s !"), sha1_to_hex(sha1));
 		free(has_data);
-	} else
-		read_unlock();
+	}
=20
 	if (strict) {
 		read_lock();
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index d9d856b..300ed91 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -418,4 +418,9 @@ test_expect_success \
     'test_must_fail git index-pack -o bad.idx test-3.pack 2>msg &&
      grep "SHA1 COLLISION FOUND" msg'
=20
+test_expect_success \
+    'make sure index-pack detects the SHA1 collision (large blobs)' \
+    'test_must_fail git -c core.bigfilethreshold=3D1 index-pack -o bad=
=2Eidx test-3.pack 2>msg &&
+     grep "SHA1 COLLISION FOUND" msg'
+
 test_done
--=20
1.7.10.2.549.g9354186
