From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Simple support for tree entry specification with relative
	pathnames
Date: Tue, 18 Dec 2007 21:47:52 +0100
Message-ID: <20071218204752.GD2875@steel.home>
References: <20071218173321.GB2875@steel.home> <m3d4t3q4e5.fsf@roke.D-201> <20071218204623.GC2875@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 21:48:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4jMQ-0004Ik-CQ
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 21:48:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921AbXLRUrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 15:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751913AbXLRUrz
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 15:47:55 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:28441 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859AbXLRUry (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 15:47:54 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBsGSh4=
Received: from tigra.home (Fcb97.f.strato-dslnet.de [195.4.203.151])
	by post.webmailer.de (mrclete mo57) (RZmta 14.6)
	with ESMTP id w06a70jBIGK6Qb ; Tue, 18 Dec 2007 21:47:52 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id A4666277AE;
	Tue, 18 Dec 2007 21:47:52 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id A428A56D22; Tue, 18 Dec 2007 21:47:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071218204623.GC2875@steel.home>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68811>

This allows git show to understand something like this:

    $ test -f DIR/file && cd DIR &&  git show rev:file

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

This is a bit too simplistic and can be fooled easily:

    .../t$ git show HEAD:../t/test-lib.sh

wont work. It is short, though.

 cache.h     |    1 +
 revision.c  |    4 ++--
 sha1_name.c |   27 ++++++++++++++++++++++++---
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index 39331c2..054f106 100644
--- a/cache.h
+++ b/cache.h
@@ -416,6 +416,7 @@ static inline unsigned int hexval(unsigned char c)
 
 extern int get_sha1(const char *str, unsigned char *sha1);
 extern int get_sha1_with_mode(const char *str, unsigned char *sha1, unsigned *mode);
+extern int get_sha1_with_prefix(const char *prefix, const char *name, unsigned char *sha1, unsigned *mode);
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
 extern int read_ref(const char *filename, unsigned char *sha1);
diff --git a/revision.c b/revision.c
index 7e2f4f1..cac283c 100644
--- a/revision.c
+++ b/revision.c
@@ -855,7 +855,7 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 		local_flags = UNINTERESTING;
 		arg++;
 	}
-	if (get_sha1_with_mode(arg, sha1, &mode))
+	if (get_sha1_with_prefix(revs->prefix, arg, sha1, &mode))
 		return -1;
 	if (!cant_be_filename)
 		verify_non_filename(revs->prefix, arg);
@@ -1280,7 +1280,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 		unsigned char sha1[20];
 		struct object *object;
 		unsigned mode;
-		if (get_sha1_with_mode(def, sha1, &mode))
+		if (get_sha1_with_prefix(revs->prefix, def, sha1, &mode))
 			die("bad default revision '%s'", def);
 		object = get_reference(revs, def, sha1, 0);
 		add_pending_object_with_mode(revs, object, def, mode);
diff --git a/sha1_name.c b/sha1_name.c
index 13e1164..358aab7 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -656,6 +656,12 @@ int get_sha1(const char *name, unsigned char *sha1)
 
 int get_sha1_with_mode(const char *name, unsigned char *sha1, unsigned *mode)
 {
+	return get_sha1_with_prefix(NULL, name, sha1, mode);
+}
+
+int get_sha1_with_prefix(const char *prefix, const char *name, unsigned char *sha1, unsigned *mode)
+{
+	char *prefixpath;
 	int ret, bracket_depth;
 	int namelen = strlen(name);
 	const char *cp;
@@ -664,6 +670,9 @@ int get_sha1_with_mode(const char *name, unsigned char *sha1, unsigned *mode)
 	ret = get_sha1_1(name, namelen, sha1);
 	if (!ret)
 		return ret;
+
+	prefixpath = prefix ? xmalloc(strlen(prefix) + namelen + 1): NULL;
+
 	/* sha1:path --> object name of path in ent sha1
 	 * :path -> object name of path in index
 	 * :[0-3]:path -> object name of path in index at stage
@@ -685,6 +694,10 @@ int get_sha1_with_mode(const char *name, unsigned char *sha1, unsigned *mode)
 		namelen = namelen - (cp - name);
 		if (!active_cache)
 			read_cache();
+		if (prefix) {
+			namelen = sprintf(prefixpath, "%s%s", prefix, cp);
+			cp = prefixpath;
+		}
 		pos = cache_name_pos(cp, namelen);
 		if (pos < 0)
 			pos = -pos - 1;
@@ -696,10 +709,12 @@ int get_sha1_with_mode(const char *name, unsigned char *sha1, unsigned *mode)
 			if (ce_stage(ce) == stage) {
 				hashcpy(sha1, ce->sha1);
 				*mode = ntohl(ce->ce_mode);
+				free(prefixpath);
 				return 0;
 			}
 			pos++;
 		}
+		free(prefixpath);
 		return -1;
 	}
 	for (cp = name, bracket_depth = 0; *cp; cp++) {
@@ -712,9 +727,15 @@ int get_sha1_with_mode(const char *name, unsigned char *sha1, unsigned *mode)
 	}
 	if (*cp == ':') {
 		unsigned char tree_sha1[20];
-		if (!get_sha1_1(name, cp-name, tree_sha1))
-			return get_tree_entry(tree_sha1, cp+1, sha1,
-					      mode);
+		if (!get_sha1_1(name, cp-name, tree_sha1)) {
+			if (!prefix)
+				ret = get_tree_entry(tree_sha1, cp + 1, sha1, mode);
+			else {
+				sprintf(prefixpath, "%s%s", prefix, cp + 1);
+				ret = get_tree_entry(tree_sha1, prefixpath, sha1, mode);
+				free(prefixpath);
+			}
+		}
 	}
 	return ret;
 }
-- 
1.5.4.rc0.86.g30f5
