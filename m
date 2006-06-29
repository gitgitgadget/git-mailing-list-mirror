From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] Cache negative delta pairs
Date: Thu, 29 Jun 2006 14:04:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606291352110.12404@g5.osdl.org>
References: <20060628223744.GA24421@coredump.intra.peff.net>
 <7v4py4y7wo.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606291053280.1213@localhost.localdomain>
 <20060629180011.GA4392@coredump.intra.peff.net>
 <Pine.LNX.4.64.0606291410420.1213@localhost.localdomain>
 <20060629185335.GA6704@coredump.intra.peff.net>
 <Pine.LNX.4.64.0606291458110.1213@localhost.localdomain>
 <20060629195201.GA10786@coredump.intra.peff.net>
 <Pine.LNX.4.64.0606291616480.1213@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 29 23:04:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw3gb-0002yp-A0
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 23:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932637AbWF2VE0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 17:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932633AbWF2VEZ
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 17:04:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11173 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932637AbWF2VEY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 17:04:24 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5TL42nW023944
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 29 Jun 2006 14:04:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5TL41KY009592;
	Thu, 29 Jun 2006 14:04:02 -0700
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0606291616480.1213@localhost.localdomain>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22905>


On Thu, 29 Jun 2006, Nicolas Pitre wrote:
> 
> The negative delta cache concept is certainly attractive even for normal 
> repositories, especially for public servers, since when used in 
> conjonction with delta reuse it makes the creation of a pack basically 
> free.  So I think this idea really has merits, as long as the cache 
> remains small.

I don't really see much of a point of this all.

Instead of having a separate cache, wouldn't it be much better to just 
take the hint from the previous pack-file?

In the repacking window, if both objects we are looking at already came 
from the same (old) pack-file, don't bother delta'ing them against each 
other. 

That means that we'll still always check for better deltas for (and 
against!) _unpacked_ objects, but assuming incremental repacks, you'll 
avoid the delta creation 99% of the time.

Ie somethng really simple like the appended.

		Linus
---
diff --git a/pack-objects.c b/pack-objects.c
index bed2497..cea63e7 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -988,6 +988,13 @@ static int try_delta(struct unpacked *tr
 		return -1;
 
 	/*
+	 * We do not bother to try a delta that we discarded
+	 * on an earlier try
+	 */
+	if (trg_entry->in_pack && trg_entry->in_pack == src_entry->in_pack)
+		return -1;
+
+	/*
 	 * If the current object is at pack edge, take the depth the
 	 * objects that depend on the current object into account --
 	 * otherwise they would become too deep.
