Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A554201A4
	for <e@80x24.org>; Sat, 13 May 2017 09:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752079AbdEMJHo (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 05:07:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:50766 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751725AbdEMJHn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 05:07:43 -0400
Received: (qmail 28405 invoked by uid 109); 13 May 2017 09:07:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 May 2017 09:07:42 +0000
Received: (qmail 30614 invoked by uid 111); 13 May 2017 09:08:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 May 2017 05:08:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 May 2017 05:07:40 -0400
Date:   Sat, 13 May 2017 05:07:40 -0400
From:   Jeff King <peff@peff.net>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: Re: [PATCH v7 09/10] sub-process: move sub-process functions into
 separate files
Message-ID: <20170513090740.xldv4td3omhg3gxc@sigill.intra.peff.net>
References: <20170505152802.6724-1-benpeart@microsoft.com>
 <20170505152802.6724-10-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170505152802.6724-10-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 05, 2017 at 11:28:01AM -0400, Ben Peart wrote:

> +static void subprocess_exit_handler(struct child_process *process)
> +{
> +	sigchain_push(SIGPIPE, SIG_IGN);
> +	/* Closing the pipe signals the subprocess to initiate a shutdown. */
> +	close(process->in);
> +	close(process->out);
> +	sigchain_pop(SIGPIPE);
> +	/* Finish command will wait until the shutdown is complete. */
> +	finish_command(process);
> +}

This isn't a new issue with your series, but the SIGPIPEs here seem odd.
I don't think you can get SIGPIPE from closing descriptors.

I suspect this is a hold-over from when Lars' original design, where we
actually sent an "exit" message to the filter. It's not hurting
anything, and I don't think it's worth holding up your series for. But
when you are working in this area further, it might be worth cleaning
up.

-Peff
