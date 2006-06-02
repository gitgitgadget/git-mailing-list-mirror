From: Jeff King <peff@peff.net>
Subject: [PATCH] sha1_file: avoid re-preparing duplicate packs
Date: Fri, 2 Jun 2006 12:49:32 -0400
Message-ID: <20060602164932.GA10216@coredump.intra.peff.net>
References: <20060602153223.GA4223@coredump.intra.peff.net> <7vwtbzblkf.fsf@assigned-by-dhcp.cox.net> <20060602160456.GA8957@coredump.intra.peff.net> <7vk67zbksv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 02 18:49:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmCqA-0001af-L8
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 18:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbWFBQtg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Jun 2006 12:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbWFBQtf
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jun 2006 12:49:35 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:22436 "HELO
	peff.net") by vger.kernel.org with SMTP id S932515AbWFBQtf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Jun 2006 12:49:35 -0400
Received: (qmail 1123 invoked from network); 2 Jun 2006 12:49:32 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 2 Jun 2006 12:49:32 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri,  2 Jun 2006 12:49:32 -0400
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vk67zbksv.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21170>

When adding packs, skip the pack if we already have it in the packed_git
list. This might happen if we are re-preparing our packs because of a
missing object.
---

On Fri, Jun 02, 2006 at 09:10:24AM -0700, Junio C Hamano wrote:

> I agree 100% on "shouldn't" part.  What I wonder is if everybody
> works correctly if we mmap the same file (all available .idx are

This patch avoids duplicates in the packed_git list. It's not necessary
under Linux, at least, but it just seems cleaner, and it's simple to do.
The list might still have packs that are now gone. I didn't want to
purge anything from the packed_git list since I'm not clear on whether
other code might have pointers into the mmap'd portion.

 sha1_file.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 696e53f..aea0f40 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -617,6 +617,12 @@ static void prepare_packed_git_one(char 
 
 		/* we have .idx.  Is it a file we can map? */
 		strcpy(path + len, de->d_name);
+		for (p = packed_git; p; p = p->next) {
+			if (!memcmp(path, p->pack_name, len + namelen - 4))
+				break;
+		}
+		if (p)
+			continue;
 		p = add_packed_git(path, len + namelen, local);
 		if (!p)
 			continue;
-- 
1.3.3.gfb825
