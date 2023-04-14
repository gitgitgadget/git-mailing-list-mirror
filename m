Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4924C77B72
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 21:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjDNVZz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 17:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDNVZy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 17:25:54 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4365B8D
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 14:25:27 -0700 (PDT)
Received: (qmail 22384 invoked by uid 109); 14 Apr 2023 21:25:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Apr 2023 21:25:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31687 invoked by uid 111); 14 Apr 2023 21:25:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Apr 2023 17:25:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Apr 2023 17:25:11 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Jonas Haag <jonas@lophus.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: [PATCH v3 3/7] v0 protocol: fix sha1/sha256 confusion for
 capabilities^{}
Message-ID: <20230414212511.GC639756@coredump.intra.peff.net>
References: <20230414212404.GA639653@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230414212404.GA639653@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit eb398797cd (connect: advertized capability is not a ref,
2016-09-09) added support for an upload-pack server responding with:

  0000000000000000000000000000000000000000        capabilities^{}

followed by a NUL and the actual capabilities. We correctly parse the
oid using the packet_reader's hash_algo field, but then we compare it to
null_oid(), which will instead use our current repo's default algorithm.
If we're defaulting to sha256 locally but the other side is sha1, they
won't match and we'll fail to parse the line (and thus die()).

This can cause a test failure when the suite is run with
GIT_TEST_DEFAULT_HASH=sha256, and we even do so regularly via the
linux-sha256 CI job. But since the test requires JGit to run, it's
usually just skipped, and nobody noticed the problem.

The reason the original patch used JGit is that Git itself does not ever
produce such a line via upload-pack; the feature was added to fix a
real-world problem when interacting with JGit. That was good for
verifying that the incompatibility was fixed, but it's not a good
regression test:

  - hardly anybody runs it, because you have to have jgit installed;
    hence this bug going unnoticed

  - we're depending on jgit's behavior for the test to do anything
    useful. In particular, this behavior is only relevant to the v0
    protocol, but these days we ask for the v2 protocol by default. So
    for modern jgit, this is probably testing nothing.

  - it's complicated and slow. We had to do some fifo trickery to handle
    races, and this one test makes up 40% of the runtime of the total
    script.

Instead, let's just hard-code the response that's of interest to us.
That will test exactly what we want for every run, and reveals the bug
when run in sha256 mode. And of course we'll fix the actual bug by using
the correct hash_algo struct.

Signed-off-by: Jeff King <peff@peff.net>
---
 connect.c            |  3 ++-
 t/t5512-ls-remote.sh | 51 +++++++++++++-------------------------------
 2 files changed, 17 insertions(+), 37 deletions(-)

diff --git a/connect.c b/connect.c
index 0dc739c4e5..b7ba5f5727 100644
--- a/connect.c
+++ b/connect.c
@@ -263,7 +263,8 @@ static int process_dummy_ref(const struct packet_reader *reader)
 		return 0;
 	name++;
 
-	return oideq(null_oid(), &oid) && !strcmp(name, "capabilities^{}");
+	return oideq(reader->hash_algo->null_oid, &oid) &&
+		!strcmp(name, "capabilities^{}");
 }
 
 static void check_no_capabilities(const char *line, int len)
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index b868e20d7e..6fb67ddce4 100755
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
2.40.0.515.gdfb9e78b42

