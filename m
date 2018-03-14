Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFD011F404
	for <e@80x24.org>; Wed, 14 Mar 2018 18:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752524AbeCNSdQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 14:33:16 -0400
Received: from mail-yw0-f202.google.com ([209.85.161.202]:38935 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752218AbeCNSdL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 14:33:11 -0400
Received: by mail-yw0-f202.google.com with SMTP id t9so4777315ywg.6
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 11:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=BT6Jhkn3j1st8CU/XrNxczI78VjFBwPbrgCC+KjlmIc=;
        b=EHGlYrIn/cKYrd3wHyZqsvV2HSdKK0sxcuQSUuQMtQpLozfR8JcKUpqu+euG1OpfXM
         JnpERzB2kUcrBY8qkQ4xDA06XRTGzPmknTtoRwcM6vFRs5YxJbRRbYLlrejTzCDj21Ik
         3crcF6oMyXq03HgxL1kBRXN4QUSVxgJ1iOfH9h0hDbfVrKtirJ3s/qqXDa1K0PJsAz5u
         lVHNDVf+Sq/DFEbQdi5JP1N4nCFhaAei38jjElh5GW7MoNEfJyWDSbsfQDEbxKXsZDaH
         HHhAvPHx0p1HyqtdOXyVZ5gUkM4EkO/kg4ydh3xUyAJSSfPwkkz1VVo1Ygs6g7AS/XLP
         98cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=BT6Jhkn3j1st8CU/XrNxczI78VjFBwPbrgCC+KjlmIc=;
        b=ItFj3r5mKJFwe7/teubhY5WemS/DFRRY10WJyjIRDKlIO/UcVMBiNL+GVTj68p/qkG
         h6ShstQVIWjqeeSufXn1Wck+thVpXlbSMW3aZfEXS6v/O4UBpJDu3iCBQT7ws7l8hXk9
         YYr/HRh0ku7p6BJ+lzRzL2Slv1VbSG46kX/MsuyVxW6fW8w0Pto4wEJIJsxciU3NywYy
         dCDYNcgPM7rM3r/tibotBgLmGS7TQQJgLu37Q+eiN815kzKiMTmGKZTnnz0UwMfZt7f1
         c54tIEUhK/ec3PfJN+pffcoZTuotyg0PRlO0i1mH5ULJ7SfWLULiiPlLgPqxyJ3U6/Z2
         VrCA==
X-Gm-Message-State: AElRT7FPUiZRLgTuhzqTnZYPw6r4AD5S2fXLTN1YAunTUPxxli9CCwem
        sWiKIdizN2r1FCmAuvGctLP/wjUfuDQw8fQy1PyEiZc0s1ytymk+rRJ0xQQT2HxojNWlUJfOm+0
        78/e3GH3kgyhimLF2SzAg5fnBjnfsKx6Uq624HTUz9nXWvIL0f9u+CJDzCQ==
X-Google-Smtp-Source: AG47ELtD4BiaKNfS+8saua2CsqRiNFKRH/8jdpbD3jF5DDk3b97uAUxBztbwLMY1BMaJ3R0zG8HjhEbiLsY=
MIME-Version: 1.0
X-Received: by 10.129.145.201 with SMTP id i192mr2695260ywg.234.1521052390896;
 Wed, 14 Mar 2018 11:33:10 -0700 (PDT)
Date:   Wed, 14 Mar 2018 11:32:00 -0700
In-Reply-To: <20180314183213.223440-1-bmwill@google.com>
Message-Id: <20180314183213.223440-24-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v5 23/35] connect: refactor git_connect to only get the
 protocol version once
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, jonathantanmy@google.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of having each builtin transport asking for which protocol
version the user has configured in 'protocol.version' by calling
`get_protocol_version_config()` multiple times, factor this logic out
so there is just a single call at the beginning of `git_connect()`.

