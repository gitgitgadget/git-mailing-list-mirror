From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 05/28] Advertise shallow graft information on the server end
Date: Mon, 25 Nov 2013 10:55:31 +0700
Message-ID: <1385351754-9954-6-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 25 04:52:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VknDT-0001in-Vr
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 04:52:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753372Ab3KYDwA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Nov 2013 22:52:00 -0500
Received: from mail-pb0-f51.google.com ([209.85.160.51]:39626 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071Ab3KYDv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Nov 2013 22:51:58 -0500
Received: by mail-pb0-f51.google.com with SMTP id up15so4756380pbc.24
        for <git@vger.kernel.org>; Sun, 24 Nov 2013 19:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=lEuXq6IueAK5I7sXungxXyW8exGe6ChmtHXw/dTjEb8=;
        b=riZCuoWXkhL4uU8607SHOGKRO8saLnsCywZn4mMHktLfcup9oeF4RSOX3oN8e+TaAV
         86F3sk01Gb6BKnUq2S//fsixPBrnC5LiU3ThuLeW8V4sh8ILApG8EFciYjzcV2VxP3bG
         FZp01c1SxQqYxB72tdSfO9TRbAM7tep5wb4OZbdWKPUjwz7wWJsqKVIAg9/J5XkG+YEt
         3z1XeAf5S703+5mY+IcZ8ztkw1m7uXoMAYBc+Hg0LMrQqPe3HLW4sgtDS6WGMjy+ISJD
         ICbonwaO9h+vLPc3ydnFgveRPmMjXj0FaurVPOgOEhsDom3W28EWLu9jQ7s/5UeIHtKq
         kQUA==
X-Received: by 10.69.11.130 with SMTP id ei2mr581666pbd.144.1385351517577;
        Sun, 24 Nov 2013 19:51:57 -0800 (PST)
Received: from lanh ([115.73.213.240])
        by mx.google.com with ESMTPSA id jn12sm28351148pbd.37.2013.11.24.19.51.54
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 24 Nov 2013 19:51:56 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 25 Nov 2013 10:56:30 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238278>

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
 shallow.c                                 | 15 +++++++++++++++
 upload-pack.c                             |  6 ++++--
 5 files changed, 26 insertions(+), 3 deletions(-)

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
index 67ce1ef..cc8c34f 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -178,6 +178,8 @@ static void write_head_info(void)
 	if (!sent_capabilities)
 		show_ref("capabilities^{}", null_sha1);
=20
+	advertise_shallow_grafts(1);
+
 	/* EOF */
 	packet_flush(1);
 }
@@ -998,7 +1000,7 @@ int cmd_receive_pack(int argc, const char **argv, =
const char *prefix)
 	if (!enter_repo(dir, 0))
 		die("'%s' does not appear to be a git repository", dir);
=20
-	if (is_repository_shallow())
+	if (is_repository_shallow() && stateless_rpc)
 		die("attempt to push into a shallow repository");
=20
 	git_config(receive_pack_config, NULL);
diff --git a/commit.h b/commit.h
index bd841f4..a879526 100644
--- a/commit.h
+++ b/commit.h
@@ -205,6 +205,7 @@ extern int write_shallow_commits(struct strbuf *out=
, int use_pack_protocol);
 extern void setup_alternate_shallow(struct lock_file *shallow_lock,
 				    const char **alternate_shallow_file);
 extern char *setup_temporary_shallow(void);
+extern void advertise_shallow_grafts(int);
=20
 int is_descendant_of(struct commit *, struct commit_list *);
 int in_merge_bases(struct commit *, struct commit *);
diff --git a/shallow.c b/shallow.c
index cdf37d6..9552512 100644
--- a/shallow.c
+++ b/shallow.c
@@ -220,3 +220,18 @@ void setup_alternate_shallow(struct lock_file *sha=
llow_lock,
 		*alternate_shallow_file =3D "";
 	strbuf_release(&sb);
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
index c989a73..38b2a29 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -758,6 +758,7 @@ static void upload_pack(void)
 		reset_timeout();
 		head_ref_namespaced(send_ref, &symref);
 		for_each_namespaced_ref(send_ref, &symref);
+		advertise_shallow_grafts(1);
 		packet_flush(1);
 	} else {
 		head_ref_namespaced(mark_our_ref, NULL);
@@ -835,8 +836,9 @@ int main(int argc, char **argv)
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
