From: Jeff King <peff@peff.net>
Subject: Re: Why is my git-http-backend solution using WebDAV on push?
Date: Wed, 25 May 2016 16:38:50 -0500
Message-ID: <20160525213850.GB13776@sigill.intra.peff.net>
References: <CABwKKP958cW3a5Cjxox+1FCtNLetdufJj0rrYBouAUhJSXKKWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Luke Madhanga <lmadhanga@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 25 23:38:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5gW1-0001k7-L2
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 23:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752298AbcEYVix (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 17:38:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:44229 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750738AbcEYVix (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 17:38:53 -0400
Received: (qmail 20083 invoked by uid 102); 25 May 2016 21:38:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 May 2016 17:38:52 -0400
Received: (qmail 13973 invoked by uid 107); 25 May 2016 21:38:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 May 2016 17:38:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 May 2016 16:38:50 -0500
Content-Disposition: inline
In-Reply-To: <CABwKKP958cW3a5Cjxox+1FCtNLetdufJj0rrYBouAUhJSXKKWA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295590>

On Wed, May 25, 2016 at 09:28:21PM +0100, Luke Madhanga wrote:

> I've implemented a PHP wrapper for git http backend which works well.
> I've done this to give me advanced control of who has access to
> repositories on my server. You can see the implementation on
> http://stackoverflow.com/questions/36998492/channel-git-on-the-server-calls-through-php/37242591#37242591.
> I can pull from the server okay and all works well. However, I cannot
> push. When I read my trace code to see where it fails, I see that the
> last request is a PROPFIND request. The URL for this request does not
> have any of the usual 'info/refs' etc. that one usually gets on git
> calls.

If the git client detects that the server doesn't implement the
smart-http protocol, it will automatically downgrade to the older,
"dumb" protocol which is less efficient.

For fetching/cloning, this might make your test appear to work, even
though it is downgrading behind the scenes. You should be able to check
GIT_CURL_VERBOSE output to tell the difference; the smart protocol will
POST to .../git-upload-pack, whereas the dumb protocol will download the
individual packfiles and objects directly.

For pushing, the dumb protocol uses WebDAV, which is what you're seeing.

So the question is: why doesn't the client think your server is a smart
server?

Just skimming your output, I'd guess:

> > GET /p/git-backend/run/1/info/refs?service=git-receive-pack HTTP/1.1
> Host: xxx
> User-Agent: git/2.7.4
> Accept: */*
> Accept-Encoding: gzip
> Accept-Language: en-GB, en;q=0.9, *;q=0.8
> Pragma: no-cache
> 
> < HTTP/1.1 200 OK
> < Date: Wed, 25 May 2016 19:00:25 GMT
> < Server: Apache/2.4.18 (Ubuntu)
> < Set-Cookie: PHPSESSID=yyy; path=/
> < Expires: Fri, 01 Jan 1980 00:00:00 GMT
> < Cache-Control: no-cache, max-age=0, must-revalidate
> < Pragma: no-cache
> < Vary: Accept-Encoding
> < Content-Encoding: gzip
> < Content-Length: 109
> < Content-Type: text/plain;charset=UTF-8
> <

The content-type here should be:

  application/x-git-receive-pack-advertisement

The body content should also include "# service=git-receive-pack" on the
first line, but if you are successfully calling into git-http-backend, I
think it should take care of that detail.

-Peff
