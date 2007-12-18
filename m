From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Use pathexpand to preparse the relative pathnames in blob
	references
Date: Tue, 18 Dec 2007 21:52:53 +0100
Message-ID: <20071218205253.GF2875@steel.home>
References: <20071218173321.GB2875@steel.home> <m3d4t3q4e5.fsf@roke.D-201> <20071218204623.GC2875@steel.home> <20071218204752.GD2875@steel.home> <20071218204947.GE2875@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 21:53:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4jRH-0006Xc-RI
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 21:53:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851AbXLRUw5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 15:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbXLRUw4
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 15:52:56 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:39793 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbXLRUw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 15:52:56 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBsGSh4=
Received: from tigra.home (Fcb97.f.strato-dslnet.de [195.4.203.151])
	by post.webmailer.de (klopstock mo7) (RZmta 14.6)
	with ESMTP id 603ccbjBIHXLCk ; Tue, 18 Dec 2007 21:52:54 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 5E2B8277AE;
	Tue, 18 Dec 2007 21:52:54 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 98FC556D22; Tue, 18 Dec 2007 21:52:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071218204947.GE2875@steel.home>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68813>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

This, OTOH, is a bit intrusive and changes the current behaviour a bit
too far. git-show cannot use the absolute pathnames in blob locators
at all now, which I consider bad. An obvious way to use rev:/path is
blocked by Johannes' get_sha1_oneline. It would have worked, though.

 sha1_name.c |   21 +++++++--------------
 1 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 358aab7..369e7d0 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -661,7 +661,7 @@ int get_sha1_with_mode(const char *name, unsigned char *sha1, unsigned *mode)
 
 int get_sha1_with_prefix(const char *prefix, const char *name, unsigned char *sha1, unsigned *mode)
 {
-	char *prefixpath;
+	char *prefixpath = NULL;
 	int ret, bracket_depth;
 	int namelen = strlen(name);
 	const char *cp;
@@ -671,8 +671,6 @@ int get_sha1_with_prefix(const char *prefix, const char *name, unsigned char *sh
 	if (!ret)
 		return ret;
 
-	prefixpath = prefix ? xmalloc(strlen(prefix) + namelen + 1): NULL;
-
 	/* sha1:path --> object name of path in ent sha1
 	 * :path -> object name of path in index
 	 * :[0-3]:path -> object name of path in index at stage
@@ -694,10 +692,9 @@ int get_sha1_with_prefix(const char *prefix, const char *name, unsigned char *sh
 		namelen = namelen - (cp - name);
 		if (!active_cache)
 			read_cache();
-		if (prefix) {
-			namelen = sprintf(prefixpath, "%s%s", prefix, cp);
-			cp = prefixpath;
-		}
+		prefixpath = pathexpand(prefix, cp);
+		namelen = strlen(prefixpath);
+		cp = prefixpath;
 		pos = cache_name_pos(cp, namelen);
 		if (pos < 0)
 			pos = -pos - 1;
@@ -728,13 +725,9 @@ int get_sha1_with_prefix(const char *prefix, const char *name, unsigned char *sh
 	if (*cp == ':') {
 		unsigned char tree_sha1[20];
 		if (!get_sha1_1(name, cp-name, tree_sha1)) {
-			if (!prefix)
-				ret = get_tree_entry(tree_sha1, cp + 1, sha1, mode);
-			else {
-				sprintf(prefixpath, "%s%s", prefix, cp + 1);
-				ret = get_tree_entry(tree_sha1, prefixpath, sha1, mode);
-				free(prefixpath);
-			}
+			prefixpath = pathexpand(prefix, cp + 1);
+			ret = get_tree_entry(tree_sha1, prefixpath, sha1, mode);
+			free(prefixpath);
 		}
 	}
 	return ret;
-- 
1.5.4.rc0.86.g30f5
