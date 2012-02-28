From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] Perform cheaper connectivity check when pack is used as medium
Date: Tue, 28 Feb 2012 20:18:29 +0700
Message-ID: <1330435109-4437-1-git-send-email-pclouds@gmail.com>
References: <7vmx849ma8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 14:19:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2Mxq-0003IA-3F
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 14:19:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359Ab2B1NT1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Feb 2012 08:19:27 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:57169 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756949Ab2B1NT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 08:19:26 -0500
Received: by pbcup15 with SMTP id up15so3280067pbc.19
        for <git@vger.kernel.org>; Tue, 28 Feb 2012 05:19:26 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.226.170 as permitted sender) client-ip=10.68.226.170;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.226.170 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.226.170])
        by 10.68.226.170 with SMTP id rt10mr18007979pbc.127.1330435166431 (num_hops = 1);
        Tue, 28 Feb 2012 05:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=xV2g4YghXrwWkK2I7ZS9nFxfKrphzHLuQhcHYPxaQeM=;
        b=K414fwN51OuidZh2Tds5quFetJMvNsgYk1MGnDhlRfQLcwXmdkttuRUVeEOUS/wUQo
         KIJlh05dgcCwA95KglibQV+hepEvtxwVUSh0w5l5c4fEMSvgBYM0SVLC9J34Ys4gASNa
         yR23/oE7oz/kXx4awfrRWxjX5RurPmdea8H6M=
Received: by 10.68.226.170 with SMTP id rt10mr14975453pbc.127.1330435166286;
        Tue, 28 Feb 2012 05:19:26 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.56.186])
        by mx.google.com with ESMTPS id g3sm15672521pbt.41.2012.02.28.05.19.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 28 Feb 2012 05:19:25 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 28 Feb 2012 20:18:31 +0700
X-Mailer: git-send-email 1.7.9.2.304.g57952
In-Reply-To: <7vmx849ma8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191731>

When we fetch or push, usually "git rev-list --verify-objects --not
--all --stdin" is used to make sure that there are no gaps between
existing refs and new refs. --verify-objects calls parse_object(),
which internally calls check_sha1_signature() to verify object content
matches its SHA-1 signature.

check_sha1_signature() is an expensive operation, especially when new
refs are far away from existing ones because all objects in between
are re-hashed. However, if we receive new objects by pack, we can
skip the operation because packs themselves do not contain SHA-1
signatures. All signatures are recreated by unpack-objects/index-pack's
hashing objects in the pack, which we can trust.

Detect pack transfer cases and turn --verify-objects to --objects.
--objects is similar to --verify-objects except that it does not call
check_sha1_signature().

As an (extreme) example, a repository is created with only one commit:
e83c516 (Initial revision of "git", the information manager from hell
- 2005-04-07). The rest of git.git is fetched on top. Without the
patch:

$ time git fetch file:///home/pclouds/w/git/.git
remote: Counting objects: 125638, done.
remote: Compressing objects: 100% (33201/33201), done.
remote: Total 125638 (delta 92568), reused 123517 (delta 90743)
Receiving objects: 100% (125638/125638), 34.58 MiB | 8.07 MiB/s, done.
Resolving deltas: 100% (92568/92568), done.
=46rom file:///home/pclouds/w/git/
 * branch            HEAD       -> FETCH_HEAD

real    1m30.972s
user    1m31.410s
sys     0m1.757s

With the patch:

$ time git fetch file:///home/pclouds/w/git/.git
remote: Counting objects: 125647, done.
remote: Compressing objects: 100% (33209/33209), done.
remote: Total 125647 (delta 92576), reused 123516 (delta 90744)
Receiving objects: 100% (125647/125647), 34.58 MiB | 7.99 MiB/s, done.
Resolving deltas: 100% (92576/92576), done.
=46rom file:///home/pclouds/w/git/
 * branch            HEAD       -> FETCH_HEAD

real    0m51.456s
user    0m52.737s
sys     0m1.548s

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 combine "quiet" and "strict" to a flag word

 builtin/fetch.c |   14 +++++++++-----
 connected.c     |   11 +++++++----
 connected.h     |    6 +++++-
 transport.c     |    5 +++++
 transport.h     |    1 +
 5 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 65f5f9b..70c9ca3 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -368,7 +368,7 @@ static int iterate_ref_map(void *cb_data, unsigned =
char sha1[20])
 }
