From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv5 0/2] Implement the GIT_TRACE_CURL environment variable
Date: Mon, 2 May 2016 14:13:47 -0400
Message-ID: <20160502181347.GB8439@sigill.intra.peff.net>
References: <20160502142813.50868-1-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, tboegi@web.de, ramsay@ramsayjones.plus.com,
	gitster@pobox.com, sunshine@sunshineco.com
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 02 20:13:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axILy-0006zK-TV
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 20:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754776AbcEBSNv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 14:13:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:60444 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754767AbcEBSNu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 14:13:50 -0400
Received: (qmail 7346 invoked by uid 102); 2 May 2016 18:13:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 May 2016 14:13:49 -0400
Received: (qmail 17076 invoked by uid 107); 2 May 2016 18:14:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 May 2016 14:14:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 May 2016 14:13:47 -0400
Content-Disposition: inline
In-Reply-To: <20160502142813.50868-1-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293258>

On Mon, May 02, 2016 at 02:28:11PM +0000, Elia Pinto wrote:

> -  redo the authorization header skip with a replace of possible sensitive data. 
>    We prefer to print only:
>        09:00:53.238330 http.c:534              => Send header: Authorization:  <redacted>
>    intested of 
>        09:00:53.238330 http.c:534              => Send header: Authorization:  Basic(o other scheme) <redacted>
>    as it was done in the original proposed suggestion by Jeff King. 
>    This is because i think it's better not to print even the authorization scheme.

I'm not sure I agree. If you're debugging curl's auth selection, that's
omitting an important piece of data. And unlike the actual credential, I
don't think it's particularly secret (and in many cases can be deduced
from the "WWW-Authenticate" header the server sends, coupled with curl's
code).

>    We add also the (previously missing) proxy-authorization case

Good catch.

> In this series i keep the original curl_dump parsing code, even though it is 
> objectively difficult to read. This is because the same code is used internally by curl 
> to do "ascii-trace" and is also reported in the libcurl code examples and test. 
> I think this may make maintenance of code easier in the future (libcurl 
> new dev, new features and so on) 

I don't agree with this line of reasoning. The code in question is
purely about how we format the output buffer, not about parsing what
curl gives us. We _should_ be diverging if we prefer a different output
format. And I don't think it's a question just of readability (though I
do agree the existing one is hard to read); it also foils the redaction
of the authorization header.

-Peff
