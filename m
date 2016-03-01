From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v7 29/33] setup: configure ref storage on setup
Date: Tue, 1 Mar 2016 03:48:30 -0500
Message-ID: <20160301084830.GB4952@sigill.intra.peff.net>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
 <1456793586-22082-30-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com,
	Junio C Hamano <gitster@pobox.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 09:48:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aafyx-00046Z-A4
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 09:48:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965AbcCAIse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 03:48:34 -0500
Received: from cloud.peff.net ([50.56.180.127]:52269 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751209AbcCAIsd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 03:48:33 -0500
Received: (qmail 11638 invoked by uid 102); 1 Mar 2016 08:48:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Mar 2016 03:48:33 -0500
Received: (qmail 6153 invoked by uid 107); 1 Mar 2016 08:48:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Mar 2016 03:48:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Mar 2016 03:48:30 -0500
Content-Disposition: inline
In-Reply-To: <1456793586-22082-30-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288002>

On Mon, Feb 29, 2016 at 07:53:02PM -0500, David Turner wrote:

> diff --git a/setup.c b/setup.c
> index bd3a2cf..e2e1220 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -457,6 +457,10 @@ static int check_repository_format_gently(const char *gitdir, int *nongit_ok)
>  		ret = -1;
>  	}
>  
> +	register_ref_storage_backends();
> +	if (set_ref_storage_backend(ref_storage_backend))
> +		die(_("Unknown ref storage backend %s"), ref_storage_backend);
> +
>  	strbuf_release(&sb);
>  	return ret;
>  }

Much nicer than the one it replaces, I think.

This whole block should probably go inside

  if (ret == 0) {
     ...
  }

If we are doing setup_git_repository_gently() and we do _not_ find a
valid repository, we would not want to enable the ref storage.

I also wondered what happens to ref_storage_backend in a case where we
call check_repository_format_gently() multiple times. I think we don't
actually call it at all for submodules, so we at least we know we are
always dealing with the main repository.

But what if we call check_repository_format_gently(), find an
extensions.refstorage config key, set the global, but then _don't_
actually accept the repo (e.g., because its version is too high). Then
we keep looking and find another repo, which does not have
extensions.refstorage set. But we use the stale value from the first
directory.

I admit this is a pretty unlikely scenario. But I think it does point to
a mis-design in the way we read extensions in the config callback. They
should not go into globals until we're sure we're accepting this config
as the actual repository.  So the existing "preciousobjects" extension
has this problem, too.

-Peff
