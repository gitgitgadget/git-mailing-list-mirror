From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Use __VA_ARGS__ for all of error's arguments
Date: Thu, 7 Feb 2013 23:24:28 -0500
Message-ID: <20130208042428.GA4157@sigill.intra.peff.net>
References: <20130207212438.GA22253@ftbfs.org>
 <1360272632-22566-1-git-send-email-kraai@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Max Horn <max@quendi.de>,
	Junio C Hamano <gitster@pobox.com>,
	Matt Kraai <matt.kraai@amo.abbott.com>
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Fri Feb 08 05:24:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3fW9-00078a-J2
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 05:24:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759790Ab3BHEYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 23:24:31 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39077 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759724Ab3BHEYa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 23:24:30 -0500
Received: (qmail 25524 invoked by uid 107); 8 Feb 2013 04:25:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 07 Feb 2013 23:25:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Feb 2013 23:24:28 -0500
Content-Disposition: inline
In-Reply-To: <1360272632-22566-1-git-send-email-kraai@ftbfs.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215748>

On Thu, Feb 07, 2013 at 01:30:32PM -0800, Matt Kraai wrote:

> From: Matt Kraai <matt.kraai@amo.abbott.com>
> 
> QNX 6.3.2 uses GCC 2.95.3 by default, and GCC 2.95.3 doesn't remove the
> comma if the error macro's variable argument is left out.
> 
> Instead of testing for a sufficiently recent version of GCC, make
> __VA_ARGS__ match all of the arguments.

Thanks, this looks better than the original (we do not assume a C99
compiler, so just doing this unconditionally would probably break some
other older systems which do not use gcc).

>  /*
>   * Let callers be aware of the constant return value; this can help
> - * gcc with -Wuninitialized analysis. We have to restrict this trick to
> - * gcc, though, because of the variadic macro and the magic ## comma pasting
> - * behavior. But since we're only trying to help gcc, anyway, it's OK; other
> - * compilers will fall back to using the function as usual.
> + * gcc with -Wuninitialized analysis.
>   */
>  #if defined(__GNUC__) && ! defined(__clang__)
> -#define error(fmt, ...) (error((fmt), ##__VA_ARGS__), -1)
> +#define error(...) (error(__VA_ARGS__), -1)

Should you be dropping most of the comment like this? I would expect it
to be more like:

  We have to restrict this trick to gcc, though, because we do not
  assume all compilers support variadic macros. But since...

Other than that, I think it is OK. The compiler will still catch
"error()" with no arguments and generate the appropriate diagnostic (in
fact, it is better, because the error is now passing too few args to a
function, not to the macro).

-Peff
