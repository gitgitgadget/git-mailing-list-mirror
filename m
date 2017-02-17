Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC00E2013A
	for <e@80x24.org>; Fri, 17 Feb 2017 08:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755744AbdBQIbP (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 03:31:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:56972 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755661AbdBQIbP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 03:31:15 -0500
Received: (qmail 5388 invoked by uid 109); 17 Feb 2017 08:31:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 08:31:14 +0000
Received: (qmail 31999 invoked by uid 111); 17 Feb 2017 08:31:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 03:31:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Feb 2017 03:31:12 -0500
Date:   Fri, 17 Feb 2017 03:31:12 -0500
From:   Jeff King <peff@peff.net>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] rename_ref: replace empty deletion message in HEAD's
 log
Message-ID: <20170217083112.vn7m4udsopmlvnn5@sigill.intra.peff.net>
References: <20170126211205.5gz3zsrptop7n34n@sigill.intra.peff.net>
 <20170217035800.13214-1-kyle@kyleam.com>
 <20170217035800.13214-4-kyle@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170217035800.13214-4-kyle@kyleam.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2017 at 10:58:00PM -0500, Kyle Meyer wrote:

> When the current branch is renamed, the deletion of the old ref is
> recorded in HEAD's log with an empty message.  Now that delete_refs()
> accepts a reflog message, provide a more descriptive message.  This
> message will not be included in the reflog of the renamed branch, but
> its log already covers the renaming event with a message of "Branch:
> renamed ...".

Right, makes sense. The code overall looks fine, though I have one
nit:

> @@ -2616,10 +2617,15 @@ static int files_rename_ref(struct ref_store *ref_store,
>  		return error("unable to move logfile logs/%s to "TMP_RENAMED_LOG": %s",
>  			oldrefname, strerror(errno));
>  
> -	if (delete_ref(oldrefname, orig_sha1, REF_NODEREF, NULL)) {
> +	strbuf_addf(&logmsg_del, "Deleted %s", oldrefname);

We've been anything but consistent with our reflog messages in the past,
but I think the general guideline for new ones is to use "command:
action". Of course we don't _know_ the action here, because we're deep
in rename_ref().

Should we have the caller pass it in for us, as we do with delete_ref()
and update_ref()?

I see we actually already have a "logmsg" parameter. It already says
"Branch: renamed %s to %s". Could we just reuse that? I know that this
step is technically just the deletion, but I think it more accurately
describes the whole operation that the deletion is part of.

-Peff
