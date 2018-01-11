Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86AD41FADF
	for <e@80x24.org>; Thu, 11 Jan 2018 13:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754102AbeAKNnQ convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 11 Jan 2018 08:43:16 -0500
Received: from elephants.elehost.com ([216.66.27.132]:58590 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753165AbeAKNnP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 08:43:15 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0BDhCgB049085
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 11 Jan 2018 08:43:13 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>
Cc:     "'git mailing list'" <git@vger.kernel.org>
References: <010f01d38a9e$a5c4f290$f14ed7b0$@nexbridge.com> <20180111063110.GB31213@sigill.intra.peff.net>
In-Reply-To: <20180111063110.GB31213@sigill.intra.peff.net>
Subject: RE: [PATCH] Replaced read with xread in transport-helper.c to fix SSIZE_MAX overun in t5509
Date:   Thu, 11 Jan 2018 08:43:06 -0500
Message-ID: <002201d38ae2$1f9b26a0$5ed173e0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJsSMotxvL6FxEkVCXZaKOUGVaNvAHrlxhgoi3VMxA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 11, 2018 1:31 AM Jeff King wrote"
> On Thu, Jan 11, 2018 at 12:40:05AM -0500, Randall S. Becker wrote:
> > diff --git a/transport-helper.c b/transport-helper.c index
> > 3640804..68a4e30 100644
> > --- a/transport-helper.c
> > +++ b/transport-helper.c
> > @@ -1202,7 +1202,7 @@ static int udt_do_read(struct
> unidirectional_transfer *t)
> >                 return 0;       /* No space for more. */
> >
> >         transfer_debug("%s is readable", t->src_name);
> > -       bytes = read(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
> > +       bytes = xread(t->src, t->buf + t->bufuse, BUFFERSIZE -
> > + t->bufuse);
> >         if (bytes < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
> >                 errno != EINTR) {
> >                 error_errno("read(%s) failed", t->src_name);
> 
> After this patch, I don't think we can ever see any of those errno values
> again, as xread() will automatically retry in such a case.
> 
> I think that's OK. In the code before your patch, udt_do_read() would return
> 0 in such a case, giving the caller the opportunity to do something besides
> simply retry the read. But the only caller is udt_copy_task_routine(), which
> would just loop anyway.  It may be worth mentioning that in the commit
> message.
> 
> So your patch is OK.  But we should probably clean up on top, like the patch
> below (on top of yours; though note your patch was whitespace corrupted;
> the tabs were converted to spaces).
> 
> -- >8 --
> Subject: [PATCH] transport-helper: drop read/write errno checks
> 
> Since we use xread() and xwrite() here, EINTR, EAGAIN, and EWOULDBLOCK
> retries are already handled for us, and we will never see these errno values
> ourselves. We can drop these conditions entirely, making the code easier to
> follow.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  transport-helper.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/transport-helper.c b/transport-helper.c index
> d48be722a5..fc49567ac4 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -1208,8 +1208,7 @@ static int udt_do_read(struct
> unidirectional_transfer *t)
> 
>  	transfer_debug("%s is readable", t->src_name);
>  	bytes = xread(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
> -	if (bytes < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
> -		errno != EINTR) {
> +	if (bytes < 0) {
>  		error_errno("read(%s) failed", t->src_name);
>  		return -1;
>  	} else if (bytes == 0) {
> @@ -1236,7 +1235,7 @@ static int udt_do_write(struct
> unidirectional_transfer *t)
> 
>  	transfer_debug("%s is writable", t->dest_name);
>  	bytes = xwrite(t->dest, t->buf, t->bufuse);
> -	if (bytes < 0 && errno != EWOULDBLOCK) {
> +	if (bytes < 0) {
>  		error_errno("write(%s) failed", t->dest_name);
>  		return -1;
>  	} else if (bytes > 0) {

I'm sorry about the spaces. Still trying to get my mailer fixed so that I can get there directly from git.

Thanks for the approval and subsequent.
Cheers,
Randall

