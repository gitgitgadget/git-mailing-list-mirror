From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH 3/3] send-pack: propagate --force and --quiet to remote hooks
Date: Sat, 30 Jan 2016 19:28:10 +0100
Message-ID: <1454178490-17873-4-git-send-email-dennis@kaarsemaker.net>
References: <1454178490-17873-1-git-send-email-dennis@kaarsemaker.net>
Cc: Dennis Kaarsemaker <dennis@kaarsemaker.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 30 19:34:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPaLr-0007OR-Vy
	for gcvg-git-2@plane.gmane.org; Sat, 30 Jan 2016 19:34:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932642AbcA3SeR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2016 13:34:17 -0500
Received: from koekblik.kaarsemaker.net ([141.138.139.206]:53716 "EHLO
	koekblik.kaarsemaker.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932145AbcA3SeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2016 13:34:16 -0500
X-Greylist: delayed 335 seconds by postgrey-1.27 at vger.kernel.org; Sat, 30 Jan 2016 13:34:16 EST
Received: from spirit.home.kaarsemaker.net (unknown [145.132.209.114])
	by koekblik.kaarsemaker.net (Postfix) with ESMTP id 2B142828B4;
	Sat, 30 Jan 2016 19:28:40 +0100 (CET)
X-Mailer: git-send-email 2.7.0-91-gf04ef09
In-Reply-To: <1454178490-17873-1-git-send-email-dennis@kaarsemaker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285126>

When a server supports hook options, we send it options for quiet and
force if the user used push --force/--quiet.

Signed-off-by: Dennis Kaarsemaker <git@vger.kernel.org>
---
 send-pack.c                  | 10 ++++++++++
 t/t5544-push-hook-options.sh | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)
 create mode 100755 t/t5544-push-hook-options.sh

diff --git a/send-pack.c b/send-pack.c
index 047bd18..5630327 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -371,6 +371,8 @@ int send_pack(struct send_pack_args *args,
 	int agent_supported = 0;
 	int use_atomic = 0;
 	int atomic_supported = 0;
+	int hook_options_supported = 0;
+	int hook_options_seen = 0;
 	unsigned cmds_sent = 0;
 	int ret;
 	struct async demux;
@@ -393,6 +395,8 @@ int send_pack(struct send_pack_args *args,
 		args->use_thin_pack = 0;
 	if (server_supports("atomic"))
 		atomic_supported = 1;
+	if (server_supports("hook-options"))
+		hook_options_supported = 1;
 
 	if (args->push_cert != SEND_PACK_PUSH_CERT_NEVER) {
 		int len;
@@ -429,6 +433,12 @@ int send_pack(struct send_pack_args *args,
 		strbuf_addstr(&cap_buf, " atomic");
 	if (agent_supported)
 		strbuf_addf(&cap_buf, " agent=%s", git_user_agent_sanitized());
+	if (hook_options_supported) {
+		if (args->quiet)
+			strbuf_addf(&cap_buf, "%squiet", hook_options_seen++ ? "," : " hook-options=");
+		if (args->force_update)
+			strbuf_addf(&cap_buf, "%sforce", hook_options_seen++ ? "," : " hook-options=");
+	}
 
 	/*
 	 * NEEDSWORK: why does delete-refs have to be so specific to
diff --git a/t/t5544-push-hook-options.sh b/t/t5544-push-hook-options.sh
new file mode 100755
index 0000000..6d52ad1
--- /dev/null
+++ b/t/t5544-push-hook-options.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+
+test_description='pushing to a repository with hook options'
+
+. ./test-lib.sh
+
+test_expect_success 'hook options are passed on to hooks' '
+	git init --bare remote.git &&
+	write_script remote.git/hooks/post-receive <<-\EOF &&
+	echo "post-receive-hook"
+	echo $GIT_HOOK_OPTIONS
+	EOF
+	(
+		test_commit one &&
+		git push remote/ master:test 2> actual &&
+		test_commit two &&
+		git push --quiet remote/ master:test 2>> actual &&
+		test_commit three &&
+		git push --force remote/ master:test 2>> actual &&
+		test_commit four &&
+		git push --quiet --force remote/ master:test 2>> actual
+	) &&
+	sed -ne "s/remote: \([^ ]*\).*/\1/p" -i actual &&
+	cat > expected <<-\EOF &&
+	post-receive-hook
+
+	post-receive-hook
+	quiet
+	post-receive-hook
+	force
+	post-receive-hook
+	quiet,force
+	EOF
+	test_cmp expected actual
+'
+
+test_done
-- 
2.7.0-91-gf04ef09
