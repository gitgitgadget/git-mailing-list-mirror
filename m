From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 17/28] Support pushing from a shallow clone
Date: Mon, 25 Nov 2013 10:55:43 +0700
Message-ID: <1385351754-9954-18-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 25 04:53:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VknEl-00027m-4c
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 04:53:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753617Ab3KYDxM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Nov 2013 22:53:12 -0500
Received: from mail-pb0-f41.google.com ([209.85.160.41]:55569 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753599Ab3KYDxK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Nov 2013 22:53:10 -0500
Received: by mail-pb0-f41.google.com with SMTP id jt11so4826985pbb.0
        for <git@vger.kernel.org>; Sun, 24 Nov 2013 19:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=69HMEHvPBLp6qIJFnIScXTGQPY9+cxBtc4ED/gewPL4=;
        b=xfs/BMHOZrupVXjDBQBqDnM6VJJ2+eKHRDOdnuxfez2L/afQfOHh3KNzntrQ60mtne
         AE4hHZ28uyUAquisu/YZbBn6etDTW9lfrHouCd080k9zfJkblLI25SINHvK+HiFHV/SU
         P3TbnSpazJwN4ZvE+2Kx95wh0zWQRNKz5Kn5Ys0bqWNPt3NeWfs08x1w6OTlzPG8nYdt
         ae46DQsHrfR6xgzNT2qUqjB/T2yoOB0DpctLjSq/j5ihDVuFQhQussvRDjQgFkCUWAzL
         j8jm5Gh75WF/JgIo3Z/fC+ngOmQm7ibX9uh2AmdYXXm4IT6yrBeDnQeqKH25qdluP/Fz
         fZkA==
X-Received: by 10.68.66.103 with SMTP id e7mr5532762pbt.120.1385351589754;
        Sun, 24 Nov 2013 19:53:09 -0800 (PST)
Received: from lanh ([115.73.213.240])
        by mx.google.com with ESMTPSA id gw10sm31843888pbd.13.2013.11.24.19.53.06
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 24 Nov 2013 19:53:09 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 25 Nov 2013 10:57:42 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238287>

Pushing from a shallow clone using today's send-pack and receive-pack
may work, if the transferred pack does not end up at any graft
points. If it does, recent receive-pack that does connectivity check
will reject the push. If receive-pack is old and does not have the
connectivity check, the upstream repo becomes corrupt.

The pack protocol is updated and send-pack now sends all shallow
grafts before it sends the commands, if the repo is shallow. This
protocol extension will break current receive-pack, which is intended,
mostly to stop corrupting the upstream repo.

Changes on the receiver are similar to what has been done in
fetch-pack, i.e. filter out refs that require new shallow roots then
go along as usual.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/technical/pack-protocol.txt |  4 +-
 builtin/receive-pack.c                    | 68 +++++++++++++++++++++++=
++++++-
 builtin/send-pack.c                       |  2 +-
 send-pack.c                               |  3 ++
 t/t5537-push-shallow.sh (new +x)          | 70 +++++++++++++++++++++++=
++++++++
 5 files changed, 143 insertions(+), 4 deletions(-)
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
index 22e162d..254feff 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -43,6 +43,9 @@ static int fix_thin =3D 1;
 static const char *head_name;
 static void *head_name_to_free;
 static int sent_capabilities;
+static int shallow_push;
+static const char* alternate_shallow_file;
+static struct extra_have_objects shallow;
=20
 static enum deny_action parse_deny_action(const char *var, const char =
*value)
 {
@@ -189,6 +192,7 @@ struct command {
 	const char *error_string;
 	unsigned int skip_update:1,
 		     did_not_exist:1;
+	int index;
 	unsigned char old_sha1[20];
 	unsigned char new_sha1[20];
 	char ref_name[FLEX_ARRAY]; /* more */
@@ -687,7 +691,7 @@ static int iterate_receive_command_list(void *cb_da=
ta, unsigned char sha1[20])
 	struct command *cmd =3D *cmd_list;
=20
 	while (cmd) {
-		if (!is_null_sha1(cmd->new_sha1)) {
+		if (!is_null_sha1(cmd->new_sha1) && !cmd->skip_update) {
 			hashcpy(sha1, cmd->new_sha1);
 			*cmd_list =3D cmd->next;
 			return 0;
@@ -712,8 +716,25 @@ static void reject_updates_to_hidden(struct comman=
d *commands)
 	}
 }
=20
+static void filter_shallow_refs(struct command *commands,
+				const int *ref_status, int nr_ref)
+{
+	struct command *cmd;
+	for (cmd =3D commands; cmd; cmd =3D cmd->next)
+		if (!is_null_sha1(cmd->new_sha1) && ref_status[cmd->index]) {
+			cmd->error_string =3D "shallow update not allowed";
+			cmd->skip_update =3D 1;
+		}
+	if (*alternate_shallow_file) {
+		unlink(alternate_shallow_file);
+		alternate_shallow_file =3D NULL;
+	}
+}
+
 static void execute_commands(struct command *commands, const char *unp=
acker_error)
 {
+	int *ref_status =3D NULL;
+	struct extra_have_objects ref;
 	struct command *cmd;
 	unsigned char sha1[20];
=20
@@ -723,6 +744,20 @@ static void execute_commands(struct command *comma=
nds, const char *unpacker_erro
 		return;
 	}
=20
+	memset(&ref, 0, sizeof(ref));
+	if (shallow_push) {
+		int i;
+		for (i =3D 0, cmd =3D commands; cmd; i++, cmd =3D cmd->next)
+			if (!is_null_sha1(cmd->new_sha1)) {
+				add_extra_have(&ref, cmd->new_sha1);
+				cmd->index =3D i;
+			}
+
+		ref_status =3D xmalloc(sizeof(*ref_status) * ref.nr);
+		if (mark_new_shallow_refs(&ref, ref_status, NULL, &shallow))
+			filter_shallow_refs(commands, ref_status, ref.nr);
+	}
+
 	cmd =3D commands;
 	if (check_everything_connected(iterate_receive_command_list,
 				       0, &cmd))
@@ -752,6 +787,8 @@ static void execute_commands(struct command *comman=
ds, const char *unpacker_erro
=20
 		cmd->error_string =3D update(cmd);
 	}
+	free(ref.array);
+	free(ref_status);
 }
=20
 static struct command *read_head_info(void)
@@ -768,6 +805,15 @@ static struct command *read_head_info(void)
 		line =3D packet_read_line(0, &len);
 		if (!line)
 			break;
+
+		if (len =3D=3D 48 && !prefixcmp(line, "shallow ")) {
+			if (get_sha1_hex(line + 8, old_sha1))
+				die("protocol error: expected shallow sha, got '%s'", line + 8);
+			add_extra_have(&shallow, old_sha1);
+			shallow_push =3D 1;
+			continue;
+		}
+
 		if (len < 83 ||
 		    line[40] !=3D ' ' ||
 		    line[81] !=3D ' ' ||
@@ -822,7 +868,7 @@ static const char *pack_lockfile;
 static const char *unpack(int err_fd)
 {
 	struct pack_header hdr;
-	const char *argv[7];
+	const char *argv[9];
 	const char *hdr_err;
 	int status, ac =3D 0;
 	char hdr_arg[38];
@@ -843,6 +889,24 @@ static const char *unpack(int err_fd)
 			"--pack_header=3D%"PRIu32",%"PRIu32,
 			ntohl(hdr.hdr_version), ntohl(hdr.hdr_entries));
=20
+	if (shallow_push) {
+		struct extra_have_objects extra;
+		memset(&extra, 0, sizeof(extra));
+		remove_reachable_shallow_points(&extra, &shallow);
+		if (extra.nr) {
+			alternate_shallow_file =3D setup_temporary_shallow(&extra);
+			free(shallow.array);
+			shallow =3D extra;
+		} else {
+			alternate_shallow_file =3D NULL;
+			shallow_push =3D 0;
+		}
+		if (alternate_shallow_file && *alternate_shallow_file) {
+			argv[ac++] =3D "--shallow-file";
+			argv[ac++] =3D alternate_shallow_file;
+		}
+	}
+
 	memset(&child, 0, sizeof(child));
 	if (ntohl(hdr.hdr_entries) < unpack_limit) {
 		argv[ac++] =3D "unpack-objects";
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index bfa9253..5db1311 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -207,7 +207,7 @@ int cmd_send_pack(int argc, const char **argv, cons=
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
index fab62e3..8b5571c 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -213,6 +213,9 @@ int send_pack(struct send_pack_args *args,
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
index 0000000..650c31a
--- /dev/null
+++ b/t/t5537-push-shallow.sh
@@ -0,0 +1,70 @@
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
+	test_must_fail git push ../.git +master:refs/remotes/shallow2/master =
2>err &&
+	grep "shallow2/master.*shallow update not allowed" err
+	) &&
+	test_must_fail git rev-parse shallow2/master &&
+	git fsck
+'
+
+test_done
--=20
1.8.2.83.gc99314b
