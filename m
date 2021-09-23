Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B572C433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 22:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D71BD61241
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 22:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbhIWWEC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 18:04:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:54012 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234737AbhIWWEB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 18:04:01 -0400
Received: (qmail 16131 invoked by uid 109); 23 Sep 2021 22:02:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Sep 2021 22:02:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 458 invoked by uid 111); 23 Sep 2021 22:02:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Sep 2021 18:02:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Sep 2021 18:02:28 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Andrzej Hunt <andrzej@ahunt.org>
Subject: Re: [PATCH] connect: also update offset for features without values
Message-ID: <YUz5dPB6/jFmdSRU@coredump.intra.peff.net>
References: <pull.1091.git.git.1631970872884.gitgitgadget@gmail.com>
 <xmqq4kabyoo3.fsf@gitster.g>
 <YUzzwCwlR9AwSeOD@coredump.intra.peff.net>
 <xmqqr1dfx8lm.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr1dfx8lm.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 23, 2021 at 02:52:53PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I think the problem is that our fake upload-pack exits immediately, so
> > ls-remote gets SIGPIPE. In a v0 conversation, ls-remote expects to say
> > "0000" to indicate that it's not interested in fetching anything (in v2,
> > it doesn't bother, since fetching would be a separate request that it
> > just declines to make).
> 
> Ah, Makes sense---the usual SIGPIPE problem ;-)

Yes, though it definitely took some head-scratching for me to see where
it was. ;)

Doing: "./t5704-* --stress" made it pretty clear. It fails almost
immediately, and mentions SIGPIPE (well, exit code 141, but by now I
have that one memorized).

> > This seems to fix it:
> >
> > diff --git a/t/t5704-protocol-violations.sh b/t/t5704-protocol-violations.sh
> > index 34538cebf0..0983c2b507 100755
> > --- a/t/t5704-protocol-violations.sh
> > +++ b/t/t5704-protocol-violations.sh
> > @@ -40,7 +40,7 @@ test_expect_success 'bogus symref in v0 capabilities' '
> >  			test-tool pkt-line pack-raw-stdin &&
> >  		printf "0000"
> >  	} >input &&
> > -	git ls-remote --upload-pack="cat input ;:" . >actual &&
> > +	git ls-remote --upload-pack="cat input; read junk;:" . >actual &&
> >  	printf "%s\tHEAD\n" "$oid" >expect &&
> >  	test_cmp expect actual
> >  '
> 
> Yup.  In the original thread there was some further back-and-forth
> about further improving the test, if I recall correctly; has the
> issue been settled there, or is everybody happy with the above
> version?

I think the change I showed earlier (to use ls-remote --symref) is worth
doing. There was lots of discussion about how to format a tab, but in
the end I don't think it really matters.

So here's that patch again, with this race fix on top, which could be
squashed in, and then I hope we can call it good.

diff --git a/t/t5704-protocol-violations.sh b/t/t5704-protocol-violations.sh
index 34538cebf0..bc393d7c31 100755
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
+	git ls-remote --symref --upload-pack="cat input; read junk;:" . >actual &&
+	printf "ref: %s\tHEAD\n%s\tHEAD\n" "$dst" "$oid" >expect &&
 	test_cmp expect actual
 '
 
