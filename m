Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A6DE92FC6
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 21:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjJEVdb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 17:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjJEVda (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 17:33:30 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407AAE4
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 14:33:27 -0700 (PDT)
Received: (qmail 27319 invoked by uid 109); 5 Oct 2023 21:33:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Oct 2023 21:33:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29460 invoked by uid 111); 5 Oct 2023 21:33:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Oct 2023 17:33:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 5 Oct 2023 17:33:26 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/3] daemon: free listen_addr before returning
Message-ID: <20231005213326.GC986467@coredump.intra.peff.net>
References: <20231005212802.GA982892@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231005212802.GA982892@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We build up a string list of listen addresses from the command-line
arguments, but never free it. This causes t5811 to complain of a leak
(though curiously it seems to do so only when compiled with gcc, not
with clang).

To handle this correctly, we have to do a little refactoring:

  - there are two exit points from the main function, depending on
    whether we are entering the main loop or serving a single client
    (since rather than a traditional fork model, we re-exec ourselves
    with the extra "--serve" argument to accommodate Windows).

    We don't need --listen at all in the --serve case, of course, but it
    is passed along by the parent daemon, which simply copies all of the
    command-line options it got.

  - we just "return serve()" to run the main loop, giving us no chance
    to do any cleanup

So let's use a "ret" variable to store the return code, and give
ourselves a single exit point at the end. That gives us one place to do
cleanup.

Note that this code also uses the "use a no-dup string-list, but
allocate strings we add to it" trick, meaning string_list_clear() will
not realize it should free them. We can fix this by switching to a "dup"
string-list, but using the "append_nodup" function to add to it (this is
preferable to tweaking the strdup_strings flag before clearing, as it
puts all the subtle memory-ownership code together).

Signed-off-by: Jeff King <peff@peff.net>
---
Diff is a little messy due to indentation. Viewing with "-w" makes it
more clear, or just viewing the post-image.

 daemon.c                     | 37 ++++++++++++++++++++----------------
 t/t5811-proto-disable-git.sh |  2 ++
 2 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/daemon.c b/daemon.c
index f5e597114b..17d331b2f3 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1243,19 +1243,20 @@ static int serve(struct string_list *listen_addr, int listen_port,
 int cmd_main(int argc, const char **argv)
 {
 	int listen_port = 0;
-	struct string_list listen_addr = STRING_LIST_INIT_NODUP;
+	struct string_list listen_addr = STRING_LIST_INIT_DUP;
 	int serve_mode = 0, inetd_mode = 0;
 	const char *pid_file = NULL, *user_name = NULL, *group_name = NULL;
 	int detach = 0;
 	struct credentials *cred = NULL;
 	int i;
+	int ret;
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		const char *v;
 
 		if (skip_prefix(arg, "--listen=", &v)) {
-			string_list_append(&listen_addr, xstrdup_tolower(v));
+			string_list_append_nodup(&listen_addr, xstrdup_tolower(v));
 			continue;
 		}
 		if (skip_prefix(arg, "--port=", &v)) {
@@ -1437,22 +1438,26 @@ int cmd_main(int argc, const char **argv)
 			die_errno("failed to redirect stderr to /dev/null");
 	}
 
-	if (inetd_mode || serve_mode)
-		return execute();
+	if (inetd_mode || serve_mode) {
+		ret = execute();
+	} else {
+		if (detach) {
+			if (daemonize())
+				die("--detach not supported on this platform");
+		}
 
-	if (detach) {
-		if (daemonize())
-			die("--detach not supported on this platform");
-	}
+		if (pid_file)
+			write_file(pid_file, "%"PRIuMAX, (uintmax_t) getpid());
 
-	if (pid_file)
-		write_file(pid_file, "%"PRIuMAX, (uintmax_t) getpid());
+		/* prepare argv for serving-processes */
+		strvec_push(&cld_argv, argv[0]); /* git-daemon */
+		strvec_push(&cld_argv, "--serve");
+		for (i = 1; i < argc; ++i)
+			strvec_push(&cld_argv, argv[i]);
 
-	/* prepare argv for serving-processes */
-	strvec_push(&cld_argv, argv[0]); /* git-daemon */
-	strvec_push(&cld_argv, "--serve");
-	for (i = 1; i < argc; ++i)
-		strvec_push(&cld_argv, argv[i]);
+		ret = serve(&listen_addr, listen_port, cred);
+	}
 
-	return serve(&listen_addr, listen_port, cred);
+	string_list_clear(&listen_addr, 0);
+	return ret;
 }
diff --git a/t/t5811-proto-disable-git.sh b/t/t5811-proto-disable-git.sh
index 8ac6b2a1d0..ed773e7432 100755
--- a/t/t5811-proto-disable-git.sh
+++ b/t/t5811-proto-disable-git.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test disabling of git-over-tcp in clone/fetch'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-proto-disable.sh"
 . "$TEST_DIRECTORY/lib-git-daemon.sh"
-- 
2.42.0.836.g4b88bf80c5
