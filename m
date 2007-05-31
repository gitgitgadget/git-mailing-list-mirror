From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] always start looking up objects in the last used pack first
Date: Wed, 30 May 2007 22:48:13 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705302152180.11491@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 31 04:48:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtaiJ-0000um-GG
	for gcvg-git@gmane.org; Thu, 31 May 2007 04:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754901AbXEaCsY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 22:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755642AbXEaCsY
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 22:48:24 -0400
Received: from relais.videotron.ca ([24.201.245.36]:36217 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754901AbXEaCsX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 22:48:23 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JIV00JT7X4D8YK0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 30 May 2007 22:48:14 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48797>

Jon Smirl said:

| Once an object reference hits a pack file it is very likely that 
| following references will hit the same pack file. So first place to 
| look for an object is the same place the previous object was found.

This is indeed a good heuristic so here it is.  The search always start
with the pack where the last object lookup succeeded.  If the wanted 
object is not available there then the search continues with the normal
pack ordering.

To test this I split the Linux repository into 66 packs and performed a
"time git-rev-list --objects --all > /dev/null".  Best results are as 
follows:

	Pack Sort			w/o this patch	w/ this patch
	-------------------------------------------------------------
	recent objects last		26.4s		20.9s
	recent objects first		24.9s		18.4s

This shows that the pack order based on object age has some influence, 
but that the last-used-pack heuristic is even more significant in 
reducing object lookup.

Signed-off-by: Nicolas Pitre <nico@cam.org> --- Note: the 
--max-pack-size to git-repack currently produces packs with old objects 
after those containing recent objects.  The pack sort based on 
filesystem timestamp is therefore backward for those.  This needs to be 
fixed of course, but at least it made me think about this variable for 
the test.

diff --git a/sha1_file.c b/sha1_file.c
index a3637d7..aa6d499 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1687,20 +1688,25 @@ static int matches_pack_name(struct packed_git *p, const char *ig)
 
 static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e, const char **ignore_packed)
 {
+	static struct packed_git *last_found = (void *)1;
 	struct packed_git *p;
 	off_t offset;
 
 	prepare_packed_git();
+	if (!packed_git)
+		return 0;
+	p = (last_found == (void *)1) ? packed_git : last_found;
 
-	for (p = packed_git; p; p = p->next) {
+	do {
 		if (ignore_packed) {
 			const char **ig;
 			for (ig = ignore_packed; *ig; ig++)
 				if (!matches_pack_name(p, *ig))
 					break;
 			if (*ig)
-				continue;
+				goto next;
 		}
+
 		offset = find_pack_entry_one(sha1, p);
 		if (offset) {
 			/*
@@ -1713,14 +1719,23 @@ static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e, cons
 			 */
 			if (p->pack_fd == -1 && open_packed_git(p)) {
 				error("packfile %s cannot be accessed", p->pack_name);
-				continue;
+				goto next;
 			}
 			e->offset = offset;
 			e->p = p;
 			hashcpy(e->sha1, sha1);
+			last_found = p;
 			return 1;
 		}
-	}
+
+		next:
+		if (p == last_found)
+			p = packed_git;
+		else
+			p = p->next;
+		if (p == last_found)
+			p = p->next;
+	} while (p);
 	return 0;
 }
 
