From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 20/28] receive-pack: allow pushing with new shallow roots
Date: Mon, 25 Nov 2013 10:55:46 +0700
Message-ID: <1385351754-9954-21-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 25 04:53:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VknEx-0002D8-C7
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 04:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753652Ab3KYDx3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Nov 2013 22:53:29 -0500
Received: from mail-pd0-f178.google.com ([209.85.192.178]:41628 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753647Ab3KYDx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Nov 2013 22:53:27 -0500
Received: by mail-pd0-f178.google.com with SMTP id y10so4643913pdj.9
        for <git@vger.kernel.org>; Sun, 24 Nov 2013 19:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=hLRDAn+p7g51Guq6VEHsfEp3JvMTBcEsuh/CIVw45IE=;
        b=IbkDQvR2NuB6WsBA3bCtbdjPchzvg4kyYru/mGArHyS1W6YJeS8HJyHKExcTafNO24
         EiQmYaDi98dOmjc+uInW8t/44J8ekvviBvHxSr/18ZeIo9B5rK5kQpsTmrMsBjshh2C9
         /NLKh3XjQUkTLnLk8lvXKQGfwMdbGFXeMAkUEsy9Elplq6iUX2Ku3ytjSbUorBTu9Tfu
         EGkFyrwPFJg8GOKEciA/YDis6fQcKhmDRSQ8isJNSgiWS5jPY2OC0cEYOiA7xZneVyAL
         5YCvJG/ms0lJgxV/jvgzyyVkLVRSV5YbSzdQt2iByZoRpMnBLCi9BWSfZbV7/5eGjpmR
         Bflg==
X-Received: by 10.66.250.163 with SMTP id zd3mr25227796pac.109.1385351606669;
        Sun, 24 Nov 2013 19:53:26 -0800 (PST)
Received: from lanh ([115.73.213.240])
        by mx.google.com with ESMTPSA id sy10sm79041518pac.15.2013.11.24.19.53.23
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 24 Nov 2013 19:53:26 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 25 Nov 2013 10:57:59 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238291>

This is more expensive than the current mode and potentially
invalidates caches like pack bitmaps. It's only enabled if
receive.shallowupdate is on.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt |   4 ++
 builtin/receive-pack.c   | 111 +++++++++++++++++++++++++++++++++++++++=
+++++---
 t/t5537-push-shallow.sh  |  16 +++++++
 3 files changed, 125 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ab26963..1a0bd0d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2026,6 +2026,10 @@ receive.updateserverinfo::
 	If set to true, git-receive-pack will run git-update-server-info
 	after receiving data from git-push and updating refs.
=20
+receive.shallowupdate::
+	If set to true, .git/shallow can be updated when new refs
+	require new shallow roots. Otherwise those refs are rejected.
+
 remote.pushdefault::
 	The remote to push to by default.  Overrides
 	`branch.<name>.remote` for all branches, and is overridden by
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 254feff..366ecde 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -43,7 +43,7 @@ static int fix_thin =3D 1;
 static const char *head_name;
 static void *head_name_to_free;
 static int sent_capabilities;
-static int shallow_push;
+static int shallow_push, shallow_update;
 static const char* alternate_shallow_file;
 static struct extra_have_objects shallow;
=20
@@ -124,6 +124,11 @@ static int receive_pack_config(const char *var, co=
nst char *value, void *cb)
 		return 0;
 	}
