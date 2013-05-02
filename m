From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] lookup_object: prioritize recently found objects
Date: Thu, 2 May 2013 11:50:37 -0400
Message-ID: <20130502155037.GB18462@sigill.intra.peff.net>
References: <20130501203449.GA12535@sigill.intra.peff.net>
 <51820B37.8010503@viscovery.net>
 <20130502064630.GA15208@sigill.intra.peff.net>
 <5182101D.4050807@viscovery.net>
 <7vzjwd1j27.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 02 17:50:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXvmO-0006AU-3t
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 17:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760103Ab3EBPuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 11:50:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:58281 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759734Ab3EBPuj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 11:50:39 -0400
Received: (qmail 28277 invoked by uid 102); 2 May 2013 15:50:56 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 02 May 2013 10:50:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 May 2013 11:50:37 -0400
Content-Disposition: inline
In-Reply-To: <7vzjwd1j27.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223217>

On Thu, May 02, 2013 at 08:46:08AM -0700, Junio C Hamano wrote:

> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
> > BTW, do you notice that the function is now modifying an object (the hash
> > table) even though this is rather unexpected from a "lookup" function?
> 
> At the philosophical level, "lookup" ought to be operating on a
> "const" table.  But at the implementation level, the table does not
> have to be "const" in the sense the implemenation language and data
> structure defines.
> 
> I think this patch is a good example of that.

Very much agreed.

> I am kind of surprised that Jeff's attempt to do a full LRU made
> things worse, though.  The only additional code compared to swap is
> a single memmove(): are we colliding too often (having to move a
> lot)?

I actually didn't use memmove, but a hand-rolled loop. I wonder if that
would have made the difference. It's a little tricky because you may
have to cross the mod(obj_hash_size) wrap-around. The patch I tested
was:

diff --git a/object.c b/object.c
index 1ba2083..8b2412c 100644
--- a/object.c
+++ b/object.c
@@ -85,10 +85,13 @@ struct object *lookup_object(const unsigned char *sha1)
 		if (i == obj_hash_size)
 			i = 0;
 	}
-	if (obj && i != first) {
-		struct object *tmp = obj_hash[i];
-		obj_hash[i] = obj_hash[first];
-		obj_hash[first] = tmp;
+	if (obj) {
+		while (i != first) {
+			int prev = i ? i - 1 : obj_hash_size - 1;
+			obj_hash[i] = obj_hash[prev];
+			i = prev;
+		}
+		obj_hash[i] = obj;
 	}
 	return obj;
 }

-Peff
