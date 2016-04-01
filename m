From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv4 3/4] bundle: don't leak an fd in case of early return
Date: Fri, 1 Apr 2016 13:31:09 -0400
Message-ID: <20160401173109.GA21061@sigill.intra.peff.net>
References: <1459470946-16522-1-git-send-email-sbeller@google.com>
 <1459470946-16522-4-git-send-email-sbeller@google.com>
 <xmqqzitdi7iq.fsf@gitster.mtv.corp.google.com>
 <20160401171535.GB20345@sigill.intra.peff.net>
 <xmqqk2khi6eo.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>, sunshine@sunshineco.com,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 19:31:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am2ui-0007Gw-LW
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 19:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391AbcDARbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 13:31:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:42559 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752287AbcDARbM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 13:31:12 -0400
Received: (qmail 11937 invoked by uid 102); 1 Apr 2016 17:31:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Apr 2016 13:31:11 -0400
Received: (qmail 27674 invoked by uid 107); 1 Apr 2016 17:31:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Apr 2016 13:31:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Apr 2016 13:31:09 -0400
Content-Disposition: inline
In-Reply-To: <xmqqk2khi6eo.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290568>

On Fri, Apr 01, 2016 at 10:29:51AM -0700, Junio C Hamano wrote:

> > This does still suffer from the double-close I mentioned earlier. I'm
> > not sure if we want to address that or not.
> 
> Something like this on top?
> 
>  bundle.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/bundle.c b/bundle.c
> index 08e32ca..bbf4efa 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -453,8 +453,10 @@ int create_bundle(struct bundle_header *header, const char *path,
>  		goto err;
>  
>  	/* write pack */
> -	if (write_pack_data(bundle_fd, &revs))
> +	if (write_pack_data(bundle_fd, &revs)) {
> +		bundle_fd = -1; /* already closed by the above call */
>  		goto err;
> +	}
>  
>  	if (!bundle_to_stdout) {
>  		if (commit_lock_file(&lock))
> @@ -463,7 +465,8 @@ int create_bundle(struct bundle_header *header, const char *path,
>  	return 0;
>  err:
>  	if (!bundle_to_stdout) {
> -		close(bundle_fd);
> +		if (0 <= bundle_fd)
> +			close(bundle_fd);
>  		rollback_lock_file(&lock);

Yep, that looks fine.

-Peff
