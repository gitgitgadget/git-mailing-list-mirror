From: Jeff King <peff@peff.net>
Subject: Re: contrib/credential/osxkeychain: Makefile should allow to set
 CFLAGS
Date: Wed, 23 May 2012 13:36:53 -0400
Message-ID: <20120523173653.GA29458@sigill.intra.peff.net>
References: <AB628C35-FEC2-4425-B3D8-EEC7F8D6A66B@samueljohn.de>
 <7vtxz82ap6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Samuel John <mail@samueljohn.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 23 19:37:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXFUc-00025S-Fh
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 19:37:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533Ab2EWRg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 13:36:57 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52929
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752872Ab2EWRg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 13:36:56 -0400
Received: (qmail 18732 invoked by uid 107); 23 May 2012 17:37:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 May 2012 13:37:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 May 2012 13:36:53 -0400
Content-Disposition: inline
In-Reply-To: <7vtxz82ap6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198315>

On Tue, May 22, 2012 at 02:00:05PM -0700, Junio C Hamano wrote:

> It however seems to me that git-credential-osxkeychain.o does honor
> $(CFLAGS), either from the user "make CFLAGS=..." or the default the
> Makefile in question supplies.
> 
> The line you quoted is not using $(CC) as the compiler, but is using it to
> link the final build product.  It may not hurt to have $(CFLAGS) on that
> line, but shouldn't the line also have $(LDFLAGS) on it?

I think so. Why don't we do this?

-- >8 --
Subject: osxkeychain: pull make config from top-level directory

The default compiler and cflags were mostly "works for me"
when I built the original version. We need to be much less
careful here than usual, because we know we are building
only on OS X.  But it's only polite to at least respect the
CFLAGS and CC definitions that the user may have provided
earlier.

While we're at it, let's update our definitions and rules to
be more like the top-level Makefile; default our CFLAGS to
include -O2, and make sure we use CFLAGS and LDFLAGS when
linking.

Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/credential/osxkeychain/Makefile | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/contrib/credential/osxkeychain/Makefile b/contrib/credential/osxkeychain/Makefile
index 75c07f8..4b3a08a 100644
--- a/contrib/credential/osxkeychain/Makefile
+++ b/contrib/credential/osxkeychain/Makefile
@@ -2,10 +2,13 @@ all:: git-credential-osxkeychain
 
 CC = gcc
 RM = rm -f
-CFLAGS = -g -Wall
+CFLAGS = -g -O2 -Wall
+
+-include ../../../config.mak.autogen
+-include ../../../config.mak
 
 git-credential-osxkeychain: git-credential-osxkeychain.o
-	$(CC) -o $@ $< -Wl,-framework -Wl,Security
+	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS) -Wl,-framework -Wl,Security
 
 git-credential-osxkeychain.o: git-credential-osxkeychain.c
 	$(CC) -c $(CFLAGS) $<
-- 
1.7.9.7.35.gbeaaf11
