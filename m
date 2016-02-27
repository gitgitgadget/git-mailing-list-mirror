From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fetch-pack: fix object_id of exact sha1
Date: Sat, 27 Feb 2016 17:12:48 -0500
Message-ID: <20160227221248.GB17475@sigill.intra.peff.net>
References: <CABaesJ+yNJ6_z=sFc+bDEPqDDsw9fkB5bYgxJaAkAMVqHNWwrQ@mail.gmail.com>
 <1456605174-28360-1-git-send-email-gabrielfrancosouza@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 23:12:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZn6e-0005lL-B2
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 23:12:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756831AbcB0WMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 17:12:52 -0500
Received: from cloud.peff.net ([50.56.180.127]:50859 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756728AbcB0WMv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 17:12:51 -0500
Received: (qmail 9171 invoked by uid 102); 27 Feb 2016 22:12:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 27 Feb 2016 17:12:51 -0500
Received: (qmail 15638 invoked by uid 107); 27 Feb 2016 22:13:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 27 Feb 2016 17:13:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 27 Feb 2016 17:12:48 -0500
Content-Disposition: inline
In-Reply-To: <1456605174-28360-1-git-send-email-gabrielfrancosouza@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287732>

On Sat, Feb 27, 2016 at 05:32:54PM -0300, Gabriel Souza Franco wrote:

> Commit 58f2ed0 (remote-curl: pass ref SHA-1 to fetch-pack as well,
> 2013-12-05) added support for specifying a SHA-1 as well as a ref name.
> Add support for specifying just a SHA-1 and set the ref name to the same
> value in this case.
> 
> Signed-off-by: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
> ---
>  builtin/fetch-pack.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
> index 79a611f..d7e439a 100644
> --- a/builtin/fetch-pack.c
> +++ b/builtin/fetch-pack.c
> @@ -16,10 +16,10 @@ static void add_sought_entry(struct ref ***sought, int *nr, int *alloc,
>  	struct ref *ref;
>  	struct object_id oid;
>  
> -	if (!get_oid_hex(name, &oid) && name[GIT_SHA1_HEXSZ] == ' ')
> -		name += GIT_SHA1_HEXSZ + 1;
> -	else
> +	if (get_oid_hex(name, &oid))
>  		oidclr(&oid);
> +	else if (name[GIT_SHA1_HEXSZ] == ' ')
> +		name += GIT_SHA1_HEXSZ + 1;

This makes sense to me. I wonder if we should be more particular about
the pure-sha1 case consuming the whole string, though. E.g., if we get:

  1234567890123456789012345678901234567890-bananas

that should probably not have sha1 1234...

I don't think it should ever really happen in practice, but it might be
worth noticing and complaining when name[GIT_SHA1_HEXSZ] is neither
space nor '\0'.

-Peff
