From: Lukas Fleischer <lfleischer@lfos.de>
Subject: [PATCH 3/4] Add support for matching full refs in hideRefs
Date: Sun,  1 Nov 2015 20:34:22 +0100
Message-ID: <1446406463-22527-4-git-send-email-lfleischer@lfos.de>
References: <1446406463-22527-1-git-send-email-lfleischer@lfos.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 01 20:34:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsyOp-0000Ob-V4
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 20:34:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752880AbbKATej (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 14:34:39 -0500
Received: from elnino.cryptocrack.de ([46.165.227.75]:8371 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752861AbbKATeh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 14:34:37 -0500
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id 4ffd906f;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	for <git@vger.kernel.org>;
	Sun, 1 Nov 2015 20:34:31 +0100 (CET)
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1446406463-22527-1-git-send-email-lfleischer@lfos.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280660>

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
 builtin/receive-pack.c   | 22 ++++++++++++++++------
 refs.c                   | 14 +++++++++++---
 refs.h                   |  2 +-
 upload-pack.c            | 13 ++++++++-----
 5 files changed, 38 insertions(+), 16 deletions(-)

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
index bcb624b..d5e58e0 100644
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
@@ -1198,7 +1200,15 @@ static void reject_updates_to_hidden(struct command *commands)
 	struct command *cmd;
 
 	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (cmd->error_string || !ref_is_hidden(cmd->ref_name))
+		const char *refname = cmd->ref_name;
+		struct strbuf refname_full_buf = STRBUF_INIT;
+		const char *refname_full;
+
+		strbuf_addf(&refname_full_buf, "%s%s", get_git_namespace(),
+				refname);
+		refname_full = strbuf_detach(&refname_full_buf, NULL);
+
+		if (cmd->error_string || !ref_is_hidden(refname, refname_full))
 			continue;
 		if (is_null_sha1(cmd->new_sha1))
 			cmd->error_string = "deny deleting a hidden ref";
diff --git a/refs.c b/refs.c
index 72d96ed..555c9d5 100644
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
 
@@ -337,10 +338,17 @@ int ref_is_hidden(const char *refname)
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
+		if (!subject || !starts_with(subject, match))
 			continue;
 		len = strlen(match);
-		if (!refname[len] || refname[len] == '/')
+		if (!subject[len] || subject[len] == '/')
 			return !neg;
 	}
 	return 0;
diff --git a/refs.h b/refs.h
index 69fa4df..fbf8e59 100644
--- a/refs.h
+++ b/refs.h
@@ -604,7 +604,7 @@ int update_ref(const char *msg, const char *refname,
 
 extern int parse_hide_refs_config(const char *var, const char *value, const char *);
 
-extern int ref_is_hidden(const char *);
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
