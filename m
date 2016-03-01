From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v7 29/33] setup: configure ref storage on setup
Date: Tue, 1 Mar 2016 09:50:48 -0500
Message-ID: <20160301145048.GK12887@sigill.intra.peff.net>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
 <1456793586-22082-30-git-send-email-dturner@twopensource.com>
 <20160301084830.GB4952@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com,
	Junio C Hamano <gitster@pobox.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 15:51:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaldb-0004Dy-Da
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 15:50:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754331AbcCAOux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 09:50:53 -0500
Received: from cloud.peff.net ([50.56.180.127]:52473 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754289AbcCAOuv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 09:50:51 -0500
Received: (qmail 28274 invoked by uid 102); 1 Mar 2016 14:50:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Mar 2016 09:50:50 -0500
Received: (qmail 8365 invoked by uid 107); 1 Mar 2016 14:51:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Mar 2016 09:51:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Mar 2016 09:50:48 -0500
Content-Disposition: inline
In-Reply-To: <20160301084830.GB4952@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288029>

On Tue, Mar 01, 2016 at 03:48:30AM -0500, Jeff King wrote:

> On Mon, Feb 29, 2016 at 07:53:02PM -0500, David Turner wrote:
> 
> > diff --git a/setup.c b/setup.c
> > index bd3a2cf..e2e1220 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -457,6 +457,10 @@ static int check_repository_format_gently(const char *gitdir, int *nongit_ok)
> >  		ret = -1;
> >  	}
> >  
> > +	register_ref_storage_backends();
> > +	if (set_ref_storage_backend(ref_storage_backend))
> > +		die(_("Unknown ref storage backend %s"), ref_storage_backend);
> > +
> >  	strbuf_release(&sb);
> >  	return ret;
> >  }
> 
> Much nicer than the one it replaces, I think.
> 
> This whole block should probably go inside
> 
>   if (ret == 0) {
>      ...
>   }
> 
> If we are doing setup_git_repository_gently() and we do _not_ find a
> valid repository, we would not want to enable the ref storage.

So in the new world order of the patch series I just posted, this would
probably look like:

 1. Add a ref_backend string to "struct repository_format", and parse it
    in the callback.

 2. The bottom of check_repository_format_gently() is only reached when
    we have a workable repo. So from there, you can:

       set_ref_storage_backend(candidate.ref_backend);

    I think you'd probably want to check nongit_ok before dying on
    failure (even without my patches).

 3. Elsewhere, you can use read_repository_format() to get the backend
    speculatively (e.g., for submodules), rather than doing a custom
    git_config_from_file invocation.

None of which is to say that building on my series is a foregone
conclusion; I just wanted to point you in the right direction if you do
want to.

-Peff
