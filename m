Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FD551F404
	for <e@80x24.org>; Wed, 28 Feb 2018 23:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965025AbeB1XY0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 18:24:26 -0500
Received: from mail-yb0-f201.google.com ([209.85.213.201]:47532 "EHLO
        mail-yb0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965020AbeB1XYT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 18:24:19 -0500
Received: by mail-yb0-f201.google.com with SMTP id c3-v6so2371506ybl.14
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 15:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=p8vESToyThfFpn15IVaKW/EDMpAadbVDww8jC4wpTHg=;
        b=r4BygSQ11TnoF3gno9NQ2aDa7uZm/1mOmChTsJkvVhgBPYdXOsKqo7kpzZayT0TOZk
         TzZEBzfXgsAu7uOXe+BTIOtE46XoawgoBeX8bL5Ftd6bI6mq9auZMC9fNVyedWS3ou2x
         G4K7iZCB9DeSsUYPm34tWGvQ7+T1VP+qWH+Vzo/9YNlnS0dlXSXqzk3Qm7TlVIp5HJ5A
         fVqORtzbI0xidzQ5d8glv+DHDJ3Tw/pQLffoOZGskh6wnSrYCFBEb2AKMFcFjPocBsry
         E87oxTfNUENzn6/KQg4s4DU5BFJ0R6c/WAMBZ4uMH4AbFOj86cyAgt2ysZuc1hRbSXTw
         C31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=p8vESToyThfFpn15IVaKW/EDMpAadbVDww8jC4wpTHg=;
        b=XOAwQwIi1Q/1zckDi2nXO5t9bELmgQFQlq1oG9of3Uk6SfOFFtb37iF8J2XY+BRbEW
         zmMqf8fAmDxvZjUirVPWcLPLT5kLL/sbpLM2YJCoSxVklIZfe0+EH9adkTxOQJWcHJiv
         rqdOQf5u4ltnmALQfwT5dY/ZbnFUHn96Z4k3bKYfmul4lFkvn3zlb62WsC4h1Yni2mIg
         ZLsGhzHEib2Mvn6wrv2F2mK2WZqwHNnsQNh2CDuZ8vuxodlzTMwjujASwsIBRnqAMgmq
         S4ancq2x2llD2dPQH6z4DtRtzQhokuxOfErpZoDx4vChM8Ko8B+sPNE6X65td3OM4O//
         7XFQ==
X-Gm-Message-State: APf1xPDVKucuANEqqIp6lQwlKRNKc8cXtJIxS/fiR8pF37pzn0sBBZ/D
        1iyzJ++vIQ7VM99NhU9mDYe3ie9g2On3Jqy/4q0g+An3cCXS4wg+vWp9Hl9/gXAB1/RPWpJR9D2
        wST9vAD6cowVJxeaaIVu/EKVTKYqZTBZT228i/lBm5NQD/7+kIIilm8IbGg==
X-Google-Smtp-Source: AH8x226Bhqr8uTaorzsGu8YosLjKK4lnNOdtJi5esk7k/wVvaaYt/6KMaSH5QjBTQjrWV3jG90gZzi0De28=
MIME-Version: 1.0
X-Received: by 10.129.2.9 with SMTP id 9mr10619776ywc.146.1519860258859; Wed,
 28 Feb 2018 15:24:18 -0800 (PST)
Date:   Wed, 28 Feb 2018 15:22:40 -0800
In-Reply-To: <20180228232252.102167-1-bmwill@google.com>
Message-Id: <20180228232252.102167-24-bmwill@google.com>
References: <20180207011312.189834-1-bmwill@google.com> <20180228232252.102167-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.107.gffe1b9127
Subject: [PATCH v4 23/35] connect: refactor git_connect to only get the
 protocol version once
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, Brandon Williams <bmwill@google.com>
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
index 66a9443c8..a0bfcdf4f 100644
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
2.16.2.395.g2e18187dfd-goog

