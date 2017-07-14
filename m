Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4B5420357
	for <e@80x24.org>; Fri, 14 Jul 2017 18:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750857AbdGNSDQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 14:03:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:40986 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750725AbdGNSDQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 14:03:16 -0400
Received: (qmail 31807 invoked by uid 109); 14 Jul 2017 18:03:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Jul 2017 18:03:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13275 invoked by uid 111); 14 Jul 2017 18:03:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Jul 2017 14:03:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Jul 2017 14:03:13 -0400
Date:   Fri, 14 Jul 2017 14:03:13 -0400
From:   Jeff King <peff@peff.net>
To:     Marko Kungla <marko.kungla@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: bug with check-ref-format outside of repository
Message-ID: <20170714180313.apsnbnw7no2nvtf5@sigill.intra.peff.net>
References: <CAKY_R-uk9hpR2hbkPsw2cqoMo6bQKoyp6cWTO20L3fOWfLW2-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKY_R-uk9hpR2hbkPsw2cqoMo6bQKoyp6cWTO20L3fOWfLW2-Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 08, 2017 at 03:17:32AM +0200, Marko Kungla wrote:

> As contrived e.g: if I have in my "workspace" sub directories mostly
> git repositories, but some not and if I exec,
> "for d in */ ; do (cd $d && git check-ref-format --branch @{-1});
> done" then I get 3 possible responses.
> 
> git version: 2.13.0
> 1. Valid branch name
> 2. fatal: '@{-1}' is not a valid branch name
> 3. fatal: BUG: setup_git_env called without repository
> 
> git version 2.13.2.915.ga9c46e097
> 1. Valid branch name
> 2. fatal: '@{-1}' is not a valid branch name
> 3. BUG: environment.c:178: git environment hasn't been setup

Thanks for the report. It's right to return an error, but obviously we
should never hit the BUG() in the lazy-setup code.

I think "check-ref-format --branch" is inherently a repository-only
operation, since its purpose is to look in the reflog with @{-1} and
similar branch-substitutions. Technically you can do:

  $ cd /not/a/git/repo
  $ git check-ref-format --branch 'refs/heads/foo'

but I'm not sure why you would want to. So I think the patch below is
probably the right direction. The other alternative is for
interpret_nth_prior_checkout() to detect the "not in a repo" case and
quietly return "nope, we couldn't find such a reflog entry".

+cc Jonathan, who added the original call in 49cc460d8 (Allow
"check-ref-format --branch" from subdirectory, 2010-08-05). That commit
message doesn't give any indication of why we used the gently form.
Looking back at the original thread[1], I suspect it was mostly out of
conservatism.

[1] https://public-inbox.org/git/20100806033922.GS22369@burratino/

---
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
