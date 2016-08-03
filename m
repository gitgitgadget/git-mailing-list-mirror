Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D8B61F858
	for <e@80x24.org>; Wed,  3 Aug 2016 16:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbcHCQcM (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 12:32:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:53827 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756622AbcHCQcK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 12:32:10 -0400
Received: (qmail 5175 invoked by uid 102); 3 Aug 2016 16:25:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 12:25:16 -0400
Received: (qmail 1665 invoked by uid 107); 3 Aug 2016 16:25:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 12:25:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Aug 2016 12:25:13 -0400
Date:	Wed, 3 Aug 2016 12:25:13 -0400
From:	Jeff King <peff@peff.net>
To:	Stefan Beller <sbeller@google.com>
Cc:	gitster@pobox.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	apenwarr@gmail.com, jrnieder@gmail.com
Subject: Re: [PATCHv3 6/7] submodule--helper: add remote-branch helper
Message-ID: <20160803162512.veyff5g52kaqwlgx@sigill.intra.peff.net>
References: <20160729004409.2072-1-sbeller@google.com>
 <20160729004409.2072-7-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160729004409.2072-7-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 28, 2016 at 05:44:08PM -0700, Stefan Beller wrote:

> +static const char *remote_submodule_branch(const char *path)
> +{
> +	const struct submodule *sub;
> +	gitmodules_config();
> +	git_config(submodule_config, NULL);
> +
> +	sub = submodule_from_path(null_sha1, path);
> +	if (!sub->branch)
> +		return "master";
> +
> +	return sub->branch;
> +}

Coverity complains about "sub" being NULL here, and indeed, it seems
like an easy segfault:

  $ ./git submodule--helper remote-branch foo
  Segmentation fault

I guess this should return NULL in that case. But then this...

> +static int resolve_remote_submodule_branch(int argc, const char **argv,
> +		const char *prefix)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +	if (argc != 2)
> +		die("submodule--helper remote-branch takes exactly one arguments, got %d", argc);
> +
> +	printf("%s", remote_submodule_branch(argv[1]));
> +	strbuf_release(&sb);
> +	return 0;
> +}

would need to handle the NULL return, as well. So maybe "master" or the
empty string would be better. I haven't followed the topic closely
enough to have an opinion.

-Peff
