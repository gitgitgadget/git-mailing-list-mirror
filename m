Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDDA91FC3E
	for <e@80x24.org>; Sat, 29 Apr 2017 13:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756495AbdD2NOp (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Apr 2017 09:14:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:42217 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756491AbdD2NOn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Apr 2017 09:14:43 -0400
Received: (qmail 2064 invoked by uid 109); 29 Apr 2017 13:14:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 29 Apr 2017 13:14:41 +0000
Received: (qmail 29596 invoked by uid 111); 29 Apr 2017 13:15:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 29 Apr 2017 09:15:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Apr 2017 09:14:40 -0400
Date:   Sat, 29 Apr 2017 09:14:40 -0400
From:   Jeff King <peff@peff.net>
To:     Marc Branchaud <marcnarc@xiplink.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2 0/3] Make diff plumbing commands respect the
 indentHeuristic.
Message-ID: <20170429131439.ohgren3i7xr4tjex@sigill.intra.peff.net>
References: <20170427205037.1787-1-marcnarc@xiplink.com>
 <20170428223315.17140-1-marcnarc@xiplink.com>
 <20170429124052.yhgwofbbd5pkd24p@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170429124052.yhgwofbbd5pkd24p@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 29, 2017 at 08:40:52AM -0400, Jeff King wrote:

> On Fri, Apr 28, 2017 at 06:33:12PM -0400, Marc Branchaud wrote:
> 
> > v2: Fixed up the commit messages and added tests.
> > 
> > Marc Branchaud (2):
> >   diff: make the indent heuristic part of diff's basic configuration
> >   diff: have the diff-* builtins configure diff before initializing
> >     revisions
> > 
> > Stefan Beller (1):
> >   diff: enable indent heuristic by default
> 
> Thanks, these look fine to me. I'd like to get an ACK from Michael, in
> case he had some other reason for omitting them from git_diff_ui_config
> (from my recollection, it's probably just a mix of conservatism and
> following what the compaction heuristic had done).

Sorry, I spoke too soon. The third one needs a few test adjustments
squashed in to pass the tests.

The fixes below for t4061 are pretty obvious, but the one in t4051 is
anything but. What happens is that we have a function:

  int dummy();
  {
     some body
  }

and modify it to look like:

  int dummy();
  int dummy();
  {
     some body
  }

and we expect that this counts as making a change to the function for
the purposes of -W. But with the indent heuristic, instead of saying "we
added an extra line after the first dummy()", we say "we added an extra
dummy() before the function". Which is perfectly reasonable.

I don't think duplicating the line is important to the test, as opposed
to making any random change.  But we can't just change a line in the
body itself, because the point of the test is making sure -W shows the
whole function. And the function is short enough that a change in the
body would show the whole thing via context anyway. So I opted to make
the change at the same spot, but make the diff less ambiguous.

diff --git a/t/t4051-diff-function-context.sh b/t/t4051-diff-function-context.sh
index 6154acb45..5f46c0341 100755
--- a/t/t4051-diff-function-context.sh
+++ b/t/t4051-diff-function-context.sh
@@ -72,7 +72,7 @@ test_expect_success 'setup' '
 
 	# overlap function context of 1st change and -u context of 2nd change
 	grep -v "delete me from hello" <"$dir/hello.c" >file.c &&
-	sed 2p <"$dir/dummy.c" >>file.c &&
+	sed "2aextra line" <"$dir/dummy.c" >>file.c &&
 	commit_and_tag changed_hello_dummy file.c &&
 
 	git checkout initial &&
diff --git a/t/t4061-diff-indent.sh b/t/t4061-diff-indent.sh
index 13d3dc96a..56d7d7760 100755
--- a/t/t4061-diff-indent.sh
+++ b/t/t4061-diff-indent.sh
@@ -153,7 +153,7 @@ test_expect_success 'prepare' '
 '
 
 test_expect_success 'diff: ugly spaces' '
-	git diff old new -- spaces.txt >out &&
+	git diff --no-indent-heuristic old new -- spaces.txt >out &&
 	compare_diff spaces-expect out
 '
 
@@ -183,7 +183,7 @@ test_expect_success 'diff: --indent-heuristic with --histogram' '
 '
 
 test_expect_success 'diff: ugly functions' '
-	git diff old new -- functions.c >out &&
+	git diff --no-indent-heuristic old new -- functions.c >out &&
 	compare_diff functions-expect out
 '
 
@@ -193,7 +193,7 @@ test_expect_success 'diff: nice functions with --indent-heuristic' '
 '
 
 test_expect_success 'blame: ugly spaces' '
-	git blame old..new -- spaces.txt >out-blame &&
+	git blame --no-indent-heuristic old..new -- spaces.txt >out-blame &&
 	compare_blame spaces-expect out-blame
 '
 
