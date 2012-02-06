From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fix build problems related to profile-directed
 optimization
Date: Sun, 5 Feb 2012 23:18:39 -0500
Message-ID: <20120206041839.GB29365@sigill.intra.peff.net>
References: <7vaa4zpu2r.fsf@alter.siamese.dyndns.org>
 <1328489090-14178-1-git-send-email-tytso@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 06 05:18:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuG2Q-0006Zz-Qn
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 05:18:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753487Ab2BFESm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 23:18:42 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58537
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753302Ab2BFESl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 23:18:41 -0500
Received: (qmail 22580 invoked by uid 107); 6 Feb 2012 04:25:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 05 Feb 2012 23:25:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Feb 2012 23:18:39 -0500
Content-Disposition: inline
In-Reply-To: <1328489090-14178-1-git-send-email-tytso@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190006>

On Sun, Feb 05, 2012 at 07:44:50PM -0500, Theodore Ts'o wrote:

> diff --git a/INSTALL b/INSTALL
> index 6fa83fe..5b7eec1 100644
> --- a/INSTALL
> +++ b/INSTALL
> @@ -28,16 +28,25 @@ set up install paths (via config.mak.autogen), so you can write instead
>  If you're willing to trade off (much) longer build time for a later
>  faster git you can also do a profile feedback build with
>  
> -	$ make profile-all
> -	# make prefix=... install
> +	$ make --prefix=/usr PROFILE=BUILD all
> +	# make --prefix=/usr PROFILE=BUILD install

Eh? --prefix?

> +As a caveat: a profile-optimized build takes a *lot* longer since it
> +is the sources have to be built twice, and in order for the profiling

s/it is//

> diff --git a/Makefile b/Makefile
> index c457c34..8cea247 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1772,6 +1772,24 @@ ifdef ASCIIDOC7
> [...]
> +ifeq "$(PROFILE)" "GEN"
> +	CFLAGS += -fprofile-generate=$(PROFILE_DIR) -DNO_NORETURN=1
> +	EXTLIBS += -lgcov
> +	export CCACHE_DISABLE=t
> +	V=1
> +else ifneq "$PROFILE" ""
> +	CFLAGS += -fprofile-use=$(PROFILE_DIR) -fprofile-correction -DNO_NORETURN=1
> +	export CCACHE_DISABLE=t
> +	V=1
> +endif

Did you mean "$(PROFILE)" in the second conditional?

-Peff
