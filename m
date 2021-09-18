Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8D2C433EF
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 22:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8DA1610A4
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 22:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240205AbhIRWGn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 18:06:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:50470 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238545AbhIRWGn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 18:06:43 -0400
Received: (qmail 17406 invoked by uid 109); 18 Sep 2021 22:05:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 18 Sep 2021 22:05:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 655 invoked by uid 111); 18 Sep 2021 22:05:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 18 Sep 2021 18:05:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 18 Sep 2021 18:05:17 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Andrzej Hunt <andrzej@ahunt.org>
Subject: Re: [PATCH] connect: also update offset for features without values
Message-ID: <YUZinXsGdL19l/tQ@coredump.intra.peff.net>
References: <pull.1091.git.git.1631970872884.gitgitgadget@gmail.com>
 <YUYLXKN8U9AMa5ke@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUYLXKN8U9AMa5ke@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 18, 2021 at 11:53:00AM -0400, Taylor Blau wrote:

> > +test_expect_success 'bogus symref in v0 capabilities' '
> > +	test_commit foo &&
> > +	oid=$(git rev-parse HEAD) &&
> > +	{
> > +		printf "%s HEAD\0symref object-format=%s\n" "$oid" "$GIT_DEFAULT_HASH" |
> > +			test-tool pkt-line pack-raw-stdin &&
> 
> I'm actually really happy with this modification to add the non-empty
> object-format after the broken "symref" part, since it ensures that your
> offset calculation is right (and that we can continue to parse features
> with or without values after a value-less one).

I don't think it quite does that, though. If I understand the parsing
code correctly, it walks through the list looking for entries for a
_particular_ capability. I.e., it will look for any "symref" entries,
advancing the offset counter. And then separately it will start again
looking for any object-format entries, with a brand-new offset counter
starting at 0.

So if you want to confirm that the parsing continues after the
unexpected entry, you'd want a second symref entry, and then to make
sure it was correctly parsed.  Perhaps something like this:

diff --git a/t/t5704-protocol-violations.sh b/t/t5704-protocol-violations.sh
index 34538cebf0..98d7f4981a 100755
--- a/t/t5704-protocol-violations.sh
+++ b/t/t5704-protocol-violations.sh
@@ -35,13 +35,15 @@ test_expect_success 'extra delim packet in v2 fetch args' '
 test_expect_success 'bogus symref in v0 capabilities' '
 	test_commit foo &&
 	oid=$(git rev-parse HEAD) &&
+	dst=refs/heads/foo &&
 	{
-		printf "%s HEAD\0symref object-format=%s\n" "$oid" "$GIT_DEFAULT_HASH" |
+		printf "%s HEAD\0symref object-format=%s symref=HEAD:%s\n" \
+			"$oid" "$GIT_DEFAULT_HASH" "$dst" |
 			test-tool pkt-line pack-raw-stdin &&
 		printf "0000"
 	} >input &&
-	git ls-remote --upload-pack="cat input ;:" . >actual &&
-	printf "%s\tHEAD\n" "$oid" >expect &&
+	git ls-remote --symref --upload-pack="cat input ;:" . >actual &&
+	printf "ref: %s\tHEAD\n%s\tHEAD\n" "$dst" "$oid" >expect &&
 	test_cmp expect actual
 '
 

I don't think it's hugely important (after all, this is something that
the server isn't supposed to send in the first place). But given that we
did make it work correctly (and the original on the security list
didn't), it's not too bad to test it on top.

Swapping out the "printf >expect" for a here-doc might make it a bit
more readable. I used printf because of the tab handling, but:

  tab=$(printf "\t")
  cat >expect <<-EOF
  ref: ${dst}${tab}HEAD
  ${oid}${tab}HEAD
  EOF

isn't too bad.

-Peff
