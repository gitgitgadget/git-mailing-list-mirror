From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 3/4] bundle: don't leak an fd in case of early return
Date: Thu, 31 Mar 2016 15:11:52 -0400
Message-ID: <20160331191151.GA5013@sigill.intra.peff.net>
References: <1459447446-32260-1-git-send-email-sbeller@google.com>
 <1459447446-32260-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: sunshine@sunshineco.com, gitster@pobox.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 21:12:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ali0d-0006B2-Lr
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 21:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755361AbcCaTL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 15:11:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:41842 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752076AbcCaTLz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 15:11:55 -0400
Received: (qmail 7403 invoked by uid 102); 31 Mar 2016 19:11:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 31 Mar 2016 15:11:54 -0400
Received: (qmail 16638 invoked by uid 107); 31 Mar 2016 19:11:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 31 Mar 2016 15:11:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Mar 2016 15:11:52 -0400
Content-Disposition: inline
In-Reply-To: <1459447446-32260-4-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290449>

On Thu, Mar 31, 2016 at 11:04:05AM -0700, Stefan Beller wrote:

> diff --git a/bundle.c b/bundle.c
> index 506ac49..31ae1da 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -435,12 +435,14 @@ int create_bundle(struct bundle_header *header, const char *path,
>  
>  	/* write prerequisites */
>  	if (compute_and_write_prerequisites(bundle_fd, &revs, argc, argv))
> -		return -1;
> +		goto err;
>  
>  	argc = setup_revisions(argc, argv, &revs, NULL);
>  
> -	if (argc > 1)
> -		return error(_("unrecognized argument: %s"), argv[1]);
> +	if (argc > 1) {
> +		error(_("unrecognized argument: %s"), argv[1]);
> +		goto err;
> +	}
>  
>  	object_array_remove_duplicates(&revs.pending);
>  
> @@ -448,17 +450,22 @@ int create_bundle(struct bundle_header *header, const char *path,
>  	if (!ref_count)
>  		die(_("Refusing to create empty bundle."));
>  	else if (ref_count < 0)
> -		return -1;
> +		goto err;
>  
>  	/* write pack */
>  	if (write_pack_data(bundle_fd, &revs))
> -		return -1;
> +		goto err;

Sorry for not noticing this before, but if we assume write_pack_data
always closes bundle_fd, even on error (and I think it does), then the
close() in the "err" code path is redundant from this goto, right?

I guess it is harmless, as nobody could have opened a new descriptor in
the interim, so our close(bundle_fd) will just get EBADF. But I guess we
could also do:

  if (write_pack_data(bundle_fd, &revs)) {
	bundle_fd = -1;
	goto err;
  }

or even:

  ret = write_pack_data(bundle_fd, &revs);
  bundle_fd = -1; /* closed by write_pack_data */
  if (ret)
	goto err;

to ensure that nobody (including the non-error code paths) uses it
again.

Like I said, I don't think it's buggy in the current code, but it does
seem a little fragile.

> +err:
> +	if (!bundle_to_stdout)
> +		close(bundle_fd);
> +	rollback_lock_file(&lock);
> +	return -1;

Similarly, I think the rollback_lock_file() call is redundant if
bundle_to_stdout is set (because we don't have created a lockfile in the
first place). I think this is more explicitly OK, because the lockfile
keeps an "am I initialized" flag, but perhaps sticking inside the "if
(!bundle_to_stdout)" condition makes it more clear that it's not an
error (especially because the "commit_lock_file" call above is inside
one).

-Peff
