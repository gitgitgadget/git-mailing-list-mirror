From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 20/28] receive-pack: allow pushes that update .git/shallow
Date: Thu,  5 Dec 2013 20:02:47 +0700
Message-ID: <1386248575-10206-21-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
 <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 05 14:00:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoYXi-0002hH-OK
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 14:00:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212Ab3LENA3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Dec 2013 08:00:29 -0500
Received: from mail-pd0-f177.google.com ([209.85.192.177]:46017 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932209Ab3LENA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 08:00:27 -0500
Received: by mail-pd0-f177.google.com with SMTP id q10so24243500pdj.8
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 05:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=raQkWXHTrYrTdr37H1F3wVlnHguS6rz+xf9YxIxAjXQ=;
        b=VJyCyaA6Kd0QyUU+VO6Dq4+8nn4ALuuWHmW+Q4ZM93EVn8wAtb54vmliDTSba1tIHX
         7L5v2IvY5tim/7+8zr5SNXy3SnIUs99X5lG7In3vD/U/uXAnSXpwXZ47vYpkPUY+f3jA
         jzR3RM8vC/4JGwLNVr/5PZ3Y5mdNbG1kqMKdWK29DgpZE1lszx+8duXXguL1o4jqNxu1
         QNNnq36JStFXN372awYry+EXum3k9tywvnzGZGBlCdPH1HETq6czcxaF4uKclSCaPqv+
         GI9DAQemnfhygfiQYOxEbXhf5K41VDwLd7I6AnewpeObU1LxS4+isOVOKFMMHZf4EKd5
         jspw==
X-Received: by 10.66.190.198 with SMTP id gs6mr88006133pac.49.1386248425956;
        Thu, 05 Dec 2013 05:00:25 -0800 (PST)
Received: from lanh ([115.73.194.163])
        by mx.google.com with ESMTPSA id ja5sm144090753pbc.14.2013.12.05.05.00.22
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Dec 2013 05:00:25 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 05 Dec 2013 20:05:07 +0700
X-Mailer: git-send-email 1.8.5.1.25.g8667982
In-Reply-To: <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238876>

The basic 8 steps to update .git/shallow does not fully apply here
because the user may choose to accept just a few refs (while fetch
always accepts all refs). The steps are modified a bit.

1-6. same as before. After calling assign_shallow_commits_to_refs at
   step 6, each shallow commit has a bitmap that marks all refs that
   require it.

7. mark all "ours" shallow commits that are reachable from any
   refs. We will need to do the original step 7 on them later.

8. go over all shallow commit bitmaps, mark refs that require new
   shallow commits.

9. setup a strict temporary shallow file to plug all the holes, even
   if it may cut some of our history short. This file is used by all
   hooks. The hooks could use --shallow-file=3D$GIT_DIR/shallow to
   overcome this and reach everything in current repo.

10. go over the new refs one by one. For each ref, do the reachability
   test if it needs a shallow commit on the list from step 7. Remove
   it if it's reachable from our refs. Gather all required shallow
   commits, run check_everything_connected() with the new ref, then
   install them to .git/shallow.

This mode is disabled by default and can be turned on with
receive.shallowupdate

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt |   4 ++
 builtin/receive-pack.c   | 163 +++++++++++++++++++++++++++++++++++++++=
++++----
 commit.h                 |   9 +++
 shallow.c                |  23 +++++++
 t/t5537-push-shallow.sh  |  15 +++++
 5 files changed, 201 insertions(+), 13 deletions(-)

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
index b9de2e8..5c85bb4 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -44,6 +44,7 @@ static int fix_thin =3D 1;
 static const char *head_name;
 static void *head_name_to_free;
 static int sent_capabilities;
+static int shallow_update;
 static const char *alt_shallow_file;
=20
 static enum deny_action parse_deny_action(const char *var, const char =
*value)
@@ -123,6 +124,11 @@ static int receive_pack_config(const char *var, co=
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
@@ -423,7 +429,46 @@ static void refuse_unconfigured_deny_delete_curren=
t(void)
 		rp_error("%s", refuse_unconfigured_deny_delete_current_msg[i]);
 }
=20
-static const char *update(struct command *cmd)
+static int command_singleton_iterator(void *cb_data, unsigned char sha=
1[20]);
+static int update_shallow_ref(struct command *cmd, struct shallow_info=
 *si)
+{
+	static struct lock_file shallow_lock;
+	struct sha1_array extra =3D SHA1_ARRAY_INIT;
+	const char *alt_file;
+	uint32_t mask =3D 1 << (cmd->index % 32);
+	int i;
+
+	trace_printf_key("GIT_TRACE_SHALLOW",
+			 "shallow: update_shallow_ref %s\n", cmd->ref_name);
+	for (i =3D 0; i < si->shallow->nr; i++)
+		if (si->used_shallow[i] &&
+		    (si->used_shallow[i][cmd->index / 32] & mask) &&
+		    !delayed_reachability_test(si, i))
+			sha1_array_append(&extra, si->shallow->sha1[i]);
+
+	setup_alternate_shallow(&shallow_lock, &alt_file, &extra);
+	if (check_shallow_connected(command_singleton_iterator,
+				    0, cmd, alt_file)) {
+		rollback_lock_file(&shallow_lock);
+		sha1_array_clear(&extra);
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
+		register_shallow(extra.sha1[i]);
+
+	si->shallow_ref[cmd->index] =3D 0;
+	sha1_array_clear(&extra);
+	return 0;
+}
+
+static const char *update(struct command *cmd, struct shallow_info *si=
)
 {
 	const char *name =3D cmd->ref_name;
 	struct strbuf namespaced_name_buf =3D STRBUF_INIT;
@@ -531,6 +576,10 @@ static const char *update(struct command *cmd)
 		return NULL; /* good */
 	}
 	else {
+		if (shallow_update && si->shallow_ref[cmd->index] &&
+		    update_shallow_ref(cmd, si))
+			return "shallow error";
+
 		lock =3D lock_any_ref_for_update(namespaced_name, old_sha1,
 					       0, NULL);
 		if (!lock) {
@@ -671,12 +720,16 @@ static int command_singleton_iterator(void *cb_da=
ta, unsigned char sha1[20])
 	return 0;
 }
=20
-static void set_connectivity_errors(struct command *commands)
+static void set_connectivity_errors(struct command *commands,
+				    struct shallow_info *si)
 {
 	struct command *cmd;
=20
 	for (cmd =3D commands; cmd; cmd =3D cmd->next) {
 		struct command *singleton =3D cmd;
+		if (shallow_update && si->shallow_ref[cmd->index])
+			/* to be checked in update_shallow_ref() */
+			continue;
 		if (!check_everything_connected(command_singleton_iterator,
 						0, &singleton))
 			continue;
@@ -684,18 +737,26 @@ static void set_connectivity_errors(struct comman=
d *commands)
 	}
 }
=20
+struct iterate_data {
+	struct command *cmds;
+	struct shallow_info *si;
+};
+
 static int iterate_receive_command_list(void *cb_data, unsigned char s=
ha1[20])
 {
-	struct command **cmd_list =3D cb_data;
+	struct iterate_data *data =3D cb_data;
+	struct command **cmd_list =3D &data->cmds;
 	struct command *cmd =3D *cmd_list;
=20
-	while (cmd) {
+	for (; cmd; cmd =3D cmd->next) {
+		if (shallow_update && data->si->shallow_ref[cmd->index])
+			/* to be checked in update_shallow_ref() */
+			continue;
 		if (!is_null_sha1(cmd->new_sha1) && !cmd->skip_update) {
 			hashcpy(sha1, cmd->new_sha1);
 			*cmd_list =3D cmd->next;
 			return 0;
 		}
-		cmd =3D cmd->next;
 	}
 	*cmd_list =3D NULL;
 	return -1; /* end of list */
@@ -715,10 +776,14 @@ static void reject_updates_to_hidden(struct comma=
nd *commands)
 	}
 }
=20
-static void execute_commands(struct command *commands, const char *unp=
acker_error)
+static void execute_commands(struct command *commands,
+			     const char *unpacker_error,
+			     struct shallow_info *si)
 {
+	int checked_connectivity;
 	struct command *cmd;
 	unsigned char sha1[20];
+	struct iterate_data data;
=20
 	if (unpacker_error) {
 		for (cmd =3D commands; cmd; cmd =3D cmd->next)
@@ -726,10 +791,10 @@ static void execute_commands(struct command *comm=
ands, const char *unpacker_erro
 		return;
 	}
=20
-	cmd =3D commands;
-	if (check_everything_connected(iterate_receive_command_list,
-				       0, &cmd))
-		set_connectivity_errors(commands);
+	data.cmds =3D commands;
+	data.si =3D si;
+	if (check_everything_connected(iterate_receive_command_list, 0, &data=
))
+		set_connectivity_errors(commands, si);
=20
 	reject_updates_to_hidden(commands);
=20
@@ -746,6 +811,7 @@ static void execute_commands(struct command *comman=
ds, const char *unpacker_erro
 	free(head_name_to_free);
 	head_name =3D head_name_to_free =3D resolve_refdup("HEAD", sha1, 0, N=
ULL);
=20
+	checked_connectivity =3D 1;
 	for (cmd =3D commands; cmd; cmd =3D cmd->next) {
 		if (cmd->error_string)
 			continue;
@@ -753,7 +819,22 @@ static void execute_commands(struct command *comma=
nds, const char *unpacker_erro
 		if (cmd->skip_update)
 			continue;
=20
-		cmd->error_string =3D update(cmd);
+		cmd->error_string =3D update(cmd, si);
+		if (shallow_update && !cmd->error_string &&
+		    si->shallow_ref[cmd->index]) {
+			error("BUG: connectivity check has not been run on ref %s",
+			      cmd->ref_name);
+			checked_connectivity =3D 0;
+		}
+	}
+
+	if (shallow_update) {
+		if (!checked_connectivity)
+			error("BUG: run 'git fsck' for safety.\n"
+			      "If there are errors, try to remove "
+			      "the reported refs above");
+		if (alt_shallow_file && *alt_shallow_file)
+			unlink(alt_shallow_file);
 	}
 }
=20
@@ -924,6 +1005,53 @@ static const char *unpack_with_sideband(struct sh=
allow_info *si)
 	return ret;
 }
=20
+static void prepare_shallow_update(struct command *commands,
+				   struct shallow_info *si)
+{
+	int i, j, k, bitmap_size =3D (si->ref->nr + 31) / 32;
+
+	si->used_shallow =3D xmalloc(sizeof(*si->used_shallow) *
+				   si->shallow->nr);
+	assign_shallow_commits_to_refs(si, si->used_shallow, NULL);
+
+	si->need_reachability_test =3D
+		xcalloc(si->shallow->nr, sizeof(*si->need_reachability_test));
+	si->reachable =3D
+		xcalloc(si->shallow->nr, sizeof(*si->reachable));
+	si->shallow_ref =3D xcalloc(si->ref->nr, sizeof(*si->shallow_ref));
+
+	for (i =3D 0; i < si->nr_ours; i++)
+		si->need_reachability_test[si->ours[i]] =3D 1;
+
+	for (i =3D 0; i < si->shallow->nr; i++) {
+		if (!si->used_shallow[i])
+			continue;
+		for (j =3D 0; j < bitmap_size; j++) {
+			if (!si->used_shallow[i][j])
+				continue;
+			si->need_reachability_test[i]++;
+			for (k =3D 0; k < 32; k++)
+				if (si->used_shallow[i][j] & (1 << k))
+					si->shallow_ref[j * 32 + k]++;
+		}
+
+		/*
+		 * true for those associated with some refs and belong
+		 * in "ours" list aka "step 7 not done yet"
+		 */
+		si->need_reachability_test[i] =3D
+			si->need_reachability_test[i] > 1;
+	}
+
+	/*
+	 * keep hooks happy by forcing a temporary shallow file via
+	 * env variable because we can't add --shallow-file to every
+	 * command. check_everything_connected() will be done with
+	 * true .git/shallow though.
+	 */
+	setenv(GIT_SHALLOW_FILE_ENVIRONMENT, alt_shallow_file, 1);
+}
+
 static void update_shallow_info(struct command *commands,
 				struct shallow_info *si,
 				struct sha1_array *ref)
@@ -932,8 +1060,10 @@ static void update_shallow_info(struct command *c=
ommands,
 	int *ref_status;
 	remove_nonexistent_theirs_shallow(si);
 	/* XXX remove_nonexistent_ours_in_pack() */
-	if (!si->nr_ours && !si->nr_theirs)
+	if (!si->nr_ours && !si->nr_theirs) {
+		shallow_update =3D 0;
 		return;
+	}
=20
 	for (cmd =3D commands; cmd; cmd =3D cmd->next) {
 		if (is_null_sha1(cmd->new_sha1))
@@ -943,6 +1073,11 @@ static void update_shallow_info(struct command *c=
ommands,
 	}
 	si->ref =3D ref;
=20
+	if (shallow_update) {
+		prepare_shallow_update(commands, si);
+		return;
+	}
+
 	ref_status =3D xmalloc(sizeof(*ref_status) * ref->nr);
 	assign_shallow_commits_to_refs(si, NULL, ref_status);
 	for (cmd =3D commands; cmd; cmd =3D cmd->next) {
@@ -1064,11 +1199,13 @@ int cmd_receive_pack(int argc, const char **arg=
v, const char *prefix)
 		const char *unpack_status =3D NULL;
=20
 		prepare_shallow_info(&si, &shallow);
+		if (!si.nr_ours && !si.nr_theirs)
+			shallow_update =3D 0;
 		if (!delete_only(commands)) {
 			unpack_status =3D unpack_with_sideband(&si);
 			update_shallow_info(commands, &si, &ref);
 		}
-		execute_commands(commands, unpack_status);
+		execute_commands(commands, unpack_status, &si);
 		if (pack_lockfile)
 			unlink_or_warn(pack_lockfile);
 		if (report_status)
diff --git a/commit.h b/commit.h
index 79649ef..a1f2d49 100644
--- a/commit.h
+++ b/commit.h
@@ -216,6 +216,14 @@ struct shallow_info {
 	int *ours, nr_ours;
 	int *theirs, nr_theirs;
 	struct sha1_array *ref;
+
+	/* for receive-pack */
+	uint32_t **used_shallow;
+	int *need_reachability_test;
+	int *reachable;
+	int *shallow_ref;
+	struct commit **commits;
+	int nr_commits;
 };
=20
 extern void prepare_shallow_info(struct shallow_info *, struct sha1_ar=
ray *);
@@ -226,6 +234,7 @@ extern void remove_nonexistent_ours_in_pack(struct =
shallow_info *,
 extern void assign_shallow_commits_to_refs(struct shallow_info *info,
 					   uint32_t **used,
 					   int *ref_status);
+extern int delayed_reachability_test(struct shallow_info *si, int c);
=20
 int is_descendant_of(struct commit *, struct commit_list *);
 int in_merge_bases(struct commit *, struct commit *);
diff --git a/shallow.c b/shallow.c
index 5710690..e611639 100644
--- a/shallow.c
+++ b/shallow.c
@@ -618,3 +618,26 @@ static void post_assign_shallow(struct shallow_inf=
o *info,
=20
 	free(ca.commits);
 }
+
+/* (Delayed) step 7, reachability test at commit level */
+int delayed_reachability_test(struct shallow_info *si, int c)
+{
+	if (si->need_reachability_test[c]) {
+		struct commit *commit =3D lookup_commit(si->shallow->sha1[c]);
+
+		if (!si->commits) {
+			struct commit_array ca;
+			memset(&ca, 0, sizeof(ca));
+			head_ref(add_ref, &ca);
+			for_each_ref(add_ref, &ca);
+			si->commits =3D ca.commits;
+			si->nr_commits =3D ca.nr;
+		}
+
+		si->reachable[c] =3Din_merge_bases_many(commit,
+						       si->nr_commits,
+						       si->commits);
+		si->need_reachability_test[c] =3D 0;
+	}
+	return si->reachable[c];
+}
diff --git a/t/t5537-push-shallow.sh b/t/t5537-push-shallow.sh
index 650c31a..ff5eb5b 100755
--- a/t/t5537-push-shallow.sh
+++ b/t/t5537-push-shallow.sh
@@ -67,4 +67,19 @@ test_expect_success 'push from shallow clone, with g=
rafted roots' '
 	git fsck
 '
=20
+test_expect_success 'add new shallow root with receive.updateshallow o=
n' '
+	test_config receive.shallowupdate true &&
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
 test_done
--=20
1.8.5.1.25.g8667982
