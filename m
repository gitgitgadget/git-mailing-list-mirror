From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2.1 4/6] index-pack: use streaming interface for collision test on large blobs
Date: Thu, 24 May 2012 20:55:44 +0700
Message-ID: <1337867744-24704-1-git-send-email-pclouds@gmail.com>
References: <1337782191-10091-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 24 15:59:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXYZy-0004Yv-FQ
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 15:59:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754106Ab2EXN7q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 May 2012 09:59:46 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:52945 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445Ab2EXN7p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 09:59:45 -0400
Received: by dady13 with SMTP id y13so11353656dad.19
        for <git@vger.kernel.org>; Thu, 24 May 2012 06:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=gM246X7ZGsQCSFGiij0RTBacdyA+lWJB1bv7Afm4leQ=;
        b=yX9Bp861kwWDgS+I6pVmjtRJTZSKlcl6Eva3EFcxSzChkALLOdd0Pj47i7MiQUNEzo
         6zCERfQY5rcwVAJ4bCv0SxLmLnXQzskBnw8HbDTOMr9epLVmIUAYgPo43MhxPMXJ6Pqi
         m2gAoBQh45ncrpp0etvsAjRlO73oQNSVYfrdvQ38SRGgHF2CkUE6/yHN/jBC/js/BZqd
         bu8rowxhMogzHiezatClyJZ7K8ciJlZmy0drbUGXEPFYW8Nz+KYgAp/7As9s/lZn6/DY
         /MzOFMvOrq3YSAOiVMuSvQYSWqPtnJROg0DnR9JVdGVdvFGFBbny+aZJs2kFOd9QVDx6
         WyXg==
Received: by 10.68.222.197 with SMTP id qo5mr21229613pbc.72.1337867984518;
        Thu, 24 May 2012 06:59:44 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.39.86])
        by mx.google.com with ESMTPS id ub8sm5557314pbc.44.2012.05.24.06.59.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 May 2012 06:59:43 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 24 May 2012 20:55:45 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1337782191-10091-4-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198374>

When putting whole objects in core is unavoidable, try match object
type and size first before actually inflating.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 The bypassing has_sha1_object() and doing sha1_object_info() directly =
mainly to
 help avoid unnecessary collision tesst when user run this command on
 an in-repo pack. But I realized there's no sure way to check if the
 given pack (especiall with --stdin) is in repo. So I'll drop 5/6 and
 6/6. People just have to set GIT_DIR=3D/nowhere.

 builtin/index-pack.c   | 82 ++++++++++++++++++++++++++++++++++++++++++=
+++++---
 t/t5300-pack-object.sh |  5 +++
 2 files changed, 82 insertions(+), 5 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 9129299..8b5c1eb 100644
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
@@ -621,31 +622,102 @@ static void find_delta_children(const union delt=
a_base *base,
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
+	int collision_test_needed;
=20
 	assert(data || obj_entry);
=20
 	read_lock();
-	if (has_sha1_file(sha1)) {
+	collision_test_needed =3D has_sha1_file(sha1);
+	read_unlock();
+
+	if (collision_test_needed && !data) {
+		read_lock();
+		if (!check_collison(obj_entry))
+			collision_test_needed =3D 0;
+		read_unlock();
+	}
+	if (collision_test_needed) {
 		void *has_data;
 		enum object_type has_type;
 		unsigned long has_size;
-		if (!data)
-			data =3D new_data =3D get_data_from_pack(obj_entry);
+		read_lock();
+		has_type =3D sha1_object_info(sha1, &has_size);
+		if (has_type !=3D type || has_size !=3D size)
+			die(_("SHA1 COLLISION FOUND WITH %s !"), sha1_to_hex(sha1));
 		has_data =3D read_sha1_file(sha1, &has_type, &has_size);
 		read_unlock();
+		if (!data)
+			data =3D new_data =3D get_data_from_pack(obj_entry);
 		if (!has_data)
 			die(_("cannot read existing object %s"), sha1_to_hex(sha1));
 		if (size !=3D has_size || type !=3D has_type ||
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
