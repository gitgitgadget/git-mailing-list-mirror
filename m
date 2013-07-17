From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 6/7] {send,receive}-pack: support pushing from a shallow clone
Date: Wed, 17 Jul 2013 19:47:13 +0700
Message-ID: <1374065234-870-7-git-send-email-pclouds@gmail.com>
References: <1374065234-870-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 17 14:47:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzR8z-0005Bd-E3
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 14:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754896Ab3GQMrl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Jul 2013 08:47:41 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:53408 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754696Ab3GQMrk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 08:47:40 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj3so1937082pad.0
        for <git@vger.kernel.org>; Wed, 17 Jul 2013 05:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=tKkWDhFeogyJ4Yni6JIuLaP36RwGwl1jswaKf11WTAQ=;
        b=b3qxSOrvTvzcbEjhxdxTkFRGRI8yTqHdwg3gbFScuwR2el1k8bClk6JNzV8Iob7KIA
         FbF0D33cKvvDdcQ8Wl7duRily+pObCtJruAswy6mUqfX6mwchEgUGL1aDQ047LIzWZOD
         gQjijMeSY9LpGEENSxnn7d2JKER0mvVS4/jUgLk0LXbgZQYtCi/uRIjgOKRUKPfWFUC1
         1tWWA5BoloCzdTmy1tEn/PxVlA4MljmpzmRzYuzjl/wnjRH6147hX5/1dEa1AxqXewf2
         zQDgJ4i0MAHznA9CUX7mO4epIbi8AzW1m8BpzvSWBd225FfsDZyYzXLxbyAsDvYzWgJS
         8/aA==
X-Received: by 10.69.4.5 with SMTP id ca5mr6674409pbd.109.1374065259834;
        Wed, 17 Jul 2013 05:47:39 -0700 (PDT)
Received: from lanh ([115.73.197.79])
        by mx.google.com with ESMTPSA id dg3sm7711877pbc.24.2013.07.17.05.47.36
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 17 Jul 2013 05:47:39 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 17 Jul 2013 19:47:54 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1374065234-870-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230617>

Pushing from a shallow clone using today's send-pack and receive-pack
may work, if the transferred pack does not ends up at any graft
points. If it does, recent receive-pack that does connectivity check
will reject the push. If receive-pack is old, the upstream repo
becomes corrupt.

The pack protocol is updated and send-pack now sends all shallow
grafts before it sends the commands, if the repo is shallow. This
protocol extension will break current receive-pack, which is intended,
mostly to stop corrupting the upstream repo.

The receiver end, the newreceive-pack, does something similar to
fetch-pack: it creates a temporary shallow file with grafts from
send-pack, then receives the pack, and finally writes the refined
shallow file down.

shadow file is not cleaned up after deleting (or force updating) a ref
if that ref is the only way to reach the graft points. The reason is
once we delete graft points, we can't recover. That may make reflog
entries on server useless. Leave that for the administrators to decide
when to clean up shadow file (maybe at repack/gc time).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/technical/pack-protocol.txt |  4 +-
 builtin/receive-pack.c                    | 49 ++++++++++++++++++----
 send-pack.c                               |  3 ++
 t/t5537-push-shallow.sh (new +x)          | 67 +++++++++++++++++++++++=
++++++++
 4 files changed, 114 insertions(+), 9 deletions(-)
 create mode 100755 t/t5537-push-shallow.sh

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/=
technical/pack-protocol.txt
index eb8edd1..c73b62f 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -464,7 +464,9 @@ contain all the objects that the server will need t=
o complete the new
 references.
=20
 ----
-  update-request    =3D  command-list [pack-file]
+  update-request    =3D  *shallow command-list [pack-file]
+
+  shallow           =3D  PKT-LINE("shallow" SP obj-id)
=20
   command-list      =3D  PKT-LINE(command NUL capability-list LF)
 		       *PKT-LINE(command LF)
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 2d8e19b..0537e26 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -41,6 +41,10 @@ static int auto_gc =3D 1;
 static const char *head_name;
 static void *head_name_to_free;
 static int sent_capabilities;
+static int shallow_changed;
+static const char* alternate_shallow_file;
+static struct lock_file shallow_lock;
+static struct extra_have_objects shallow;
=20
 static enum deny_action parse_deny_action(const char *var, const char =
*value)
 {
@@ -751,6 +755,13 @@ static void execute_commands(struct command *comma=
nds, const char *unpacker_erro
 	}
 }
