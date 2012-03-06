From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/4] http: handle proxy proactive authentication
Date: Tue, 6 Mar 2012 05:53:39 -0500
Message-ID: <20120306105339.GA5013@sigill.intra.peff.net>
References: <4F54D98C.2070909@seap.minhap.es>
 <20120306083052.GD21199@sigill.intra.peff.net>
 <4F55EDF3.2030201@seap.minhap.es>
 <20120306100947.GA710@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, sam@vilain.net
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Tue Mar 06 11:53:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4s1b-0005sQ-TD
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 11:53:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758162Ab2CFKxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 05:53:42 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42008
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754964Ab2CFKxl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 05:53:41 -0500
Received: (qmail 7742 invoked by uid 107); 6 Mar 2012 10:53:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 06 Mar 2012 05:53:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Mar 2012 05:53:39 -0500
Content-Disposition: inline
In-Reply-To: <20120306100947.GA710@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192330>

On Tue, Mar 06, 2012 at 05:09:47AM -0500, Jeff King wrote:

> > Ok, will remove it, I copy/paste it from the http code and I must admit
> > I didn't understand why this was needed.
> 
> Ah.  I grepped for the spot you copied. The cast is to get rid of the
> "const" on curl_http_proxy. But if it's a pointer to allocated memory,
> it should not be declared const in the first place. Unfortunately,
> fixing this means casting in the call to git_config_string (which for
> some reason takes a pointer-to-const-pointer, even though the value it
> puts in will always be allocated by xstrdup). Or fixing
> git_config_string, but that cascades to require fixing in lots of other
> places. Ugh.

I did a little more looking into this. The situation is annoyingly
complex, because some callers really do have const strings. They do
things like this:

  static const char *prune_expire = "2.weeks.ago";
  [...]
  git_config_string(&prune_expire, var, value);

And that one should be const, because the string literal really is
const. Sometimes it is converted into an allocated value, but we
effectively treat it as const.

And then you have things like curl_http_proxy, which are never actually
const, but always allocated strings (that get freed during cleanup).
Those ones should probably not be const.

So I don't think there's an easy solution, and the least evil thing is
probably to just keep the cast on free, as you did (although I think if
you convert to using CURLOPT_PROXYUSERPWD, you won't be rewriting
curl_http_proxy anymore, and thus your free() call will go away).

-Peff
