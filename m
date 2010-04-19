From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH v3 1/3] receive-pack: switch global variable 'commands' to a parameter
Date: Mon, 19 Apr 2010 18:08:30 -0400
Message-ID: <1271714912-56659-2-git-send-email-jaysoffian@gmail.com>
References: <1271714912-56659-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	"Shawn O . Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <junio@kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 20 00:09:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3z9g-0005uP-Bm
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 00:09:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752691Ab0DSWJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 18:09:08 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:53241 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423Ab0DSWJH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 18:09:07 -0400
Received: by gwj19 with SMTP id 19so429991gwj.19
        for <git@vger.kernel.org>; Mon, 19 Apr 2010 15:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=fqf0DwFrPhZQRFMgquEYSWx0dvgIeGyNFiqEELKTA5k=;
        b=cal4W0fMvI4Q7SH+dNX0cty++cQTZFr9M70xVgwy370DSbbjdJrnXzKNQWayPoG6eH
         Z2d4TFVhNPfnREAfR9KVm79g0+u0skfzvoT0XXYHLU4vrpvPTsM/Ln4L6cQBdqrQgx9q
         BtIkP298hZBJlkvxXHojOl2QAezyYys67kekc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=IhcuBWEPed3vsC1HvLl1o0SJB18qPWjvQGDQqEpHVKNSj3jnEpO71lGmfSz2Aa1qL3
         8+zuqludTOsDwInryBiUaWtK7IxcbzU56/CTtAFkuZ8znVsY7FWkeSHV9oijwaXJ8oI1
         LDskpDw8RykBbm787t4S28PXMj93pR4llO2qI=
Received: by 10.101.189.3 with SMTP id r3mr15501186anp.241.1271714940144;
        Mon, 19 Apr 2010 15:09:00 -0700 (PDT)
Received: from localhost (cpe-065-190-041-119.nc.res.rr.com [65.190.41.119])
        by mx.google.com with ESMTPS id r21sm50197336anp.17.2010.04.19.15.08.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Apr 2010 15:08:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3.436.g2b878
In-Reply-To: <1271714912-56659-1-git-send-email-jaysoffian@gmail.com>
In-Reply-To: <1271694343-31876-2-git-send-email-jaysoffian@gmail.com>
References: <1271694343-31876-2-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145335>

Receive-pack is inconsistent in its usage of the 'commands'
variable; though it is setup as a global and accessed that way by
execute_commands(), report(), and run_receive_hook(), it is also
passed as a parameter to delete_only() and run_update_post_hook().

For consistency, make it local to cmd_receive_pack and pass it as a
parameter. As long as we're cleaning up, also make our use of the
names 'commands' and 'cmd' consistent.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 builtin-receive-pack.c |   60 +++++++++++++++++++++--------------------------
 1 files changed, 27 insertions(+), 33 deletions(-)

diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index 0559fcc..fffb6ea 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -134,8 +134,6 @@ struct command {
 	char ref_name[FLEX_ARRAY]; /* more */
 };
 
-static struct command *commands;
-
 static const char pre_receive_hook[] = "hooks/pre-receive";
 static const char post_receive_hook[] = "hooks/post-receive";
 
@@ -188,7 +186,7 @@ static int copy_to_sideband(int in, int out, void *arg)
 	return 0;
 }
 