=20
+static void add_extra_have(struct extra_have_objects *extra, unsigned =
char *sha1)
+{
+	ALLOC_GROW(extra->array, extra->nr + 1, extra->alloc);
+	hashcpy(&(extra->array[extra->nr][0]), sha1);
+	extra->nr++;
+}
+
 static struct command *read_head_info(void)
 {
 	struct command *commands =3D NULL;
@@ -765,6 +776,17 @@ static struct command *read_head_info(void)
 		line =3D packet_read_line(0, &len);
 		if (!line)
 			break;
+
+		if (len =3D=3D 48 && !prefixcmp(line, "shallow ")) {
+			if (get_sha1_hex(line + 8, old_sha1))
+				die("protocol error: expected shallow sha, got '%s'", line + 8);
+			if (!has_sha1_file(old_sha1)) {
+				add_extra_have(&shallow, old_sha1);
+				shallow_changed =3D 1;
+			}
+			continue;
+		}
+
 		if (len < 83 ||
 		    line[40] !=3D ' ' ||
 		    line[81] !=3D ' ' ||
@@ -827,6 +849,12 @@ static const char *unpack(int err_fd)
 			    ? transfer_fsck_objects
 			    : 0);
=20
+	if (shallow_changed)
+		setup_alternate_shallow(&shallow_lock,
+					&alternate_shallow_file,
+					&shallow, 0);
+
+
 	hdr_err =3D parse_pack_header(&hdr);
 	if (hdr_err) {
 		if (err_fd > 0)
@@ -854,9 +882,8 @@ static const char *unpack(int err_fd)
 		child.err =3D err_fd;
 		child.git_cmd =3D 1;
 		code =3D run_command(&child);
-		if (!code)
-			return NULL;
-		return "unpack-objects abnormal exit";
+		if (code)
+			return "unpack-objects abnormal exit";
 	} else {
 		const char *keeper[7];
 		int s, status, i =3D 0;
@@ -887,12 +914,18 @@ static const char *unpack(int err_fd)
 		pack_lockfile =3D index_pack_lockfile(ip.out);
 		close(ip.out);
 		status =3D finish_command(&ip);
-		if (!status) {
-			reprepare_packed_git();
-			return NULL;
-		}
-		return "index-pack abnormal exit";
+		if (status)
+			return "index-pack abnormal exit";
+		reprepare_packed_git();
+	}
+
+	if (shallow_changed) {
+		setup_alternate_shallow(&shallow_lock,
+					&alternate_shallow_file,
+					&shallow, 1);
+		commit_lock_file(&shallow_lock);
 	}
+	return NULL;
 }
=20
 static const char *unpack_with_sideband(void)
diff --git a/send-pack.c b/send-pack.c
index 7d172ef..81d4b1c 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -212,6 +212,9 @@ int send_pack(struct send_pack_args *args,
 		return 0;
 	}
=20
+	if (!args->dry_run && !args->stateless_rpc)
+		advertise_shallow_grafts(out);
+
 	/*
 	 * Finally, tell the other end!
 	 */
diff --git a/t/t5537-push-shallow.sh b/t/t5537-push-shallow.sh
new file mode 100755
index 0000000..30fdbc8
--- /dev/null
+++ b/t/t5537-push-shallow.sh
@@ -0,0 +1,67 @@
+#!/bin/sh
+
+test_description=3D'push from/to a shallow clone'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit 1 &&
+	test_commit 2 &&
+	test_commit 3 &&
+	test_commit 4
+'
+
+test_expect_success 'setup shallow clone' '
+	git clone --no-local --depth=3D2 .git shallow &&
+	git --git-dir=3Dshallow/.git log --format=3D%s >actual &&
+	cat <<EOF >expect &&
+4
+3
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'push from shallow clone' '
+	(
+	cd shallow &&
+	test_commit 5 &&
+	git push ../.git +master:refs/remotes/shallow/master
+	) &&
+	git log --format=3D%s shallow/master >actual &&
+	git fsck &&
+	cat <<EOF >expect &&
+5
+4
+3
+2
+1
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'push from shallow clone, with grafted roots' '
+	git init shallow2 &&
+	(
+	cd shallow2 &&
+	test_commit a &&
+	test_commit b &&
+	test_commit c &&
+	git rev-parse b > .git/shallow &&
+	git log --format=3D%s >actual &&
+	cat <<EOF >expect &&
+c
+b
+EOF
+	test_cmp expect actual &&
+	git push ../.git +master:refs/remotes/shallow2/master
+	) &&
+	git log --format=3D%s shallow2/master >actual &&
+	git fsck &&
+	cat <<EOF >expect &&
+c
+b
+EOF
+	test_cmp expect actual
+'
+
+test_done
--=20
1.8.2.83.gc99314b
