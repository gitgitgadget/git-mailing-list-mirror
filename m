Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74C561FAAD
	for <e@80x24.org>; Wed,  1 Feb 2017 12:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752085AbdBAMBX (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 07:01:23 -0500
Received: from mout.gmx.net ([212.227.15.18]:57449 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751950AbdBAMBV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 07:01:21 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M6BKc-1cFRqH0aYE-00y8rw; Wed, 01
 Feb 2017 13:01:11 +0100
Date:   Wed, 1 Feb 2017 13:01:10 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 3/4] git_connect(): factor out SSH variant handling
In-Reply-To: <cover.1485950225.git.johannes.schindelin@gmx.de>
Message-ID: <838100594d8461d05da365d1b1c97c1f6c8c8ea3.1485950225.git.johannes.schindelin@gmx.de>
References: <cover.1485442231.git.johannes.schindelin@gmx.de> <cover.1485950225.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:B4x5ClYGMRuisL3z8SmMq4AnimGFISsXWhVd4sKmUujFghfrPxS
 GWsKW48tfRiYQPtT3huIvZ4T6Zp9DN3/b7qWsJZT2NRteYCivzw5+jzOs4FNBVi0PZ6Ona2
 TE6jl5fZUDZ9HWJyemNXLQ17y8Lld1KfUzOzzqElQ7uyB7CSieZRBzuztjkxQHgJ5j8QRJk
 ukDa5foe49H49D4EBvPaQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uG/3V/YlpfY=:XIZmGi+HsutIOgKVz41WAw
 4+IL66gbQlxoViXXCJPqWsLTj0SLOw1Ci0EeZK99DYYWvnc+O2dKVuCXthtFymZXNSYCQmxUJ
 2llMZI/nkKrdp8vT7y0YvjHVfPsPwygkFW+EqR8HJTY/NcvVm3G5xqiuHuCQY3UEdWQBU0exp
 NS5N9XhNpfQbTuGbCez0yTjzd6ki2egIFLD349K4OKWHhss9+QIwGykv15M8WoIapWEH/akDn
 /ybYi7+Cm4bcofQLAl9wN1mw8C1WLTp5hXDRxd1T7rYC56DclXp9xbFIIfU4wT9o4MYYi+6OB
 rkLRBhbAuSwXaKfeMBXr4z3wzZY/vVKPl+3FBPKUwKf4jmw9DRL3dIO7gcufV5a4nCScW6sFC
 GJFtpbywUYI0jmFNxcVmUUUT0sZ/WYr7Hy4Xqf5X/B8gGQjExpL1VzxWJndAPhii6Gv33RrYA
 C/+Jj6gsQxLJ+AJKPYvaUQ/ue+R/g7UdSHlPnxVwWzdNkH/yQAn7niq5KludWyO8gaWu1z973
 N1jqMJNh8JD2iCPuaOSjOk57g1UIYaWy2tQCCcSYztz1gnjv9ySQE8BH0Na3CyfPhNlGkzzbM
 r+e6Gg9ZdLynodx/l6lQavOXOa5i+g/iV9nHOkEtyXg2ZpNuqlimQFeFS0gsdMyYBcTcZxh1L
 2wLlUTo9+k9F6wyb0ld24O2bhBemD2cqtPIcWQcZ+P4cMRj33hdrxTcx6mBgw+dDh2685zncr
 LEvlyqJLbL5Jd2puHCAPgQ6fOXEt8qicQr0Y2diAQdZlgXGLsKvpCeBnRbBHXsQmEe+ibnj9c
 xWrRVDDdhmXTdFgdNpLM4plxKdkgg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We handle plink and tortoiseplink as OpenSSH replacements, by passing
the correct command-line options when detecting that they are used.

To let users override that auto-detection (in case Git gets it wrong),
we need to introduce new code to that end.

In preparation for this code, let's factor out the SSH variant handling
into its own function, handle_ssh_variant().

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 connect.c | 72 ++++++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 46 insertions(+), 26 deletions(-)

diff --git a/connect.c b/connect.c
index 9f750eacb6..2734b9a1ca 100644
--- a/connect.c
+++ b/connect.c
@@ -691,6 +691,44 @@ static const char *get_ssh_command(void)
 	return NULL;
 }
 
+static int handle_ssh_variant(const char *ssh_command, int is_cmdline,
+			      int *port_option, int *needs_batch)
+{
+	const char *variant;
+	char *p = NULL;
+
+	if (!is_cmdline) {
+		p = xstrdup(ssh_command);
+		variant = basename(p);
+	} else {
+		const char **ssh_argv;
+
+		p = xstrdup(ssh_command);
+		if (split_cmdline(p, &ssh_argv)) {
+			variant = basename((char *)ssh_argv[0]);
+			/*
+			 * At this point, variant points into the buffer
+			 * referenced by p, hence we do not need ssh_argv
+			 * any longer.
+			 */
+			free(ssh_argv);
+		} else
+			return 0;
+	}
+
+	if (!strcasecmp(variant, "plink") ||
+	    !strcasecmp(variant, "plink.exe"))
+		*port_option = 'P';
+	else if (!strcasecmp(variant, "tortoiseplink") ||
+		 !strcasecmp(variant, "tortoiseplink.exe")) {
+		*port_option = 'P';
+		*needs_batch = 1;
+	}
+	free(p);
+
+	return 1;
+}
+
 /*
  * This returns a dummy child_process if the transport protocol does not
  * need fork(2), or a struct child_process object if it does.  Once done,
@@ -773,7 +811,6 @@ struct child_process *git_connect(int fd[2], const char *url,
 			int port_option = 'p';
 			char *ssh_host = hostandport;
 			const char *port = NULL;
-			char *ssh_argv0 = NULL;
 			transport_check_allowed("ssh");
 			get_host_and_port(&ssh_host, &port);
 
@@ -794,15 +831,10 @@ struct child_process *git_connect(int fd[2], const char *url,
 			}
 
 			ssh = get_ssh_command();
-			if (ssh) {
-				char *split_ssh = xstrdup(ssh);
-				const char **ssh_argv;
-
-				if (split_cmdline(split_ssh, &ssh_argv))
-					ssh_argv0 = xstrdup(ssh_argv[0]);
-				free(split_ssh);
-				free((void *)ssh_argv);
-			} else {
+			if (ssh)
+				handle_ssh_variant(ssh, 1, &port_option,
+						   &needs_batch);
+			else {
 				/*
 				 * GIT_SSH is the no-shell version of
 				 * GIT_SSH_COMMAND (and must remain so for
@@ -813,22 +845,10 @@ struct child_process *git_connect(int fd[2], const char *url,
 				ssh = getenv("GIT_SSH");
 				if (!ssh)
 					ssh = "ssh";
-
-				ssh_argv0 = xstrdup(ssh);
-			}
-
-			if (ssh_argv0) {
-				const char *base = basename(ssh_argv0);
-
-				if (!strcasecmp(base, "tortoiseplink") ||
-				    !strcasecmp(base, "tortoiseplink.exe")) {
-					port_option = 'P';
-					needs_batch = 1;
-				} else if (!strcasecmp(base, "plink") ||
-					   !strcasecmp(base, "plink.exe")) {
-					port_option = 'P';
-				}
-				free(ssh_argv0);
+				else
+					handle_ssh_variant(ssh, 0,
+							   &port_option,
+							   &needs_batch);
 			}
 
 			argv_array_push(&conn->args, ssh);
-- 
2.11.1.windows.prerelease.2.9.g3014b57


