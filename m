From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/6] bundle: don't leak an fd in case of early return
Date: Tue, 29 Mar 2016 21:17:43 -0400
Message-ID: <20160330011743.GD2237@sigill.intra.peff.net>
References: <1459298333-21899-1-git-send-email-sbeller@google.com>
 <1459298333-21899-6-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 03:17:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al4lb-00018A-8y
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 03:17:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753669AbcC3BRr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 21:17:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:40483 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752995AbcC3BRq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 21:17:46 -0400
Received: (qmail 23089 invoked by uid 102); 30 Mar 2016 01:17:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Mar 2016 21:17:46 -0400
Received: (qmail 30312 invoked by uid 107); 30 Mar 2016 01:17:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Mar 2016 21:17:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Mar 2016 21:17:43 -0400
Content-Disposition: inline
In-Reply-To: <1459298333-21899-6-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290249>

On Tue, Mar 29, 2016 at 05:38:52PM -0700, Stefan Beller wrote:

> In successful operation `write_pack_data` will close the `bundle_fd`,
> but when we exit early, we need to take care of the file descriptor
> ourselves.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  bundle.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/bundle.c b/bundle.c
> index 506ac49..04d62af 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -434,8 +434,11 @@ int create_bundle(struct bundle_header *header, const char *path,
>  	init_revisions(&revs, NULL);
>  
>  	/* write prerequisites */
> -	if (compute_and_write_prerequisites(bundle_fd, &revs, argc, argv))
> +	if (compute_and_write_prerequisites(bundle_fd, &revs, argc, argv)) {
> +		if (!bundle_to_stdout)
> +			close(bundle_fd);
>  		return -1;
> +	}

Makes sense. Should we also be rolling back the lock file? It happens
automatically at program exit, of course, but we are in library code
here that should not rely on that.

> @@ -447,8 +450,11 @@ int create_bundle(struct bundle_header *header, const char *path,
>  	ref_count = write_bundle_refs(bundle_fd, &revs);
>  	if (!ref_count)
>  		die(_("Refusing to create empty bundle."));
> -	else if (ref_count < 0)
> +	else if (ref_count < 0) {
> +		if (!bundle_to_stdout)
> +			close(bundle_fd);
>  		return -1;
> +	}

Ditto here, and in the error return from write_pack_data(). There are
enough spots that it may be worth setting up a "goto err" path.

-Peff
