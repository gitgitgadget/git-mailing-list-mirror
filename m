From: Linus Torvalds <torvalds@osdl.org>
Subject: Very limited pathspec wildcards..
Date: Wed, 3 Aug 2005 10:48:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508031038320.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 03 19:48:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0NLm-0002ZR-11
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 19:48:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262372AbVHCRsL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 13:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbVHCRsL
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 13:48:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20635 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262372AbVHCRsK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2005 13:48:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j73Hm4jA008360
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 3 Aug 2005 10:48:05 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j73Hm3LH030986;
	Wed, 3 Aug 2005 10:48:04 -0700
To: Junio C Hamano <junkio@cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


I ended up looking at wildcards in pathspecs, but wasn't quite ready
enough to pay the price of real wildcards. This limited form is the end
result.

It allows a final '*' in the path matching to indicate that we don't care 
about the "match exact files/subdirectories only" rule.

So while

	git-whatchanged git

will only show the file called "git" (or any changes under a subdirectory
called "git"),

	git-whatchanged git*

will show anything that starts with "git".

Note that this _only_ works at the very end. You can't say

	git-whatchanged git-*-script

even though maybe it would be good if we allowed full wildcards some day.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

Btw, I'm not sure this is a wonderful idea. I found it useful for doing

	git-whatchanged -p drivers/scsi/aic7xxx/aic79xx*

since I was interested in seeign if only that particular driver had had 
changes. But it's hacky and pretty limited, so I throw this patch out more 
as a "maybe others think it is a good idea" thing. 

So Junio, if you feel this is ugly, just drop it, I certainly won't mind.  
As it is you can't even escape the '*', so if you actually only want to
match a filename that literally ends in an asterisk, this makes that
impossible, and will match that file _and_ anything that shares the same
prefix..

diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -163,6 +163,12 @@ static int interesting(void *tree, unsig
 	for (i=0; i < nr_paths; i++) {
 		const char *match = paths[i];
 		int matchlen = pathlens[i];
+		int wildcard = 0;
+
+		if (matchlen && match[matchlen-1] == '*') {
+			matchlen--;
+			wildcard = 1;
+		}
 
 		if (baselen >= matchlen) {
 			/* If it doesn't match, move along... */
@@ -183,7 +189,7 @@ static int interesting(void *tree, unsig
 		if (pathlen > matchlen)
 			continue;
 
-		if (matchlen > pathlen) {
+		if (!wildcard && matchlen > pathlen) {
 			if (match[pathlen] != '/')
 				continue;
 			if (!S_ISDIR(mode))
diff --git a/read-cache.c b/read-cache.c
--- a/read-cache.c
+++ b/read-cache.c
@@ -183,10 +183,17 @@ int ce_path_match(const struct cache_ent
 	name = ce->name;
 	while ((match = *pathspec++) != NULL) {
 		int matchlen = strlen(match);
+		int wildcard = 0;
+		if (matchlen && match[matchlen-1]) {
+			matchlen--;
+			wildcard = 1;
+		}
 		if (matchlen > len)
 			continue;
 		if (memcmp(name, match, matchlen))
 			continue;
+		if (wildcard)
+			return 1;
 		if (matchlen && name[matchlen-1] == '/')
 			return 1;
 		if (name[matchlen] == '/' || !name[matchlen])
