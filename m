Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB47C77B60
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 11:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240233AbjDZLZM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 07:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240424AbjDZLZL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 07:25:11 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA311988
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 04:25:10 -0700 (PDT)
Received: (qmail 6683 invoked by uid 109); 26 Apr 2023 11:25:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 26 Apr 2023 11:25:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13830 invoked by uid 111); 26 Apr 2023 11:25:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 26 Apr 2023 07:25:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 26 Apr 2023 07:25:08 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Adam Majer <adamm@zombino.com>,
        git@vger.kernel.org
Subject: Re: git clone of empty repositories doesn't preserve hash
Message-ID: <20230426112508.GB130148@coredump.intra.peff.net>
References: <e7a8957e-6251-39f1-5109-87d4dd382e81@zombino.com>
 <xmqqr0syw3pe.fsf@gitster.g>
 <d04c430e-b609-b0a1-fd0f-0f3734d5c3b1@zombino.com>
 <20230405200153.GA525125@coredump.intra.peff.net>
 <xmqqa5zmukp5.fsf@gitster.g>
 <xmqq355euj2i.fsf@gitster.g>
 <ZEhHsJh20gtiDBd9@tapette.crustytoothpaste.net>
 <xmqqcz3ry2sw.fsf@gitster.g>
 <ZEhuMML6n8F+cNLg@tapette.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZEhuMML6n8F+cNLg@tapette.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 26, 2023 at 12:20:00AM +0000, brian m. carlson wrote:

> In my case, the clone is over HTTP, so this may not be the ideal way to
> reproduce it and it may need a better testcase, but it does bisect to
> the patch above and it is new in master (and doesn't reproduce in
> 2.40.0).  Note that in our case in the Git LFS testsuite, we're using
> GIT_DEFAULT_HASH=sha256.
> 
> I believe what is happening is that for some reason, the object-format
> data in v0 and v1 is not being read properly, and so we're now setting
> it to sha1 whereas before we were reading the value from the default
> setting of the repository (sha256).

I'm having trouble finding any breakage at all. E.g., this test passes:

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 0908534f25..95b10288e7 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -704,4 +704,24 @@ test_expect_success 'no empty path components' '
 	! grep "//" log
 '
 
+test_expect_success 'v0 clone over http recognizes object-format' '
+	git init --bare --object-format=sha256 \
+		"$HTTPD_DOCUMENT_ROOT_PATH/sha256.git" &&
+
+	# do not test an empty repo. In v0, we have no way for an
+	# empty server to report its object format, so we would
+	# always default to sha1. We could in theory test that
+	# a client who wants to default to sha256 will realize
+	# the other side is sha1, but we have no way to set that local
+	# default. Unlike git-init, git-clone does not support
+	# --object-format, nor GIT_DEFAULT_HASH.
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/sha256.git" --work-tree=. \
+		commit --allow-empty -m foo &&
+
+	git -c protocol.version=0 clone $HTTPD_URL/smart/sha256.git sha256 &&
+	git -C sha256 rev-parse --show-object-format >actual &&
+	echo sha256 >expect &&
+	test_cmp expect actual
+'
+
 test_done

I'd expect it to break in the empty-repo case, for the reasons given in
the comment (v0 cannot communicate object-format in an empty repo). But
that is nothing new.

It sounds from your description that your test is running in a mode
where the client defaults to sha256 (though I'm not sure how, since we
explicitly document that GIT_DEFAULT_HASH should not affect clone), and
then you clone an empty sha256 repository via v0, expecting the result
to be sha256.

But I think that is a wrong expectation, at least from the
client's perspective. An empty repository cannot communicate its
object-format over v0, so the client should assume its v0, and should
then itself become v0. And that last "should itself become" is what
Junio's patch fixed.

The first part, "empty repository cannot communicate its object-format
over v0" is the part is "it's always been broken". We could fix it, but
I'm not sure if it is worth the trouble (see my other message).

> It very well may be that it's always been broken and this has just made
> it obvious that it's broken, but I'll look tomorrow and probably send a
> patch.  I don't think we should revert this change, but I do think we
> need to fix it before 2.41, since I think it means right now that all
> clones over protocol v0 and v1 end up with a SHA-1 repository.

Hopefully my guess at what your test is doing is correct, and I didn't
just leave us off on a tangent. ;)

But if it is, then I think that everything in Git is OK. Non-empty repos
over v0 work correctly both before and after Junio's patch. Empty ones
before his patch were erroneously using sha256 if they preferred it
locally, even when the other side really was sha1. They _also_ were
using sha256 erroneously when the other side was sha256 but wasn't able
to report it (because of v0 limitations). Which is counter-intuitive,
perhaps, but was still the wrong thing for a client to do.

-Peff
