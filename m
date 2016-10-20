Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E0D31F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 21:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756760AbcJTV4v (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 17:56:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:60316 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751481AbcJTV4u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 17:56:50 -0400
Received: (qmail 5217 invoked by uid 109); 20 Oct 2016 21:56:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Oct 2016 21:56:50 +0000
Received: (qmail 30549 invoked by uid 111); 20 Oct 2016 21:57:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Oct 2016 17:57:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Oct 2016 17:56:47 -0400
Date:   Thu, 20 Oct 2016 17:56:47 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Drastic jump in the time required for the test suite
Message-ID: <20161020215647.5no7effvutwep2xt@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1610191049040.3847@virtualbox>
 <xmqqbmygmehv.fsf@gitster.mtv.corp.google.com>
 <20161019205638.m3ytxozzmeh47ml2@sigill.intra.peff.net>
 <alpine.DEB.2.20.1610201218060.3264@virtualbox>
 <CAGZ79kZpj5xXHmnA+JfLKdGmgzp7Mut1OsKMOeowpw8m1+aKGA@mail.gmail.com>
 <20161020213803.7d7bymby7pouzij3@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161020213803.7d7bymby7pouzij3@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2016 at 05:38:03PM -0400, Jeff King wrote:

> I think that helper still ends up using "cat" and "diff" under the hood,
> unless you write those bits in pure shell. But at that point, I suspect
> we could "cat" and "test_cmp" in pure shell, something like:
> [...]
> Those are both completely untested. But maybe they are worth playing
> around with for somebody on Windows to see if they make a dent in the
> test runtime.

If you tried to run them, you probably noticed that the "untested" was
really true. One of the functions was missing an "else", and the other
forgot to add a "\n" to its printf.

The patch below gets closer, though there are still a handful of test
failures.  I didn't investigate deeply, but I think at least one is
related to the "read/printf" version of cat not being binary-clean.

-Peff

---
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index fdaeb3a96b..de37f3d 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -685,9 +685,48 @@ test_expect_code () {
 # - not all diff versions understand "-u"
 
 test_cmp() {
+	# optimize for common "they are the same" case
+	# without any subshells or subprograms
+	while true; do
+		if ! read -r line1 <&3
+		then
+			if ! read -r line2 <&4
+			then
+				# EOF on both; good
+				return 0
+			else
+				# EOF only on file1; fail
+				break
+			fi
+		fi
+		if ! read -r line2 <&4
+		then
+			# EOF only on file2; fail
+			break
+		fi
+		test "$line1" = "$line2" || break
+	done 3<"$1" 4<"$2"
+
+	# if we get here, the optimized version found some
+	# difference. We can just "return 1", but let's run
+	# the real $GIT_TEST_CMP to provide pretty output.
+	# This should generally only happen on test failures,
+	# so performance isn't a big deal.
 	$GIT_TEST_CMP "$@"
 }
 
+cat () {
+	# optimize common here-doc usage
+	if test $# -eq 0
+	then
+		while read -r line
+		do
+			printf '%s\n' "$line"
+		done
+	fi
+	command cat "$@"
+}
+
 # test_cmp_bin - helper to compare binary files
 
 test_cmp_bin() {
