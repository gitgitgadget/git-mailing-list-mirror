From: Jeff King <peff@peff.net>
Subject: Re: GIT, libcurl and GSS-Negotiate
Date: Mon, 12 May 2014 16:21:53 -0400
Message-ID: <20140512202153.GB2329@sigill.intra.peff.net>
References: <CAPc4eF__gWMy=E-8tdpMn_irA4m7mYF3=cwN6JeAqJsdPshNLw@mail.gmail.com>
 <20140426174718.GC238861@vauxhall.crustytoothpaste.net>
 <CAPc4eF-aT47aEPmmPPkPRfntTNdNp=c4+OK_CPdq_7YB6rxDug@mail.gmail.com>
 <20140510210132.GD45511@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ivo Bellin Salarin <ivo.bellinsalarin@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 12 22:22:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjwjX-0004BA-57
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 22:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754577AbaELUVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2014 16:21:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:50164 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752384AbaELUVz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2014 16:21:55 -0400
Received: (qmail 22732 invoked by uid 102); 12 May 2014 20:21:54 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 May 2014 15:21:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 May 2014 16:21:53 -0400
Content-Disposition: inline
In-Reply-To: <20140510210132.GD45511@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248729>

On Sat, May 10, 2014 at 09:01:32PM +0000, brian m. carlson wrote:

> What it looks like is happening is that git is offering Negotiate data,
> and then your server is responding with a 401 Unauthorized.  libgit2
> (presumably using WinHTTP) continues in this case, retrying with a
> longer set of credential containing more data, but git gives up.
> 
> Both responses comply with RFC 2616, by my reading.  I guess there are a
> couple of choices here:
> 
> * Make your web server happy with the data that it gets passed
>   initially.
> * Make git understand that it really needs to try again with different
>   credentials in this case (how to do that is unknown).

It should be pretty straightforward to loop again; http_request_reauth
just needs to turn into a for-loop on getting HTTP_REAUTH, rather than a
static two-tries (I even had a patch for this a while ago, but the
function has changed a bit in the interim).

The tricky part is figuring out when to return HTTP_NOAUTH ("do not try
again, we failed") versus HTTP_REAUTH ("get credentials and try again")
in handle_curl_result. Right now the decision is based on "did we have a
username and password for this request?" I'm not clear on what extra
bits would be needed to decide to continue in the case you guys are
discussing.

> * Provide some way of forcing git to use a particular authentication
>   protocol.

Yeah, we just set CURLAUTH_ANY now, but it would be fairly trivial to
add "http.authtype" and "http.proxyauthtype" to map to CURLOPT_HTTPAUTH
and CURLOPT_PROXYAUTH.

-Peff
