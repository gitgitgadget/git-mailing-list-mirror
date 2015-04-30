From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] git-compat-util.h: implement a different ARRAY_SIZE
 macro for for safely deriving the size of array
Date: Thu, 30 Apr 2015 14:19:01 -0400
Message-ID: <20150430181901.GA23431@peff.net>
References: <1430397854-28908-1-git-send-email-gitter.spiros@gmail.com>
 <xmqqd22l1pkl.fsf@gitster.dls.corp.google.com>
 <20150430174440.GC21800@peff.net>
 <xmqq8ud91ozm.fsf@gitster.dls.corp.google.com>
 <xmqq4mnx1or9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 20:19:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ynt3G-0000rq-4U
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 20:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752469AbbD3STG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2015 14:19:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:52360 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752077AbbD3STE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2015 14:19:04 -0400
Received: (qmail 10887 invoked by uid 102); 30 Apr 2015 18:19:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Apr 2015 13:19:04 -0500
Received: (qmail 7376 invoked by uid 107); 30 Apr 2015 18:19:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Apr 2015 14:19:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Apr 2015 14:19:01 -0400
Content-Disposition: inline
In-Reply-To: <xmqq4mnx1or9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268085>

On Thu, Apr 30, 2015 at 10:59:06AM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Jeff King <peff@peff.net> writes:
> >
> >> ISTR that you compile with "-std=c89". typeof was added in c99, I think
> >> (and was a GNU extension before that). I wonder if that is fooling the
> >> gcc version-check.
> >
> > Yeah, I think that is very likely.
> 
> Yes.  One workaround is to explicitly say that we accept the GNU
> extension in the source, perhaps.
> 
>  git-compat-util.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/git-compat-util.h b/git-compat-util.h
> index f1f8f23..7fad5aa 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -62,8 +62,8 @@
>  # if GIT_GNUC_PREREQ(3, 1)
>   /* &arr[0] degrades to a pointer: a different type from an array */
>  # define BARF_UNLESS_AN_ARRAY(arr)						\
> -	BUILD_ASSERT_OR_ZERO(!__builtin_types_compatible_p(typeof(arr), \
> -							typeof(&(arr)[0])))
> +	BUILD_ASSERT_OR_ZERO(!__builtin_types_compatible_p(__typeof__(arr), \
> +							   __typeof__(&(arr)[0])))

That seems like a reasonable fix, provided that other gcc-compatible
compilers implement the GNU-compatible name. I just tried with clang
3.5, and it seems to work fine.

And I was wrong about "typeof". It is not in C99 at all. So I think it
is really a matter of whether you are in the default "-std=gnu89" mode
or not, as to whether the compiler imports the "typeof" keyword, or if
it must be hidden in the compiler-reserved area (starting with "__").

-Peff
