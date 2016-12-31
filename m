Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C96F81FCA5
	for <e@80x24.org>; Sat, 31 Dec 2016 06:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752580AbcLaGf3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Dec 2016 01:35:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:33488 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752336AbcLaGf2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2016 01:35:28 -0500
Received: (qmail 11096 invoked by uid 109); 31 Dec 2016 06:35:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 31 Dec 2016 06:35:27 +0000
Received: (qmail 2149 invoked by uid 111); 31 Dec 2016 06:36:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 31 Dec 2016 01:36:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 31 Dec 2016 01:35:23 -0500
Date:   Sat, 31 Dec 2016 01:35:23 -0500
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        David Turner <novalis@novalis.org>
Subject: Re: [PATCH v3 14/23] log_ref_write_1(): don't depend on logfile
 argument
Message-ID: <20161231063523.fncqqpr3m42jjvbs@sigill.intra.peff.net>
References: <cover.1483153436.git.mhagger@alum.mit.edu>
 <1e1295aff09039fc49188b085bda6ee5166d313e.1483153436.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1e1295aff09039fc49188b085bda6ee5166d313e.1483153436.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 31, 2016 at 04:12:54AM +0100, Michael Haggerty wrote:

> It's unnecessary to pass a strbuf holding the reflog path up and down
> the call stack now that it is hardly needed by the callers. Remove the
> places where log_ref_write_1() uses it, in preparation for making it
> internal to log_ref_setup().
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs/files-backend.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 7f26cf8..5a96424 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2837,14 +2837,18 @@ static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
>  	result = log_ref_write_fd(logfd, old_sha1, new_sha1,
>  				  git_committer_info(0), msg);
>  	if (result) {
> -		strbuf_addf(err, "unable to append to '%s': %s", logfile->buf,
> -			    strerror(errno));
> +		int save_errno = errno;
> +
> +		strbuf_addf(err, "unable to append to '%s': %s",
> +			    git_path("logs/%s", refname), strerror(save_errno));

Hmm. This means the logic of "the path for a reflog is
git_path(logs/%s)" is now replicated in several places. Which feels kind
of like a backwards step. But I guess it is pretty well cemented in the
concept of files-backend.c, and I do like the later cleanups that this
allows.

-Peff
