From: Jeff King <peff@peff.net>
Subject: Re: git segfaults on older Solaris releases
Date: Thu, 7 Apr 2016 15:07:10 -0400
Message-ID: <20160407190709.GC4478@sigill.intra.peff.net>
References: <5706A489.7070101@jupiterrise.com>
 <xmqqoa9lz2uw.fsf@gitster.mtv.corp.google.com>
 <xmqqk2k9z20p.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Tom G. Christensen" <tgc@jupiterrise.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 21:07:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoFH6-0001ED-8m
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 21:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756860AbcDGTHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 15:07:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:46062 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751626AbcDGTHO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 15:07:14 -0400
Received: (qmail 28124 invoked by uid 102); 7 Apr 2016 19:07:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 07 Apr 2016 15:07:13 -0400
Received: (qmail 29770 invoked by uid 107); 7 Apr 2016 19:07:16 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 07 Apr 2016 15:07:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Apr 2016 15:07:10 -0400
Content-Disposition: inline
In-Reply-To: <xmqqk2k9z20p.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290977>

On Thu, Apr 07, 2016 at 11:50:46AM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > "Tom G. Christensen" <tgc@jupiterrise.com> writes:
> >
> >> The reason for the crash is simple, a null value was passed to the 's'
> >> format for the *printf family of functions.
> >> ...
> >> Passing a null value to the 's' format is explicitly documented as
> >> giving undefined results on Solaris, even on Solaris 11(2).

Thanks, TIL (though it is not really surprising, I guess, since some
memcpy implementations have the same problem).

> So, I've looked at places where we use "%.*s" with "prefix" nearby,
> and it seems that this is the only place.

Thank you for digging; I obviously didn't think about this issue at all
when doing the mass conversions recently.

> The "prefix" being a NULL is a perfectly valid state throughout the
> system and means a different thing than it being an empty string, so
> it is valid for callers of prefix_path() and prefix_path_gently() to
> pass prefix=NULL as long as they pass len=0.
> 
> So perhaps this is all we need to fix your box.
> 
>  setup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/setup.c b/setup.c
> index 3439ec6..b6c8aab 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -103,7 +103,7 @@ char *prefix_path_gently(const char *prefix, int len,
>  			return NULL;
>  		}
>  	} else {
> -		sanitized = xstrfmt("%.*s%s", len, prefix, path);
> +		sanitized = xstrfmt("%.*s%s", len, prefix ? prefix : "", path);
>  		if (remaining_prefix)
>  			*remaining_prefix = len;
>  		if (normalize_path_copy_len(sanitized, sanitized, remaining_prefix)) {

The original pre-75faa45ae0230b321bf72027b2274315d7e14e34 version
checked "if (len)", but I think this should be equally right.

-Peff
