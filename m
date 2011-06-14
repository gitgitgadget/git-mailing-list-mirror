From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] config.c: Make git_config() work correctly when
 called recursively
Date: Tue, 14 Jun 2011 14:27:26 -0400
Message-ID: <20110614182726.GA451@sigill.intra.peff.net>
References: <4DF106B8.2080902@ramsay1.demon.co.uk>
 <20110609203958.GA4671@sigill.intra.peff.net>
 <4DF7A627.2080600@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, johan@herland.net
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Jun 14 20:27:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWYKr-0003mZ-Vi
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 20:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321Ab1FNS13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 14:27:29 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39962
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751553Ab1FNS12 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 14:27:28 -0400
Received: (qmail 29302 invoked by uid 107); 14 Jun 2011 18:27:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 14 Jun 2011 14:27:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Jun 2011 14:27:26 -0400
Content-Disposition: inline
In-Reply-To: <4DF7A627.2080600@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175787>

On Tue, Jun 14, 2011 at 07:19:19PM +0100, Ramsay Jones wrote:

> > Since you've nicely encapsulated all of the global data in this struct,
> > maybe it is worth simply passing a struct pointer down the call-chain
> > instead of relying on a global pointer. Then you can let the language do
> > its job and stop managing the stack yourself.
> 
> The first version of this patch did exactly that! However, that first patch
> failed the test-suite. :(
> 
> The failure was caused by a change to the die_bad_config() function, which
> in the current patch looks like this:
> 
>     @@ -374,8 +381,8 @@ int git_parse_ulong(const char *value, unsigned long *ret)
>  
>      static void die_bad_config(const char *name)
>      {
>     -	if (config_file_name)
>     -		die("bad config value for '%s' in %s", name, config_file_name);
>     +	if (cf && cf->name)
>     +		die("bad config value for '%s' in %s", name, cf->name);
>      	die("bad config value for '%s'", name);
>      }

Ah, right. We want to keep it as globals, because we end up in a
callback which does not get the context passed to it.

> In order not to change the public interface (note that git_config_int() and
> git_config_ulong() call die_bad_config()), I had to change this function so
> that it only contains the final die() call. Thus, the error message no longer
> included the config filename. This caused the test called 'invalid unit' in
> t1300-repo-config.sh to fail.
> 
> I could, of course, have simply changed the expect file so that it would pass
> the test, but I wanted the change to be self-contained and to pass all existing
> tests (ie. the external interface/behaviour should *not* change).

No, you did the right thing here. The information on which config file
we're in is valuable, and taking away the globals is not worth the pain
of making all of the callers and callbacks of git_config have to deal
with passing around a context struct.

So the patch you posted looks good to me.

-Peff
