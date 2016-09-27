Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6CB120986
	for <e@80x24.org>; Tue, 27 Sep 2016 19:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934497AbcI0TDb (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 15:03:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:49014 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933516AbcI0TD3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 15:03:29 -0400
Received: (qmail 2557 invoked by uid 109); 27 Sep 2016 19:03:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Sep 2016 19:03:29 +0000
Received: (qmail 18941 invoked by uid 111); 27 Sep 2016 19:03:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Sep 2016 15:03:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Sep 2016 15:03:26 -0400
Date:   Tue, 27 Sep 2016 15:03:26 -0400
From:   Jeff King <peff@peff.net>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/3] fsck: handle bad trees like other errors
Message-ID: <20160927190326.6wdmxodfisdiku2c@sigill.intra.peff.net>
References: <1474989806-5002-1-git-send-email-dturner@twosigma.com>
 <1474989806-5002-2-git-send-email-dturner@twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1474989806-5002-2-git-send-email-dturner@twosigma.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 27, 2016 at 11:23:25AM -0400, David Turner wrote:

> +test_expect_success 'unparseable tree object' '
> +	test_when_finished "git update-ref -d refs/heads/wrong" &&
> +	test_when_finished "remove_object \$tree_sha1" &&
> +	test_when_finished "remove_object \$commit_sha1" &&
> +	tree_sha1=$(printf "100644 \0twenty-bytes-of-junk" | git hash-object -t tree --stdin -w --literally) &&
> +	commit_sha1=$(git commit-tree $tree_sha1) &&
> +	git update-ref refs/heads/wrong $commit_sha1 &&
> +	test_must_fail git fsck 2>out &&
> +	test_i18ngrep "error: empty filename in tree entry" out &&
> +	test_i18ngrep "$tree_sha1" out &&
> +	! test_i18ngrep "fatal: empty filename in tree entry" out
> +'

Unfortunately this last one needs to be spelled as:

  test_i18ngrep ! "fatal: empty filename in tree entry" out

because the function always pretends to match when GETTEXT_POISON is
set.

Other than the minor test fixups, this all looks good to me.

-Peff
