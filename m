From: Jan Engelhardt <jengelh@medozas.de>
Subject: Re: [2/3] git-daemon: use getnameinfo to resolve hostname
Date: Wed, 14 Jan 2009 20:25:28 +0100 (CET)
Message-ID: <alpine.LSU.2.00.0901142014380.24672@fbirervta.pbzchgretzou.qr>
References: <alpine.LSU.2.00.0901141147120.16109@fbirervta.pbzchgretzou.qr> <alpine.LSU.2.00.0901141148130.16109@fbirervta.pbzchgretzou.qr> <20090114122536.GA5939@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 14 20:26:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNBOB-0007dQ-TC
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 20:26:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754826AbZANTZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 14:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754649AbZANTZb
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 14:25:31 -0500
Received: from sovereign.computergmbh.de ([85.214.69.204]:34989 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754530AbZANTZb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 14:25:31 -0500
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 0CE671812FE75; Wed, 14 Jan 2009 20:25:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 06C9C1D17C7A7;
	Wed, 14 Jan 2009 20:25:29 +0100 (CET)
In-Reply-To: <20090114122536.GA5939@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105684>


On Wednesday 2009-01-14 13:25, Jeff King wrote:
>On Wed, Jan 14, 2009 at 11:48:38AM +0100, Jan Engelhardt wrote:
>
>> This is much shorter than inet_ntop'ing, and also translated
>> unresolvable addresses into a string.
>
>Er, doesn't this totally change the meaning of REMOTE_ADDR from an IP
>address to a hostname? That seems bad because:
>[...]
>  - people already have hooks that compare REMOTE_ADDR against an
>    address, so we are breaking their hooks
>[...]
>So at the very least, you should be adding REMOTE_HOST in _addition_ to
>REMOTE_ADDR, not instead of.

Good catch. It's always good to have someone else look through it.
Changed, and below is the proposition as a non-mergable diff.

In case getnameinfo fails, the IP address from inet_ntop
should be left in addrbuf, is not it?

And yeah, it does not have a flag to disable DNS resolution, but
it's a draft for now.

---8<---
git-daemon: resolve source host's DNS

Try to resolve DNS addresses so that run_service() can print the
name of the host from which the request originated.
[addrbuf is passed to run_service as a result of patch 1/3]

---
 daemon.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: git-1.6.1/daemon.c
===================================================================
--- git-1.6.1.orig/daemon.c
+++ git-1.6.1/daemon.c
@@ -530,6 +530,10 @@ static int execute(struct sockaddr *addr
 #endif
 		}
 		setenv("REMOTE_ADDR", addrbuf, 1);
+		getnameinfo(addr, (addr->sa_family == AF_INET6) ?
+			sizeof(struct sockaddr_in6) :
+			sizeof(struct sockaddr_in),
+			addrbuf, sizeof(addrbuf), NULL, 0, 0);
 	}
 	else {
 		unsetenv("REMOTE_ADDR");
