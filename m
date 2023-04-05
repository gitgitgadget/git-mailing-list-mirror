Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177D8C7619A
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 21:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjDEV0V (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 17:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDEV0T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 17:26:19 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A345FDE
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 14:26:18 -0700 (PDT)
Received: (qmail 6491 invoked by uid 109); 5 Apr 2023 21:26:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 05 Apr 2023 21:26:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15943 invoked by uid 111); 5 Apr 2023 21:26:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 Apr 2023 17:26:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 5 Apr 2023 17:26:17 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Adam Majer <adamm@zombino.com>, git@vger.kernel.org
Subject: Re: git clone of empty repositories doesn't preserve hash
Message-ID: <20230405212617.GB529421@coredump.intra.peff.net>
References: <e7a8957e-6251-39f1-5109-87d4dd382e81@zombino.com>
 <xmqqr0syw3pe.fsf@gitster.g>
 <d04c430e-b609-b0a1-fd0f-0f3734d5c3b1@zombino.com>
 <20230405200153.GA525125@coredump.intra.peff.net>
 <xmqqa5zmukp5.fsf@gitster.g>
 <xmqq355euj2i.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq355euj2i.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 05, 2023 at 02:15:33PM -0700, Junio C Hamano wrote:

> ----- >8 -----
> Subject: [PATCH] clone: propagate object-format when cloning from void
> 
> A user could prepare an empty repository and set it to use SHA256 as
> the object format.  The new repository created by "git clone" from
> such a repository however would not record that it is expecting
> objects in the same SHA256 format.  This works as expected if the
> source repository is not empty.
> 
> Just like we started copying the name of the primary branch from the
> remote repository even if it is unborn in 3d8314f8 (clone: propagate
> empty remote HEAD even with other branches, 2022-07-07), lift the
> code that records the object format out of the block executed only
> when cloning from an instantiated repository, so that it works also
> when cloning from an empty repository.

Heh, our mails just crossed, but I stumbled upon the same patch. So yes,
this looks good to me.

I suspect that setting the flag in the_repository might not matter,
since we do not have any refs or objects to manipulate, and what we care
about here is that initialize_repository_version() is run. But I agree
that the two conceptually belong together, and hoisting both out of the
block is the right thing to do.

> diff --git c/t/t5702-protocol-v2.sh w/t/t5702-protocol-v2.sh
> index 71aabe30b7..6af5c2062f 100755
> --- c/t/t5702-protocol-v2.sh
> +++ w/t/t5702-protocol-v2.sh
> @@ -269,6 +269,17 @@ test_expect_success 'clone propagates unborn HEAD from non-empty repo' '
>  	grep "warning: remote HEAD refers to nonexistent ref" stderr
>  '
>  
> +test_expect_success 'clone propagates object-format from empty repo' '
> +	test_when_finished "rm -fr src256 dst256" &&
> +
> +	echo sha256 >expect &&
> +	git init --object-format=sha256 src256 &&
> +	git clone src256 dst256 &&
> +	git -C dst256 rev-parse --show-object-format >actual &&
> +
> +	test_cmp expect actual
> +'

And this test looks straightforward. Very nice.

-Peff