-static int run_receive_hook(const char *hook_name)
+static int run_receive_hook(struct command *commands, const char *hook_name)
 {
 	static char buf[sizeof(commands->old_sha1) * 2 + PATH_MAX + 4];
 	struct command *cmd;
@@ -447,15 +445,15 @@ static const char *update(struct command *cmd)
 
 static char update_post_hook[] = "hooks/post-update";
 
-static void run_update_post_hook(struct command *cmd)
+static void run_update_post_hook(struct command *commands)
 {
-	struct command *cmd_p;
+	struct command *cmd;
 	int argc;
 	const char **argv;
 	struct child_process proc;
 
-	for (argc = 0, cmd_p = cmd; cmd_p; cmd_p = cmd_p->next) {
-		if (cmd_p->error_string)
+	for (argc = 0, cmd = commands; cmd; cmd = cmd->next) {
+		if (cmd->error_string)
 			continue;
 		argc++;
 	}
@@ -464,12 +462,12 @@ static void run_update_post_hook(struct command *cmd)
 	argv = xmalloc(sizeof(*argv) * (2 + argc));
 	argv[0] = update_post_hook;
 
-	for (argc = 1, cmd_p = cmd; cmd_p; cmd_p = cmd_p->next) {
+	for (argc = 1, cmd = commands; cmd; cmd = cmd->next) {
 		char *p;
-		if (cmd_p->error_string)
+		if (cmd->error_string)
 			continue;
-		p = xmalloc(strlen(cmd_p->ref_name) + 1);
-		strcpy(p, cmd_p->ref_name);
+		p = xmalloc(strlen(cmd->ref_name) + 1);
+		strcpy(p, cmd->ref_name);
 		argv[argc] = p;
 		argc++;
 	}
@@ -488,37 +486,32 @@ static void run_update_post_hook(struct command *cmd)
 	}
 }
 
-static void execute_commands(const char *unpacker_error)
+static void execute_commands(struct command *commands, const char *unpacker_error)
 {
-	struct command *cmd = commands;
+	struct command *cmd;
 	unsigned char sha1[20];
 
 	if (unpacker_error) {
-		while (cmd) {
+		for (cmd = commands; cmd; cmd = cmd->next)
 			cmd->error_string = "n/a (unpacker error)";
-			cmd = cmd->next;
-		}
 		return;
 	}
 
-	if (run_receive_hook(pre_receive_hook)) {
-		while (cmd) {
+	if (run_receive_hook(commands, pre_receive_hook)) {
+		for (cmd = commands; cmd; cmd = cmd->next)
 			cmd->error_string = "pre-receive hook declined";
-			cmd = cmd->next;
-		}
 		return;
 	}
 
 	head_name = resolve_ref("HEAD", sha1, 0, NULL);
 
-	while (cmd) {
+	for (cmd = commands; cmd; cmd = cmd->next)
 		cmd->error_string = update(cmd);
-		cmd = cmd->next;
-	}
 }
 
-static void read_head_info(void)
+static struct command *read_head_info(void)
 {
+	struct command *commands = NULL;
 	struct command **p = &commands;
 	for (;;) {
 		static char line[1000];
@@ -557,6 +550,7 @@ static void read_head_info(void)
 		*p = cmd;
 		p = &cmd->next;
 	}
+	return commands;
 }
 
 static const char *parse_pack_header(struct pack_header *hdr)
@@ -643,7 +637,7 @@ static const char *unpack(void)
 	}
 }
 
-static void report(const char *unpack_status)
+static void report(struct command *commands, const char *unpack_status)
 {
 	struct command *cmd;
 	struct strbuf buf = STRBUF_INIT;
@@ -667,12 +661,12 @@ static void report(const char *unpack_status)
 	strbuf_release(&buf);
 }
 
-static int delete_only(struct command *cmd)
+static int delete_only(struct command *commands)
 {
-	while (cmd) {
+	struct command *cmd;
+	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (!is_null_sha1(cmd->new_sha1))
 			return 0;
-		cmd = cmd->next;
 	}
 	return 1;
 }
@@ -722,6 +716,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 	int stateless_rpc = 0;
 	int i;
 	char *dir = NULL;
+	struct command *commands;
 
 	argv++;
 	for (i = 1; i < argc; i++) {
@@ -772,18 +767,17 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 	if (advertise_refs)
 		return 0;
 
-	read_head_info();
-	if (commands) {
+	if ((commands = read_head_info()) != NULL) {
 		const char *unpack_status = NULL;
 
 		if (!delete_only(commands))
 			unpack_status = unpack();
-		execute_commands(unpack_status);
+		execute_commands(commands, unpack_status);
 		if (pack_lockfile)
 			unlink_or_warn(pack_lockfile);
 		if (report_status)
-			report(unpack_status);
-		run_receive_hook(post_receive_hook);
+			report(commands, unpack_status);
+		run_receive_hook(commands, post_receive_hook);
 		run_update_post_hook(commands);
 		if (auto_gc) {
 			const char *argv_gc_auto[] = {
-- 
1.7.0.3.436.g2b878
