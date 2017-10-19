Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8ACB202FC
	for <e@80x24.org>; Thu, 19 Oct 2017 21:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752348AbdJSVHd (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 17:07:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:58300 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751346AbdJSVHd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 17:07:33 -0400
Received: (qmail 4432 invoked by uid 109); 19 Oct 2017 21:07:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 21:07:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12515 invoked by uid 111); 19 Oct 2017 21:07:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 17:07:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Oct 2017 17:07:31 -0400
Date:   Thu, 19 Oct 2017 17:07:31 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 2/3] t5615: avoid re-using descriptor 4
Message-ID: <20171019210730.sgm4g4tmor2dgjv7@sigill.intra.peff.net>
References: <20171019210140.64lb52cqtgdh22ew@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171019210140.64lb52cqtgdh22ew@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

File descriptors 3 and 4 are special in our test suite, as
they link back to the test script's original stdout and
stderr. Normally this isn't something tests need to worry
about: they are free to clobber these descriptors for
sub-commands without affecting the overall script.

But there's one very special thing about descriptor 4: since
d88785e424 (test-lib: set BASH_XTRACEFD automatically,
2016-05-11), we ask bash to output "set -x" output to it by
number. This goes to _any_ descriptor 4, even if it no
longer points to the place it did when we set BASH_XTRACEFD.

But in t5615, we run a shell loop with descriptor 4
redirected.  As a result, t5615 works with non-bash shells
even with "-x". And it works with bash without "-x". But the
combination of "bash t5615-alternate-env.sh -x" gets a test
failure (because our "set -x" output pollutes one of the
files).

We can fix this by using any descriptor _except_ the magical
4. So let's switch arbitrarily to using 5/6 in this loop,
not 3/4.

Signed-off-by: Jeff King <peff@peff.net>
---
I also considered trying to bump the "set -x" output descriptor to "9".
That just moves the problem around, but presumably scripts are less
likely to go that high. :)

It would also be possible to pick something insanely high, like "999".
Many shells choke on descriptors higher than 9, but since the issue is
related to BASH_XTRACEFD, we could make it a bash-only thing. I don't
know if it's worth the trouble. I hate leaving a subtle "don't use
descriptor 4 in a subshell or your script will break" hand-grenade like
this lying around, but we do seem to have only one instance of it over
the whole test suite.

 t/t5615-alternate-env.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t5615-alternate-env.sh b/t/t5615-alternate-env.sh
index d2d883f3a1..b4905b822c 100755
--- a/t/t5615-alternate-env.sh
+++ b/t/t5615-alternate-env.sh
@@ -7,9 +7,9 @@ check_obj () {
 	alt=$1; shift
 	while read obj expect
 	do
-		echo "$obj" >&3 &&
-		echo "$obj $expect" >&4
-	done 3>input 4>expect &&
+		echo "$obj" >&5 &&
+		echo "$obj $expect" >&6
+	done 5>input 6>expect &&
 	GIT_ALTERNATE_OBJECT_DIRECTORIES=$alt \
 		git "$@" cat-file --batch-check='%(objectname) %(objecttype)' \
 		<input >actual &&
-- 
2.15.0.rc1.560.g5f0609e481

