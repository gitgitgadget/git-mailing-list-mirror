From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/3] upload-pack: allow hiding ref hiearchies
Date: Mon, 28 Jan 2013 16:13:31 -0800
Message-ID: <1359418412-26602-3-git-send-email-gitster@pobox.com>
References: <1359418412-26602-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 29 01:14:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzypz-0005Uz-CI
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 01:14:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640Ab3A2ANn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 19:13:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52377 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751380Ab3A2ANk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 19:13:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 289B6C7F5
	for <git@vger.kernel.org>; Mon, 28 Jan 2013 19:13:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=KCrQ
	jcgeAWoAhCvbDNkPYgbgoeE=; b=wIVDGI/J835/6yqM4TukZezaTx2MoedRP/Hw
	6io3i2CDZucxjtzNWoU2WliiyeqWHTYMwwPACTHtl77FsT/meBnIEKCR4hznFUb3
	FNqeLcNrBwJ9AycECJGxc9r+Fw9+VAdI+SjpitlwAICwtSBMtc8CVPezqZchYRm0
	C6o9bYI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=iVw+fn
	3tIbraqb15E84loOLmzhITx2eeGnogsjJwkWGoHsIkAIp+EC7npc692amJIPT/hb
	KItjC80cjpuTNL3UjKqKjYBvzsJDSYWOcZ/vvmqlUQxJ2qoxtEZHXyI85eX7V5lL
	GogatIjIXvOWm6kJ6U9WWnQ6ukJSRb6uhGoy0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DF8BC7F4
	for <git@vger.kernel.org>; Mon, 28 Jan 2013 19:13:40 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 34D52C7F3 for
 <git@vger.kernel.org>; Mon, 28 Jan 2013 19:13:38 -0500 (EST)
X-Mailer: git-send-email 1.8.1.2.548.g0e4986f
In-Reply-To: <1359418412-26602-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: BAB2B532-69A8-11E2-9423-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214890>

Teach upload-pack to omit some refs from the initial advertisement
by introducing the uploadPack.hiderefs multivalued configuration
variable.  Any ref that is under the hierarchies listed on the value
of this variable is excluded from responses to "ls-remote", "fetch"
or "clone" requests.  One typical use case may be

	[uploadPack]
		hiderefs = refs/changes

Note that the underlying protocol still allows a request to fetch
objects at the tip of any ref, including the hidden ones, but on the
client side (e.g. fetch-pack), the requests are checked against the
ls-remote response, so it cannot ask for refs/changes/14/432432, or
for the object name (which is what eventually goes over the wire on
"want" line) the user may obtain out of band (e.g. Gerrit dashboard).
A new capability "allow-tip-sha1-in-want" is returned by upload-pack
to signal updated clients that it may be OK to ask for objects that
were not advertised.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt |  8 ++++++++
 builtin/receive-pack.c   |  8 ++++++++
 refs.c                   | 41 +++++++++++++++++++++++++++++++++++++++++
 refs.h                   |  3 +++
 t/t5512-ls-remote.sh     |  9 +++++++++
 upload-pack.c            | 25 +++++++++++++++++++++++--
 6 files changed, 92 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ef45c99..8e2853e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2057,6 +2057,14 @@ transfer.fsckObjects::
 	not set, the value of this variable is used instead.
 	Defaults to false.
 
+transfer.hiderefs::
+	String(s) `upload-pack` and `receive-pack` use to decide
+	which refs to omit from their initial advertisement.  Use
+	more than one transfer.hiderefs configuration variables to
+	specify multiple prefix strings. A ref that has one of these
+	strings as its prefix is excluded, and is hidden from
+	`git clone --mirror` and `git push :`.
+
 transfer.unpackLimit::
 	When `fetch.unpackLimit` or `receive.unpackLimit` are
 	not set, the value of this variable is used instead.
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index ff781fe..5ed40be 100644
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
diff --git a/upload-pack.c b/upload-pack.c
index 3dd220d..31ce954 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -12,6 +12,7 @@
 #include "run-command.h"
 #include "sigchain.h"
 #include "version.h"
+#include "string-list.h"
 
 static const char upload_pack_usage[] = "git upload-pack [--strict] [--timeout=<n>] <dir>";
 
@@ -28,10 +29,12 @@ static const char upload_pack_usage[] = "git upload-pack [--strict] [--timeout=<
 
 static unsigned long oldest_have;
 
-static int multi_ack, nr_our_refs;
+static int multi_ack;
+static int nr_our_refs; /* This counts both advertised and unadvertised */
 static int no_done;
 static int use_thin_pack, use_ofs_delta, use_include_tag;
 static int no_progress, daemon_mode;
+static int allow_tip_sha1_in_want;
 static int shallow_nr;
 static struct object_array have_obj;
 static struct object_array want_obj;
@@ -743,11 +746,14 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 	unsigned char peeled[20];
 
 	mark_our_ref(refname, sha1, flag, cb_data);
+	if (ref_is_hidden(refname))
+		return 0;
 
 	if (capabilities)
-		packet_write(1, "%s %s%c%s%s agent=%s\n",
+		packet_write(1, "%s %s%c%s%s%s agent=%s\n",
 			     sha1_to_hex(sha1), refname_nons,
 			     0, capabilities,
+			     allow_tip_sha1_in_want ? " allow-tip-sha1-in-want" : "",
 			     stateless_rpc ? " no-done" : "",
 			     git_user_agent_sanitized());
 	else
@@ -758,11 +764,20 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 	return 0;
 }
 
+static int check_hidden_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+{
+	if (!ref_is_hidden(refname))
+		return 0;
+	allow_tip_sha1_in_want = 1;
+	return 1; /* terminate iteration over refs early */
+}
+
 static void upload_pack(void)
 {
 	if (advertise_refs || !stateless_rpc) {
 		reset_timeout();
 		head_ref_namespaced(send_ref, NULL);
+		for_each_namespaced_ref(check_hidden_ref, NULL);
 		for_each_namespaced_ref(send_ref, NULL);
 		packet_flush(1);
 	} else {
@@ -779,6 +794,11 @@ static void upload_pack(void)
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
@@ -830,6 +850,7 @@ int main(int argc, char **argv)
 		die("'%s' does not appear to be a git repository", dir);
 	if (is_repository_shallow())
 		die("attempt to fetch/clone from a shallow repository");
+	git_config(upload_pack_config, NULL);
 	if (getenv("GIT_DEBUG_SEND_PACK"))
 		debug_fd = atoi(getenv("GIT_DEBUG_SEND_PACK"));
 	upload_pack();
-- 
1.8.1.2.548.g0e4986f
