From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 3/8] upload/receive-pack: allow hiding ref hierarchies
Date: Wed, 30 Jan 2013 10:45:37 -0800
Message-ID: <1359571542-19852-4-git-send-email-gitster@pobox.com>
References: <1359571542-19852-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 30 19:46:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0cg4-0004fU-8z
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 19:46:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756673Ab3A3Sp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 13:45:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33697 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756655Ab3A3Spv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 13:45:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92A0DC401;
	Wed, 30 Jan 2013 13:45:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=6K8W
	W0KDMQQqzCzkMOfpmk5N/ds=; b=CwzaatiR6GI651dZn6HBWLZ5M91Hps1cBU1q
	wRJ89HT4qpqH7rjh/hHCsfr5x2BIzfGxSqvi5yAsMeENHcGW62HSvUycSEHTwst2
	+CR7AoaigSdyEeVnJwuhHC3aXg6B76piWXw8lKUkCsa1ulHCA2QeY6hE1SUmRA6W
	rtqgXIU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	T4rvK8Ad47E0h6E8CDcK7SBhdW9nwy2LNex5QOFttYLp1+SGV3g+2N8U6acPmN/H
	fGeTlvIAD0ao4H0+a65RH9D/l/gIeM76T2KWbJyL5CPtjNNdanqSKY9WU3YcPJXA
	TFgcVtimA3qs5/tbKCdiK0AuzN6xwn1USHGg3jCSJk0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88123C400;
	Wed, 30 Jan 2013 13:45:50 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 94D35C3FE; Wed, 30 Jan 2013
 13:45:49 -0500 (EST)
X-Mailer: git-send-email 1.8.1.2.589.ga9b91ac
In-Reply-To: <1359571542-19852-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 441EF42E-6B0D-11E2-BD9B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215052>

Teach upload-pack and receive-pack to omit some refs from their
initial advertisements by paying attention to the transfer.hiderefs
multi-valued configuration variable.  Any ref that is under the
hierarchies listed on the value of this variable is excluded from
responses to requests made by "ls-remote", "fetch", "clone", "push",
etc.

A typical use case may be

	[transfer]
		hiderefs = refs/pull

to hide the refs that are internally used by the hosting site and
should not be exposed over the network.

Because these hidden refs do not count as OUR_REF, an attempt to
fetch objects at the tip of them will be rejected, and because these
refs do not get advertised, "git push :" will not see local branches
that have the same name as them as "matching" ones to be sent.

An attempt to update/delete these hidden refs with an explicit
refspec, e.g. "git push origin :refs/pull/11/head", is rejected.

This is not a new restriction.  To the pusher, it would appear that
there is no such ref, so its push request will conclude with "Now
that I sent you all the data, it is time for you to update the refs.
I saw that the ref did not exist when I started pushing, and I want
the result to point at this commit".  The receiving end will apply
the compare-and-swap rule to this request and rejects the push with
"Well, your update request conflicts with somebody else; I see there
is such a ref.", which is the right thing to do. Otherwise a push to
a hidden ref will always be "the last one wins", which is not a good
default.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt | 11 +++++++++++
 builtin/receive-pack.c   | 24 ++++++++++++++++++++++++
 refs.c                   | 41 +++++++++++++++++++++++++++++++++++++++++
 refs.h                   |  3 +++
 t/t5512-ls-remote.sh     |  9 +++++++++
 t/t5516-fetch-push.sh    | 24 ++++++++++++++++++++++++
 upload-pack.c            | 14 +++++++++++++-
 7 files changed, 125 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ef45c99..f57c802 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2057,6 +2057,17 @@ transfer.fsckObjects::
 	not set, the value of this variable is used instead.
 	Defaults to false.
 
