From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] http.c: Add config options/parsing for SSL engine vars
Date: Tue, 30 Apr 2013 16:22:42 -0400
Message-ID: <20130430202242.GA3247@sigill.intra.peff.net>
References: <1366758207-7724-1-git-send-email-jqassar@gmail.com>
 <7v61z4ezlz.fsf@alter.siamese.dyndns.org>
 <20130430182732.GB1972@sigill.intra.peff.net>
 <CAJC3a=pU2m8LpUh0u0XXXgOiDiPo-QAdA471orGs9jcyDJTU5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jerry Qassar <jqassar@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 22:22:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXH4c-0003Od-PG
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 22:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933255Ab3D3UWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 16:22:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:41035 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760097Ab3D3UWp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 16:22:45 -0400
Received: (qmail 23993 invoked by uid 102); 30 Apr 2013 20:22:59 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 30 Apr 2013 15:22:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Apr 2013 16:22:42 -0400
Content-Disposition: inline
In-Reply-To: <CAJC3a=pU2m8LpUh0u0XXXgOiDiPo-QAdA471orGs9jcyDJTU5g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223005>

On Tue, Apr 30, 2013 at 01:04:17PM -0700, Jerry Qassar wrote:

> First, thanks very much for taking a look at this.  I wasn't 100% certain about
> the versioning to use for it (specifically the version-to-0x mapping), so any
> input on that would be a big help.  I'll try to answer your questions below...

The explanation is hiding in a comment in curlver.h:

  This is the numeric version of the libcurl version number, meant for
  easier parsing and comparions by programs. The LIBCURL_VERSION_NUM
  define will always follow this syntax:

         0xXXYYZZ

  Where XX, YY and ZZ are the main version, release and patch numbers in
  hexadecimal (using 8 bits each). All three numbers are always
  represented using two digits.  1.2 would appear as "0x010200" while
  version 9.11.7 appears as "0x090b07".

So I think you'd just want to check:

  #if LIBCURL_VERSION_NUM >= 0x070903

It looks like we already have such an #if block for ssl_key, so you
could just add the new options there.

> > Current curl seems to take ENG only for the key, and assumes you have
> > the certificate on disk [...]
> [...]
> Curl already does support engine-based certificates (in code and
> help).

My "seems to..." above was based on reading the curl_easy_setopt
manpage. It sounds like that documentation may be out of date.

> I can't think of a way to reliably provide a hardware-dependent engine
> implementation to the suite.  So ENG is probably out, but I can think
> of something to verify PEM and DER once I figure out how the test
> suite works.

I think the trickiest part for testing PEM/DER support will actually be
setting up the apache config to authenticate a user based on a client
side certificate. I was hoping you might know off-hand since that is
obviously the goal of your patch (though of course you might not be
using apache). The relevant config would be in t/lib-httpd/apache.conf,
and the tests could probably go into t/t5551-http-fetch.sh.

> > Shouldn't we be checking the result of curl_easy_setopt for errors here
> > (and when the engine cannot be loaded)?  I think we should probably die
> > if the engine can't be loaded, but at the very least we'd want to warn
> > the user that their settings are being ignored.
> 
> Errors are handled by curl (up to this point):
> 
> 1) Setting the cert type to FOO:
> error: not supported file type 'FOO' for certificate...
> fatal: HTTP request failed
> 
> 2) Setting the key type to FOO:
> error: not supported file type for private key...
> fatal: HTTP request failed
> 
> 3) Setting engine type to something invalid:
>  * SSL Engine 'pkcsfoo' not found (only with GIT_CURL_VERBOSE set)
> error: crypto engine not set, can't load certificate...
> fatal: HTTP request failed
> 
> ...that last one could probably be a little better, but it's curl-managed.

Hmm. So all of that happens when we actually try to make the request. I
think that should be OK. Curl is presumably smart enough to fail early
in the *_perform() functions, when it notices the handle is in a bogus
state.

> Thanks very much for the constructive input.  Once I make the
> corrections and determine how to make some appropriate tests I'll
> resubmit.  I guess my open question is, if you wish to wrap the prop
> setting in a curl version #if, what version is desired?

>From my reading of the curl docs, it's 7.9.3.

-Peff
