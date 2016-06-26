Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D6BA1FEAA
	for <e@80x24.org>; Sun, 26 Jun 2016 04:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbcFZEPA (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 00:15:00 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:38964 "EHLO
	homiemail-a17.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751898AbcFZEOq (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jun 2016 00:14:46 -0400
Received: from homiemail-a17.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a17.g.dreamhost.com (Postfix) with ESMTP id 675A02B206A;
	Sat, 25 Jun 2016 21:14:46 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=novalis.org;
	 bh=p8DMRos+KSIdu+LhiWe6RNMzLc8=; b=KTgpAq7B2Lk8WcQzAA2b1xqkz6O5
	Xz36r3icJNLusa7NHkxLDmoiAtWunxi1kV9oeB4VZC9qiVz2fF8tcGypcbuyYRcf
	3tdJ6NwOt5YLuqw+NjO9Nqr/tTEhd6cYrYttyyNyEBFAG8NpxXIEvLIWReBJgA5S
	DIOSZXInZDLrbb8=
Received: from frank.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com [207.38.164.98])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: novalis@novalis.org)
	by homiemail-a17.g.dreamhost.com (Postfix) with ESMTPSA id CA6F02B205C;
	Sat, 25 Jun 2016 21:14:45 -0700 (PDT)
From:	David Turner <novalis@novalis.org>
To:	git@vger.kernel.org, pclouds@gmail.com, kamggg@gmail.com
Cc:	David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v13 17/20] index-helper: autorun mode
Date:	Sun, 26 Jun 2016 00:14:21 -0400
Message-Id: <1466914464-10358-17-git-send-email-novalis@novalis.org>
X-Mailer: git-send-email 2.8.0.rc4.20.g1d4f562
In-Reply-To: <1466914464-10358-1-git-send-email-novalis@novalis.org>
References: <1466914464-10358-1-git-send-email-novalis@novalis.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: David Turner <dturner@twopensource.com>

Soon, we'll want to automatically start index-helper, so we need
a mode that silently exits if it can't start up (either because
it's not in a git dir, or because another one is already running).

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-index-helper.txt |  4 ++++
 index-helper.c                     | 29 +++++++++++++++++++++++------
 t/t7900-index-helper.sh            |  8 ++++++++
 3 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-index-helper.txt b/Documentation/git-index-helper.txt
index 6f63a9e..eea5a38 100644
--- a/Documentation/git-index-helper.txt
+++ b/Documentation/git-index-helper.txt
@@ -43,6 +43,10 @@ OPTIONS
 --kill::
 	Kill any running index-helper and clean up the socket
 
+--autorun::
+	If index-helper is not already running, start it.  Else, do
+	nothing.
+
 NOTES
 -----
 
diff --git a/index-helper.c b/index-helper.c
index 9cfcb9e..f57fc14 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -415,8 +415,9 @@ static void request_kill(void)
 int main(int argc, char **argv)
 {
 	const char *prefix;
-	int idle_in_seconds = 600, detach = 0, kill = 0;
+	int idle_in_seconds = 600, detach = 0, kill = 0, autorun = 0;
 	int fd;
+	int nongit;
 	struct strbuf socket_path = STRBUF_INIT;
 	struct option options[] = {
 		OPT_INTEGER(0, "exit-after", &idle_in_seconds,
@@ -425,6 +426,7 @@ int main(int argc, char **argv)
 			 N_("verify shared memory after creating")),
 		OPT_BOOL(0, "detach", &detach, N_("detach the process")),
 		OPT_BOOL(0, "kill", &kill, N_("request that existing index helper processes exit")),
+		OPT_BOOL(0, "autorun", &autorun, N_("this is an automatic run of git index-helper, so certain errors can be solved by silently exiting")),
 		OPT_END()
 	};
 
@@ -434,7 +436,14 @@ int main(int argc, char **argv)
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(usage_text, options);
 
-	prefix = setup_git_directory();
+	prefix = setup_git_directory_gently(&nongit);
+	if (nongit) {
+		if (autorun)
+			exit(0);
+		else
+			die(_("not a git repository"));
+	}
+
 	if (parse_options(argc, (const char **)argv, prefix,
 			  options, usage_text, 0))
 		die(_("too many arguments"));
@@ -448,10 +457,18 @@ int main(int argc, char **argv)
 
 	/* check that no other copy is running */
 	fd = unix_stream_connect(git_path("index-helper.sock"));
-	if (fd >= 0)
-		die(_("Already running"));
-	if (errno != ECONNREFUSED && errno != ENOENT)
-		die_errno(_("Unexpected error checking socket"));
+	if (fd >= 0) {
+		if (autorun)
+			exit(0);
+		else
+			die(_("Already running"));
+	}
+	if (errno != ECONNREFUSED && errno != ENOENT) {
+		if (autorun)
+			return 0;
+		else
+			die_errno(_("Unexpected error checking socket"));
+	}
 
 	atexit(cleanup);
 	sigchain_push_common(cleanup_on_signal);
diff --git a/t/t7900-index-helper.sh b/t/t7900-index-helper.sh
index 7159971..aa6e5fc 100755
--- a/t/t7900-index-helper.sh
+++ b/t/t7900-index-helper.sh
@@ -38,4 +38,12 @@ test_expect_success 'index-helper will not start if already running' '
 	grep "Already running" err
 '
 
+test_expect_success 'index-helper is quiet with --autorun' '
+	test_when_finished "git index-helper --kill" &&
+	git index-helper --kill &&
+	git index-helper --detach &&
+	test -S .git/index-helper.sock &&
+	git index-helper --autorun
+'
+
 test_done
-- 
1.9.1

