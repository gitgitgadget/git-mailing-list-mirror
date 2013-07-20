From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 02/16] {receive,upload}-pack: advertise shallow graft information
Date: Sat, 20 Jul 2013 16:57:56 +0700
Message-ID: <1374314290-5976-3-git-send-email-pclouds@gmail.com>
References: <1374065234-870-1-git-send-email-pclouds@gmail.com>
 <1374314290-5976-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 20 11:58:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0Tvo-0001Gz-93
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 11:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885Ab3GTJ6T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Jul 2013 05:58:19 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:51573 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752665Ab3GTJ6I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jul 2013 05:58:08 -0400
Received: by mail-ie0-f178.google.com with SMTP id u16so11262463iet.23
        for <git@vger.kernel.org>; Sat, 20 Jul 2013 02:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=UotRB5nlgAyNvW5zmQQVQA6rjVc5D8HskmfH/mjGXVo=;
        b=zoGKOrL356zqZX62drMfWTcN0RYx8ntjABCW4JfJiZUomIfReSvLZYJPP2d/V+eaER
         YJfJ/IGfG4oZLWQwDJo4+qXlCKNN7I1fSivtpNavoOK3J5hr7S0ifcCkhU7Umay1GdcA
         8Ru/zI6PXvQfAnvOPiVxZEn1fppjhQlPm+N3kFuNthPJdsxlUpqy7PPBCj5b19hAWVk0
         qT2gaZ9FP1H+aYin6Y6rabRqx1qTaHPK0WnNTrSmwtY7IwMZBHX9vOhHhmVixBFgb6P8
         xkxMAGTV21U+0OkxGJrzCWVd5qSEITKmQFFLYFqco3pQ8FggF97+MP8XX76IgoNmlJA5
         YoCw==
X-Received: by 10.42.52.6 with SMTP id h6mr13310523icg.5.1374314288338;
        Sat, 20 Jul 2013 02:58:08 -0700 (PDT)
Received: from lanh ([115.73.248.127])
        by mx.google.com with ESMTPSA id hj6sm2257841igb.1.2013.07.20.02.58.05
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Jul 2013 02:58:07 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 20 Jul 2013 16:58:27 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1374314290-5976-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230881>

If either receive-pack or upload-pack is called on a shallow
repository, shallow graft points will be sent after the ref
advertisement (but before the packet flush), so that the client has
the full "shape" of the server's commit graph.

This breaks the protocol for all clients trying to push to a shallow
repo, or fetch from one. Which is basically the same end result as
today's "is_repository_shallow() && die()" in receive-pack and
upload-pack. New clients will be made aware of shallow upstream and
can make use of this information.

Smart HTTP is not affected by this patch. Shallow support on
smart-http comes later separately.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/technical/pack-protocol.txt |  3 +++
 builtin/receive-pack.c                    |  4 +++-
 commit.h                                  |  1 +
 shallow.c                                 | 16 ++++++++++++++++
 upload-pack.c                             |  6 ++++--
 5 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/=
technical/pack-protocol.txt
index b898e97..eb8edd1 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -161,6 +161,7 @@ MUST peel the ref if it's an annotated tag.
=20
 ----
   advertised-refs  =3D  (no-refs / list-of-refs)
+		      *shallow
 		      flush-pkt
=20
   no-refs          =3D  PKT-LINE(zero-id SP "capabilities^{}"
@@ -174,6 +175,8 @@ MUST peel the ref if it's an annotated tag.
   other-tip        =3D  obj-id SP refname LF
   other-peeled     =3D  obj-id SP refname "^{}" LF
=20
+  shallow          =3D  PKT-LINE("shallow" SP obj-id)
+
   capability-list  =3D  capability *(SP capability)
   capability       =3D  1*(LC_ALPHA / DIGIT / "-" / "_")
   LC_ALPHA         =3D  %x61-7A
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e3eb5fc..6ffe526 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -176,6 +176,8 @@ static void write_head_info(void)
 	if (!sent_capabilities)
 		show_ref("capabilities^{}", null_sha1);
=20
+	advertise_shallow_grafts(1);
+
 	/* EOF */
 	packet_flush(1);
 }
@@ -990,7 +992,7 @@ int cmd_receive_pack(int argc, const char **argv, c=
onst char *prefix)
 	if (!enter_repo(dir, 0))
 		die("'%s' does not appear to be a git repository", dir);
=20
-	if (is_repository_shallow())
+	if (is_repository_shallow() && stateless_rpc)
 		die("attempt to push into a shallow repository");
=20
 	git_config(receive_pack_config, NULL);
diff --git a/commit.h b/commit.h
index 4d452dc..e0688c3 100644
--- a/commit.h
+++ b/commit.h
@@ -187,6 +187,7 @@ extern struct commit_list *get_shallow_commits(stru=
ct object_array *heads,
 		int depth, int shallow_flag, int not_shallow_flag);
 extern void check_shallow_file_for_update(void);
 extern void set_alternate_shallow_file(const char *path);
+extern void advertise_shallow_grafts(int);
=20
 int is_descendant_of(struct commit *, struct commit_list *);
 int in_merge_bases(struct commit *, struct commit *);
diff --git a/shallow.c b/shallow.c
index cbe2526..ccdfefc 100644
--- a/shallow.c
+++ b/shallow.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "commit.h"
 #include "tag.h"
+#include "pkt-line.h"
=20
 static int is_shallow =3D -1;
 static struct stat shallow_stat;
@@ -146,3 +147,18 @@ void check_shallow_file_for_update(void)
 		   )
 		die("shallow file was changed during fetch");
 }
+
+static int advertise_shallow_grafts_cb(const struct commit_graft *graf=
t, void *cb)
+{
+	int fd =3D *(int*)cb;
+	if (graft->nr_parent =3D=3D -1)
+		packet_write(fd, "shallow %s\n", sha1_to_hex(graft->sha1));
+	return 0;
+}
+
+void advertise_shallow_grafts(int fd)
+{
+	if (!is_repository_shallow())
+		return;
+	for_each_commit_graft(advertise_shallow_grafts_cb, &fd);
+}
diff --git a/upload-pack.c b/upload-pack.c
index 127e59a..c377a3e 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -766,6 +766,7 @@ static void upload_pack(void)
 		reset_timeout();
 		head_ref_namespaced(send_ref, NULL);
 		for_each_namespaced_ref(send_ref, NULL);
+		advertise_shallow_grafts(1);
 		packet_flush(1);
 	} else {
 		head_ref_namespaced(mark_our_ref, NULL);
@@ -837,8 +838,9 @@ int main(int argc, char **argv)
=20
 	if (!enter_repo(dir, strict))
 		die("'%s' does not appear to be a git repository", dir);
-	if (is_repository_shallow())
-		die("attempt to fetch/clone from a shallow repository");
+	if (is_repository_shallow() && stateless_rpc)
+		die("attempt to push into a shallow repository");
+
 	git_config(upload_pack_config, NULL);
 	upload_pack();
 	return 0;
--=20
1.8.2.83.gc99314b