=20
+	if (strcmp(var, "receive.shallowupdate") =3D=3D 0) {
+		shallow_update =3D git_config_bool(var, value);
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
=20
@@ -191,6 +196,7 @@ struct command {
 	struct command *next;
 	const char *error_string;
 	unsigned int skip_update:1,
+		     checked_connectivity:1,
 		     did_not_exist:1;
 	int index;
 	unsigned char old_sha1[20];
@@ -424,7 +430,44 @@ static void refuse_unconfigured_deny_delete_curren=
t(void)
 		rp_error("%s", refuse_unconfigured_deny_delete_current_msg[i]);
 }
=20
-static const char *update(struct command *cmd)
+static int command_singleton_iterator(void *cb_data, unsigned char sha=
1[20]);
+static int update_ref_shallow(struct command *cmd, uint32_t **used_sha=
llow)
+{
+	static struct lock_file shallow_lock;
+	struct extra_have_objects extra;
+	const char *alt_file;
+	uint32_t mask =3D 1 << (cmd->index % 32);
+	int i;
+
+	memset(&extra, 0, sizeof(extra));
+	for (i =3D 0; i < shallow.nr; i++)
+		if (used_shallow[i] &&
+		    used_shallow[i][cmd->index / 32] & mask)
+			add_extra_have(&extra, shallow.array[i]);
+
+	setup_alternate_shallow(&shallow_lock, &alt_file, &extra);
+	if (check_shallow_connected(command_singleton_iterator,
+				     0, cmd, alt_file)) {
+		rollback_lock_file(&shallow_lock);
+		free(extra.array);
+		return -1;
+	}
+
+	commit_lock_file(&shallow_lock);
+
+	/*
+	 * Make sure setup_alternate_shallow() for the next ref does
+	 * not lose these new roots..
+	 */
+	for (i =3D 0; i < extra.nr; i++)
+		register_shallow(extra.array[i]);
+
+	cmd->checked_connectivity =3D 1;
+	free(extra.array);
+	return 0;
+}
+
+static const char *update(struct command *cmd, uint32_t **used_shallow=
)
 {
 	const char *name =3D cmd->ref_name;
 	struct strbuf namespaced_name_buf =3D STRBUF_INIT;
@@ -532,6 +575,10 @@ static const char *update(struct command *cmd)
 		return NULL; /* good */
 	}
 	else {
+		if (shallow_push && !cmd->checked_connectivity &&
+		    update_ref_shallow(cmd, used_shallow))
+			return "shallow error";
+
 		lock =3D lock_any_ref_for_update(namespaced_name, old_sha1,
 					       0, NULL);
 		if (!lock) {
@@ -678,6 +725,8 @@ static void set_connectivity_errors(struct command =
*commands)
=20
 	for (cmd =3D commands; cmd; cmd =3D cmd->next) {
 		struct command *singleton =3D cmd;
+		if (shallow_push && !cmd->checked_connectivity)
+			continue;
 		if (!check_everything_connected(command_singleton_iterator,
 						0, &singleton))
 			continue;
@@ -691,7 +740,8 @@ static int iterate_receive_command_list(void *cb_da=
ta, unsigned char sha1[20])
 	struct command *cmd =3D *cmd_list;
=20
 	while (cmd) {
-		if (!is_null_sha1(cmd->new_sha1) && !cmd->skip_update) {
+		if (!is_null_sha1(cmd->new_sha1) && !cmd->skip_update &&
+		    (!shallow_push || cmd->checked_connectivity)) {
 			hashcpy(sha1, cmd->new_sha1);
 			*cmd_list =3D cmd->next;
 			return 0;
@@ -733,9 +783,10 @@ static void filter_shallow_refs(struct command *co=
mmands,
=20
 static void execute_commands(struct command *commands, const char *unp=
acker_error)
 {
-	int *ref_status =3D NULL;
+	int *ref_status =3D NULL, checked_connectivity;
 	struct extra_have_objects ref;
 	struct command *cmd;
+	uint32_t **used_shallow =3D NULL;
 	unsigned char sha1[20];
=20
 	if (unpacker_error) {
@@ -754,8 +805,39 @@ static void execute_commands(struct command *comma=
nds, const char *unpacker_erro
 			}
=20
 		ref_status =3D xmalloc(sizeof(*ref_status) * ref.nr);
-		if (mark_new_shallow_refs(&ref, ref_status, NULL, &shallow))
+		if (shallow_update)
+			used_shallow =3D xmalloc(sizeof(*used_shallow) * shallow.nr);
+		if (!mark_new_shallow_refs(&ref, ref_status, used_shallow,
+					   &shallow))
+			shallow_push =3D 0;
+		else if (!shallow_update) {
 			filter_shallow_refs(commands, ref_status, ref.nr);
+			shallow_push =3D 0;
+		}
+	}
+
+	/*
+	 * If shallow_push is still on at this point, we know some of
+	 * the new refs may require extra shallow roots. But we don't
+	 * know yet which ref will be accepted because hooks may
+	 * reject some of them. So we can't add all new shallow roots
+	 * in. Go through ref by ref and only add relevant shallow
+	 * roots right before write_ref_sha1.
+	 */
+	if (shallow_push) {
+		int i;
+		/* keep hooks happy */
+		setenv(GIT_SHALLOW_FILE_ENVIRONMENT, alternate_shallow_file, 1);
+		for (i =3D 0, cmd =3D commands; i < ref.nr; i++, cmd =3D cmd->next) =
{
+			/*
+			 * marker for iterate_receive_command_list.
+			 * All safe refs are run through the next
+			 * check_everything_connected() the rest one
+			 * by one in update()
+			 */
+			cmd->checked_connectivity =3D !ref_status[i];
+			cmd->index =3D i;
+		}
 	}
=20
 	cmd =3D commands;
@@ -778,6 +860,7 @@ static void execute_commands(struct command *comman=
ds, const char *unpacker_erro
 	free(head_name_to_free);
 	head_name =3D head_name_to_free =3D resolve_refdup("HEAD", sha1, 0, N=
ULL);
=20
+	checked_connectivity =3D 1;
 	for (cmd =3D commands; cmd; cmd =3D cmd->next) {
 		if (cmd->error_string)
 			continue;
@@ -785,10 +868,26 @@ static void execute_commands(struct command *comm=
ands, const char *unpacker_erro
 		if (cmd->skip_update)
 			continue;
=20
-		cmd->error_string =3D update(cmd);
+		cmd->error_string =3D update(cmd, used_shallow);
+		if (shallow_push && !cmd->error_string &&
+		    !cmd->checked_connectivity) {
+			error("BUG: connectivity check has not been run on ref %s",
+			      cmd->ref_name);
+			checked_connectivity =3D 0;
+		}
+	}
+
+	if (shallow_push) {
+		if (!checked_connectivity)
+			error("BUG: run 'git fsck' for safety.\n"
+			      "If there are errors, try to remove "
+			      "the reported refs above");
+		if (*alternate_shallow_file)
+			unlink(alternate_shallow_file);
 	}
 	free(ref.array);
 	free(ref_status);
+	free(used_shallow);
 }
=20
 static struct command *read_head_info(void)
diff --git a/t/t5537-push-shallow.sh b/t/t5537-push-shallow.sh
index 650c31a..0084a31 100755
--- a/t/t5537-push-shallow.sh
+++ b/t/t5537-push-shallow.sh
@@ -67,4 +67,20 @@ test_expect_success 'push from shallow clone, with g=
rafted roots' '
 	git fsck
 '
=20
+test_expect_success 'add new shallow root with receive.updateshallow o=
n' '
+	git config receive.shallowupdate true &&
+	(
+	cd shallow2 &&
+	GIT_TRACE=3D2 git push ../.git +master:refs/remotes/shallow2/master
+	) &&
+	git log --format=3D%s shallow2/master >actual &&
+	git fsck &&
+	cat <<EOF >expect &&
+c
+b
+EOF
+	test_cmp expect actual &&
+	git config receive.shallowupdate false
+'
+
 test_done
--=20
1.8.2.83.gc99314b
