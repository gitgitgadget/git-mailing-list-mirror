From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH/RFC v1 1/6] symlinks.c: small cleanup and optimisation
Date: Mon, 26 Jan 2009 22:17:12 +0100
Message-ID: <1233004637-15112-2-git-send-email-barvik@broadpark.no>
References: <1233004637-15112-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 26 22:19:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRYrE-0000UB-7f
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 22:19:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752471AbZAZVRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 16:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752391AbZAZVRY
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 16:17:24 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:62233 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193AbZAZVRW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 16:17:22 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KE3003TMKGXXC90@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Mon, 26 Jan 2009 22:17:21 +0100 (CET)
Received: from localhost.localdomain ([80.203.78.144])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KE3001KZKGTUNC0@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Mon, 26 Jan 2009 22:17:21 +0100 (CET)
X-Mailer: git-send-email 1.6.1.349.g99fa5
In-reply-to: <1233004637-15112-1-git-send-email-barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107280>

Simplify the if-else test in longest_match_lstat_cache() such that we
only have one simple if test.  Instead of testing for 'i == cache.len'
or 'i == len', we transform this to a common test for 'i == max_len'.

And to further optimise we use 'i >= max_len' instead of 'i ==
max_len', the reason is that it is now the exact opposite of one part
inside the while-loop termination expression 'i < max_len && name[i]
== cache.path[i]', and then the compiler can hopefully/probably reuse
a test-result from it.

We do similar transformations inside the lstat_cache() and the
invalidate_lstat_cache() functions.

The result is a little smaller text-size as shown below:

 ~/git/git $ size symlinks_??_*
   text	   data	    bss	    dec	    hex	filename
   1282       0	   4116	   5398	   1516	symlinks_O2_after.o
   1378       0	   4116	   5494	   1576	symlinks_O2_before.o
    896       0	   4116	   5012	   1394	symlinks_Os_after.o
    902       0	   4116	   5018	   139a	symlinks_Os_before.o

'O2' means that the file is compiled with 'gcc -O2', and similar 'Os'
means that the file is compiled with 'gcc -Os' (gcc 4.3.2).

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---
 symlinks.c |   25 +++++++++++++------------
 1 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/symlinks.c b/symlinks.c
index f262b7c..81f490c 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -25,15 +25,16 @@ static inline int longest_match_lstat_cache(int len, const char *name,
 		}
 		i++;
 	}
-	/* Is the cached path string a substring of 'name'? */
-	if (i == cache.len && cache.len < len && name[cache.len] == '/') {
-		match_len_prev = match_len;
-		match_len = cache.len;
-	/* Is 'name' a substring of the cached path string? */
-	} else if ((i == len && len < cache.len && cache.path[len] == '/') ||
-		   (i == len && len == cache.len)) {
+	/*
+	 * Is the cached path string a substring of 'name', is 'name'
+	 * a substring of the cached path string, or is 'name' and the
+	 * cached path string the exact same string?
+	 */
+	if (i >= max_len && ((i < len && name[i] == '/') ||
+			     (i < cache.len && cache.path[i] == '/') ||
+			     (len == cache.len))) {
 		match_len_prev = match_len;
-		match_len = len;
+		match_len = i;
 	}
 	*previous_slash = match_len_prev;
 	return match_len;
@@ -91,7 +92,7 @@ static int lstat_cache(int len, const char *name,
 		match_len = last_slash =
 			longest_match_lstat_cache(len, name, &previous_slash);
 		match_flags = cache.flags & track_flags & (FL_NOENT|FL_SYMLINK);
-		if (match_flags && match_len == cache.len)
+		if (match_flags && match_len >= cache.len)
 			return match_flags;
 		/*
 		 * If we now have match_len > 0, we would know that
@@ -102,7 +103,7 @@ static int lstat_cache(int len, const char *name,
 		 * we can return immediately.
 		 */
 		match_flags = track_flags & FL_DIR;
-		if (match_flags && len == match_len)
+		if (match_flags && match_len >= len)
 			return match_flags;
 	}
 
@@ -153,7 +154,7 @@ static int lstat_cache(int len, const char *name,
 		cache.path[last_slash] = '\0';
 		cache.len = last_slash;
 		cache.flags = save_flags;
-	} else if (track_flags & FL_DIR &&
+	} else if ((track_flags & FL_DIR) &&
 		   last_slash_dir > 0 && last_slash_dir <= PATH_MAX) {
 		/*
 		 * We have a separate test for the directory case,
@@ -184,7 +185,7 @@ void invalidate_lstat_cache(int len, const char *name)
 	int match_len, previous_slash;
 
 	match_len = longest_match_lstat_cache(len, name, &previous_slash);
-	if (len == match_len) {
+	if (match_len >= len) {
 		if ((cache.track_flags & FL_DIR) && previous_slash > 0) {
 			cache.path[previous_slash] = '\0';
 			cache.len = previous_slash;
-- 
1.6.1.349.g99fa5
