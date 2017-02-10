Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10B8A1FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 21:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751025AbdBJVPN (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 16:15:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:53190 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750940AbdBJVPN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 16:15:13 -0500
Received: (qmail 4304 invoked by uid 109); 10 Feb 2017 21:15:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Feb 2017 21:15:12 +0000
Received: (qmail 3213 invoked by uid 111); 10 Feb 2017 21:15:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Feb 2017 16:15:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Feb 2017 16:15:10 -0500
Date:   Fri, 10 Feb 2017 16:15:10 -0500
From:   Jeff King <peff@peff.net>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] gc: ignore old gc.log files
Message-ID: <20170210211510.zbustcl5ickfiqdy@sigill.intra.peff.net>
References: <20170210205931.5348-1-dturner@twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170210205931.5348-1-dturner@twosigma.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> @@ -76,10 +78,30 @@ static void git_config_date_string(const char *key, const char **output)
>  static void process_log_file(void)
>  {
>  	struct stat st;
> -	if (!fstat(get_lock_file_fd(&log_lock), &st) && st.st_size)
> +	if (fstat(get_lock_file_fd(&log_lock), &st)) {
> +		/*
> +		 * Perhaps there was an i/o error or another
> +		 * unlikely situation.  Try to make a note of
> +		 * this in gc.log along with any existing
> +		 * messages.
> +		 */
> +		FILE *fp;
> +		int saved_errno = errno;
> +		fp = fdopen(log_lock.tempfile.fd, "a");

We usually use xfdopen() to handle (unlikely) errors rather than
segfaulting.  But I think you'd actually want fdopen_lock_file(), which
attaches the fd to the tempfile for flushing and cleanup purposes.

That said, I'm not sure I understand why you're opening a new stdio
filehandle. We know that stderr already points to our logfile (that's
how content gets there in the first place). If there's a problem with
the file or the descriptor, opening a new filehandle around the same
descriptor won't help.

Speaking of stderr, I wonder if this function should be calling
fflush(stderr) before looking at the fstat result. There could be
contents buffered there that haven't been written out yet (not from
child processes, but perhaps ones written in this process itself).
Probably unlikely in practice, since stderr is typically unbuffered by
default.

-Peff
