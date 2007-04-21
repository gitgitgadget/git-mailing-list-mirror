From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFH] WTF did we change in git-fsck recently?
Date: Fri, 20 Apr 2007 18:30:06 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704201826350.9964@woody.linux-foundation.org>
References: <7vps5ywouw.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.98.0704201823310.9964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Apr 21 03:30:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hf4R7-0001G8-SU
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 03:30:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754034AbXDUBaa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 21:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754035AbXDUBaa
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 21:30:30 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:60283 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754034AbXDUBaa (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Apr 2007 21:30:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l3L1U7d6021114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 20 Apr 2007 18:30:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3L1U6dA028345;
	Fri, 20 Apr 2007 18:30:06 -0700
In-Reply-To: <alpine.LFD.0.98.0704201823310.9964@woody.linux-foundation.org>
X-Spam-Status: No, hits=-3.544 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45145>



On Fri, 20 Apr 2007, Linus Torvalds wrote:
> 
> Hmm. Probably something broken in my "object decorator" thing then. 

Duh.

When I did the object decorator thing, I made the "loop over the hash" 
function use the same logic for updating the hash, ie made them use

	if (++j >= size)
		j = 0;

for both the hash update for both "insert" and "lookup"

HOWEVER.

For some inexplicable reason I had an extraneous

	j++;

in the insert path (probably just from the fact that the old code there 
used 

	j++;
	if (j >= size)
		j = 0;

and when I made them use the same logic I just didn't remove the old 
extraneous line properly.

This fixes it.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 decorate.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/decorate.c b/decorate.c
index 396b413..23f6b00 100644
--- a/decorate.c
+++ b/decorate.c
@@ -24,7 +24,6 @@ static void *insert_decoration(struct decoration *n, struct object *base, void *
 			hash[j].decoration = decoration;
 			return old;
 		}
-		j++;
 		if (++j >= size)
 			j = 0;
 	}
