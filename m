From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 4/4] git-compat-util.h: dietlibc-friendly x{malloc,realloc,calloc}
Date: Sat, 24 Dec 2005 04:14:54 -0800
Message-ID: <20051224121454.GC3963@mail.yhbt.net>
References: <20051224121007.GA19136@mail.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Dec 24 13:14:57 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eq8Ia-0000Nt-Uu
	for gcvg-git@gmane.org; Sat, 24 Dec 2005 13:14:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbVLXMOy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Dec 2005 07:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbVLXMOy
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Dec 2005 07:14:54 -0500
Received: from hand.yhbt.net ([66.150.188.102]:27779 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S932520AbVLXMOy (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Dec 2005 07:14:54 -0500
Received: by mail.yhbt.net (Postfix, from userid 500)
	id 420DF7DC005; Sat, 24 Dec 2005 04:14:54 -0800 (PST)
To: git list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20051224121007.GA19136@mail.yhbt.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14022>

dietlibc versions of these allocators returns NULL if a size of zero is
specified.  Obviously, this is a problem with the x* wrappers since
we check for them returning NULL.

Down the line, it'd be better to hunt down and eliminate all calls to
these functions when they are called with a zero argument.  I've already
added some checks for these cases that were exposed by tests.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 git-compat-util.h |   23 ++++++++++++++++++++---
 1 files changed, 20 insertions(+), 3 deletions(-)

113dca27f9f95a76a0f98929720f5f567c7586b2
diff --git a/git-compat-util.h b/git-compat-util.h
index 0c98c99..bd2f150 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -62,7 +62,12 @@ extern char *gitstrcasestr(const char *h
 
 static inline void *xmalloc(size_t size)
 {
-	void *ret = malloc(size);
+	void *ret;
+	
+	if (!size)
+		return NULL;
+	
+	ret = malloc(size);
 	if (!ret)
 		die("Out of memory, malloc failed");
 	return ret;
@@ -70,7 +75,14 @@ static inline void *xmalloc(size_t size)
 
 static inline void *xrealloc(void *ptr, size_t size)
 {
-	void *ret = realloc(ptr, size);
+	void *ret;
+	
+	if (!size) {
+		free(ptr);
+		return NULL;
+	}
+	
+	ret = realloc(ptr, size);
 	if (!ret)
 		die("Out of memory, realloc failed");
 	return ret;
@@ -78,7 +90,12 @@ static inline void *xrealloc(void *ptr, 
 
 static inline void *xcalloc(size_t nmemb, size_t size)
 {
-	void *ret = calloc(nmemb, size);
+	void *ret;
+	
+	if (!nmemb || !size)
+		return NULL;
+	
+	ret = calloc(nmemb, size);
 	if (!ret)
 		die("Out of memory, calloc failed");
 	return ret;
-- 
1.0.GIT
