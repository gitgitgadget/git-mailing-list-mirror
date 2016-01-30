From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH 2/3] receive-pack: add a capability for hook options
Date: Sat, 30 Jan 2016 19:28:09 +0100
Message-ID: <1454178490-17873-3-git-send-email-dennis@kaarsemaker.net>
References: <1454178490-17873-1-git-send-email-dennis@kaarsemaker.net>
Cc: Dennis Kaarsemaker <dennis@kaarsemaker.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 30 19:34:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPaLs-0007OR-JV
	for gcvg-git-2@plane.gmane.org; Sat, 30 Jan 2016 19:34:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932837AbcA3SeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2016 13:34:22 -0500
Received: from koekblik.kaarsemaker.net ([141.138.139.206]:53717 "EHLO
	koekblik.kaarsemaker.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932535AbcA3SeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2016 13:34:16 -0500
Received: from spirit.home.kaarsemaker.net (unknown [145.132.209.114])
	by koekblik.kaarsemaker.net (Postfix) with ESMTP id 12FBC828B3;
	Sat, 30 Jan 2016 19:28:40 +0100 (CET)
X-Mailer: git-send-email 2.7.0-91-gf04ef09
In-Reply-To: <1454178490-17873-1-git-send-email-dennis@kaarsemaker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285127>

Allow the client to specify options to influence the behaviour of hooks
run by receive-pack. This can be used to e.g. tell hooks to be quiet or
verbose, or to ignore errors.

These options are passed on to the hooks in the environment variable
GIT_HOOK_OPTIONS, which hooks can choose to respect to or ignore. The
default hooks do not respect these options.

Signed-off-by: Dennis Kaarsemaker <git@vger.kernel.org>
---
 Documentation/technical/protocol-capabilities.txt |  9 +++++++++
 builtin/receive-pack.c                            | 19 +++++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index eaab6b4..dea47e6 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -275,3 +275,12 @@ to accept a signed push certificate, and asks the <nonce> to be
 included in the push certificate.  A send-pack client MUST NOT
 send a push-cert packet unless the receive-pack server advertises
 this capability.
+
+hook-options
+------------
+
+The receive-pack server that advertises this capability can accept hook
+options in the capabilities sent by the client. The hook options string is
+a string of characters in the set [0-9a-zA-Z,=_] and is made available to
+all hooks executed by the receive pack process as environment variable
+GIT_HOOK_OPTIONS
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index f2d6761..120d9b3 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -73,6 +73,8 @@ static long nonce_stamp_slop;
 static unsigned long nonce_stamp_slop_limit;
 static struct ref_transaction *transaction;
 
+static const char *hook_options;
+
 static enum deny_action parse_deny_action(const char *var, const char *value)
 {
 	if (value) {
@@ -201,7 +203,7 @@ static void show_ref(const char *path, const unsigned char *sha1)
 		struct strbuf cap = STRBUF_INIT;
 
 		strbuf_addstr(&cap,
-			      "report-status delete-refs side-band-64k quiet");
+			      "report-status delete-refs side-band-64k quiet hook-options");
 		if (advertise_atomic_push)
 			strbuf_addstr(&cap, " atomic");
 		if (prefer_ofs_delta)
@@ -561,6 +563,9 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed, void *feed_sta
 
 	argv[1] = NULL;
 
+	if (hook_options)
+		argv_array_pushf(&proc.env_array, "GIT_HOOK_OPTIONS=%s", hook_options);
+
 	proc.argv = argv;
 	proc.in = -1;
 	proc.stdout_to_stderr = 1;
@@ -663,6 +668,9 @@ static int run_update_hook(struct command *cmd)
 	argv[3] = sha1_to_hex(cmd->new_sha1);
 	argv[4] = NULL;
 
+	if (hook_options)
+		argv_array_pushf(&proc.env_array, "GIT_HOOK_OPTIONS=%s", hook_options);
+
 	proc.no_stdin = 1;
 	proc.stdout_to_stderr = 1;
 	proc.err = use_sideband ? -1 : 0;
@@ -1055,6 +1063,9 @@ static void run_update_post_hook(struct command *commands)
 	}
 	argv[argc] = NULL;
 
+	if (hook_options)
+		argv_array_pushf(&proc.env_array, "GIT_HOOK_OPTIONS=%s", hook_options);
+
 	proc.no_stdin = 1;
 	proc.stdout_to_stderr = 1;
 	proc.err = use_sideband ? -1 : 0;
@@ -1415,7 +1426,8 @@ static struct command *read_head_info(struct sha1_array *shallow)
 	struct command **p = &commands;
 	for (;;) {
 		char *line;
-		int len, linelen;
+		const char *feature;
+		int len, linelen, featurelen;
 
 		line = packet_read_line(0, &len);
 		if (!line)
@@ -1442,6 +1454,9 @@ static struct command *read_head_info(struct sha1_array *shallow)
 			if (advertise_atomic_push
 			    && parse_feature_request(feature_list, "atomic"))
 				use_atomic = 1;
+			if ((feature =
+				parse_feature_value(feature_list, "hook-options", &featurelen)))
+				hook_options = xmemdupz(feature, featurelen);
 		}
 
 		if (!strcmp(line, "push-cert")) {
-- 
2.7.0-91-gf04ef09
