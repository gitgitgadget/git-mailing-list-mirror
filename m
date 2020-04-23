Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8F5C2BA19
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 06:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 792F1214AF
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 06:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="zX4EBHYA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgDWGrP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 02:47:15 -0400
Received: from out1.migadu.com ([91.121.223.63]:24548 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbgDWGrP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 02:47:15 -0400
X-Greylist: delayed 345 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Apr 2020 02:47:14 EDT
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1587624087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5jgi4NCWwdtvZB1MtWWesBvRwXfL233BM7cuAwB9CMI=;
        b=zX4EBHYAHz/AInu+1+XjJrxLBSZhFm+T7QBR/rX/gkdbUKSEMAtWUrY7uv3BLq+zbs0fPO
        vSR8vmfBjbiIW7ErjCRP41IYADVQV2mJXBUlE/Z0le1juU5s7NroVCa3/bK/8yD8FiEa3k
        3H1SAqqgX6vFGRwboF/9YfBjZ6X4FzM=
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     git@vger.kernel.org
Cc:     "Raymond E. Pasco" <ray@ameretat.dev>
Subject: [PATCH] ssh: add 'ssh.keyfile' option
Date:   Thu, 23 Apr 2020 02:41:10 -0400
Message-Id: <20200423064110.77258-1-ray@ameretat.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a specific private key needs to be used with a repository, manually
specifying it via 'core.sshCommand' is not ideal. This option allows a
keyfile to be specified in the local configuration. If a keyfile is
specified, SSH agents are disabled for the command.

Signed-off-by: Raymond E. Pasco <ray@ameretat.dev>
---
I've encountered the need to specify a specific SSH key to be used with
a repository, and overriding the whole ssh command isn't great. I have
only tested this with OpenSSH.

 connect.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/connect.c b/connect.c
index 23013c6344..dc7c75ead3 100644
--- a/connect.c
+++ b/connect.c
@@ -1104,8 +1104,9 @@ static struct child_process *git_connect_git(int fd[2], char *hostandport,
  * `args` for running ssh in Git's SSH-tunneled transport.
  */
 static void push_ssh_options(struct argv_array *args, struct argv_array *env,
-			     enum ssh_variant variant, const char *port,
-			     enum protocol_version version, int flags)
+			     enum ssh_variant variant, const char *keyfile,
+			     const char *port, enum protocol_version version,
+			     int flags)
 {
 	if (variant == VARIANT_SSH &&
 	    version > 0) {
@@ -1144,6 +1145,26 @@ static void push_ssh_options(struct argv_array *args, struct argv_array *env,
 	if (variant == VARIANT_TORTOISEPLINK)
 		argv_array_push(args, "-batch");
 
+	if (keyfile) {
+		switch (variant) {
+		case VARIANT_AUTO:
+			BUG("VARIANT_AUTO passed to push_ssh_options");
+		case VARIANT_SIMPLE:
+			die(_("ssh variant 'simple' does not support setting keyfiles"));
+		case VARIANT_SSH:
+			argv_array_push(args, "-a");
+			argv_array_push(args, "-i");
+			argv_array_push(args, keyfile);
+			break;
+		case VARIANT_PLINK:
+		case VARIANT_PUTTY:
+		case VARIANT_TORTOISEPLINK:
+			argv_array_push(args, "-noagent");
+			argv_array_push(args, "-i");
+			argv_array_push(args, keyfile);
+		}
+	}
+
 	if (port) {
 		switch (variant) {
 		case VARIANT_AUTO:
@@ -1169,6 +1190,7 @@ static void fill_ssh_args(struct child_process *conn, const char *ssh_host,
 			  int flags)
 {
 	const char *ssh;
+	const char *keyfile;
 	enum ssh_variant variant;
 
 	if (looks_like_command_line_option(ssh_host))
@@ -1200,14 +1222,16 @@ static void fill_ssh_args(struct child_process *conn, const char *ssh_host,
 		argv_array_push(&detect.args, ssh);
 		argv_array_push(&detect.args, "-G");
 		push_ssh_options(&detect.args, &detect.env_array,
-				 VARIANT_SSH, port, version, flags);
+				 VARIANT_SSH, keyfile, port, version, flags);
 		argv_array_push(&detect.args, ssh_host);
 
 		variant = run_command(&detect) ? VARIANT_SIMPLE : VARIANT_SSH;
 	}
 
+	git_config_get_string_const("ssh.keyfile", &keyfile);
+
 	argv_array_push(&conn->args, ssh);
-	push_ssh_options(&conn->args, &conn->env_array, variant, port, version, flags);
+	push_ssh_options(&conn->args, &conn->env_array, variant, keyfile, port, version, flags);
 	argv_array_push(&conn->args, ssh_host);
 }
 
-- 
2.26.1

