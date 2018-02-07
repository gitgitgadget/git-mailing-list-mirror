Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B5E11F404
	for <e@80x24.org>; Wed,  7 Feb 2018 01:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932258AbeBGBOS (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 20:14:18 -0500
Received: from mail-qt0-f201.google.com ([209.85.216.201]:36022 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932252AbeBGBOM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 20:14:12 -0500
Received: by mail-qt0-f201.google.com with SMTP id c12so3065262qtj.3
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 17:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=rFom2Pm0CN7p60EEkiCY+CmmCLKvsCKXBf5g1rwxkUg=;
        b=Tue9itXwHenS/mRhL3ro5/Ne3TmAjsqPk1nyHRUai6VKzIWaCTi9fbSCKageoYprOI
         cDrtafPM8x4Oq/uF4VXjkrANQL4pW0GdiMZ5pCKxifIFyh5Gnd1tciuMmWIRMa/ZLypD
         IfeuRu4oeuafsDKt3fRKv/xYj5yCqGgW6H/eie+g/ctF12xlMuItvJqs0c2dIHO6IkiR
         TslfMQ2FlLfbdGtH7YuW6S2l55vswGfUHOn8FAiq+k7delIzJ+AAAjPpxhfQOq8rB1vP
         6P9QWgf65iEglUFk1Ax3agsHnl78Zs3UT8QscfFxChhFs3znyIo6ouicLQ26WXH0paXl
         fcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=rFom2Pm0CN7p60EEkiCY+CmmCLKvsCKXBf5g1rwxkUg=;
        b=uS2mP+ZwvNEPdYbMaf4MdR2mFEzth8ezjwkt5W8sDsfo0o5GigQmrz53Nq7aDb06un
         L64o/l3/vCa9wRTNHGsgXptSIFYnJV8s0qO03JjDP/icbrQoJpuVVsqmT9FLt2YAblb9
         YB7G3V7mx7w5CsljDlgGBYqJSg3JUcd5//Cmim1KY+pC6ElxtpIu/42PCOzVCwPgLiTn
         iui2s+509aBp9rvnD1f1PrYHHEWQ575Ngi54amZ89zSiX6BbYxD08S0Nffl639zHva4i
         mz9XRKlgtDUXZxXY2Ucg9dyK9DsIg+k3DzqONbn2P/K+AqpqwPAE0Tk8W1q/n+sL80w4
         IfFg==
X-Gm-Message-State: APf1xPAXgSWOXSjkrnpcRUSoP7Pn2P2pDghT5YjTBaaFY0EQswpFjg0P
        mYsSBIyvBpgvU3DqZ0HpyeD27LYv+nMmZw307ymbx1OLFKVBZVZBs0QT0tPAZHD8t1LCti6zOzz
        emCO084Pkdxzoa2KCavkJVrMPiA4y6Qw48mBl8nMedsOdosXGm5XV3yKJAw==
X-Google-Smtp-Source: AH8x226R7IaaAPg0iKGfOUkRArbZb80D1Zyho5+eEJ/pu9fHE8kZ/dskvng82rpK3MWEe8D9oa/kWZ6IFvg=
MIME-Version: 1.0
X-Received: by 10.200.83.17 with SMTP id t17mr3195323qtn.43.1517966051436;
 Tue, 06 Feb 2018 17:14:11 -0800 (PST)
Date:   Tue,  6 Feb 2018 17:13:01 -0800
In-Reply-To: <20180207011312.189834-1-bmwill@google.com>
Message-Id: <20180207011312.189834-25-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com> <20180207011312.189834-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v3 24/35] connect: refactor git_connect to only get the
 protocol version once
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, gitster@pobox.com,
        jrnieder@gmail.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
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
index 9577528f3..dbf4def65 100644
--- a/connect.c
+++ b/connect.c
@@ -1029,6 +1029,7 @@ static enum ssh_variant determine_ssh_variant(const char *ssh_command,
  */
 static struct child_process *git_connect_git(int fd[2], char *hostandport,
 					     const char *path, const char *prog,
+					     enum protocol_version version,
 					     int flags)
 {
 	struct child_process *conn;
@@ -1067,10 +1068,10 @@ static struct child_process *git_connect_git(int fd[2], char *hostandport,
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
@@ -1086,14 +1087,14 @@ static struct child_process *git_connect_git(int fd[2], char *hostandport,
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
@@ -1146,7 +1147,8 @@ static void push_ssh_options(struct argv_array *args, struct argv_array *env,
 
 /* Prepare a child_process for use by Git's SSH-tunneled transport. */
 static void fill_ssh_args(struct child_process *conn, const char *ssh_host,
-			  const char *port, int flags)
+			  const char *port, enum protocol_version version,
+			  int flags)
 {
 	const char *ssh;
 	enum ssh_variant variant;
@@ -1180,14 +1182,14 @@ static void fill_ssh_args(struct child_process *conn, const char *ssh_host,
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
 
@@ -1208,6 +1210,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 	char *hostandport, *path;
 	struct child_process *conn;
 	enum protocol protocol;
+	enum protocol_version version = get_protocol_version_config();
 
 	/* Without this we cannot rely on waitpid() to tell
 	 * what happened to our children.
@@ -1222,7 +1225,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 		printf("Diag: path=%s\n", path ? path : "NULL");
 		conn = NULL;
 	} else if (protocol == PROTO_GIT) {
-		conn = git_connect_git(fd, hostandport, path, prog, flags);
+		conn = git_connect_git(fd, hostandport, path, prog, version, flags);
 	} else {
 		struct strbuf cmd = STRBUF_INIT;
 		const char *const *var;
@@ -1265,12 +1268,12 @@ struct child_process *git_connect(int fd[2], const char *url,
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
2.16.0.rc1.238.g530d649a79-goog

