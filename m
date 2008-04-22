From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Don't force imap.host to be set when imap.tunnel is set
Date: Tue, 22 Apr 2008 06:41:47 -0400
Message-ID: <20080422104146.GA11198@sigill.intra.peff.net>
References: <200804211459.07527.andyparkins@gmail.com> <7vbq424c8f.fsf@gitster.siamese.dyndns.org> <fuka50$pce$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 12:42:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoFxP-0000f0-FD
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 12:42:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754794AbYDVKlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 06:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754783AbYDVKlx
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 06:41:53 -0400
Received: from peff.net ([208.65.91.99]:2808 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754690AbYDVKlw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 06:41:52 -0400
Received: (qmail 10405 invoked by uid 111); 22 Apr 2008 10:41:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 22 Apr 2008 06:41:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Apr 2008 06:41:47 -0400
Content-Disposition: inline
In-Reply-To: <fuka50$pce$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80097>

On Tue, Apr 22, 2008 at 10:11:59AM +0100, Andy Parkins wrote:

> I'm sure you are correct, but as I say - it's not guaranteed.  Since
> git-imap-send can't know what this particular tunnel requires it shouldn't
> force the creation of a dummy option.  If the tunnel does require a
> hostname then there is a place to put it, and the person writing the tunnel
> line can decide that.

I think Junio's point is that it's easy to start dereferencing NULL,
because later parts of the code assume that "host" is always set, even
if only to use it for informational purposes. So those callsites either
need to be fixed to handle a NULL host, or perhaps something like this
instead (totally untested):

diff --git a/imap-send.c b/imap-send.c
index 04afbc4..db65597 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1303,8 +1303,11 @@ main(int argc, char **argv)
 		return 1;
 	}
 	if (!server.host) {
-		fprintf( stderr, "no imap host specified\n" );
-		return 1;
+		if (!server.tunnel) {
+			fprintf( stderr, "no imap host specified\n" );
+			return 1;
+		}
+		server.host = "tunnel";
 	}
 
 	/* read the messages */

-Peff
