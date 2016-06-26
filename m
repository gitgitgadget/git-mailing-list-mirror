Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0FDD1F744
	for <e@80x24.org>; Sun, 26 Jun 2016 04:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752001AbcFZEO6 (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 00:14:58 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:38952 "EHLO
	homiemail-a17.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751883AbcFZEOp (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jun 2016 00:14:45 -0400
Received: from homiemail-a17.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a17.g.dreamhost.com (Postfix) with ESMTP id DE86A2B206D;
	Sat, 25 Jun 2016 21:14:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=novalis.org;
	 bh=G5GHksV6QuZEA8jmjWZQCWXK6r8=; b=pAGJ+2obKe2vUOXKOK/OA1iSp6f+
	SF/tz3dk5X2kZ5hT3NMe2D7YGEZeUZpxn4mE3nb3SW5KycNy4SY6DJiwA46VIKpG
	4hlXUva02i9ldi3QmkTZsv3qjuqV8eKvAt0Qn6VHukkeE0BvJ4yhuAHNV9BfhVD2
	zx7cfwiMv0jPa0Y=
Received: from frank.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com [207.38.164.98])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: novalis@novalis.org)
	by homiemail-a17.g.dreamhost.com (Postfix) with ESMTPSA id 4EE172B205C;
	Sat, 25 Jun 2016 21:14:44 -0700 (PDT)
From:	David Turner <novalis@novalis.org>
To:	git@vger.kernel.org, pclouds@gmail.com, kamggg@gmail.com
Cc:	David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v13 15/20] index-helper: kill mode
Date:	Sun, 26 Jun 2016 00:14:19 -0400
Message-Id: <1466914464-10358-15-git-send-email-novalis@novalis.org>
X-Mailer: git-send-email 2.8.0.rc4.20.g1d4f562
In-Reply-To: <1466914464-10358-1-git-send-email-novalis@novalis.org>
References: <1466914464-10358-1-git-send-email-novalis@novalis.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: David Turner <dturner@twopensource.com>

Add a new command (and command-line arg) to allow index-helpers to
exit cleanly.

This is mainly useful for tests.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-index-helper.txt |  3 +++
 index-helper.c                     | 31 ++++++++++++++++++++++++++++++-
 t/t7900-index-helper.sh            |  9 +++++++++
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-index-helper.txt b/Documentation/git-index-helper.txt
index b2ca511..6f63a9e 100644
--- a/Documentation/git-index-helper.txt
+++ b/Documentation/git-index-helper.txt
@@ -40,6 +40,9 @@ OPTIONS
 --detach::
 	Detach from the shell.
 
+--kill::
+	Kill any running index-helper and clean up the socket
+
 NOTES
 -----
 
diff --git a/index-helper.c b/index-helper.c
index bb39326..f7a002b 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -361,6 +361,8 @@ static void loop(int fd, int idle_in_seconds)
 					 * alive, nothing to do.
 					 */
 				}
+			} else if (!strcmp(buf, "die")) {
+				break;
 			} else {
 				warning("BUG: Bogus command %s", buf);
 			}
@@ -391,10 +393,29 @@ static const char * const usage_text[] = {
 	NULL
 };
 
+static void request_kill(void)
+{
+	int fd = unix_stream_connect(git_path("index-helper.sock"));
+
+	if (fd >= 0) {
+		write_in_full(fd, "die", 4);
+		close(fd);
+	}
+
+	/*
+	 * The child will try to do this anyway, but we want to be
+	 * ready to launch a new daemon immediately after this command
+	 * returns.
+	 */
+
+	unlink(git_path("index-helper.sock"));
+	return;
+}
+
 int main(int argc, char **argv)
 {
 	const char *prefix;
-	int idle_in_seconds = 600, detach = 0;
+	int idle_in_seconds = 600, detach = 0, kill = 0;
 	int fd;
 	struct strbuf socket_path = STRBUF_INIT;
 	struct option options[] = {
@@ -403,6 +424,7 @@ int main(int argc, char **argv)
 		OPT_BOOL(0, "strict", &to_verify,
 			 N_("verify shared memory after creating")),
 		OPT_BOOL(0, "detach", &detach, N_("detach the process")),
+		OPT_BOOL(0, "kill", &kill, N_("request that existing index helper processes exit")),
 		OPT_END()
 	};
 
@@ -417,6 +439,13 @@ int main(int argc, char **argv)
 			  options, usage_text, 0))
 		die(_("too many arguments"));
 
+	if (kill) {
+		if (detach)
+			die(_("--kill doesn't want any other options"));
+		request_kill();
+		return 0;
+	}
+
 	atexit(cleanup);
 	sigchain_push_common(cleanup_on_signal);
 
diff --git a/t/t7900-index-helper.sh b/t/t7900-index-helper.sh
index 114c112..e71b5af 100755
--- a/t/t7900-index-helper.sh
+++ b/t/t7900-index-helper.sh
@@ -20,4 +20,13 @@ test_expect_success 'index-helper smoke test' '
 	test_path_is_missing .git/index-helper.sock
 '
 
+test_expect_success 'index-helper creates usable path file and can be killed' '
+	test_when_finished "git index-helper --kill" &&
+	test_path_is_missing .git/index-helper.sock &&
+	git index-helper --detach &&
+	test -S .git/index-helper.sock &&
+	git index-helper --kill &&
+	test_path_is_missing .git/index-helper.sock
+'
+
 test_done
-- 
1.9.1

