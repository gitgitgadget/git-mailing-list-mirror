From: Jeff King <peff@peff.net>
Subject: Re: Fix up ugly open-coded "alloc_nr()" user in object.c
Date: Sat, 16 Jun 2007 14:21:34 -0400
Message-ID: <20070616182134.GA22003@coredump.intra.peff.net>
References: <alpine.LFD.0.98.0706161024220.14121@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jun 16 20:21:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hzcu2-00028P-H7
	for gcvg-git@gmane.org; Sat, 16 Jun 2007 20:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752792AbXFPSVh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 14:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752813AbXFPSVh
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 14:21:37 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2007 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750996AbXFPSVg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 14:21:36 -0400
Received: (qmail 31792 invoked from network); 16 Jun 2007 18:21:50 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 16 Jun 2007 18:21:50 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 16 Jun 2007 14:21:34 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0706161024220.14121@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50292>

On Sat, Jun 16, 2007 at 10:30:22AM -0700, Linus Torvalds wrote:

> When adding objects to the object/mode array, we used to have our own 
> alloc_nr() implementation, rather than use the normal one.
> 
> And since the normal one is arguably a bit nicer (still grows the 
> allocation exponentially, just not by more-than-doubling it every time), 
> why not just use it?

How about using the new ALLOC_GROW macro to make it even shorter? I also
got rid of the aliased variables, which IMO just make it harder to see
what's going on.

---
 object.c |   19 +++++--------------
 1 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/object.c b/object.c
index 16793d9..064e423 100644
--- a/object.c
+++ b/object.c
@@ -240,18 +240,9 @@ void add_object_array(struct object *obj, const char *name, struct object_array
 
 void add_object_array_with_mode(struct object *obj, const char *name, struct object_array *array, unsigned mode)
 {
-	unsigned nr = array->nr;
-	unsigned alloc = array->alloc;
-	struct object_array_entry *objects = array->objects;
-
-	if (nr >= alloc) {
-		alloc = (alloc + 32) * 2;
-		objects = xrealloc(objects, alloc * sizeof(*objects));
-		array->alloc = alloc;
-		array->objects = objects;
-	}
-	objects[nr].item = obj;
-	objects[nr].name = name;
-	objects[nr].mode = mode;
-	array->nr = ++nr;
+	ALLOC_GROW(array->objects, array->nr, array->alloc);
+	array->objects[array->nr].item = obj;
+	array->objects[array->nr].name = name;
+	array->objects[array->nr].mode = mode;
+	array->nr++;
 }
