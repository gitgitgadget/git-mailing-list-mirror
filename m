Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 981F41F744
	for <e@80x24.org>; Sun, 26 Jun 2016 04:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbcFZEOs (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 00:14:48 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:38904 "EHLO
	homiemail-a17.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750940AbcFZEOj convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2016 00:14:39 -0400
Received: from homiemail-a17.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a17.g.dreamhost.com (Postfix) with ESMTP id B5C962B2070;
	Sat, 25 Jun 2016 21:14:38 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-type:content-transfer-encoding; s=novalis.org; bh=OPFnj
	odd7+iyck3sgFGZA26Mjdk=; b=mtfdvUyWYcBrrlFgqyUPCmz8vb46EfMBHGC9v
	sQN1jgKBuRmruvRixlsbbXXrLfk+fhWNQvlIB1ka2yLnN6s2cNc6lVlf/NbL74b+
	HOBN7fG05vIghP9p8EP6bVgMkDX8JGHbs6E1AnaJmUbvrz9OCtYGmiAKOQTFX/H1
	4zeK1Y=
Received: from frank.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com [207.38.164.98])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: novalis@novalis.org)
	by homiemail-a17.g.dreamhost.com (Postfix) with ESMTPSA id 2173A2B205C;
	Sat, 25 Jun 2016 21:14:38 -0700 (PDT)
From:	David Turner <novalis@novalis.org>
To:	git@vger.kernel.org, pclouds@gmail.com, kamggg@gmail.com
Cc:	David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v13 07/20] index-helper: add --detach
Date:	Sun, 26 Jun 2016 00:14:11 -0400
Message-Id: <1466914464-10358-7-git-send-email-novalis@novalis.org>
X-Mailer: git-send-email 2.8.0.rc4.20.g1d4f562
In-Reply-To: <1466914464-10358-1-git-send-email-novalis@novalis.org>
References: <1466914464-10358-1-git-send-email-novalis@novalis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

We detach after creating and opening the socket, because otherwise
we might return control to the shell before index-helper is ready to
accept commands.  This might lead to flaky tests.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-index-helper.txt | 3 +++
 index-helper.c                     | 9 +++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-index-helper.txt b/Documentation/git-index-helper.txt
index ca5a9de..228b1df 100644
--- a/Documentation/git-index-helper.txt
+++ b/Documentation/git-index-helper.txt
@@ -34,6 +34,9 @@ OPTIONS
 	for reading an index, but because it will happen in the
 	background, it's not noticable. `--strict` is enabled by default.
 
+--detach::
+	Detach from the shell.
+
 NOTES
 -----
 
diff --git a/index-helper.c b/index-helper.c
index d1e9287..7cc8166 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -17,7 +17,7 @@ struct shm {
 
 static struct shm shm_index;
 static struct shm shm_base_index;
-static int to_verify = 1;
+static int daemonized, to_verify = 1;
 
 static void release_index_shm(struct shm *is)
 {
@@ -36,6 +36,8 @@ static void cleanup_shm(void)
 
 static void cleanup(void)
 {
+	if (daemonized)
+		return;
 	unlink(git_path("index-helper.sock"));
 	cleanup_shm();
 }
@@ -298,7 +300,7 @@ static const char * const usage_text[] = {
 int main(int argc, char **argv)
 {
 	const char *prefix;
-	int idle_in_seconds = 600;
+	int idle_in_seconds = 600, detach = 0;
 	int fd;
 	struct strbuf socket_path = STRBUF_INIT;
 	struct option options[] = {
@@ -306,6 +308,7 @@ int main(int argc, char **argv)
 			    N_("exit if not used after some seconds")),
 		OPT_BOOL(0, "strict", &to_verify,
 			 N_("verify shared memory after creating")),
+		OPT_BOOL(0, "detach", &detach, N_("detach the process")),
 		OPT_END()
 	};
 
@@ -333,6 +336,8 @@ int main(int argc, char **argv)
 		die("--exit-after value must be less than %d seconds",
 		    INT_MAX / 1000);
 
+	if (detach && daemonize(&daemonized))
+		die_errno(_("unable to detach"));
 	loop(fd, idle_in_seconds);
 
 	close(fd);
-- 
1.9.1

