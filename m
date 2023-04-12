Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC240C7619A
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 06:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjDLGbX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 02:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDLGbU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 02:31:20 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C061A4C24
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 23:31:19 -0700 (PDT)
Received: (qmail 17885 invoked by uid 109); 12 Apr 2023 06:31:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 Apr 2023 06:31:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17136 invoked by uid 111); 12 Apr 2023 06:31:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Apr 2023 02:31:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 12 Apr 2023 02:31:18 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Jonas Haag <jonas@lophus.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: [PATCH 3/7] t5512: stop using jgit for capabilities^{} test
Message-ID: <20230412063118.GC1681312@coredump.intra.peff.net>
References: <20230412062300.GA838367@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230412062300.GA838367@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit eb398797cd (connect: advertized capability is not a ref,
2016-09-09) added support for an upload-pack server responding with:

  0000000000000000000000000000000000000000        capabilities^{}

followed by a NUL and capabilities. This is not something Git itself has
ever produced for upload-pack, but JGit does. And hence the test used
JGit to reproduce the real-world situation. That was good for verifying
that the incompatibility was fixed, but it's a lousy regression test for
a few reasons:

  - hardly anybody runs it, because you have to have jgit installed

  - we're depending on jgit's behavior for the test to do anything
    useful. In particular, this behavior is only relevant to the v0
    protocol, but these days we ask for the v2 protocol by default. So
    for modern jgit, this is probably testing nothing.

  - it's complicated and slow. We had to do some fifo trickery to handle
    races, and this one test makes up 40% of the runtime of the total
    script.

Instead, let's just hard-code the response that's of interest to us.
That will test exactly what we want for every run.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5512-ls-remote.sh | 51 +++++++++++++-------------------------------
 1 file changed, 15 insertions(+), 36 deletions(-)

diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index ce7a9f1594..4e21ab60bf 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -300,44 +300,23 @@ test_expect_success 'ls-remote --symref omits filtered-out matches' '
 	test_cmp expect actual
 '
 
-test_lazy_prereq GIT_DAEMON '
-	test_bool_env GIT_TEST_GIT_DAEMON true
-'
-
-# This test spawns a daemon, so run it only if the user would be OK with
-# testing with git-daemon.
-test_expect_success PIPE,JGIT,GIT_DAEMON 'indicate no refs in standards-compliant empty remote' '
-	test_set_port JGIT_DAEMON_PORT &&
-	JGIT_DAEMON_PID= &&
-	git init --bare empty.git &&
-	>empty.git/git-daemon-export-ok &&
-	mkfifo jgit_daemon_output &&
-	{
-		jgit daemon --port="$JGIT_DAEMON_PORT" . >jgit_daemon_output &
-		JGIT_DAEMON_PID=$!
-	} &&
-	test_when_finished kill "$JGIT_DAEMON_PID" &&
-	{
-		read line &&
-		case $line in
-		Exporting*)
-			;;
-		*)
-			echo "Expected: Exporting" &&
-			false;;
-		esac &&
-		read line &&
-		case $line in
-		"Listening on"*)
-			;;
-		*)
-			echo "Expected: Listening on" &&
-			false;;
-		esac
-	} <jgit_daemon_output &&
+test_expect_success 'indicate no refs in v0 standards-compliant empty remote' '
+	# Git does not produce an output like this, but it does match the
+	# standard and is produced by other implementations like JGit. So
+	# hard-code the case we care about.
+	#
+	# The actual capabilities do not matter; there are none that would
+	# change how ls-remote behaves.
+	oid=0000000000000000000000000000000000000000 &&
+	test-tool pkt-line pack >input.q <<-EOF &&
+	$oid capabilities^{}Qcaps-go-here
+	0000
+	EOF
+	q_to_nul <input.q >input &&
+
 	# --exit-code asks the command to exit with 2 when no
 	# matching refs are found.
-	test_expect_code 2 git ls-remote --exit-code git://localhost:$JGIT_DAEMON_PORT/empty.git
+	test_expect_code 2 git ls-remote --exit-code --upload-pack=./cat-input .
 '
 
 test_expect_success 'ls-remote works outside repository' '
-- 
2.40.0.493.gfc602f1919

