From: Jeff King <peff@peff.net>
Subject: Re: [RFC] How to pass Git config command line instructions to
 Submodule commands?
Date: Thu, 28 Apr 2016 08:05:04 -0400
Message-ID: <20160428120504.GA22399@sigill.intra.peff.net>
References: <60724588-B06E-47E8-9302-8709C4601826@gmail.com>
 <CAGZ79kYmAr-O6_Jw2KO9eZEfZQ+_WBiERF=nhOYLJCZpUjSSyA@mail.gmail.com>
 <CA+P7+xoaqNF+uBHVnD2QR7j-=0Hyvd-scTc_vOdV+etC0VS9jA@mail.gmail.com>
 <20160425212449.GA7636@sigill.intra.peff.net>
 <017AA7DB-5224-49C3-A4A6-6C93005BF006@gmail.com>
 <20160428112511.GA11522@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Git Users <git@vger.kernel.org>, Jens.Lehmann@web.de
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 14:05:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avkh4-0004VS-Lc
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 14:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239AbcD1MFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 08:05:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:58219 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752876AbcD1MFH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 08:05:07 -0400
Received: (qmail 20725 invoked by uid 102); 28 Apr 2016 12:05:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 08:05:06 -0400
Received: (qmail 8811 invoked by uid 107); 28 Apr 2016 12:05:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 08:05:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Apr 2016 08:05:04 -0400
Content-Disposition: inline
In-Reply-To: <20160428112511.GA11522@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292869>

On Thu, Apr 28, 2016 at 07:25:11AM -0400, Jeff King wrote:

> > diff --git a/git-submodule.sh b/git-submodule.sh
> > index 2a84d7e..b02f5b9 100755
> > --- a/git-submodule.sh
> > +++ b/git-submodule.sh
> > @@ -199,7 +199,7 @@ sanitize_submodule_env()
> >  {
> >  	sanitized_config=$(git submodule--helper sanitize-config)
> >  	clear_local_git_env
> > -	GIT_CONFIG_PARAMETERS=$sanitized_config
> > +	export GIT_CONFIG_PARAMETERS=$sanitized_config
> >  }
> 
> If you already have $GIT_CONFIG_PARAMETERS exported when we enter the
> function, then we should not need to re-export it when changing the
> value in the final line (the export bit is retained by the shell). But
> if you don't have it set already, then $sanitized_config must by
> definition be empty.
> 
> So it should do the right thing without the export.
> 
> At the same time, clear_local_git_env() will call "unset" on
> GIT_CONFIG_PARAMETERS. Which would clear the export bit, meaning the
> final line doesn't ever have any impact on sub-programs, and the whole
> thing is totally broken. But then, why does the test in t5550 pass?
> 
> Confused...

Ah. t5550 passes because it does not exercise this code path at all. We
try a recursive clone, which calls "git submodule update --init", which
does not seem to clear the config at all. So it works even without
14111fc49.

I tried to improve the test by adding git-fetch (note that I also fixed
a bug where we use $HTTP_URL instead of $HTTPD_URL, and added some
whitespace to make the result more readable):

diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 69ef388..6ec3ba3 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -103,12 +103,23 @@ test_expect_success 'cmdline credential config passes into submodules' '
 		git submodule add "$HTTPD_URL/auth/dumb/repo.git" sub &&
 		git commit -m "add submodule"
 	) &&
+
 	set_askpass wrong pass@host &&
 	test_must_fail git clone --recursive super super-clone &&
 	rm -rf super-clone &&
+
 	set_askpass wrong pass@host &&
-	git -c "credential.$HTTP_URL.username=user@host" \
+	git -c "credential.$HTTPD_URL.username=user@host" \
 		clone --recursive super super-clone &&
+	expect_askpass pass user@host &&
+
+	set_askpass wrong pass@host &&
+	test_must_fail git -C super-clone fetch --recurse-submodules &&
+
+	set_askpass wrong pass@host &&
+	git -C super-clone \
+	    -c "credential.$HTTPD_URL.username=user@host" \
+	    fetch --recurse-submodules &&
 	expect_askpass pass user@host
 '
 

but that doesn't pass, even with the export fix! That's because fetch
doesn't go through git-submodule at all; it calls "git fetch" itself,
and uses local_repo_env, which clears the config. It needs to learn to
use the same mechanism that sanitize_submodule_env() does.

So AFAICT 14111fc49 is totally broken. It doesn't actually work for
git-submodule (because of the missing export), nor for git-fetch
(because that skips the shell script), and the one case we are testing
already worked without it (but probably _should_ be sanitizing the
config, so is buggy, too).

-Peff
