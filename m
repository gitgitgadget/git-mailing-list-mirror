Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B7F01F403
	for <e@80x24.org>; Mon, 11 Jun 2018 04:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753866AbeFKEUT (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 00:20:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:40938 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751383AbeFKEUT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 00:20:19 -0400
Received: (qmail 2012 invoked by uid 109); 11 Jun 2018 04:20:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Jun 2018 04:20:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12898 invoked by uid 111); 11 Jun 2018 04:20:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 11 Jun 2018 00:20:33 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jun 2018 00:20:16 -0400
Date:   Mon, 11 Jun 2018 00:20:16 -0400
From:   Jeff King <peff@peff.net>
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Takuto Ikuta <tikuta@chromium.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: demonstrate --all breakage when remote have
 tags to non-commit objects
Message-ID: <20180611042016.GA31642@sigill.intra.peff.net>
References: <20180610143231.7131-1-kirr@nexedi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180610143231.7131-1-kirr@nexedi.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 10, 2018 at 02:32:57PM +0000, Kirill Smelkov wrote:

> Added test shows remote with two tag objects pointing to a blob and a
> tree. The tag objects themselves are referenced from under regular
> refs/tags/* namespace. If test_expect_failure is changed to
> test_expect_success the test fails:

Interesting case. The problem is actually that upload-pack complains:

> 	fatal: git upload-pack: not our ref 038f48ad0beaffbea71d186a05084b79e3870cbf

And that sha1 is the tagged blob:

> 	bc4e9e1fa80662b449805b1ac29fc9b1e4c49187        refs/tags/tag-to-blob			# <-- NOTE
> 	038f48ad0beaffbea71d186a05084b79e3870cbf        refs/tags/tag-to-blob^{}
> 	520db1f5e1afeaa12b1a8d73ce82db72ca036ee1        refs/tags/tag-to-tree			# <-- NOTE
> 	7395c100223b7cd760f58ccfa0d3f3d2dd539bb6        refs/tags/tag-to-tree^{}

So it seems like upload-pack is at fault for not marking the object as a
tip when it peels the tag.

> For the reference, porcelain fetch 'refs/*:refs/origin/*' works:

That's because it doesn't actually issue a "want" for the peeled blob
(it doesn't need to, because it's fetching the tag itself). So it
happens to work, but I still think upload-pack is at fault for not
accepting the "want" on the blob it advertised.

Doubly interesting, it looks like this case _used_ to work, but was
broken by 5f0fc64513 (fetch-pack: eliminate spurious error messages,
2012-09-09). Which only changed the fetch-pack side. It moved the
handling of --all so that it was no longer in the "else" for
check_refname_format(). I guess the original code was rejecting those
peeled bits as "not a ref" (which makes sense).

So that seems like a bug in fetch-pack. But I'm still not convinced that
upload-pack doesn't also have a bug.

> +test_expect_failure 'test --all wrt tag to non-commits' '
> +	blob_sha1=$(echo "hello blob" | git hash-object -t blob -w --stdin) &&
> +	git tag -a -m "tag -> blob" tag-to-blob $blob_sha1 &&
> +	tree_sha1=$(echo -e "100644 blob $blob_sha1\tfile" | git mktree) &&

I had to switch this "echo -e" to:

  printf "100644 blob $blob_sha1\tfile\n"

since "-e" is a bash-ism (and my /bin/sh is dash).

-Peff
