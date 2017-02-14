Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01E2E1FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 20:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753766AbdBNUdk (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 15:33:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:55283 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755455AbdBNUda (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 15:33:30 -0500
Received: (qmail 18660 invoked by uid 109); 14 Feb 2017 20:33:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 20:33:30 +0000
Received: (qmail 6326 invoked by uid 111); 14 Feb 2017 20:33:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 15:33:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2017 15:33:28 -0500
Date:   Tue, 14 Feb 2017 15:33:28 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Duy Nguyen <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] remote: avoid reading $GIT_DIR config in non-repo
Message-ID: <20170214203327.icdvrhwpmarvwe5y@sigill.intra.peff.net>
References: <20170214203117.xnln6ahb3l32agqb@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170214203117.xnln6ahb3l32agqb@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "git ls-remote" command can be run outside of a
repository, but needs to look up configured remotes. The
config code is smart enough to handle this case itself, but
we also check the historical "branches" and "remotes" paths
in $GIT_DIR. The git_path() function causes us to blindly
look at ".git/remotes", even if we know we aren't in a git
repository.

For now, this is just an unlikely bug (you probably don't
have such a file if you're not in a repository), but it will
become more obvious once we merge b1ef400ee (setup_git_env:
avoid blind fall-back to ".git", 2016-10-20):

  [now]
  $ git ls-remote
  fatal: No remote configured to list refs from.

  [with b1ef400ee]
  $ git ls-remote
  fatal: BUG: setup_git_env called without repository

We can fix this by skipping these sources entirely when
we're outside of a repository.

The test is a little more complex than the demonstration
above. Rather than detect the correct behavior by parsing
the error message, we can actually set up a case where the
remote name we give is a valid repository, but b1ef400ee
would cause us to die in the configuration step.

This test doesn't fail now, but it future-proofs us for the
b1ef400ee change.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote.c             | 2 +-
 t/t5512-ls-remote.sh | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index bf1bf2309..9f83fe2c4 100644
--- a/remote.c
+++ b/remote.c
@@ -693,7 +693,7 @@ static struct remote *remote_get_1(const char *name,
 		name = get_default(current_branch, &name_given);
 
 	ret = make_remote(name, 0);
-	if (valid_remote_nick(name)) {
+	if (valid_remote_nick(name) && have_git_dir()) {
 		if (!valid_remote(ret))
 			read_remotes_file(ret);
 		if (!valid_remote(ret))
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 55fc83fc0..94fc9be9c 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -248,4 +248,13 @@ test_expect_success PIPE,JGIT,GIT_DAEMON 'indicate no refs in standards-complian
 	test_expect_code 2 git ls-remote --exit-code git://localhost:$JGIT_DAEMON_PORT/empty.git
 '
 
+test_expect_success 'ls-remote works outside repository' '
+	# It is important for this repo to be inside the nongit
+	# area, as we want a repo name that does not include
+	# slashes (because those inhibit some of our configuration
+	# lookups).
+	nongit git init --bare dst.git &&
+	nongit git ls-remote dst.git
+'
+
 test_done
-- 
2.12.0.rc1.479.g59880b11e