=20
 static int store_updated_refs(const char *raw_url, const char *remote_=
name,
-		struct ref *ref_map)
+			      struct ref *ref_map, int use_pack)
 {
 	FILE *fp;
 	struct commit *commit;
@@ -389,7 +389,9 @@ static int store_updated_refs(const char *raw_url, =
const char *remote_name,
 		url =3D xstrdup("foreign");
=20
 	rm =3D ref_map;
-	if (check_everything_connected(iterate_ref_map, 0, &rm)) {
+	if (check_everything_connected(iterate_ref_map,
+				       use_pack ? 0 : CHECK_CONNECT_STRICT,
+				       &rm)) {
 		rc =3D error(_("%s did not send all necessary objects\n"), url);
 		goto abort;
 	}
@@ -516,7 +518,8 @@ static int quickfetch(struct ref *ref_map)
 	 */
 	if (depth)
 		return -1;
-	return check_everything_connected(iterate_ref_map, 1, &rm);
+	return check_everything_connected(iterate_ref_map,
+					  CHECK_CONNECT_QUIET, &rm);
 }
=20
 static int fetch_refs(struct transport *transport, struct ref *ref_map=
)
@@ -526,8 +529,9 @@ static int fetch_refs(struct transport *transport, =
struct ref *ref_map)
 		ret =3D transport_fetch_refs(transport, ref_map);
 	if (!ret)
 		ret |=3D store_updated_refs(transport->url,
-				transport->remote->name,
-				ref_map);
+					  transport->remote->name,
+					  ref_map,
+					  is_pack_transport(transport));
 	transport_unlock_pack(transport);
 	return ret;
 }
diff --git a/connected.c b/connected.c
index d762423..9df357d 100644
--- a/connected.c
+++ b/connected.c
@@ -14,10 +14,11 @@
  *
  * Returns 0 if everything is connected, non-zero otherwise.
  */
-int check_everything_connected(sha1_iterate_fn fn, int quiet, void *cb=
_data)
+int check_everything_connected(sha1_iterate_fn fn, unsigned int flags,
+			       void *cb_data)
 {
 	struct child_process rev_list;
-	const char *argv[] =3D {"rev-list", "--verify-objects",
+	const char *argv[] =3D {"rev-list", "--objects",
 			      "--stdin", "--not", "--all", NULL, NULL};
 	char commit[41];
 	unsigned char sha1[20];
@@ -26,7 +27,9 @@ int check_everything_connected(sha1_iterate_fn fn, in=
t quiet, void *cb_data)
 	if (fn(cb_data, sha1))
 		return err;
=20
-	if (quiet)
+	if (flags & CHECK_CONNECT_STRICT)
+		argv[1] =3D "--verify-objects";
+	if (flags & CHECK_CONNECT_QUIET)
 		argv[5] =3D "--quiet";
=20
 	memset(&rev_list, 0, sizeof(rev_list));
@@ -34,7 +37,7 @@ int check_everything_connected(sha1_iterate_fn fn, in=
t quiet, void *cb_data)
 	rev_list.git_cmd =3D 1;
 	rev_list.in =3D -1;
 	rev_list.no_stdout =3D 1;
-	rev_list.no_stderr =3D quiet;
+	rev_list.no_stderr =3D flags & CHECK_CONNECT_QUIET;
 	if (start_command(&rev_list))
 		return error(_("Could not run 'git rev-list'"));
=20
diff --git a/connected.h b/connected.h
index 7e4585a..52636b9 100644
--- a/connected.h
+++ b/connected.h
@@ -1,6 +1,9 @@
 #ifndef CONNECTED_H
 #define CONNECTED_H
=20
+#define CHECK_CONNECT_QUIET  1
+#define CHECK_CONNECT_STRICT 2
+
 /*
  * Take callback data, and return next object name in the buffer.
  * When called after returning the name for the last object, return -1
@@ -15,6 +18,7 @@ typedef int (*sha1_iterate_fn)(void *, unsigned char =
[20]);
  *
  * Return 0 if Ok, non zero otherwise (i.e. some missing objects)
  */
-extern int check_everything_connected(sha1_iterate_fn, int quiet, void=
 *cb_data);
+extern int check_everything_connected(sha1_iterate_fn, unsigned int fl=
ags,
+				      void *cb_data);
=20
 #endif /* CONNECTED_H */
diff --git a/transport.c b/transport.c
index 181f8f2..cd5e0ca 100644
--- a/transport.c
+++ b/transport.c
@@ -1248,3 +1248,8 @@ void for_each_alternate_ref(alternate_ref_fn fn, =
void *data)
 	cb.data =3D data;
 	foreach_alt_odb(refs_from_alternate_cb, &cb);
 }
+
+int is_pack_transport(const struct transport *transport)
+{
+	return transport->fetch =3D=3D fetch_refs_via_pack;
+}
diff --git a/transport.h b/transport.h
index ce99ef8..7cf72ff 100644
--- a/transport.h
+++ b/transport.h
@@ -150,6 +150,7 @@ int transport_disconnect(struct transport *transpor=
t);
 char *transport_anonymize_url(const char *url);
 void transport_take_over(struct transport *transport,
 			 struct child_process *child);
+int is_pack_transport(const struct transport *transport);
=20
 int transport_connect(struct transport *transport, const char *name,
 		      const char *exec, int fd[2]);
--=20
1.7.8.36.g69ee2
