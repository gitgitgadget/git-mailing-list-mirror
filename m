Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300A6C433DF
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 13:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BD7120A8B
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 13:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgFPNE6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 09:04:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:33092 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgFPNE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 09:04:57 -0400
Received: (qmail 21735 invoked by uid 109); 16 Jun 2020 13:04:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Jun 2020 13:04:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12927 invoked by uid 111); 16 Jun 2020 13:04:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Jun 2020 09:04:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Jun 2020 09:04:56 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        sandals@crustytoothpaste.net, Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 02/12] fmt-merge-msg: introduce a way to override the
 main branch name
Message-ID: <20200616130456.GF666057@coredump.intra.peff.net>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
 <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
 <f4d547391537e5c3b0b4a07adb41b6aa56541fc3.1592225416.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f4d547391537e5c3b0b4a07adb41b6aa56541fc3.1592225416.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 15, 2020 at 12:50:06PM +0000, Johannes Schindelin via GitGitGadget wrote:

> +char *repo_main_branch_name(struct repository *r)
> +{
> +	const char *config_key = "core.mainbranch";
> +	const char *config_display_key = "core.mainBranch";
> +	const char *fall_back = "master";
> +	char *name = NULL, *ret;
> +
> +	if (repo_config_get_string(r, config_key, &name) < 0)
> +		die(_("could not retrieve `%s`"), config_display_key);
> +
> +	ret = name ? name : xstrdup(fall_back);
> +
> +	if (check_refname_format(ret, REFNAME_ALLOW_ONELEVEL))
> +		die(_("invalid branch name: %s = %s"),
> +		    config_display_key, name);

Ah, this fixes the "we do not check the format of the short name" issue
I pointed out in v1 (sorry, I just realized that v2 existed so I'll
resume reviewing from there; I do still think this might make life
easier for callers by returning a const pointer).

I'm not sure if this check_refname_format() is valid, though. IIRC we've
had issues where "ONELEVEL" was used to check a branch name, but misses
some cases. The more full check done by strbuf_check_branch_ref()
actually creates the full refname and checks that. It also catches stuff
like refs/heads/HEAD.

I doubt that it matters too much for us to be completely thorough here
(unlike some other spots, we are not enforcing rules against potentially
malicious names, but rather just helping the user realize early that
their config is bogus). So I'm not sure how careful we want to be.

-Peff
