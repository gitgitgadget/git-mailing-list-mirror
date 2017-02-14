Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F05A1FC44
	for <e@80x24.org>; Tue, 14 Feb 2017 06:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751950AbdBNGDG (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 01:03:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:54876 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750766AbdBNGDG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 01:03:06 -0500
Received: (qmail 11574 invoked by uid 109); 14 Feb 2017 06:03:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 06:03:06 +0000
Received: (qmail 678 invoked by uid 111); 14 Feb 2017 06:03:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 01:03:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2017 01:03:03 -0500
Date:   Tue, 14 Feb 2017 01:03:03 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: [PATCH 2/7] grep: do not unnecessarily query repo for "--"
Message-ID: <20170214060303.7y7osfhwnxadcr32@sigill.intra.peff.net>
References: <20170214060021.einv7372exbxa23z@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170214060021.einv7372exbxa23z@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Tan <jonathantanmy@google.com>

When running a command of the form

  git grep --no-index pattern -- path

in the absence of a Git repository, an error message will be printed:

  fatal: BUG: setup_git_env called without repository

This is because "git grep" tries to interpret "--" as a rev. "git grep"
has always tried to first interpret "--" as a rev for at least a few
years, but this issue was upgraded from a pessimization to a bug in
commit 59332d1 ("Resurrect "git grep --no-index"", 2010-02-06), which
calls get_sha1 regardless of whether --no-index was specified. This bug
appeared to be benign until commit b1ef400 ("setup_git_env: avoid blind
fall-back to ".git"", 2016-10-20) when Git was taught to die in this
situation.  (This "git grep" bug appears to be one of the bugs that
commit b1ef400 is meant to flush out.)

Therefore, always interpret "--" as signaling the end of options,
instead of trying to interpret it as a rev first.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Jeff King <peff@peff.net>
---
Unchanged from your original.

 builtin/grep.c  |  9 +++++----
 t/t7810-grep.sh | 12 ++++++++++++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 5a282c4d0..081e1b57a 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1154,6 +1154,11 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		const char *arg = argv[i];
 		unsigned char sha1[20];
 		struct object_context oc;
+		if (!strcmp(arg, "--")) {
+			i++;
+			seen_dashdash = 1;
+			break;
+		}
 		/* Is it a rev? */
 		if (!get_sha1_with_context(arg, 0, sha1, &oc)) {
 			struct object *object = parse_object_or_die(sha1, arg);
@@ -1162,10 +1167,6 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			add_object_array_with_path(object, arg, &list, oc.mode, oc.path);
 			continue;
 		}
-		if (!strcmp(arg, "--")) {
-			i++;
-			seen_dashdash = 1;
-		}
 		break;
 	}
 
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 19f0108f8..29202f0e7 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -982,6 +982,18 @@ test_expect_success 'grep -e -- -- path' '
 	test_cmp expected actual
 '
 
+test_expect_success 'grep --no-index pattern -- path' '
+	rm -fr non &&
+	mkdir -p non/git &&
+	(
+		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd non/git &&
+		echo hello >hello &&
+		git grep --no-index o -- .
+	)
+'
+
 cat >expected <<EOF
 hello.c:int main(int argc, const char **argv)
 hello.c:	printf("Hello world.\n");
-- 
2.12.0.rc1.471.ga79ec8999

