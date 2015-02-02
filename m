From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] sha1_file: fix iterating loose alternate objects
Date: Mon, 2 Feb 2015 12:53:00 -0500
Message-ID: <20150202175259.GA24025@peff.net>
References: <BF4AA771-DEB5-4DED-9C74-768036C1E2DD@jonathonmah.com>
 <50251CB8-0885-40FF-A7C9-9C9460266E14@jonathonmah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathon Mah <me@jonathonmah.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 18:53:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YILBN-0003Uw-Lh
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 18:53:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbbBBRxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 12:53:05 -0500
Received: from cloud.peff.net ([50.56.180.127]:44099 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753025AbbBBRxE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2015 12:53:04 -0500
Received: (qmail 10823 invoked by uid 102); 2 Feb 2015 17:53:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Feb 2015 11:53:03 -0600
Received: (qmail 9977 invoked by uid 107); 2 Feb 2015 17:53:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Feb 2015 12:53:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Feb 2015 12:53:00 -0500
Content-Disposition: inline
In-Reply-To: <50251CB8-0885-40FF-A7C9-9C9460266E14@jonathonmah.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263265>

On Sun, Feb 01, 2015 at 01:55:33PM -0800, Jonathon Mah wrote:

> The string in 'base' contains a path suffix to a specific object; when
> its value is used, the suffix must either be filled (as in
> stat_sha1_file, open_sha1_file, check_and_freshen_nonlocal) or cleared
> (as in prepare_packed_git) to avoid junk at the end.  loose_from_alt_odb
> (introduced in 660c889e46d185dc98ba78963528826728b0a55d) did neither and
> treated 'base' as a complete path to the "base" object directory,
> instead of a pointer to the "base" of the full path string.
> 
> The trailing path after 'base' is still initialized to NUL, hiding the
> bug in some common cases.  Additionally the descendent
> for_each_file_in_obj_subdir function swallows ENOENT, so an error only
> shows if the alternate's path was last filled with a valid object
> (where statting /path/to/existing/00/0bjectfile/00 fails).

Thanks for catching this, and for a nice explanation.

> diff --git a/sha1_file.c b/sha1_file.c
> index 30995e6..fcb1c4b 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -3396,9 +3396,13 @@ static int loose_from_alt_odb(struct alternate_object_database *alt,
>  			      void *vdata)
>  {
>  	struct loose_alt_odb_data *data = vdata;
> -	return for_each_loose_file_in_objdir(alt->base,
> -					     data->cb, NULL, NULL,
> -					     data->data);
> +	int r;
> +	alt->name[-1] = 0;
> +	r = for_each_loose_file_in_objdir(alt->base,
> +					  data->cb, NULL, NULL,
> +					  data->data);
> +	alt->name[-1] = '/';
> +	return r;
>  }

I think this is probably the best fix, and is the pattern we use
elsewhere when touching alt->base.

We _could_ further change this to have for_each_loose_file_in_objdir
actually use alt->base as its scratch buffer, writing the object
filenames into the end of it (i.e., what it was designed for). But:

  1. We still need a strbuf scratch-buffer for the non-alternate object
     directory. So we'd have to push more code there to over-allocate
     the buffer, and then for_each_loose_file_in_objdir would assume
     we always feed it a buffer with the extra slop. That would work,
     but I find the strbuf approach a little safer; there's not an
     implicit over-allocation far away in the code preventing us from
     overflowing a buffer.

  2. The reason for the existing alt->base behavior is that the
     sha1_file code gets fed objects one at a time, and don't want to
     pay strbuf overhead for each. With the iterator, we know we are
     going to hit a bunch of objects, so we only have to pay the strbuf
     overhead once for the iteration. So there's not the same
     performance penalty, and we can stick with the strbuf if we prefer
     it.

-Peff
