From: Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH] Support multiple virtual repositories with a single object
 store and refs
Date: Mon, 23 May 2011 18:02:52 -0700
Message-ID: <20110524010252.GA5368@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jamey Sharp <jamey@minilop.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 03:03:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOg1h-0000sw-7Q
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 03:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758041Ab1EXBDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 21:03:07 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:38218 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758038Ab1EXBDF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 21:03:05 -0400
X-Originating-IP: 217.70.178.134
Received: from mfilter4-d.gandi.net (mfilter4-d.gandi.net [217.70.178.134])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id DF690A8076;
	Tue, 24 May 2011 03:03:01 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at #File managed by puppet, do not edit
	locally
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
	by mfilter4-d.gandi.net (mfilter4-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id cU91oYm0S2Fg; Tue, 24 May 2011 03:03:00 +0200 (CEST)
X-Originating-IP: 131.252.248.161
Received: from leaf (host-248-161.pubnet.pdx.edu [131.252.248.161])
	(Authenticated sender: josh@joshtriplett.org)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 4D3D1A8072;
	Tue, 24 May 2011 03:02:54 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174305>

Given many repositories with copies of the same objects (such as
branches of the same source), sharing a common object store will avoid
duplication.  Alternates provide a single baseline, but don't handle
ongoing activity in the various repositories.  Git safely handles
concurrent accesses to the same object store across repositories, but
operations such as gc need to know about all of the refs.

This change adds support in upload-pack and receive-pack to simulate
multiple virtual repositories within the object store and references of
a single underlying repository.  The refs and heads of the virtual
repositories get stored in the underlying repository using prefixed
names specified by the --ref-prefix and --head options; for instance,
--ref-prefix=repo1/ will use refs/repo1/heads/* and refs/repo1/tags/*.
upload-pack and receive-pack will not expose any references that do not
match the specified prefix.

These options implement the underlying mechanism for virtual
repositories; the higher-level protocol handler (such as http-backend or
a custom server) can pass these options when invoking upload-pack or
receive-pack, providing values based on components of the repository
path.  For a simple local test, git-remote-ext works:

git clone ext::'git %s --ref-prefix=prefix/ --head=prefix-HEAD /tmp/prefixed.git'

Commit by Josh Triplett and Jamey Sharp.
Signed-off-by: Josh Triplett <josh@joshtriplett.org>
Signed-off-by: Jamey Sharp <jamey@minilop.net>
---
 builtin/receive-pack.c |   38 +++++++++++++++++++++++++++++---------
 upload-pack.c          |   34 +++++++++++++++++++++++++++-------
 2 files changed, 56 insertions(+), 16 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e1ba4dc..45d0b35 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -34,6 +34,8 @@ static int prefer_ofs_delta = 1;
 static int auto_update_server_info;
 static int auto_gc = 1;
 static const char *head_name;
+static const char *head_path = "HEAD";
+static const char *ref_prefix = "refs/";
 static int sent_capabilities;
 
 static enum deny_action parse_deny_action(const char *var, const char *value)
@@ -108,11 +110,12 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 
 static int show_ref(const char *path, const unsigned char *sha1, int flag, void *cb_data)
 {
+	const char *refnameprefix = cb_data;
 	if (sent_capabilities)
-		packet_write(1, "%s %s\n", sha1_to_hex(sha1), path);
+		packet_write(1, "%s %s%s\n", sha1_to_hex(sha1), refnameprefix, path);
 	else
-		packet_write(1, "%s %s%c%s%s\n",
-			     sha1_to_hex(sha1), path, 0,
+		packet_write(1, "%s %s%s%c%s%s\n",
+			     sha1_to_hex(sha1), refnameprefix, path, 0,
 			     " report-status delete-refs side-band-64k",
 			     prefer_ofs_delta ? " ofs-delta" : "");
 	sent_capabilities = 1;
@@ -121,9 +124,9 @@ static int show_ref(const char *path, const unsigned char *sha1, int flag, void
 
 static void write_head_info(void)
 {
-	for_each_ref(show_ref, NULL);
+	for_each_ref_in(ref_prefix, show_ref, "refs/");
 	if (!sent_capabilities)
-		show_ref("capabilities^{}", null_sha1, 0, NULL);
+		show_ref("capabilities^{}", null_sha1, 0, "");
 
 }
 
@@ -332,6 +335,8 @@ static void refuse_unconfigured_deny_delete_current(void)
 static const char *update(struct command *cmd)
 {
 	const char *name = cmd->ref_name;
+	struct strbuf prefixed_name_buf = STRBUF_INIT;
+	const char *prefixed_name;
 	unsigned char *old_sha1 = cmd->old_sha1;
 	unsigned char *new_sha1 = cmd->new_sha1;
 	struct ref_lock *lock;
@@ -342,7 +347,12 @@ static const char *update(struct command *cmd)
 		return "funny refname";
 	}
 
-	if (is_ref_checked_out(name)) {
+	strbuf_addf(&prefixed_name_buf, "%s%s", ref_prefix, name + 5);
+	prefixed_name = strbuf_detach(&prefixed_name_buf, NULL);
+
+	rp_warning("name \"%s\", prefixed_name \"%s\"", name, prefixed_name);
+
+	if (is_ref_checked_out(prefixed_name)) {
 		switch (deny_current_branch) {
 		case DENY_IGNORE:
 			break;
@@ -370,7 +380,7 @@ static const char *update(struct command *cmd)
 			return "deletion prohibited";
 		}
 
-		if (!strcmp(name, head_name)) {
+		if (!strcmp(prefixed_name, head_name)) {
 			switch (deny_delete_current) {
 			case DENY_IGNORE:
 				break;
@@ -426,14 +436,14 @@ static const char *update(struct command *cmd)
 			rp_warning("Allowing deletion of corrupt ref.");
 			old_sha1 = NULL;
 		}
-		if (delete_ref(name, old_sha1, 0)) {
+		if (delete_ref(prefixed_name, old_sha1, 0)) {
 			rp_error("failed to delete %s", name);
 			return "failed to delete";
 		}
 		return NULL; /* good */
 	}
 	else {
-		lock = lock_any_ref_for_update(name, old_sha1, 0);
+		lock = lock_any_ref_for_update(prefixed_name, old_sha1, 0);
 		if (!lock) {
 			rp_error("failed to lock %s", name);
 			return "failed to lock";
@@ -760,6 +770,16 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 				advertise_refs = 1;
 				continue;
 			}
+			if (!prefixcmp(arg, "--head=")) {
+				head_path = arg+7;
+				continue;
+			}
+			if (!prefixcmp(arg, "--ref-prefix=")) {
+				struct strbuf prefixbuf = STRBUF_INIT;
+				strbuf_addf(&prefixbuf, "refs/%s", arg+13);
+				ref_prefix = strbuf_detach(&prefixbuf, NULL);
+				continue;
+			}
 			if (!strcmp(arg, "--stateless-rpc")) {
 				stateless_rpc = 1;
 				continue;
diff --git a/upload-pack.c b/upload-pack.c
index ce5cbbe..a1e495f 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -34,6 +34,8 @@ static int shallow_nr;
 static struct object_array have_obj;
 static struct object_array want_obj;
 static struct object_array extra_edge_obj;
+static const char *head_path = "HEAD";
+static const char *ref_prefix = "";
 static unsigned int timeout;
 /* 0 for no sideband,
  * otherwise maximum packet size (up to 65520 bytes).
@@ -640,17 +642,18 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 	static const char *capabilities = "multi_ack thin-pack side-band"
 		" side-band-64k ofs-delta shallow no-progress"
 		" include-tag multi_ack_detailed";
+	const char *refnameprefix = cb_data;
 	struct object *o = parse_object(sha1);
 
 	if (!o)
 		die("git upload-pack: cannot find object %s:", sha1_to_hex(sha1));
 
 	if (capabilities)
-		packet_write(1, "%s %s%c%s%s\n", sha1_to_hex(sha1), refname,
+		packet_write(1, "%s %s%s%c%s%s\n", sha1_to_hex(sha1), refnameprefix, refname,
 			     0, capabilities,
 			     stateless_rpc ? " no-done" : "");
 	else
-		packet_write(1, "%s %s\n", sha1_to_hex(sha1), refname);
+		packet_write(1, "%s %s%s\n", sha1_to_hex(sha1), refnameprefix, refname);
 	capabilities = NULL;
 	if (!(o->flags & OUR_REF)) {
 		o->flags |= OUR_REF;
@@ -659,7 +662,7 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 	if (o->type == OBJ_TAG) {
 		o = deref_tag(o, refname, 0);
 		if (o)
-			packet_write(1, "%s %s^{}\n", sha1_to_hex(o->sha1), refname);
+			packet_write(1, "%s %s%s^{}\n", sha1_to_hex(o->sha1), refnameprefix, refname);
 	}
 	return 0;
 }
@@ -678,15 +681,24 @@ static int mark_our_ref(const char *refname, const unsigned char *sha1, int flag
 
 static void upload_pack(void)
 {
+	struct strbuf prefix = STRBUF_INIT;
+	unsigned char sha1[20];
+	int flag;
+
+	strbuf_addf(&prefix, "refs/%s", ref_prefix);
 	if (advertise_refs || !stateless_rpc) {
 		reset_timeout();
-		head_ref(send_ref, NULL);
-		for_each_ref(send_ref, NULL);
+		if (resolve_ref(head_path, sha1, 1, &flag))
+			send_ref("HEAD", sha1, flag, "");
+		for_each_ref_in(prefix.buf, send_ref, "refs/");
 		packet_flush(1);
 	} else {
-		head_ref(mark_our_ref, NULL);
-		for_each_ref(mark_our_ref, NULL);
+		if (resolve_ref(head_path, sha1, 1, &flag))
+			mark_our_ref("HEAD", sha1, flag, NULL);
+		for_each_ref_in(prefix.buf, mark_our_ref, NULL);
 	}
+	strbuf_release(&prefix);
+
 	if (advertise_refs)
 		return;
 
@@ -716,6 +728,14 @@ int main(int argc, char **argv)
 			advertise_refs = 1;
 			continue;
 		}
+		if (!prefixcmp(arg, "--head=")) {
+			head_path = arg+7;
+			continue;
+		}
+		if (!prefixcmp(arg, "--ref-prefix=")) {
+			ref_prefix = arg+13;
+			continue;
+		}
 		if (!strcmp(arg, "--stateless-rpc")) {
 			stateless_rpc = 1;
 			continue;
-- 
1.7.5.1
