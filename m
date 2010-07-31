From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/16] Hook up replace-object to allow bulk commit replacement
Date: Sat, 31 Jul 2010 23:18:14 +0700
Message-ID: <1280593105-22015-6-git-send-email-pclouds@gmail.com>
References: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 01 04:38:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfORW-0002rL-CO
	for gcvg-git-2@lo.gmane.org; Sun, 01 Aug 2010 04:38:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755010Ab0HACiU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 22:38:20 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:33077 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754975Ab0HACiS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 22:38:18 -0400
Received: by mail-pv0-f174.google.com with SMTP id 7so978167pvc.19
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 19:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=S2INjgyqgEd8qNYoBijtqp35OuLhCWxzTjnHzjwgwkc=;
        b=aXOYaEYi1VHkKln9vuBv5h/YGFxPc+Bs0MZHfbNe/c/OVjkVYmsFDw68WdV4t+1xuC
         AG6ta8GbCuOBI9AA31GDMA7z4kP6P5HJ9/jKVUp+AXExMwt1R4hckj05i2jKsyp9bngE
         N+/nttCOeJfypR8vlN5dACi0yHh+JKwC1/0tY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=i+bRkAxhzGPHWsQ32qcyqj+ZXeO+7mbx8mI5pcvINIUqRPdV3Ufgh6YU61xZBIRHSj
         k21Y1vmRT4W941xccqsEDDDR+VqnePgsbJvayP0eA1j793+fYDQ5YwyoggoyhFCf4aC8
         5mP++/afXvH/Ly3wxste+/vF40AFOLSMYJc2M=
Received: by 10.142.194.2 with SMTP id r2mr1304348wff.279.1280630298688;
        Sat, 31 Jul 2010 19:38:18 -0700 (PDT)
Received: from dektop ([119.12.238.118])
        by mx.google.com with ESMTPS id v38sm5246591wfh.0.2010.07.31.19.38.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 31 Jul 2010 19:38:17 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sat, 31 Jul 2010 23:19:11 +0700
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152352>

$GIT_DIR/subtree contains commit mapping in subtree mode. It's quite
large that putting it in $GIT_DIR/refs/replace may slow git down
significantly. Even with this, there will be a split second delay for
every git command.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile         |    2 +
 replace_object.c |    5 ++
 subtree.c        |  117 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 subtree.h        |    2 +
 4 files changed, 126 insertions(+), 0 deletions(-)
 create mode 100644 subtree.c
 create mode 100644 subtree.h

diff --git a/Makefile b/Makefile
index f33648d..0d13538 100644
--- a/Makefile
+++ b/Makefile
@@ -525,6 +525,7 @@ LIB_H +=3D sigchain.h
 LIB_H +=3D strbuf.h
 LIB_H +=3D string-list.h
 LIB_H +=3D submodule.h
+LIB_H +=3D subtree.h
 LIB_H +=3D tag.h
 LIB_H +=3D transport.h
 LIB_H +=3D tree.h
@@ -629,6 +630,7 @@ LIB_OBJS +=3D sigchain.o
 LIB_OBJS +=3D strbuf.o
 LIB_OBJS +=3D string-list.o
 LIB_OBJS +=3D submodule.o
+LIB_OBJS +=3D subtree.o
 LIB_OBJS +=3D symlinks.o
 LIB_OBJS +=3D tag.o
 LIB_OBJS +=3D trace.o
diff --git a/replace_object.c b/replace_object.c
index eb59604..5fe4099 100644
--- a/replace_object.c
+++ b/replace_object.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "sha1-lookup.h"
 #include "refs.h"
+#include "subtree.h"
=20
 static struct replace_object {
 	unsigned char sha1[2][20];
@@ -82,6 +83,7 @@ static void prepare_replace_object(void)
 	if (replace_object_prepared)
 		return;
=20
+	prepare_subtree_commit();
 	for_each_replace_ref(register_replace_ref, NULL);
 	replace_object_prepared =3D 1;
 }
@@ -99,6 +101,9 @@ const unsigned char *lookup_replace_object(const uns=
igned char *sha1)
=20
 	prepare_replace_object();
