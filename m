Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 670511F404
	for <e@80x24.org>; Thu, 15 Mar 2018 17:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752588AbeCORcs (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 13:32:48 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:51094 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752078AbeCORcn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:32:43 -0400
Received: by mail-vk0-f73.google.com with SMTP id x140so4570823vkx.17
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 10:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=BT6Jhkn3j1st8CU/XrNxczI78VjFBwPbrgCC+KjlmIc=;
        b=Ad/yBYoF+gNa1gVCC+Le6nzm8PH3T+HLvTHbdV7S84KLdOmvQzXvQRoSbmqIJFsNHH
         CAZkdwO0Gcxj37V3dVf8Ld5UkwdUcYqFBnKsjRUEfGTAW3rvwPXt9LTC0N8LXZmulLJP
         YbRWrJqJrM3BRCpUj4WXaDp4lYK3cYlbammDjtNpNuFAou63yx05Qii7WkAe6QL8wUKi
         qILg0IkMOzzWD68YvMaUsL/7a5xe1R+meDGhrR1WOGxDC0nUL7SD6Bhuu22m8jIgiT+7
         RJ3LJ1Z5WTzsWYoR0PxRdxo4UFahvIfHP44HYq+s4JMYSkr4A/AZ0lhX2aIRobdKX9D2
         CdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=BT6Jhkn3j1st8CU/XrNxczI78VjFBwPbrgCC+KjlmIc=;
        b=eFFFIENa4bpZsHadQ/CtJ0zYSr5VQUObZytZi4/OqcP2rir+RbtXW4XRk8VHtub0Wj
         u7vN3/a9+p41W6LYTkixtozpBk/JN09CFJnTzzWsLnHsutvUDbWES2TeXK3XrzWLTbat
         3i5gsHLrPkiRFPi0TxQd/vJgh4MyrWLnsawl1dD40wGjXXJyzIvrncBNFITg3B+jJvoc
         18hcDUo1QJgUESOuZpu2/b5P1DVHbRbjvR7SF5NfRgjl/EQxbsH2KemQqxnzwQPgtBGA
         YzOA4Br5hsy03czSb0wQB7aO1san/BC8lS2QotIHCeFoxMCtTEGRdou2Bgu2VkOfYZ9d
         zoBw==
X-Gm-Message-State: AElRT7HxyDV0t0KYYQnRRroARxuSItRL7QWM/HQOnI4rk+d9EZ8rTNBG
        p5IvlMIXy3vfbBzGAbzq2HaEuhe75dWX3Iq3FBQDXsiVVY1f72cNJBSC1eK8n/8qnpn09LWPotS
        mREpq7OEgc/B2r5rIjes1YV7DsNlPUyvaKeqd4iCXDMfuZUG+bXGJ13JROw==
X-Google-Smtp-Source: AG47ELugZfO6q1JIiTirFaPk+D4f8At10f9TuaAf/hSWhYuUrSa3Ik/ONhIWyzkcXC9XNTLRN8Yz7BeUH/k=
MIME-Version: 1.0
X-Received: by 10.31.196.199 with SMTP id u190mr748463vkf.40.1521135162138;
 Thu, 15 Mar 2018 10:32:42 -0700 (PDT)
Date:   Thu, 15 Mar 2018 10:31:30 -0700
In-Reply-To: <20180315173142.176023-1-bmwill@google.com>
Message-Id: <20180315173142.176023-24-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com> <20180315173142.176023-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v6 23/35] connect: refactor git_connect to only get the
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

