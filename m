From: Josh Triplett <josh@joshtriplett.org>
Subject: [PATCHv9 3/4] ref namespaces: Support remote repositories via
 upload-pack and receive-pack
Date: Tue, 5 Jul 2011 10:55:00 -0700
Message-ID: <fff78c90d7f9deb0a8294fe3158ab0285e1610ff.1309888001.git.josh@joshtriplett.org>
References: <cover.1309888001.git.josh@joshtriplett.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jamey Sharp <jamey@minilop.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 05 19:56:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qe9qs-0001JW-M0
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jul 2011 19:56:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752243Ab1GERzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jul 2011 13:55:15 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:55750 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233Ab1GERzO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2011 13:55:14 -0400
X-Originating-IP: 217.70.178.134
Received: from mfilter4-d.gandi.net (mfilter4-d.gandi.net [217.70.178.134])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id F32C1172093;
	Tue,  5 Jul 2011 19:55:12 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter4-d.gandi.net
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
	by mfilter4-d.gandi.net (mfilter4-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id iVTjKB5akpk4; Tue,  5 Jul 2011 19:55:11 +0200 (CEST)
X-Originating-IP: 174.25.139.9
Received: from leaf (174-25-139-9.ptld.qwest.net [174.25.139.9])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 49027172083;
	Tue,  5 Jul 2011 19:55:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <cover.1309888001.git.josh@joshtriplett.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176623>

Change upload-pack and receive-pack to use the namespace-prefixed refs
when working with the repository, and use the unprefixed refs when
talking to the client, maintaining the masquerade.  This allows
clone, pull, fetch, and push to work with a suitably configured
GIT_NAMESPACE.

With appropriate configuration, this also allows http-backend to expose
namespaces as multiple repositories with different paths.  This only
requires setting GIT_NAMESPACE, which http-backend passes through to
upload-pack and receive-pack.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
Signed-off-by: Jamey Sharp <jamey@minilop.net>
---
 builtin/receive-pack.c |   37 +++++++++++++++++++++++++++++++------
 upload-pack.c          |   15 ++++++++-------
 2 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e1a687a..2d36378 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -120,9 +120,17 @@ static int show_ref(const char *path, const unsigned char *sha1, int flag, void
 	return 0;
 }
 
+static int show_ref_cb(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+{
+	path = strip_namespace(path);
+	if (!path)
+		path = ".have";
+	return show_ref(path, sha1, flag, cb_data);
+}
+
 static void write_head_info(void)
 {
-	for_each_ref(show_ref, NULL);
+	for_each_ref(show_ref_cb, NULL);
 	if (!sent_capabilities)
 		show_ref("capabilities^{}", null_sha1, 0, NULL);
 
@@ -333,6 +341,8 @@ static void refuse_unconfigured_deny_delete_current(void)
 static const char *update(struct command *cmd)
 {
 	const char *name = cmd->ref_name;
+	struct strbuf namespaced_name_buf = STRBUF_INIT;
+	const char *namespaced_name;
 	unsigned char *old_sha1 = cmd->old_sha1;
 	unsigned char *new_sha1 = cmd->new_sha1;
 	struct ref_lock *lock;
@@ -343,7 +353,10 @@ static const char *update(struct command *cmd)
 		return "funny refname";
 	}
 
-	if (is_ref_checked_out(name)) {
+	strbuf_addf(&namespaced_name_buf, "%s%s", get_git_namespace(), name);
+	namespaced_name = strbuf_detach(&namespaced_name_buf, NULL);
+
+	if (is_ref_checked_out(namespaced_name)) {
 		switch (deny_current_branch) {
 		case DENY_IGNORE:
 			break;
@@ -371,7 +384,7 @@ static const char *update(struct command *cmd)
 			return "deletion prohibited";
 		}
 
-		if (!strcmp(name, head_name)) {
+		if (!strcmp(namespaced_name, head_name)) {
 			switch (deny_delete_current) {
 			case DENY_IGNORE:
 				break;
@@ -427,14 +440,14 @@ static const char *update(struct command *cmd)
 			rp_warning("Allowing deletion of corrupt ref.");
 			old_sha1 = NULL;
 		}
-		if (delete_ref(name, old_sha1, 0)) {
+		if (delete_ref(namespaced_name, old_sha1, 0)) {
 			rp_error("failed to delete %s", name);
 			return "failed to delete";
 		}
 		return NULL; /* good */
 	}
 	else {
-		lock = lock_any_ref_for_update(name, old_sha1, 0);
+		lock = lock_any_ref_for_update(namespaced_name, old_sha1, 0);
 		if (!lock) {
 			rp_error("failed to lock %s", name);
 			return "failed to lock";
@@ -491,17 +504,29 @@ static void run_update_post_hook(struct command *commands)
 
 static void check_aliased_update(struct command *cmd, struct string_list *list)
 {
+	struct strbuf buf = STRBUF_INIT;
+	const char *dst_name;
 	struct string_list_item *item;
 	struct command *dst_cmd;
 	unsigned char sha1[20];
 	char cmd_oldh[41], cmd_newh[41], dst_oldh[41], dst_newh[41];
 	int flag;
 
-	const char *dst_name = resolve_ref(cmd->ref_name, sha1, 0, &flag);
+	strbuf_addf(&buf, "%s%s", get_git_namespace(), cmd->ref_name);
+	dst_name = resolve_ref(buf.buf, sha1, 0, &flag);
+	strbuf_release(&buf);
 
 	if (!(flag & REF_ISSYMREF))
 		return;
 
+	dst_name = strip_namespace(dst_name);
+	if (!dst_name) {
+		rp_error("refusing update to broken symref '%s'", cmd->ref_name);
+		cmd->skip_update = 1;
+		cmd->error_string = "broken symref";
+		return;
+	}
+
 	if ((item = string_list_lookup(list, dst_name)) == NULL)
 		return;
 
diff --git a/upload-pack.c b/upload-pack.c
index ce5cbbe..267e5b1 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -641,16 +641,17 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 		" side-band-64k ofs-delta shallow no-progress"
 		" include-tag multi_ack_detailed";
 	struct object *o = parse_object(sha1);
+	const char *refname_nons = strip_namespace(refname);
 
 	if (!o)
 		die("git upload-pack: cannot find object %s:", sha1_to_hex(sha1));
 
 	if (capabilities)
-		packet_write(1, "%s %s%c%s%s\n", sha1_to_hex(sha1), refname,
+		packet_write(1, "%s %s%c%s%s\n", sha1_to_hex(sha1), refname_nons,
 			     0, capabilities,
 			     stateless_rpc ? " no-done" : "");
 	else
-		packet_write(1, "%s %s\n", sha1_to_hex(sha1), refname);
+		packet_write(1, "%s %s\n", sha1_to_hex(sha1), refname_nons);
 	capabilities = NULL;
 	if (!(o->flags & OUR_REF)) {
 		o->flags |= OUR_REF;
@@ -659,7 +660,7 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 	if (o->type == OBJ_TAG) {
 		o = deref_tag(o, refname, 0);
 		if (o)
-			packet_write(1, "%s %s^{}\n", sha1_to_hex(o->sha1), refname);
+			packet_write(1, "%s %s^{}\n", sha1_to_hex(o->sha1), refname_nons);
 	}
 	return 0;
 }
@@ -680,12 +681,12 @@ static void upload_pack(void)
 {
 	if (advertise_refs || !stateless_rpc) {
 		reset_timeout();
-		head_ref(send_ref, NULL);
-		for_each_ref(send_ref, NULL);
+		head_ref_namespaced(send_ref, NULL);
+		for_each_namespaced_ref(send_ref, NULL);
 		packet_flush(1);
 	} else {
-		head_ref(mark_our_ref, NULL);
-		for_each_ref(mark_our_ref, NULL);
+		head_ref_namespaced(mark_our_ref, NULL);
+		for_each_namespaced_ref(mark_our_ref, NULL);
 	}
 	if (advertise_refs)
 		return;
-- 
1.7.5.4