=20
+	if (core_subtree)
+		cur =3D subtree_lookup_object(cur);
+
 	/* Try to recursively replace the object */
 	do {
 		if (--depth < 0)
diff --git a/subtree.c b/subtree.c
new file mode 100644
index 0000000..601d827
--- /dev/null
+++ b/subtree.c
@@ -0,0 +1,117 @@
+#include "cache.h"
+#include "commit.h"
+#include "tree.h"
+#include "diff.h"
+#include "revision.h"
+#include "refs.h"
+#include "tag.h"
+#include "progress.h"
+#include "pack.h"
+#include "sha1-lookup.h"
+#include "csum-file.h"
+
+static struct replace_object {
+	unsigned char sha1[2][20];
+} **subtree_commit;
+
+static struct replace_object **subtree_commit, **subtree_commit_r;
+static int subtree_commit_nr, subtree_commit_r_nr, subtree_commit_allo=
c;
+
+static const unsigned char *replace_sha1_access(size_t index, void *ta=
ble)
+{
+	struct replace_object **replace =3D table;
+	return replace[index]->sha1[0];
+}
+
+static int subtree_replace_object_pos(struct replace_object **store, i=
nt nr,
+				      const unsigned char *sha1)
+{
+	return sha1_pos(sha1, store, nr, replace_sha1_access);
+}
+
+static int subtree_register_object(struct replace_object **store,
+					   int *nr,
+					   const unsigned char *sha1,
+					   struct replace_object *replace,
+					   int ignore_dups)
+{
+	int pos =3D subtree_replace_object_pos(store, *nr, sha1);
+
+	if (0 <=3D pos) {
+		if (ignore_dups)
+			free(replace);
+		else {
+			free(store[pos]);
+			store[pos] =3D replace;
+		}
+		return 1;
+	}
+	pos =3D -pos - 1;
+	(*nr)++;
+	if (pos < *nr)
+		memmove(store + pos + 1,
+			store + pos,
+			(*nr - pos - 1) *
+			sizeof(*store));
+	store[pos] =3D replace;
+	return 0;
+}
+
+void prepare_subtree_commit()
+{
+	int fd;
+	struct stat stat;
+	struct replace_object *ro;
+	int ro_size, ro_table_size;
+	char *subtree, *entry;
+
+	if (!core_subtree)
+		return;
+
+	fd =3D open(git_path("subtree"), O_RDONLY);
+	if (fd =3D=3D -1)
+		return;
+
+	if (fstat(fd, &stat))
+		die("Could not stat .git/subtree");
+
+	if (stat.st_size % 82)
+		die("Invalid .git/subtree size");
+
+	subtree_commit_alloc =3D stat.st_size / 82;
+	ro_size =3D sizeof(struct replace_object) * subtree_commit_alloc;
+	ro_table_size =3D sizeof(struct replace_object*) * subtree_commit_all=
oc;
+	subtree_commit_nr =3D 0;
+	subtree_commit_r_nr =3D 0;
+
+	subtree_commit =3D xmalloc(ro_size + ro_table_size*2);
+	subtree_commit_r =3D (struct replace_object **)(((char*)subtree_commi=
t) + ro_table_size);
+	ro =3D (struct replace_object *)(((char*)subtree_commit) + 2*ro_table=
_size);
+
+	entry =3D subtree =3D xmmap(NULL, stat.st_size, PROT_READ, MAP_PRIVAT=
E, fd, 0);
+
+	for (entry =3D subtree; subtree_commit_nr < subtree_commit_alloc; ent=
ry +=3D 82, ro++) {
+		if (entry[40] !=3D ' ' || entry[81] !=3D '\n')
+			die("Broken .git/subtree");
+
+		get_sha1_hex(entry,    ro->sha1[0]);
+		get_sha1_hex(entry+41, ro->sha1[1]);
+		if (subtree_register_object(subtree_commit, &subtree_commit_nr,
+						    ro->sha1[0], ro, 1) ||
+		    subtree_register_object(subtree_commit_r, &subtree_commit_r_nr,
+						    ro->sha1[1], ro, 1))
+			die("duplicate replace ref: %s", sha1_to_hex(ro->sha1[0]));
+	}
+	munmap(subtree, stat.st_size);
+	close(fd);
+}
+
+const unsigned char *subtree_lookup_object(const unsigned char *sha1)
+{
+	int pos =3D subtree_replace_object_pos(subtree_commit,
+					     subtree_commit_nr,
+					     sha1);
+	if (0 <=3D pos)
+		return subtree_commit[pos]->sha1[1];
+	return sha1;
+}
diff --git a/subtree.h b/subtree.h
new file mode 100644
index 0000000..157153a
--- /dev/null
+++ b/subtree.h
@@ -0,0 +1,2 @@
+void prepare_subtree_commit();
+const unsigned char *subtree_lookup_object(const unsigned char *sha1);
--=20
1.7.1.rc1.69.g24c2f7
