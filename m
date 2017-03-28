Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11D831FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 19:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755560AbdC1Tsd (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 15:48:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:53197 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752808AbdC1Tsc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 15:48:32 -0400
Received: (qmail 11964 invoked by uid 109); 28 Mar 2017 19:48:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 19:48:13 +0000
Received: (qmail 14657 invoked by uid 111); 28 Mar 2017 19:48:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 15:48:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Mar 2017 15:48:10 -0400
Date:   Tue, 28 Mar 2017 15:48:10 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 18/18] daemon: use an argv_array to exec children
Message-ID: <20170328194810.upseqefljp2v3a6n@sigill.intra.peff.net>
References: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our struct child_process already has its own argv_array.
Let's use that to avoid having to format options into
separate buffers.

Note that we'll need to declare the child process outside of
the run_service_command() helper to do this. But that opens
up a further simplification, which is that the helper can
append to our argument list, saving each caller from
specifying "." manually.

Signed-off-by: Jeff King <peff@peff.net>
---
Of all the patches in this series, this is the one where I was most
undecided on whether the result was more readable or not.

My ulterior motive, of course, was to get rid of the unchecked
snprintf() into timebuf. But it could also just become an xsnprintf()
with no further changes.

 daemon.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/daemon.c b/daemon.c
index 473e6b6b6..f70d27b82 100644
--- a/daemon.c
+++ b/daemon.c
@@ -449,46 +449,42 @@ static void copy_to_log(int fd)
 	fclose(fp);
 }
 
-static int run_service_command(const char **argv)
+static int run_service_command(struct child_process *cld)
 {
-	struct child_process cld = CHILD_PROCESS_INIT;
-
-	cld.argv = argv;
-	cld.git_cmd = 1;
-	cld.err = -1;
-	if (start_command(&cld))
+	argv_array_push(&cld->args, ".");
+	cld->git_cmd = 1;
+	cld->err = -1;
+	if (start_command(cld))
 		return -1;
 
 	close(0);
 	close(1);
 
-	copy_to_log(cld.err);
+	copy_to_log(cld->err);
 
-	return finish_command(&cld);
+	return finish_command(cld);
 }
 
 static int upload_pack(void)
 {
-	/* Timeout as string */
-	char timeout_buf[64];
-	const char *argv[] = { "upload-pack", "--strict", NULL, ".", NULL };
-
-	argv[2] = timeout_buf;
-
-	snprintf(timeout_buf, sizeof timeout_buf, "--timeout=%u", timeout);
-	return run_service_command(argv);
+	struct child_process cld = CHILD_PROCESS_INIT;
+	argv_array_pushl(&cld.args, "upload-pack", "--strict", NULL);
+	argv_array_pushf(&cld.args, "--timeout=%u", timeout);
+	return run_service_command(&cld);
 }
 
 static int upload_archive(void)
 {
-	static const char *argv[] = { "upload-archive", ".", NULL };
-	return run_service_command(argv);
+	struct child_process cld = CHILD_PROCESS_INIT;
+	argv_array_push(&cld.args, "upload-archive");
+	return run_service_command(&cld);
 }
 
 static int receive_pack(void)
 {
-	static const char *argv[] = { "receive-pack", ".", NULL };
-	return run_service_command(argv);
+	struct child_process cld = CHILD_PROCESS_INIT;
+	argv_array_push(&cld.args, "receive-pack");
+	return run_service_command(&cld);
 }
 
 static struct daemon_service daemon_service[] = {
-- 
2.12.2.845.g55fcf8b10
