From: Jeff King <peff@peff.net>
Subject: Re: Is there a reason the credential cache server cowardly refuses
 to delete/reuse the socket file?
Date: Tue, 17 Jun 2014 05:45:16 -0400
Message-ID: <20140617094516.GB6267@sigill.intra.peff.net>
References: <1EFC4B213D584B1EBAE78E6882705B6D@black>
 <20140615140800.GA6216@sigill.intra.peff.net>
 <7EDCFBB4F08F4A0EBB5D19A481BF7D5A@black>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jason Pyeron <jpyeron@pdinc.us>
X-From: git-owner@vger.kernel.org Tue Jun 17 11:45:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwpxE-0008Ty-1l
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 11:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521AbaFQJpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 05:45:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:45923 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752206AbaFQJpT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 05:45:19 -0400
Received: (qmail 23485 invoked by uid 102); 17 Jun 2014 09:45:19 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 17 Jun 2014 04:45:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jun 2014 05:45:16 -0400
Content-Disposition: inline
In-Reply-To: <7EDCFBB4F08F4A0EBB5D19A481BF7D5A@black>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251859>

On Sun, Jun 15, 2014 at 10:52:09AM -0400, Jason Pyeron wrote:

> > Could this be a cygwin weirdness? I'd be interested to see the output
> > of:
> > 
> >   echo url=https://example.com |
> 
> >   strace -f git credential-cache get
> 
> On cygwin things can git a bit weird, I changed it to the actual executable.

Ugh, I forgot how difficult cygwin strace is to read. I think the
interesting bit is here:

> 1053395 1084132 [main] git-credential-cache 4308 __set_errno: void
> __set_winsock_errno(const char*, int):230 setting errno 0
>    88 1084220 [main] git-credential-cache 4308 __set_winsock_errno: connect:1118
> - winsock error 0 -> errno 0
>    46 1084266 [main] git-credential-cache 4308 getpid: 4308 = getpid()
>    37 1084303 [main] git-credential-cache 4308 cygwin_connect: -1 = connect(3,
> 0x22A5A2, 110), errno 0

So yeah, it looks like errno does not get set properly in this case. I
think the only thing to do is just loosen the error path, like:

diff --git a/credential-cache.c b/credential-cache.c
index 9a03792..d0a1106 100644
--- a/credential-cache.c
+++ b/credential-cache.c
@@ -72,8 +72,6 @@ static void do_cache(const char *socket, const char *action, int timeout,
 	}
 
 	if (send_request(socket, &buf) < 0) {
-		if (errno != ENOENT && errno != ECONNREFUSED)
-			die_errno("unable to connect to cache daemon");
 		if (flags & FLAG_SPAWN) {
 			spawn_daemon(socket);
 			if (send_request(socket, &buf) < 0)

I'd rather not do that on all platforms, though (I guess we could also
check explicitly for "errno == 0", but I have a feeling that many errors
may return errno==0 on your platform).

Can you confirm that works? I suppose we can wrap it in an #ifdef.

-Peff
