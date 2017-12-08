Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB4E720C32
	for <e@80x24.org>; Fri,  8 Dec 2017 10:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753373AbdLHKrT (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 05:47:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:51972 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753202AbdLHKrP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 05:47:15 -0500
Received: (qmail 1762 invoked by uid 109); 8 Dec 2017 10:47:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Dec 2017 10:47:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30957 invoked by uid 111); 8 Dec 2017 10:47:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Fri, 08 Dec 2017 05:47:37 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Dec 2017 05:47:13 -0500
Date:   Fri, 8 Dec 2017 05:47:13 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 2/4] t5615: avoid re-using descriptor 4
Message-ID: <20171208104713.GB4939@sigill.intra.peff.net>
References: <20171208104647.GA4016@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171208104647.GA4016@sigill.intra.peff.net>
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

Another alternative is to use a different descriptor for
BASH_XTRACEFD. But picking an unused one turns out to be
hard. Most shells limit us to 9 numbered descriptors. Bash
can handle more, but:

  - while the BASH_XTRACEFD is specific to bash, GIT_TRACE=4
    has a similar problem, and would affect all shells

  - constructs like "999>/dev/null" are synticatically
    invalid to non-bash shells. So we have to actually bury
    it inside an eval, which creates more complications.

Of the numbers 1-9, you might think that "9" would be less
used than "4". But it's not; many of our scripts use
descriptors 8 and 9 (probably under the assumption that they
are high and therefore unused). The least-used descriptor is
currently "7". We could switch to that, but we're just
trading one magic number for another.

Signed-off-by: Jeff King <peff@peff.net>
---
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
2.15.1.659.g8bd2eae3ea

