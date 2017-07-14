Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F26BC20357
	for <e@80x24.org>; Fri, 14 Jul 2017 18:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750919AbdGNSSe (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 14:18:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:40996 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750799AbdGNSSe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 14:18:34 -0400
Received: (qmail 32479 invoked by uid 109); 14 Jul 2017 18:18:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Jul 2017 18:18:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13343 invoked by uid 111); 14 Jul 2017 18:18:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Jul 2017 14:18:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Jul 2017 14:18:31 -0400
Date:   Fri, 14 Jul 2017 14:18:31 -0400
From:   Jeff King <peff@peff.net>
To:     Marko Kungla <marko.kungla@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] check-ref-format: require a repository for --branch
Message-ID: <20170714181831.fvi2coppzhm747mk@sigill.intra.peff.net>
References: <CAKY_R-uk9hpR2hbkPsw2cqoMo6bQKoyp6cWTO20L3fOWfLW2-Q@mail.gmail.com>
 <20170714180313.apsnbnw7no2nvtf5@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170714180313.apsnbnw7no2nvtf5@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 14, 2017 at 02:03:13PM -0400, Jeff King wrote:

> So I think the patch below is probably the right direction.

And here it is with a real commit message, if this is what we want to
do.

I do feel like "check-ref-format --branch" is a misfeature. The
operation seems to fit better with "rev-parse" (which yes, is a kitchen
sink, but it does all sorts of similar resolution operations). I think
"git rev-parse --symbolic-full-name @{-1}" is basically the same thing
(modulo the refs/heads/ shortening).

-- >8 --
Subject: [PATCH] check-ref-format: require a repository for --branch

When the user asks "--branch" to interpret a branch name
like "@{-1}", we have to dig the answer out of the HEAD
reflog. We can obviously only do that if we have a
repository, and indeed, running it outside a repository
causes us to hit a BUG().

We basically have two options:

  1. We can define "@{-N}" outside of a repository as "no
     such branch" and die with "not a valid brach name".

  2. We can just declare that "--branch" must be run inside
     a repository, in which case we die with "not a git
     repository".

The effect is more or less the same for "@{-N}".
Technically one can use "--branch" outside of a repository
as long as you don't use any names that actually need
interpreting. But since intrpreting is the option's
documented purpose, there doesn't seem any point in trying
to resolve vanilla names like "foo" (which we end up just
printing to stdout verbatim).

So let's go with option 2.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/check-ref-format.c  | 3 +--
 t/t1402-check-ref-format.sh | 4 ++++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index eac499450..1e5f9835f 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -39,9 +39,8 @@ static char *collapse_slashes(const char *refname)
 static int check_ref_format_branch(const char *arg)
 {
 	struct strbuf sb = STRBUF_INIT;
-	int nongit;
 
-	setup_git_directory_gently(&nongit);
+	setup_git_directory();
 	if (strbuf_check_branch_ref(&sb, arg))
 		die("'%s' is not a valid branch name", arg);
 	printf("%s\n", sb.buf + 11);
diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index 0790edf60..1674b061e 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -161,6 +161,10 @@ test_expect_success 'check-ref-format --branch from subdir' '
 	test "$refname" = "$sha1"
 '
 
+test_expect_success 'check-ref-format --branch from non-repo' '
+	test_must_fail nongit git check-ref-format --branch @{-1}
+'
+
 valid_ref_normalized() {
 	prereq=
 	case $1 in
-- 
2.14.0.rc0.457.g08326e0ba

