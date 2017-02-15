Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B91A2013A
	for <e@80x24.org>; Wed, 15 Feb 2017 21:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752350AbdBOVvy (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 16:51:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:56024 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751994AbdBOVvx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 16:51:53 -0500
Received: (qmail 24605 invoked by uid 109); 15 Feb 2017 21:51:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Feb 2017 21:51:53 +0000
Received: (qmail 17928 invoked by uid 111); 15 Feb 2017 21:51:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Feb 2017 16:51:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Feb 2017 16:51:51 -0500
Date:   Wed, 15 Feb 2017 16:51:51 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?SsOhY2h5bSBCYXJ2w61uZWs=?= <jachymb@gmail.com>,
        git@vger.kernel.org
Subject: Re: Confusing git messages when disk is full.
Message-ID: <20170215215151.a5chtxyjhbe3og4p@sigill.intra.peff.net>
References: <CABpqov=FE-h_2s=O9fkSjFjgFXSy6hDwc2fu5ijiVvkaLx9f_Q@mail.gmail.com>
 <20170215213221.lnraiktneokpk3mg@sigill.intra.peff.net>
 <xmqqk28r2kk4.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqk28r2kk4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 15, 2017 at 01:47:23PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Sun, Feb 12, 2017 at 05:37:30PM +0100, Jáchym Barvínek wrote:
> > If FETCH_HEAD failed to write because of a full disk (or any other
> > reason), then the right thing is for "git fetch" to write an error to
> > stderr, and git-pull should not continue the operation at all.
> >
> > If we're not doing that, then that is certainly a bug.
> 
> One suspect would be store_updated_refs().  We do catch failure from
> fopen("a") of FETCH_HEAD (it is truncated earlier in the code when
> the --append option is not given), but all the writes go through
> stdio without error checking.
> 
> I wonder if this lazy patch is sufficient.  I want to avoid having
> to sprinkle
> 
> 	if (fputs("\\n", fp))
> 		error(...);
> 
> all over the code.

Heh, I was just tracking down the exact same spot.

I think that yes, the lazy check-error-flag-at-the-end approach is fine
for stdio.

I tried to reproduce the original problem on a full loopback filesystem,
but got:

  fatal: update_ref failed for ref 'ORIG_HEAD': could not write to '.git/ORIG_HEAD'

I suspect you'd need the _exact_ right amount of free space to get all
of the predecessor steps done, and then run out of space right when
trying to flush the FETCH_HEAD contents.

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index b5ad09d046..72347f0054 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -868,7 +868,10 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>   abort:
>  	strbuf_release(&note);
>  	free(url);
> -	fclose(fp);
> +	if (ferror(fp))
> +		rc = -1;
> +	if (fclose(fp))
> +		rc = -1;
>  	return rc;

Yeah, I think this works. Normally you'd want to flush before checking
ferror(), but since you detect errors from fclose, too, it should be
fine.

We probably should write something stderr, though. Maybe:

  if (ferror(fp) || fclose(fp))
	rc = error_errno("unable to write to %s", filename);

-Peff
