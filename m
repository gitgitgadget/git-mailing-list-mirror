From: Jamey Sharp <jamey@minilop.net>
Subject: [PATCH 3/4] Support ref namespaces for remote repositories via upload-pack and receive-pack
Date: Tue,  7 Jun 2011 11:21:24 -0700
Message-ID: <1307470885-4018-4-git-send-email-jamey@minilop.net>
References: <7vsjrna2x2.fsf@alter.siamese.dyndns.org>
 <1307470885-4018-1-git-send-email-jamey@minilop.net>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 20:22:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU0up-0003Lr-AG
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 20:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218Ab1FGSV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 14:21:58 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:37507 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756879Ab1FGSVs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 14:21:48 -0400
Received: by pzk9 with SMTP id 9so2668167pzk.19
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 11:21:47 -0700 (PDT)
Received: by 10.68.5.137 with SMTP id s9mr328386pbs.61.1307470907614;
        Tue, 07 Jun 2011 11:21:47 -0700 (PDT)
Received: from oh.minilop.net (host-246-101.pubnet.pdx.edu [131.252.246.101])
        by mx.google.com with ESMTPS id i7sm298315pbj.90.2011.06.07.11.21.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 07 Jun 2011 11:21:45 -0700 (PDT)
Received: from jamey by oh.minilop.net with local (Exim 4.76)
	(envelope-from <jamey@oh.minilop.net>)
	id 1QU0uO-00013i-EX; Tue, 07 Jun 2011 11:21:44 -0700
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1307470885-4018-1-git-send-email-jamey@minilop.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175248>

From: Josh Triplett <josh@joshtriplett.org>

Change upload-pack and receive-pack to use the namespace-prefixed refs
when working with the repository, and use the unprefixed refs when
talking to the client, maintaining the masquerade.  This allows
clone, pull, fetch, and push to work with a suitably configured
GIT_NAMESPACE.

With appropriate configuration, this also allows http-backend to expose
namespaces as multiple repositories with different paths.  This only
requires setting GIT_NAMESPACE, which http-backend passes through to
upload-pack and receive-pack.

Commit by Josh Triplett and Jamey Sharp.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
Signed-off-by: Jamey Sharp <jamey@minilop.net>
---
 builtin/receive-pack.c |   34 ++++++++++++++++++++++++++++------
 upload-pack.c          |   15 ++++++++-------
 2 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e1a687a..54dd5d4 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -120,9 +120,14 @@ static int show_ref(const char *path, const unsigned char *sha1, int flag, void
 	return 0;
 }
 
+static int show_ref_cb(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+{
+	return show_ref(strip_namespace(path), sha1, flag, cb_data);
+}
+
 static void write_head_info(void)
 {
-	for_each_ref(show_ref, NULL);
+	for_each_namespaced_ref(show_ref_cb, NULL);
 	if (!sent_capabilities)
 		show_ref("capabilities^{}", null_sha1, 0, NULL);
 
@@ -333,6 +338,8 @@ static void refuse_unconfigured_deny_delete_current(void)
 static const char *update(struct command *cmd)
 {
 	const char *name = cmd->ref_name;
+	struct strbuf namespaced_name_buf = STRBUF_INIT;
+	const char *namespaced_name;
 	unsigned char *old_sha1 = cmd->old_sha1;
 	unsigned char *new_sha1 = cmd->new_sha1;
 	struct ref_lock *lock;
@@ -343,7 +350,10 @@ static const char *update(struct command *cmd)
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
@@ -371,7 +381,7 @@ static const char *update(struct command *cmd)
 			return "deletion prohibited";
 		}
 
-		if (!strcmp(name, head_name)) {
+		if (!strcmp(namespaced_name, head_name)) {
 			switch (deny_delete_current) {
 			case DENY_IGNORE:
 				break;
@@ -427,14 +437,14 @@ static const char *update(struct command *cmd)
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
@@ -491,17 +501,29 @@ static void run_update_post_hook(struct command *commands)
 
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
1.7.5.3
