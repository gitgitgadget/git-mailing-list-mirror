From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] http: when proxy url has username but no
 password, ask for password
Date: Fri, 2 Mar 2012 07:45:39 -0500
Message-ID: <20120302124538.GA10637@sigill.intra.peff.net>
References: <4F4FBE6C.5050507@seap.minhap.es>
 <4F4FB69C.7000708@vilain.net>
 <20120301215812.GG17631@sigill.intra.peff.net>
 <4F50CC41.5020307@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Fri Mar 02 13:45:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3Rry-00075d-8e
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 13:45:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210Ab2CBMpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 07:45:51 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35355
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758012Ab2CBMpl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 07:45:41 -0500
Received: (qmail 21924 invoked by uid 107); 2 Mar 2012 12:45:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 Mar 2012 07:45:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Mar 2012 07:45:39 -0500
Content-Disposition: inline
In-Reply-To: <4F50CC41.5020307@seap.minhap.es>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192035>

On Fri, Mar 02, 2012 at 02:33:53PM +0100, Nelson Benitez Leon wrote:

> > So there's the history lesson. What should proxy auth do?
> > 
> >   1. Definitely respond to HTTP 407 by prompting on the fly; this code
> >      should go along-side the HTTP 401 code in http.c.
> > 
> >   2. Definitely do the pre-prompt thing when http_proactive_auth is set
> >      (which is used only by http-push). Unless somebody really feels
> >      like re-writing http-push to handle retries for authentication.
> > 
> >   3. Consider doing the pre-prompt thing when http_proactive_auth is not
> >      set. This can save a round-trip, but we should not do it if there
> >      is a good reason not to. The two possible reasons I can think of
> >      are:
> > 
> >        a. Like http auth, if curl will read the proxy credentials from
> >           .netrc, then we should not do it for the same reasons
> >           mentioned in 986bbc0.
> > 
> >        b. If people realistically have proxy URLs with usernames but do
> >           _not_ want to ask for a password, then the prompt will be
> >           annoying. I'm not sure that anybody expects that.
> 
> So, trying to sum up, I will try to redo patch-set as follows:
> - Ignore PATCH 2/3 , that is, we won't read any env var.
> - Let cURL try to connect and if that fails with 407 , then do a credential_fill
> and try to reconnect.
> 
> Is that ok? or do I need to do something more?

I think you'll still need to read the env var, because you'll need to
know the proxy URL when getting the password (to ask credential helpers
properly, and to prompt the user).

Also, I think you'll need to call credential_fill() when
http_proactive_auth is set. Otherwise http-push will not be able to do
proxy auth.

-Peff
