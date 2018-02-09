Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D11F1F404
	for <e@80x24.org>; Fri,  9 Feb 2018 19:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752860AbeBITan (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 14:30:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:47180 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752403AbeBITam (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 14:30:42 -0500
Received: (qmail 5553 invoked by uid 109); 9 Feb 2018 19:30:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 09 Feb 2018 19:30:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24307 invoked by uid 111); 9 Feb 2018 19:31:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 09 Feb 2018 14:31:24 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Feb 2018 14:30:39 -0500
Date:   Fri, 9 Feb 2018 14:30:39 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alexander Shopov <ash@kambanaria.org>, git@vger.kernel.org,
        martin.agren@gmail.com, bmwill@google.com,
        sandals@crustytoothpaste.net, worldhello.net@gmail.com,
        j6t@kdbg.org, sunshine@sunshineco.com, pclouds@gmail.com
Subject: Re: [PATCH 1/1] Mark messages for translations
Message-ID: <20180209193039.GA15554@sigill.intra.peff.net>
References: <20180209074404.2902-1-ash@kambanaria.org>
 <20180206073812.GA14133@sigill.intra.peff.net>
 <20180209074404.2902-2-ash@kambanaria.org>
 <xmqqlgg2xbx0.fsf@gitster-ct.c.googlers.com>
 <xmqqwozmvuth.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwozmvuth.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 09, 2018 at 11:15:06AM -0800, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> -	if ! grep "Invalid gitfile format" .err
> >> +	if ! test_i18ngrep "invalid gitfile format" .err
> >
> > Shouldn't this rather be like so instead?
> >
> > 	if test_i18ngrep ! "invalid gitfile format" .err
> >
> > Ditto for the other negated use of test_i18ngrep we see in the same
> > file in this patch.
> 
> Sorry, my thinko.  These two ones want to be written in the patch
> as-is.

Yes, I think so, but we may want to avoid this anti-pattern (since
usually "! test_i18ngrep" is a sign of something wrong. It seems like
these tests are doing more manual reporting work than is necessary, and
could just be relying on helpers to report errors.

Something like the patch below, though I'm not sure if we'd want to
leave it as "grep" (if applying on master), or have "test_i18ngrep" in
the preimage (if basing on top of Alexander's patch).

-Peff

---
 t/t0002-gitfile.sh | 54 +++++++----------------------------
 1 file changed, 11 insertions(+), 43 deletions(-)

diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
index 9670e8cbe6..74b7307997 100755
--- a/t/t0002-gitfile.sh
+++ b/t/t0002-gitfile.sh
@@ -10,15 +10,6 @@ objpath() {
 	echo "$1" | sed -e 's|\(..\)|\1/|'
 }
 
-objck() {
-	p=$(objpath "$1")
-	if test ! -f "$REAL/objects/$p"
-	then
-		echo "Object not found: $REAL/objects/$p"
-		false
-	fi
-}
-
 test_expect_success 'initial setup' '
 	REAL="$(pwd)/.real" &&
 	mv .git "$REAL"
@@ -26,30 +17,14 @@ test_expect_success 'initial setup' '
 
 test_expect_success 'bad setup: invalid .git file format' '
 	echo "gitdir $REAL" >.git &&
-	if git rev-parse 2>.err
-	then
-		echo "git rev-parse accepted an invalid .git file"
-		false
-	fi &&
-	if ! grep "Invalid gitfile format" .err
-	then
-		echo "git rev-parse returned wrong error"
-		false
-	fi
+	test_must_fail git rev-parse 2>.err &&
+	test_i18ngrep "Invalid gitfile format" .err
 '
 
 test_expect_success 'bad setup: invalid .git file path' '
 	echo "gitdir: $REAL.not" >.git &&
-	if git rev-parse 2>.err
-	then
-		echo "git rev-parse accepted an invalid .git file path"
-		false
-	fi &&
-	if ! grep "Not a git repository" .err
-	then
-		echo "git rev-parse returned wrong error"
-		false
-	fi
+	test_must_fail git rev-parse 2>.err &&
+	test_i18ngrep "Not a git repository" .err
 '
 
 test_expect_success 'final setup + check rev-parse --git-dir' '
@@ -60,7 +35,7 @@ test_expect_success 'final setup + check rev-parse --git-dir' '
 test_expect_success 'check hash-object' '
 	echo "foo" >bar &&
 	SHA=$(cat bar | git hash-object -w --stdin) &&
-	objck $SHA
+	test_path_is_file "$REAL/objects/$(objpath $SHA)"
 '
 
 test_expect_success 'check cat-file' '
@@ -69,29 +44,22 @@ test_expect_success 'check cat-file' '
 '
 
 test_expect_success 'check update-index' '
-	if test -f "$REAL/index"
-	then
-		echo "Hmm, $REAL/index exists?"
-		false
-	fi &&
+	test_path_is_missing "$REAL/index" &&
 	rm -f "$REAL/objects/$(objpath $SHA)" &&
 	git update-index --add bar &&
-	if ! test -f "$REAL/index"
-	then
-		echo "$REAL/index not found"
-		false
-	fi &&
-	objck $SHA
+	test_path_is_file "$REAL/index" &&
+	test_path_is_file "$REAL/objects/$(objpath $SHA)" &&
+	false
 '
 
 test_expect_success 'check write-tree' '
 	SHA=$(git write-tree) &&
-	objck $SHA
+	test_path_is_file "$REAL/objects/$(objpath $SHA)"
 '
 
 test_expect_success 'check commit-tree' '
 	SHA=$(echo "commit bar" | git commit-tree $SHA) &&
-	objck $SHA
+	test_path_is_file "$REAL/objects/$(objpath $SHA)"
 '
 
 test_expect_success 'check rev-list' '
