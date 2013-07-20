From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 06/16] {send,receive}-pack: support pushing from a shallow clone
Date: Sat, 20 Jul 2013 16:58:00 +0700
Message-ID: <1374314290-5976-7-git-send-email-pclouds@gmail.com>
References: <1374065234-870-1-git-send-email-pclouds@gmail.com>
 <1374314290-5976-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 20 11:58:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0Tw7-0001QB-C5
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 11:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753334Ab3GTJ6g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Jul 2013 05:58:36 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:48800 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753304Ab3GTJ6e (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jul 2013 05:58:34 -0400
Received: by mail-ie0-f173.google.com with SMTP id k13so11238754iea.4
        for <git@vger.kernel.org>; Sat, 20 Jul 2013 02:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=AQELxSyu/gepUk2Boh25pXEifJjpaa8CUrptkrtKZe0=;
        b=jQghHlY9FLfLUltHbi6PZNhCfMTlAt5DfxSrBj3CGXTSQ6GCT8iYe0h66IpBj5UhYl
         gnFVRfVCPgF9Rav7h4iuUGrCP8z4Nnrj5w+atXsAmpnp98QONLkdIpl03IqAgN8trcaI
         +Hs0IMvuvF0T9peSkzQK98u1sUd4fAZAB4c8TsZclWDHw14KWSJPkFhj/ajkOusQMXOu
         pXIGiHR9wYvufnX8eaDmx1QyiKE4LtbgBJ3/Q85WFSNkmm/S+m5H3cxEAGNdplCcoCAl
         kMASdWEZqovyvsK3isXZvjyYl7IhMSohcHLUE4IglKbYNTAxXc+Y6bciBscH46UlPG7M
         hTOg==
X-Received: by 10.50.16.76 with SMTP id e12mr5256673igd.47.1374314314280;
        Sat, 20 Jul 2013 02:58:34 -0700 (PDT)
Received: from lanh ([115.73.248.127])
        by mx.google.com with ESMTPSA id ht10sm21110127igb.2.2013.07.20.02.58.30
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Jul 2013 02:58:33 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 20 Jul 2013 16:58:52 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1374314290-5976-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230885>

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
 builtin/receive-pack.c                    | 66 ++++++++++++++++++++++-=
----
 builtin/send-pack.c                       |  2 +-
 send-pack.c                               |  3 ++
 t/t5537-push-shallow.sh (new +x)          | 74 +++++++++++++++++++++++=
++++++++
 5 files changed, 137 insertions(+), 12 deletions(-)
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
index 6ffe526..cbb2025 100644
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
@@ -827,6 +849,13 @@ static const char *unpack(int err_fd)
 			    ? transfer_fsck_objects
 			    : 0);
=20
+	if (shallow_changed)
+		setup_alternate_shallow(&shallow_lock,
+					&alternate_shallow_file,
+					&shallow,
+					WRITE_SHALLOW_NO_CUT);
+
+
 	hdr_err =3D parse_pack_header(&hdr);
 	if (hdr_err) {
 		if (err_fd > 0)
@@ -840,7 +869,12 @@ static const char *unpack(int err_fd)
 	if (ntohl(hdr.hdr_entries) < unpack_limit) {
 		int code, i =3D 0;
 		struct child_process child;
-		const char *unpacker[5];
+		const char *unpacker[7];
+		if (alternate_shallow_file &&
+		    *alternate_shallow_file) {
+			unpacker[i++] =3D "--shallow-file";
+			unpacker[i++] =3D alternate_shallow_file;
+		}
 		unpacker[i++] =3D "unpack-objects";
 		if (quiet)
 			unpacker[i++] =3D "-q";
@@ -854,15 +888,19 @@ static const char *unpack(int err_fd)
 		child.err =3D err_fd;
 		child.git_cmd =3D 1;
 		code =3D run_command(&child);
-		if (!code)
-			return NULL;
-		return "unpack-objects abnormal exit";
+		if (code)
+			return "unpack-objects abnormal exit";
 	} else {
-		const char *keeper[7];
+		const char *keeper[9];
 		int s, status, i =3D 0;
 		char keep_arg[256];
 		struct child_process ip;
=20
+		if (alternate_shallow_file &&
+		    *alternate_shallow_file) {
+			keeper[i++] =3D "--shallow-file";
+			keeper[i++] =3D alternate_shallow_file;
+		}
 		s =3D sprintf(keep_arg, "--keep=3Dreceive-pack %"PRIuMAX" on ", (uin=
tmax_t) getpid());
 		if (gethostname(keep_arg + s, sizeof(keep_arg) - s))
 			strcpy(keep_arg + s, "localhost");
@@ -887,12 +925,20 @@ static const char *unpack(int err_fd)
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
+					&shallow,
+					WRITE_SHALLOW_NO_CUT |
+					WRITE_SHALLOW_REWRITE);
+		commit_lock_file(&shallow_lock);
 	}
+	return NULL;
 }
=20
 static const char *unpack_with_sideband(void)
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 4be5931..7dd254f 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -184,7 +184,7 @@ int cmd_send_pack(int argc, const char **argv, cons=
t char *prefix)
 	    (send_all && args.send_mirror))
 		usage(send_pack_usage);
=20
-	if (is_repository_shallow())
+	if (is_repository_shallow() && args.stateless_rpc)
 		die("attempt to push from a shallow repository");
=20
 	if (remote_name) {
diff --git a/send-pack.c b/send-pack.c
index 7d172ef..dcd3345 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -212,6 +212,9 @@ int send_pack(struct send_pack_args *args,
 		return 0;
 	}
=20
+	if (!args->dry_run)
+		advertise_shallow_grafts(out);
+
 	/*
 	 * Finally, tell the other end!
 	 */
diff --git a/t/t5537-push-shallow.sh b/t/t5537-push-shallow.sh
new file mode 100755
index 0000000..37ad69b
--- /dev/null
+++ b/t/t5537-push-shallow.sh
@@ -0,0 +1,74 @@
+#!/bin/sh
+
+test_description=3D'push from/to a shallow clone'
+
+. ./test-lib.sh
+
+commit() {
+	echo "$1" >tracked &&
+	git add tracked &&
+	git commit -m "$1"
+}
+
+test_expect_success 'setup' '
+	git config --global transfer.fsckObjects true &&
+	commit 1 &&
+	commit 2 &&
+	commit 3 &&
+	commit 4 &&
+	(
+	git init full-abc &&
+	cd full-abc &&
+	commit a &&
+	commit b &&
+	commit c
+	) &&
+	git clone --no-local --depth=3D2 .git shallow &&
+	git --git-dir=3Dshallow/.git log --format=3D%s >actual &&
+	cat <<EOF >expect &&
+4
+3
+EOF
+	test_cmp expect actual &&
+	git clone --no-local --depth=3D2 full-abc/.git shallow2 &&
+	git --git-dir=3Dshallow2/.git log --format=3D%s >actual &&
+	cat <<EOF >expect &&
+c
+b
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'push from shallow clone' '
+	(
+	cd shallow &&
+	commit 5 &&
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
+	(
+	cd shallow2 &&
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
