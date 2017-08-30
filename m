Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A636920285
	for <e@80x24.org>; Wed, 30 Aug 2017 17:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752337AbdH3Rux (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 13:50:53 -0400
Received: from mout.web.de ([212.227.17.11]:62799 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751754AbdH3RuI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 13:50:08 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LiUG8-1dEsEc2nmu-00ch93 for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 19:50:06 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 08/34] connect: release strbuf on error return in git_connect()
Date:   Wed, 30 Aug 2017 19:49:39 +0200
Message-Id: <20170830175005.20756-9-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170830175005.20756-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
X-Provags-ID: V03:K0:Yp9WXB/LlGK0HbpJHDwQ1zi7u7WGrKRtQ4kIhL+87eO+LOeZvi6
 6IUE938GKsVi1BY9fE/Z0KQk91sqtZGSsZgS9fwmm+QnV4gKjyHPT5mN673cpzxP+fdDwG0
 CZnmS3a2ZC2jcE9xCL4skNhs9Wi9hbThcRcr7tmoXfplnaSdXXCMvGSJgfYBF3cjAoXg49i
 o0Pmp3Nz8Y8AJPrIYgRQg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cl9uZhqxEvk=:BCYu7wbN3xYdm5XEISZtJC
 rL9CWXPCRH8Nt4fZXoudjRRibsLIrfuY4EiKR1rWvBLWRoGIIAc+BK6SUE7JXLrMl4XFsSZou
 wUz/prMCPayd4Dp3uMfcAsGd2C81Ko2ozU24WnPGj6LwgJnCYMlMb670/tv643cTS8UeEkIYl
 sgwb05BrfAFa0KO2ldaTA1Jf/V165xU0HTZMBDbUfZvbDvTbQiD0OQpgJGvwvhSUeRw5z6acq
 P4QfC+q/tXjYyS36yuiS/jm8UEXvRI7ieSIVVw+m+5dS52/DSpV6/dJJ1Gbbd5RiDV8wtl1yz
 HPKvWZF3Vkzeuolb8QGQX4ykuVk23o17EDp6UnvclmpJmTDap3cTWSjuq2kVQX9COxcbR5FqA
 us9RGJuMgJ/Wdi7s56WjbCq6e/29bz6Rdtx0zzj+dxiiZ4twEi9ERu8r2ODz5LhWW4FnVtTDY
 HJ4lQAqCg19JKytWwJQrJLVi/9Ll0UfYhvT7kJBf9g9FPi2ZLczqdZ/Wzt1uqeFOsbzcwXQHI
 anIQxqqn/aSLvdcpfOezDuVMRJyqla/aj3QJFi6gBl28yZW8GTj7fSOncsg0nSnVhqpxrWStl
 Qie+NXheauIbGdZn6rBIA38efZXzybdQ8bMUqhDBOlfGsbnMtMGRcaGTYOpuGeiq765o44wou
 OHzz1koxttOMQboa2xryV2KzTKS8wUZ4eSg/0ozmqCRlY91ZCILY+G41KWinmp3DJe8xMhXzK
 9jLvtvSAZb8kku67oIYiiF39No+J+7Ixz5fHZuFecFHYhNoVf6uxPgjrCbJtwnkzOyOuXS05d
 5oEdqZ3W0l6humKopePzr+d+Mdllg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reduce the scope of the variable cmd and release it before returning
early.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 connect.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/connect.c b/connect.c
index 49b28b83be..df56c0cbff 100644
--- a/connect.c
+++ b/connect.c
@@ -775,146 +775,148 @@ static void handle_ssh_variant(const char *ssh_command, int is_cmdline,
 struct child_process *git_connect(int fd[2], const char *url,
 				  const char *prog, int flags)
 {
 	char *hostandport, *path;
 	struct child_process *conn = &no_fork;
 	enum protocol protocol;
-	struct strbuf cmd = STRBUF_INIT;
 
 	/* Without this we cannot rely on waitpid() to tell
 	 * what happened to our children.
 	 */
 	signal(SIGCHLD, SIG_DFL);
 
 	protocol = parse_connect_url(url, &hostandport, &path);
 	if ((flags & CONNECT_DIAG_URL) && (protocol != PROTO_SSH)) {
 		printf("Diag: url=%s\n", url ? url : "NULL");
 		printf("Diag: protocol=%s\n", prot_name(protocol));
 		printf("Diag: hostandport=%s\n", hostandport ? hostandport : "NULL");
 		printf("Diag: path=%s\n", path ? path : "NULL");
 		conn = NULL;
 	} else if (protocol == PROTO_GIT) {
 		/*
 		 * Set up virtual host information based on where we will
 		 * connect, unless the user has overridden us in
 		 * the environment.
 		 */
 		char *target_host = getenv("GIT_OVERRIDE_VIRTUAL_HOST");
 		if (target_host)
 			target_host = xstrdup(target_host);
 		else
 			target_host = xstrdup(hostandport);
 
 		transport_check_allowed("git");
 
 		/* These underlying connection commands die() if they
 		 * cannot connect.
 		 */
 		if (git_use_proxy(hostandport))
 			conn = git_proxy_connect(fd, hostandport);
 		else
 			git_tcp_connect(fd, hostandport, flags);
 		/*
 		 * Separate original protocol components prog and path
 		 * from extended host header with a NUL byte.
 		 *
 		 * Note: Do not add any other headers here!  Doing so
 		 * will cause older git-daemon servers to crash.
 		 */
 		packet_write_fmt(fd[1],
 			     "%s %s%chost=%s%c",
 			     prog, path, 0,
 			     target_host, 0);
 		free(target_host);
 	} else {
+		struct strbuf cmd = STRBUF_INIT;
+
 		conn = xmalloc(sizeof(*conn));
 		child_process_init(conn);
 
 		if (looks_like_command_line_option(path))
 			die("strange pathname '%s' blocked", path);
 
 		strbuf_addstr(&cmd, prog);
 		strbuf_addch(&cmd, ' ');
 		sq_quote_buf(&cmd, path);
 
 		/* remove repo-local variables from the environment */
 		conn->env = local_repo_env;
 		conn->use_shell = 1;
 		conn->in = conn->out = -1;
 		if (protocol == PROTO_SSH) {
 			const char *ssh;
 			int needs_batch = 0;
 			int port_option = 'p';
 			char *ssh_host = hostandport;
 			const char *port = NULL;
 			transport_check_allowed("ssh");
 			get_host_and_port(&ssh_host, &port);
 
 			if (!port)
 				port = get_port(ssh_host);
 
 			if (flags & CONNECT_DIAG_URL) {
 				printf("Diag: url=%s\n", url ? url : "NULL");
 				printf("Diag: protocol=%s\n", prot_name(protocol));
 				printf("Diag: userandhost=%s\n", ssh_host ? ssh_host : "NULL");
 				printf("Diag: port=%s\n", port ? port : "NONE");
 				printf("Diag: path=%s\n", path ? path : "NULL");
 
 				free(hostandport);
 				free(path);
 				free(conn);
+				strbuf_release(&cmd);
 				return NULL;
 			}
 
 			if (looks_like_command_line_option(ssh_host))
 				die("strange hostname '%s' blocked", ssh_host);
 
 			ssh = get_ssh_command();
 			if (ssh)
 				handle_ssh_variant(ssh, 1, &port_option,
 						   &needs_batch);
 			else {
 				/*
 				 * GIT_SSH is the no-shell version of
 				 * GIT_SSH_COMMAND (and must remain so for
 				 * historical compatibility).
 				 */
 				conn->use_shell = 0;
 
 				ssh = getenv("GIT_SSH");
 				if (!ssh)
 					ssh = "ssh";
 				else
 					handle_ssh_variant(ssh, 0,
 							   &port_option,
 							   &needs_batch);
 			}
 
 			argv_array_push(&conn->args, ssh);
 			if (flags & CONNECT_IPV4)
 				argv_array_push(&conn->args, "-4");
 			else if (flags & CONNECT_IPV6)
 				argv_array_push(&conn->args, "-6");
 			if (needs_batch)
 				argv_array_push(&conn->args, "-batch");
 			if (port) {
 				argv_array_pushf(&conn->args,
 						 "-%c", port_option);
 				argv_array_push(&conn->args, port);
 			}
 			argv_array_push(&conn->args, ssh_host);
 		} else {
 			transport_check_allowed("file");
 		}
 		argv_array_push(&conn->args, cmd.buf);
 
 		if (start_command(conn))
 			die("unable to fork");
 
 		fd[0] = conn->out; /* read from child's stdout */
 		fd[1] = conn->in;  /* write to child's stdin */
 		strbuf_release(&cmd);
 	}
 	free(hostandport);
 	free(path);
 	return conn;
 }
-- 
2.14.1