This will be helpful in the next patch where we can have centralized
logic which determines if we need to request a different protocol
version than what the user has configured.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 connect.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/connect.c b/connect.c
index 5bb9d34844..a57a060dc4 100644
--- a/connect.c
+++ b/connect.c
@@ -1035,6 +1035,7 @@ static enum ssh_variant determine_ssh_variant(const char *ssh_command,
  */
 static struct child_process *git_connect_git(int fd[2], char *hostandport,
 					     const char *path, const char *prog,
+					     enum protocol_version version,
 					     int flags)
 {
 	struct child_process *conn;
@@ -1073,10 +1074,10 @@ static struct child_process *git_connect_git(int fd[2], char *hostandport,
 		    target_host, 0);
 
 	/* If using a new version put that stuff here after a second null byte */
-	if (get_protocol_version_config() > 0) {
+	if (version > 0) {
 		strbuf_addch(&request, '\0');
 		strbuf_addf(&request, "version=%d%c",
-			    get_protocol_version_config(), '\0');
+			    version, '\0');
 	}
 
 	packet_write(fd[1], request.buf, request.len);
@@ -1092,14 +1093,14 @@ static struct child_process *git_connect_git(int fd[2], char *hostandport,
  */
 static void push_ssh_options(struct argv_array *args, struct argv_array *env,
 			     enum ssh_variant variant, const char *port,
-			     int flags)
+			     enum protocol_version version, int flags)
 {
 	if (variant == VARIANT_SSH &&
-	    get_protocol_version_config() > 0) {
+	    version > 0) {
 		argv_array_push(args, "-o");
 		argv_array_push(args, "SendEnv=" GIT_PROTOCOL_ENVIRONMENT);
 		argv_array_pushf(env, GIT_PROTOCOL_ENVIRONMENT "=version=%d",
-				 get_protocol_version_config());
+				 version);
 	}
 
 	if (flags & CONNECT_IPV4) {
@@ -1152,7 +1153,8 @@ static void push_ssh_options(struct argv_array *args, struct argv_array *env,
 
 /* Prepare a child_process for use by Git's SSH-tunneled transport. */
 static void fill_ssh_args(struct child_process *conn, const char *ssh_host,
-			  const char *port, int flags)
+			  const char *port, enum protocol_version version,
+			  int flags)
 {
 	const char *ssh;
 	enum ssh_variant variant;
@@ -1186,14 +1188,14 @@ static void fill_ssh_args(struct child_process *conn, const char *ssh_host,
 		argv_array_push(&detect.args, ssh);
 		argv_array_push(&detect.args, "-G");
 		push_ssh_options(&detect.args, &detect.env_array,
-				 VARIANT_SSH, port, flags);
+				 VARIANT_SSH, port, version, flags);
 		argv_array_push(&detect.args, ssh_host);
 
 		variant = run_command(&detect) ? VARIANT_SIMPLE : VARIANT_SSH;
 	}
 
 	argv_array_push(&conn->args, ssh);
-	push_ssh_options(&conn->args, &conn->env_array, variant, port, flags);
+	push_ssh_options(&conn->args, &conn->env_array, variant, port, version, flags);
 	argv_array_push(&conn->args, ssh_host);
 }
 
@@ -1214,6 +1216,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 	char *hostandport, *path;
 	struct child_process *conn;
 	enum protocol protocol;
+	enum protocol_version version = get_protocol_version_config();
 
 	/* Without this we cannot rely on waitpid() to tell
 	 * what happened to our children.
@@ -1228,7 +1231,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 		printf("Diag: path=%s\n", path ? path : "NULL");
 		conn = NULL;
 	} else if (protocol == PROTO_GIT) {
-		conn = git_connect_git(fd, hostandport, path, prog, flags);
+		conn = git_connect_git(fd, hostandport, path, prog, version, flags);
 	} else {
 		struct strbuf cmd = STRBUF_INIT;
 		const char *const *var;
@@ -1271,12 +1274,12 @@ struct child_process *git_connect(int fd[2], const char *url,
 				strbuf_release(&cmd);
 				return NULL;
 			}
-			fill_ssh_args(conn, ssh_host, port, flags);
+			fill_ssh_args(conn, ssh_host, port, version, flags);
 		} else {
 			transport_check_allowed("file");
-			if (get_protocol_version_config() > 0) {
+			if (version > 0) {
 				argv_array_pushf(&conn->env_array, GIT_PROTOCOL_ENVIRONMENT "=version=%d",
-						 get_protocol_version_config());
+						 version);
 			}
 		}
 		argv_array_push(&conn->args, cmd.buf);
-- 
2.16.2.804.g6dcf76e118-goog

