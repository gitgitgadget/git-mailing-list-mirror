From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 17/28] receive/send-pack: support pushing from a shallow clone
Date: Thu,  5 Dec 2013 20:02:44 +0700
Message-ID: <1386248575-10206-18-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
 <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 05 14:00:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoYXM-0002S2-V7
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 14:00:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197Ab3LENAG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Dec 2013 08:00:06 -0500
Received: from mail-pb0-f48.google.com ([209.85.160.48]:33191 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299Ab3LENAE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 08:00:04 -0500
Received: by mail-pb0-f48.google.com with SMTP id md12so25714727pbc.21
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 05:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=bJm3+u0gculj3Ux5sIfCR842ltNcLaspYNmjmiSZy+I=;
        b=crPOvusq3ZbFgtdGCvcgKgRKPJWuZC5s+aPZmXxr7lpzqM6Iu/6itH1SBD7oe1ouer
         nrBS6agC0kTEIVVwz155/r2l3EW3b4hYS/FNMMW+vK1rVuF72PqBRVWeOVr6e5vdVmqY
         4zPJVxhZHlOXfKbJmhszI8V8bp9K956+PwABqTMGXO+DcXUmV+VPnOj8ZqACcz9o8Xy/
         nPLvQaTYGTVyORLFqZRAGvjQHMBaHhvhezkH9oIW+NT4SwPbybPqqMWblJqL8lf3LA82
         ZFloleC1FTR9w5doQWE/CZ5OE8HFu5URwSiqaeYeQQQ19MCsw09ACBcwOsfInEqYQCfg
         4xsA==
X-Received: by 10.66.136.101 with SMTP id pz5mr69431895pab.118.1386248403874;
        Thu, 05 Dec 2013 05:00:03 -0800 (PST)
Received: from lanh ([115.73.194.163])
        by mx.google.com with ESMTPSA id de1sm144622871pbc.7.2013.12.05.05.00.00
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Dec 2013 05:00:03 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 05 Dec 2013 20:04:46 +0700
X-Mailer: git-send-email 1.8.5.1.25.g8667982
In-Reply-To: <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238873>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/technical/pack-protocol.txt |  4 +-
 builtin/receive-pack.c                    | 78 +++++++++++++++++++++++=
++++----
 builtin/send-pack.c                       |  2 +-
 send-pack.c                               |  3 ++
 t/t5537-push-shallow.sh (new +x)          | 70 +++++++++++++++++++++++=
++++
 5 files changed, 146 insertions(+), 11 deletions(-)
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
index 8927ddf..b9de2e8 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -44,6 +44,7 @@ static int fix_thin =3D 1;
 static const char *head_name;
 static void *head_name_to_free;
 static int sent_capabilities;
+static const char *alt_shallow_file;
=20
 static enum deny_action parse_deny_action(const char *var, const char =
*value)
 {
@@ -190,6 +191,7 @@ struct command {
 	const char *error_string;
 	unsigned int skip_update:1,
 		     did_not_exist:1;
+	int index;
 	unsigned char old_sha1[20];
 	unsigned char new_sha1[20];
 	char ref_name[FLEX_ARRAY]; /* more */
@@ -688,7 +690,7 @@ static int iterate_receive_command_list(void *cb_da=
ta, unsigned char sha1[20])
 	struct command *cmd =3D *cmd_list;
=20
 	while (cmd) {
-		if (!is_null_sha1(cmd->new_sha1)) {
+		if (!is_null_sha1(cmd->new_sha1) && !cmd->skip_update) {
 			hashcpy(sha1, cmd->new_sha1);
 			*cmd_list =3D cmd->next;
 			return 0;
@@ -755,7 +757,7 @@ static void execute_commands(struct command *comman=
ds, const char *unpacker_erro
 	}
 }
=20
-static struct command *read_head_info(void)
+static struct command *read_head_info(struct sha1_array *shallow)
 {
 	struct command *commands =3D NULL;
 	struct command **p =3D &commands;
@@ -769,6 +771,14 @@ static struct command *read_head_info(void)
 		line =3D packet_read_line(0, &len);
 		if (!line)
 			break;
+
+		if (len =3D=3D 48 && !prefixcmp(line, "shallow ")) {
+			if (get_sha1_hex(line + 8, old_sha1))
+				die("protocol error: expected shallow sha, got '%s'", line + 8);
+			sha1_array_append(shallow, old_sha1);
+			continue;
+		}
+
 		if (len < 83 ||
 		    line[40] !=3D ' ' ||
 		    line[81] !=3D ' ' ||
@@ -820,7 +830,7 @@ static const char *parse_pack_header(struct pack_he=
ader *hdr)
=20
 static const char *pack_lockfile;
=20
-static const char *unpack(int err_fd)
+static const char *unpack(int err_fd, struct shallow_info *si)
 {
 	struct pack_header hdr;
 	struct argv_array av =3D ARGV_ARRAY_INIT;
@@ -844,6 +854,11 @@ static const char *unpack(int err_fd)
 			"--pack_header=3D%"PRIu32",%"PRIu32,
 			ntohl(hdr.hdr_version), ntohl(hdr.hdr_entries));
=20
+	if (si->nr_ours || si->nr_theirs) {
+		alt_shallow_file =3D setup_temporary_shallow(si->shallow);
+		argv_array_pushl(&av, "--shallow-file", alt_shallow_file, NULL);
+	}
+
 	memset(&child, 0, sizeof(child));
 	if (ntohl(hdr.hdr_entries) < unpack_limit) {
 		argv_array_pushl(&av, "unpack-objects", hdr_arg, NULL);
@@ -889,13 +904,13 @@ static const char *unpack(int err_fd)
 	return NULL;
 }
=20
-static const char *unpack_with_sideband(void)
+static const char *unpack_with_sideband(struct shallow_info *si)
 {
 	struct async muxer;
 	const char *ret;
=20
 	if (!use_sideband)
-		return unpack(0);
+		return unpack(0, si);
=20
 	memset(&muxer, 0, sizeof(muxer));
 	muxer.proc =3D copy_to_sideband;
@@ -903,12 +918,48 @@ static const char *unpack_with_sideband(void)
 	if (start_async(&muxer))
 		return NULL;
=20
-	ret =3D unpack(muxer.in);
+	ret =3D unpack(muxer.in, si);
=20
 	finish_async(&muxer);
 	return ret;
 }
=20
+static void update_shallow_info(struct command *commands,
+				struct shallow_info *si,
+				struct sha1_array *ref)
+{
+	struct command *cmd;
+	int *ref_status;
+	remove_nonexistent_theirs_shallow(si);
+	/* XXX remove_nonexistent_ours_in_pack() */
+	if (!si->nr_ours && !si->nr_theirs)
+		return;
+
+	for (cmd =3D commands; cmd; cmd =3D cmd->next) {
+		if (is_null_sha1(cmd->new_sha1))
+			continue;
+		sha1_array_append(ref, cmd->new_sha1);
+		cmd->index =3D ref->nr - 1;
+	}
+	si->ref =3D ref;
+
+	ref_status =3D xmalloc(sizeof(*ref_status) * ref->nr);
+	assign_shallow_commits_to_refs(si, NULL, ref_status);
+	for (cmd =3D commands; cmd; cmd =3D cmd->next) {
+		if (is_null_sha1(cmd->new_sha1))
+			continue;
+		if (ref_status[cmd->index]) {
+			cmd->error_string =3D "shallow update not allowed";
+			cmd->skip_update =3D 1;
+		}
+	}
+	if (alt_shallow_file && *alt_shallow_file) {
+		unlink(alt_shallow_file);
+		alt_shallow_file =3D NULL;
+	}
+	free(ref_status);
+}
+
 static void report(struct command *commands, const char *unpack_status=
)
 {
 	struct command *cmd;
@@ -950,6 +1001,9 @@ int cmd_receive_pack(int argc, const char **argv, =
const char *prefix)
 	int i;
 	char *dir =3D NULL;
 	struct command *commands;
+	struct sha1_array shallow =3D SHA1_ARRAY_INIT;
+	struct sha1_array ref =3D SHA1_ARRAY_INIT;
+	struct shallow_info si;
=20
 	packet_trace_identity("receive-pack");
=20
@@ -1006,11 +1060,14 @@ int cmd_receive_pack(int argc, const char **arg=
v, const char *prefix)
 	if (advertise_refs)
 		return 0;
=20
-	if ((commands =3D read_head_info()) !=3D NULL) {
+	if ((commands =3D read_head_info(&shallow)) !=3D NULL) {
 		const char *unpack_status =3D NULL;
=20
-		if (!delete_only(commands))
-			unpack_status =3D unpack_with_sideband();
+		prepare_shallow_info(&si, &shallow);
+		if (!delete_only(commands)) {
+			unpack_status =3D unpack_with_sideband(&si);
+			update_shallow_info(commands, &si, &ref);
+		}
 		execute_commands(commands, unpack_status);
 		if (pack_lockfile)
 			unlink_or_warn(pack_lockfile);
@@ -1027,8 +1084,11 @@ int cmd_receive_pack(int argc, const char **argv=
, const char *prefix)
 		}
 		if (auto_update_server_info)
 			update_server_info(0);
+		clear_shallow_info(&si);
 	}
 	if (use_sideband)
 		packet_flush(1);
+	sha1_array_clear(&shallow);
+	sha1_array_clear(&ref);
 	return 0;
 }
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 62cc4d3..ea2ab28 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -208,7 +208,7 @@ int cmd_send_pack(int argc, const char **argv, cons=
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
index 14005fa..cd536b4 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -214,6 +214,9 @@ int send_pack(struct send_pack_args *args,
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
1.8.5.1.25.g8667982
