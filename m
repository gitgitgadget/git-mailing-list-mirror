Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A65C433DF
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 13:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E27E4206F1
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 13:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgFPNWT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 09:22:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:33164 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgFPNWR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 09:22:17 -0400
Received: (qmail 21885 invoked by uid 109); 16 Jun 2020 13:22:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Jun 2020 13:22:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13069 invoked by uid 111); 16 Jun 2020 13:22:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Jun 2020 09:22:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Jun 2020 09:22:16 -0400
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
Subject: Re: [PATCH v2 09/12] clone: handle overridden main branch names
Message-ID: <20200616132216.GH666057@coredump.intra.peff.net>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
 <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
 <0e59b6181699abe17eb46fe3ca5a48ce71889780.1592225416.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0e59b6181699abe17eb46fe3ca5a48ce71889780.1592225416.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 15, 2020 at 12:50:13PM +0000, Johannes Schindelin via GitGitGadget wrote:

> diff --git a/builtin/clone.c b/builtin/clone.c
> index 487b0a42d75..755fcaeb0ba 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -718,6 +718,7 @@ static void update_head(const struct ref *our, const struct ref *remote,
>  		/* Local default branch link */
>  		if (create_symref("HEAD", our->name, NULL) < 0)
>  			die(_("unable to update HEAD"));
> +		git_config_set("core.mainbranch", head);
>  		if (!option_bare) {
>  			update_ref(msg, "HEAD", &our->old_oid, NULL, 0,
>  				   UPDATE_REFS_DIE_ON_ERR);

Just making sure I understand what's going on here...

This covers the case that we've run "clone -b foo" or similar, but there
are two other case arms when "foo" is a tag, or the remote HEAD is
unreachable. And there we don't set core.mainbranch at all.

But we would not want it to be missing, because that will likely need to
stay a default for "master" indefinitely (to keep behavior for existing
repositories). However, it won't be missing. We'll always have set it
during the init_db() call, and this is just overriding that. So we'd end
update_head() with either:

  - core.mainbranch set to the same branch we point HEAD to, whether we
    got it from the remote side or from "-b foo"

  - if we write a detached HEAD, then core.mainbranch remains at
    init.mainbranch (or defaulting to "master" now, and probably "main"
    later). We have no better option.

If so, then that makes sense to me.

-Peff
