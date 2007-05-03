From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Make xstrndup common
Date: Wed, 2 May 2007 22:49:41 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0705022248040.28708@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 03 04:49:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjRO8-00050A-OZ
	for gcvg-git@gmane.org; Thu, 03 May 2007 04:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767339AbXECCto (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 22:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767340AbXECCtn
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 22:49:43 -0400
Received: from iabervon.org ([66.92.72.58]:4543 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767339AbXECCtm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 22:49:42 -0400
Received: (qmail 7934 invoked by uid 1000); 3 May 2007 02:49:41 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 May 2007 02:49:41 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46057>

This also improves the implementation to match how strndup is
specified (by GNU): if the length given is longer than the string,
only the string's length is allocated and copied, but the string need
not be null-terminated if it is at least as long as the given length.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
Haven't got the rest of my series updated for comments, but I'd like to 
get this change, which is logically unrelated aside from being a 
dependancy, in now.

 commit.c          |    8 --------
 git-compat-util.h |   12 ++++++++++++
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/commit.c b/commit.c
index f1ba972..aa7059c 100644
--- a/commit.c
+++ b/commit.c
@@ -718,14 +718,6 @@ static char *logmsg_reencode(const struct commit *commit,
 	return out;
 }
 
-static char *xstrndup(const char *text, int len)
-{
-	char *result = xmalloc(len + 1);
-	memcpy(result, text, len);
-	result[len] = '\0';
-	return result;
-}
-
 static void fill_person(struct interp *table, const char *msg, int len)
 {
 	int start, end, tz = 0;
diff --git a/git-compat-util.h b/git-compat-util.h
index 2c84016..0dcd4e2 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -197,6 +197,18 @@ static inline void *xmalloc(size_t size)
 	return ret;
 }
 
+static inline char *xstrndup(const char *str, int len)
+{
+	char *ret;
+	int i;
+	for (i = 0; i < len && str[i]; i++)
+		;
+	ret = xmalloc(i + 1);
+	strncpy(ret, str, i);
+	ret[i] = '\0';
+	return ret;
+}
+
 static inline void *xrealloc(void *ptr, size_t size)
 {
 	void *ret = realloc(ptr, size);
-- 
1.5.1.2.255.g6ead4-dirty
