From: David Rientjes <rientjes@google.com>
Subject: [PATCH] cleans up builtin-mv
Date: Thu, 17 Aug 2006 22:59:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608172230470.25827@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Aug 18 07:59:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDxOD-00036K-Hk
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 07:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbWHRF71 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 01:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964853AbWHRF70
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 01:59:26 -0400
Received: from smtp-out.google.com ([216.239.45.12]:41716 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S964844AbWHRF70
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 01:59:26 -0400
Received: from zps36.corp.google.com (zps36.corp.google.com [172.25.146.36])
	by smtp-out.google.com with ESMTP id k7I5xOrQ009612
	for <git@vger.kernel.org>; Thu, 17 Aug 2006 22:59:24 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:subject:message-id:
	mime-version:content-type;
	b=ZV/oFFR+NAi6w2Ywjf3c6w/44Wf+3N81mv+Jg+gyNw5Rr+1HELhvupc1uL1bl0yqG
	cehwH+WYdZr4zz5RD1LFw==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps36.corp.google.com with ESMTP id k7I5xNw2007036
	for <git@vger.kernel.org>; Thu, 17 Aug 2006 22:59:23 -0700
Received: by localhost (Postfix, from userid 24081)
	id F202587D71; Thu, 17 Aug 2006 22:59:22 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id ED7A587D70
	for <git@vger.kernel.org>; Thu, 17 Aug 2006 22:59:22 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25631>

Cleans up builtin-mv by removing a needless check of source's length, 
redefinition of source's length, and misuse of strlen call that was 
already assigned.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 builtin-mv.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin-mv.c b/builtin-mv.c
index c0c8764..54c9262 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -126,7 +126,7 @@ int cmd_mv(int argc, const char **argv, 
 
 	/* Checking */
 	for (i = 0; i < count; i++) {
-		int length;
+		int length = strlen(source[i]);
 		const char *bad = NULL;
 
 		if (show_only)
@@ -137,14 +137,13 @@ int cmd_mv(int argc, const char **argv, 
 			bad = "bad source";
 
 		if (!bad &&
-		    (length = strlen(source[i])) >= 0 &&
 		    !strncmp(destination[i], source[i], length) &&
 		    (destination[i][length] == 0 || destination[i][length] == '/'))
 			bad = "can not move directory into itself";
 
 		if (S_ISDIR(st.st_mode)) {
 			const char *dir = source[i], *dest_dir = destination[i];
-			int first, last, len = strlen(dir);
+			int first, last;
 
 			if (lstat(dest_dir, &st) == 0) {
 				bad = "cannot move directory over file";
@@ -153,14 +152,15 @@ int cmd_mv(int argc, const char **argv, 
 
 			modes[i] = WORKING_DIRECTORY;
 
-			first = cache_name_pos(source[i], len);
+			first = cache_name_pos(source[i], length);
 			if (first >= 0)
 				die ("Huh? %s/ is in index?", dir);
 
 			first = -1 - first;
 			for (last = first; last < active_nr; last++) {
 				const char *path = active_cache[last]->name;
-				if (strncmp(path, dir, len) || path[len] != '/')
+				if (strncmp(path, dir, length) ||
+				    path[length] != '/')
 					break;
 			}
 
@@ -189,7 +189,7 @@ int cmd_mv(int argc, const char **argv, 
 					source[count + j] = path;
 					destination[count + j] =
 						prefix_path(dest_dir, dst_len,
-							path + len);
+							path + length);
 					modes[count + j] = INDEX;
 				}
 				count += last - first;
@@ -217,7 +217,7 @@ int cmd_mv(int argc, const char **argv, 
 			}
 		}
 
-		if (!bad && cache_name_pos(source[i], strlen(source[i])) < 0)
+		if (!bad && cache_name_pos(source[i], length) < 0)
 			bad = "not under version control";
 
 		if (!bad) {
-- 
1.4.2.rc4.g55c3-dirty
