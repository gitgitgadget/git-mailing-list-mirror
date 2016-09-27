Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FDC2207EC
	for <e@80x24.org>; Tue, 27 Sep 2016 06:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752149AbcI0GKn (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 02:10:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:48599 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751962AbcI0GKl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 02:10:41 -0400
Received: (qmail 19751 invoked by uid 109); 27 Sep 2016 06:10:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Sep 2016 06:10:41 +0000
Received: (qmail 13088 invoked by uid 111); 27 Sep 2016 06:10:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Sep 2016 02:10:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Sep 2016 02:10:38 -0400
Date:   Tue, 27 Sep 2016 02:10:38 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>, git@vger.kernel.org,
        Santi =?utf-8?B?QsOpamFy?= <sbejar@gmail.com>,
        Kevin Bracey <kevin@bracey.fi>,
        Philip Oakley <philipoakley@iee.org>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [RFC PATCH v4] revision: new rev^-n shorthand for rev^n..rev
Message-ID: <20160927061038.pgb4uyx4sillmq5r@sigill.intra.peff.net>
References: <20160926204959.26007-1-vegard.nossum@oracle.com>
 <xmqqr386pd7d.fsf@gitster.mtv.corp.google.com>
 <xmqqh992pbq6.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh992pbq6.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 26, 2016 at 02:55:45PM -0700, Junio C Hamano wrote:

> Taking these two together, perhaps squashing this in may be
> sufficient.
> [...]
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index 2c3da19..9474c37 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -333,8 +333,22 @@ static int try_parent_shorthands(const char *arg)
>  	if (include_rev)
>  		show_rev(NORMAL, sha1, arg);
>  	commit = lookup_commit_reference(sha1);
> +
> +	if (exclude_parent) {
> +		/* do we have enough parents? */
> +		for (parent_number = 0, parents = commit->parents;
> +		     parents;
> +		     parents = parents->next)
> +			parent_number++;
> +		if (parent_number < exclude_parent) {
> +			*dotdot = '^';
> +			return 0;
> +		}
> +	}

I think you can use commit_list_count() to make this a bit shorter,
like:

  if (exclude_parent &&
      commit_list_count(commit->parents) < exclude_parent) {
          *dotdot = '^';
	  return 0;
  }

Technically you can drop the first half of the &&, but it is probably a
good idea to avoid the traversal when exclude_parent is not in use.

Also technically, you can stop counting when you hit exclude_parent
(which is only possible with a custom traversal), but it is unlikely
enough that it is probably not worth caring about.

-Peff
