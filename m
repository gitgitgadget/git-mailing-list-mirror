Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 892001FF6D
	for <e@80x24.org>; Thu, 15 Dec 2016 19:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753614AbcLOTEw (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 14:04:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:57156 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751845AbcLOTEu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 14:04:50 -0500
Received: (qmail 14507 invoked by uid 109); 15 Dec 2016 19:03:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Dec 2016 19:03:54 +0000
Received: (qmail 4583 invoked by uid 111); 15 Dec 2016 19:04:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Dec 2016 14:04:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Dec 2016 14:03:51 -0500
Date:   Thu, 15 Dec 2016 14:03:51 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 07/34] sequencer (rebase -i): add support for the
 'fixup' and 'squash' commands
Message-ID: <20161215190351.as76panrcz5rgibj@sigill.intra.peff.net>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
 <cover.1481642927.git.johannes.schindelin@gmx.de>
 <ae521f75a105c6b9e54595d68bda3c5b62f313b6.1481642927.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ae521f75a105c6b9e54595d68bda3c5b62f313b6.1481642927.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 13, 2016 at 04:30:01PM +0100, Johannes Schindelin wrote:

> +	else {
> +		unsigned char head[20];
> +		struct commit *head_commit;
> +		const char *head_message, *body;
> +
> +		if (get_sha1("HEAD", head))
> +			return error(_("need a HEAD to fixup"));
> +		if (!(head_commit = lookup_commit_reference(head)))
> +			return error(_("could not read HEAD"));
> +		if (!(head_message = get_commit_buffer(head_commit, NULL)))
> +			return error(_("could not read HEAD's commit message"));

This get_commit_buffer() may allocate a fresh buffer...

> +		body = strstr(head_message, "\n\n");
> +		if (!body)
> +			body = "";
> +		else
> +			body = skip_blank_lines(body + 2);
> +		if (write_message(body, strlen(body),
> +				  rebase_path_fixup_msg(), 0))
> +			return error(_("cannot write '%s'"),
> +				     rebase_path_fixup_msg());

...and then this return leaks the result (the other code path hits
unuse_commit_buffer(), and is fine).

This leak was noticed by Coverity. It has a _ton_ of false positives
across the whole project, but it sends out a mail with new ones every
few days, which is usually short enough that I can process it in 30
seconds or so.

I _think_ that email just goes to me and Stefan right now. You can add
yourself at:

  https://scan.coverity.com/projects/git?tab=project_settings

if you already have admin access to the project (which I think you
(Dscho) do).  I wonder if it would be helpful to send that output to the
list.

-Peff
