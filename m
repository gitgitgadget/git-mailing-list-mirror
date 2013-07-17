From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/7] {receive,upload}-pack: advertise shallow graft information
Date: Wed, 17 Jul 2013 19:47:09 +0700
Message-ID: <1374065234-870-3-git-send-email-pclouds@gmail.com>
References: <1374065234-870-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 17 14:47:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzR8c-0004vL-Hw
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 14:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754771Ab3GQMrS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Jul 2013 08:47:18 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:38006 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754719Ab3GQMrR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 08:47:17 -0400
Received: by mail-pa0-f45.google.com with SMTP id bi5so1917359pad.18
        for <git@vger.kernel.org>; Wed, 17 Jul 2013 05:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=XJ234/fd62lJ5CspmLH1tRWR1fQrvAfY3l0dJ08O/AA=;
        b=QIrDdrrMoxuYXBoI7Qw3mf0qBgvYt8EXnBJruhGq92onMLsNWUAJhbOv6CCWqOXOwn
         tp9gBaymhFndjaSeLCitRMLX38DKJ+CuO4iFOKabbZ/WYAYbLk+VFtsYQnaSjMn2Bp3K
         txxlO5ba6fa44Xn1di6MSqWyYp9tcU6VyKqeNGYVivZ19ZRIf7bylauHpEqXwBW1Wnvk
         UcV3hWEeabZxjwT0bs0UzHW9hwXQ40xG8be6ME+oZbyVrEaj0BAd2a/vRqLMu+0RKoYf
         ICAaEjMJ2T6kLnwc4avJ9pi4Sh4rgsafayv6azvdElBboNwTjnboLx0TBuFHkzp3VZqa
         uL9g==
X-Received: by 10.66.231.103 with SMTP id tf7mr7763411pac.154.1374065236553;
        Wed, 17 Jul 2013 05:47:16 -0700 (PDT)
Received: from lanh ([115.73.197.79])
        by mx.google.com with ESMTPSA id vi8sm7692804pbc.31.2013.07.17.05.47.13
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 17 Jul 2013 05:47:15 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 17 Jul 2013 19:47:32 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1374065234-870-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230614>

If either receive-pack or upload-pack is called on a shallow
repository, shallow graft points will be sent after the ref
advertisement (but before the packet flush).

This breaks the protocol for all clients trying to push to a shallow
repo, or fetch from one. Which is basically the same end result as
today's "is_repository_shallow() && die()" in receive-pack and
upload-pack. New clients will be made aware of shallow upstream and
can make use of this information.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/technical/pack-protocol.txt |  3 +++
 builtin/receive-pack.c                    |  5 ++---
 commit.h                                  |  1 +
 shallow.c                                 | 16 ++++++++++++++++
 upload-pack.c                             |  3 +--
 5 files changed, 23 insertions(+), 5 deletions(-)

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
index e3eb5fc..2d8e19b 100644
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
@@ -990,9 +992,6 @@ int cmd_receive_pack(int argc, const char **argv, c=
onst char *prefix)
 	if (!enter_repo(dir, 0))
 		die("'%s' does not appear to be a git repository", dir);
=20
-	if (is_repository_shallow())
-		die("attempt to push into a shallow repository");
-
 	git_config(receive_pack_config, NULL);
=20
 	if (0 <=3D transfer_unpack_limit)
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
index 127e59a..6cefe43 100644
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
@@ -837,8 +838,6 @@ int main(int argc, char **argv)
=20
 	if (!enter_repo(dir, strict))
 		die("'%s' does not appear to be a git repository", dir);
-	if (is_repository_shallow())
-		die("attempt to fetch/clone from a shallow repository");
 	git_config(upload_pack_config, NULL);
 	upload_pack();
 	return 0;
--=20
1.8.2.83.gc99314b