+transfer.hiderefs::
+	String(s) `upload-pack` and `receive-pack` use to decide
+	which refs to omit from their initial advertisement.  Use
+	more than one transfer.hiderefs configuration variables to
+	specify multiple prefix strings. A ref that are under the
+	hierarchies listed on the value of this variable is excluded,
+	and is hidden from `git ls-remote`, `git fetch`, `git push :`,
+	etc.  An attempt to update or delete a hidden ref by `git push`
+	is rejected, and an attempt to fetch a hidden ref by `git fetch`
+	will fail.
+
 transfer.unpackLimit::
 	When `fetch.unpackLimit` or `receive.unpackLimit` are
 	not set, the value of this variable is used instead.
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index ff781fe..a8248d9 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -59,6 +59,11 @@ static enum deny_action parse_deny_action(const char *var, const char *value)
 
 static int receive_pack_config(const char *var, const char *value, void *cb)
 {
+	int status = parse_hide_refs_config(var, value, cb);
+
+	if (status)
+		return status;
+
 	if (strcmp(var, "receive.denydeletes") == 0) {
 		deny_deletes = git_config_bool(var, value);
 		return 0;
@@ -119,6 +124,9 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 
 static void show_ref(const char *path, const unsigned char *sha1)
 {
+	if (ref_is_hidden(path))
+		return;
+
 	if (sent_capabilities)
 		packet_write(1, "%s %s\n", sha1_to_hex(sha1), path);
 	else
@@ -688,6 +696,20 @@ static int iterate_receive_command_list(void *cb_data, unsigned char sha1[20])
 	return -1; /* end of list */
 }
 
+static void reject_updates_to_hidden(struct command *commands)
+{
+	struct command *cmd;
+
+	for (cmd = commands; cmd; cmd = cmd->next) {
+		if (cmd->error_string || !ref_is_hidden(cmd->ref_name))
+			continue;
+		if (is_null_sha1(cmd->new_sha1))
+			cmd->error_string = "deny deleting a hidden ref";
+		else
+			cmd->error_string = "deny updating a hidden ref";
+	}
+}
+
 static void execute_commands(struct command *commands, const char *unpacker_error)
 {
 	struct command *cmd;
@@ -704,6 +726,8 @@ static void execute_commands(struct command *commands, const char *unpacker_erro
 				       0, &cmd))
 		set_connectivity_errors(commands);
 
+	reject_updates_to_hidden(commands);
+
 	if (run_receive_hook(commands, pre_receive_hook, 0)) {
 		for (cmd = commands; cmd; cmd = cmd->next) {
 			if (!cmd->error_string)
diff --git a/refs.c b/refs.c
index 541fec2..e3574ca 100644
--- a/refs.c
+++ b/refs.c
@@ -3,6 +3,7 @@
 #include "object.h"
 #include "tag.h"
 #include "dir.h"
+#include "string-list.h"
 
 /*
  * Make sure "ref" is something reasonable to have under ".git/refs/";
@@ -2556,3 +2557,43 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 	free(short_name);
 	return xstrdup(refname);
 }
+
+static struct string_list *hide_refs;
+
+int parse_hide_refs_config(const char *var, const char *value, void *unused)
+{
+	if (!strcmp("transfer.hiderefs", var)) {
+		char *ref;
+		int len;
+
+		if (!value)
+			return config_error_nonbool(var);
+		ref = xstrdup(value);
+		len = strlen(ref);
+		while (len && ref[len - 1] == '/')
+			ref[--len] = '\0';
+		if (!hide_refs) {
+			hide_refs = xcalloc(1, sizeof(*hide_refs));
+			hide_refs->strdup_strings = 1;
+		}
+		string_list_append(hide_refs, ref);
+	}
+	return 0;
+}
+
+int ref_is_hidden(const char *refname)
+{
+	struct string_list_item *item;
+
+	if (!hide_refs)
+		return 0;
+	for_each_string_list_item(item, hide_refs) {
+		int len;
+		if (prefixcmp(refname, item->string))
+			continue;
+		len = strlen(item->string);
+		if (!refname[len] || refname[len] == '/')
+			return 1;
+	}
+	return 0;
+}
diff --git a/refs.h b/refs.h
index d6c2fe2..50b233f 100644
--- a/refs.h
+++ b/refs.h
@@ -147,4 +147,7 @@ int update_ref(const char *action, const char *refname,
 		const unsigned char *sha1, const unsigned char *oldval,
 		int flags, enum action_on_err onerr);
 
+extern int parse_hide_refs_config(const char *var, const char *value, void *);
+extern int ref_is_hidden(const char *);
+
 #endif /* REFS_H */
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index d16e5d3..d0702ed 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -126,4 +126,13 @@ test_expect_success 'Report match with --exit-code' '
 	test_cmp expect actual
 '
 
+test_expect_success 'Hide some refs' '
+	test_config transfer.hiderefs refs/tags &&
+	git ls-remote . >actual &&
+	test_unconfig transfer.hiderefs &&
+	git ls-remote . |
+	sed -e "/	refs\/tags\//d" >expect &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 6009372..852efb6 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1037,4 +1037,28 @@ test_expect_success 'push --prune refspec' '
 	! check_push_result $the_first_commit tmp/foo tmp/bar
 '
 
+test_expect_success 'push to update a hidden ref' '
+	mk_test heads/master hidden/one hidden/two hidden/three &&
+	(
+		cd testrepo &&
+		git config transfer.hiderefs refs/hidden
+	) &&
+
+	# push to unhidden ref succeeds normally
+	git push testrepo master:refs/heads/master &&
+	check_push_result $the_commit heads/master &&
+
+	# push to update a hidden ref should fail
+	test_must_fail git push testrepo master:refs/hidden/one &&
+	check_push_result $the_first_commit hidden/one &&
+
+	# push to delete a hidden ref should fail
+	test_must_fail git push testrepo :refs/hidden/two &&
+	check_push_result $the_first_commit hidden/two &&
+
+	# idempotent push to update a hidden ref should fail
+	test_must_fail git push testrepo $the_first_commit:refs/hidden/three &&
+	check_push_result $the_first_commit hidden/three
+'
+
 test_done
diff --git a/upload-pack.c b/upload-pack.c
index 3a26a7b..6b10843 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -12,6 +12,7 @@
 #include "run-command.h"
 #include "sigchain.h"
 #include "version.h"
+#include "string-list.h"
 
 static const char upload_pack_usage[] = "git upload-pack [--strict] [--timeout=<n>] <dir>";
 
@@ -719,9 +720,13 @@ static void receive_needs(void)
 	free(shallows.objects);
 }
 
+/* return non-zero if the ref is hidden, otherwise 0 */
 static int mark_our_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
 	struct object *o = lookup_unknown_object(sha1);
+
+	if (ref_is_hidden(refname))
+		return 1;
 	if (!o)
 		die("git upload-pack: cannot find object %s:", sha1_to_hex(sha1));
 	o->flags |= OUR_REF;
@@ -736,7 +741,8 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 	const char *refname_nons = strip_namespace(refname);
 	unsigned char peeled[20];
 
-	mark_our_ref(refname, sha1, flag, cb_data);
+	if (mark_our_ref(refname, sha1, flag, cb_data))
+		return 0;
 
 	if (capabilities)
 		packet_write(1, "%s %s%c%s%s agent=%s\n",
@@ -773,6 +779,11 @@ static void upload_pack(void)
 	}
 }
 
+static int upload_pack_config(const char *var, const char *value, void *unused)
+{
+	return parse_hide_refs_config(var, value, unused);
+}
+
 int main(int argc, char **argv)
 {
 	char *dir;
@@ -824,6 +835,7 @@ int main(int argc, char **argv)
 		die("'%s' does not appear to be a git repository", dir);
 	if (is_repository_shallow())
 		die("attempt to fetch/clone from a shallow repository");
+	git_config(upload_pack_config, NULL);
 	if (getenv("GIT_DEBUG_SEND_PACK"))
 		debug_fd = atoi(getenv("GIT_DEBUG_SEND_PACK"));
 	upload_pack();
-- 
1.8.1.2.589.ga9b91ac
