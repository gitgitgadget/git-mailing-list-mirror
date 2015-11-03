From: Lukas Fleischer <lfleischer@lfos.de>
Subject: [PATCH v2 3/4] Add support for matching full refs in hideRefs
Date: Tue,  3 Nov 2015 08:58:16 +0100
Message-ID: <1446537497-13921-4-git-send-email-lfleischer@lfos.de>
References: <1446537497-13921-1-git-send-email-lfleischer@lfos.de>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 03 09:13:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtWj1-000157-2W
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 09:13:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbbKCH62 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 02:58:28 -0500
Received: from elnino.cryptocrack.de ([46.165.227.75]:44899 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbbKCH61 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 02:58:27 -0500
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id 18c207fb;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	Tue, 3 Nov 2015 08:58:19 +0100 (CET)
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1446537497-13921-1-git-send-email-lfleischer@lfos.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280784>

In addition to matching stripped refs, one can now add hideRefs patterns
that the full (unstripped) ref is matched against. To distinguish
between stripped and full matches, those new patterns must be prefixed
with a circumflex (^).

This commit also removes support for the undocumented and unintended
hideRefs settings "have" (suppressing all "have" lines) and
"capabilities^{}" (suppressing the capabilities line).

Signed-off-by: Lukas Fleischer <lfleischer@lfos.de>
---
 Documentation/config.txt |  3 ++-
 builtin/receive-pack.c   | 27 +++++++++++++++++++++------
 refs.c                   | 15 ++++++++++++---
 refs.h                   | 10 +++++++++-
 upload-pack.c            | 13 ++++++++-----
 5 files changed, 52 insertions(+), 16 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3da97a1..91ed6a5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2690,7 +2690,8 @@ the prefix `refs/heads/master` is specified in `transfer.hideRefs` and the
 current namespace is `foo`, then `refs/namespaces/foo/refs/heads/master` is
 omitted from the advertisements but `refs/heads/master` and
 `refs/namespaces/bar/refs/heads/master` are still advertised as so-called
-"have" lines.
+"have" lines. In order to match refs before stripping, add a `^` in front of
+the ref name. If you combine `!` and `^`, `!` must be specified first.
 
 transfer.unpackLimit::
 	When `fetch.unpackLimit` or `receive.unpackLimit` are
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index bcb624b..9939de1 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -195,9 +195,6 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 
 static void show_ref(const char *path, const unsigned char *sha1)
 {
-	if (ref_is_hidden(path))
-		return;
-
 	if (sent_capabilities) {
 		packet_write(1, "%s %s\n", sha1_to_hex(sha1), path);
 	} else {
@@ -219,9 +216,14 @@ static void show_ref(const char *path, const unsigned char *sha1)
 	}
 }
 
-static int show_ref_cb(const char *path, const struct object_id *oid, int flag, void *unused)
+static int show_ref_cb(const char *path_full, const struct object_id *oid,
+		       int flag, void *unused)
 {
-	path = strip_namespace(path);
+	const char *path = strip_namespace(path_full);
+
+	if (ref_is_hidden(path, path_full))
+		return 1;
+
 	/*
 	 * Advertise refs outside our current namespace as ".have"
 	 * refs, so that the client can use them to minimize data
@@ -1195,16 +1197,29 @@ static int iterate_receive_command_list(void *cb_data, unsigned char sha1[20])
 
 static void reject_updates_to_hidden(struct command *commands)
 {
+	struct strbuf refname_full = STRBUF_INIT;
+	size_t prefix_len;
 	struct command *cmd;
 
+	strbuf_addstr(&refname_full, get_git_namespace());
+	prefix_len = refname_full.len;
+
 	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (cmd->error_string || !ref_is_hidden(cmd->ref_name))
+		if (cmd->error_string)
+			continue;
+
+		strbuf_setlen(&refname_full, prefix_len);
+		strbuf_addstr(&refname_full, cmd->ref_name);
+
+		if (!ref_is_hidden(cmd->ref_name, refname_full.buf))
 			continue;
 		if (is_null_sha1(cmd->new_sha1))
 			cmd->error_string = "deny deleting a hidden ref";
 		else
 			cmd->error_string = "deny updating a hidden ref";
 	}
+
+	strbuf_release(&refname_full);
 }
 
 static int should_process_cmd(struct command *cmd)
diff --git a/refs.c b/refs.c
index 72d96ed..892fffb 100644
--- a/refs.c
+++ b/refs.c
@@ -321,7 +321,7 @@ int parse_hide_refs_config(const char *var, const char *value, const char *secti
 	return 0;
 }
 
-int ref_is_hidden(const char *refname)
+int ref_is_hidden(const char *refname, const char *refname_full)
 {
 	int i;
 
@@ -329,6 +329,7 @@ int ref_is_hidden(const char *refname)
 		return 0;
 	for (i = hide_refs->nr - 1; i >= 0; i--) {
 		const char *match = hide_refs->items[i].string;
+		const char *subject;
 		int neg = 0;
 		int len;
 
@@ -337,10 +338,18 @@ int ref_is_hidden(const char *refname)
 			match++;
 		}
 
-		if (!starts_with(refname, match))
+		if (*match == '^') {
+			subject = refname_full;
+			match++;
+		} else {
+			subject = refname;
+		}
+
+		/* refname can be NULL when namespaces are used. */
+		if (!subject || !starts_with(subject, match))
 			continue;
 		len = strlen(match);
-		if (!refname[len] || refname[len] == '/')
+		if (!subject[len] || subject[len] == '/')
 			return !neg;
 	}
 	return 0;
diff --git a/refs.h b/refs.h
index 69fa4df..116c461 100644
--- a/refs.h
+++ b/refs.h
@@ -604,7 +604,15 @@ int update_ref(const char *msg, const char *refname,
 
 extern int parse_hide_refs_config(const char *var, const char *value, const char *);
 
-extern int ref_is_hidden(const char *);
+/*
+ * Check whether a ref is hidden. If no namespace is set, both the first and
+ * the second parameter point to the full ref name. If a namespace is set and
+ * the ref is inside that namespace, the first parameter is a pointer to the
+ * name of the ref with the namespace prefix removed. If a namespace is set and
+ * the ref is outside that namespace, the first parameter is NULL. The second
+ * parameter always points to the full ref name.
+ */
+extern int ref_is_hidden(const char *, const char *);
 
 enum ref_type {
 	REF_TYPE_PER_WORKTREE,
diff --git a/upload-pack.c b/upload-pack.c
index 4ca960e..08efb1d 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -688,11 +688,12 @@ static void receive_needs(void)
 }
 
 /* return non-zero if the ref is hidden, otherwise 0 */
-static int mark_our_ref(const char *refname, const struct object_id *oid)
+static int mark_our_ref(const char *refname, const char *refname_full,
+			const struct object_id *oid)
 {
 	struct object *o = lookup_unknown_object(oid->hash);
 
-	if (refname && ref_is_hidden(refname)) {
+	if (ref_is_hidden(refname, refname_full)) {
 		o->flags |= HIDDEN_REF;
 		return 1;
 	}
@@ -700,10 +701,12 @@ static int mark_our_ref(const char *refname, const struct object_id *oid)
 	return 0;
 }
 
-static int check_ref(const char *refname, const struct object_id *oid,
+static int check_ref(const char *refname_full, const struct object_id *oid,
 		     int flag, void *cb_data)
 {
-	mark_our_ref(strip_namespace(refname), oid);
+	const char *refname = strip_namespace(refname_full);
+
+	mark_our_ref(refname, refname_full, oid);
 	return 0;
 }
 
@@ -726,7 +729,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 	const char *refname_nons = strip_namespace(refname);
 	struct object_id peeled;
 
-	if (mark_our_ref(refname_nons, oid))
+	if (mark_our_ref(refname_nons, refname, oid))
 		return 0;
 
 	if (capabilities) {
-- 
2.6.2
