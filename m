From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/4] git-compat-util.h: dietlibc-friendly x{malloc,realloc,calloc}
Date: Sat, 24 Dec 2005 10:28:02 -0800
Message-ID: <7v3bkis631.fsf@assigned-by-dhcp.cox.net>
References: <20051224121007.GA19136@mail.yhbt.net>
	<20051224121454.GC3963@mail.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 24 19:28:19 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EqE7s-0003H6-2Y
	for gcvg-git@gmane.org; Sat, 24 Dec 2005 19:28:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbVLXS2F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Dec 2005 13:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbVLXS2F
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Dec 2005 13:28:05 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:56263 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932198AbVLXS2E (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Dec 2005 13:28:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051224182702.PTZR20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Dec 2005 13:27:02 -0500
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20051224121454.GC3963@mail.yhbt.net> (Eric Wong's message of
	"Sat, 24 Dec 2005 04:14:54 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14030>

Eric Wong <normalperson@yhbt.net> writes:

> dietlibc versions of these allocators returns NULL if a size of zero is
> specified.  Obviously, this is a problem with the x* wrappers since
> we check for them returning NULL.
>
> Down the line, it'd be better to hunt down and eliminate all calls to
> these functions when they are called with a zero argument.  I've already
> added some checks for these cases that were exposed by tests.

I agree that it is a bug to rely on *alloc(0) not returning
NULL, but this patch is too risky.  It would be a good thing to
have debugging variant of x* wrappers that barf on a 0-byte
allocation request to find the offending callers, instead of
returning NULL, maybe like the attached patch.

Since eradicating *alloc(0) calls is the right way to go, but it
takes time.  Touching x* wrappers for general public should not
be done before it is done.  It breaks things for everybody,
while the current code is broken only for diet people and
developers that use the debugging variant of x* wrappers.

-- >8 --
diff --git a/git-compat-util.h b/git-compat-util.h
index 0c98c99..08fd6bc 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -60,9 +60,17 @@ extern int gitsetenv(const char *, const
 extern char *gitstrcasestr(const char *haystack, const char *needle);
 #endif
 
+#ifdef DEBUG_0ALLOC
+#define debug_0alloc(sz) assert(0 < (sz))
+#else
+#define debug_0alloc(sz)
+#endif
+
 static inline void *xmalloc(size_t size)
 {
 	void *ret = malloc(size);
+
+	debug_0alloc(size);
 	if (!ret)
 		die("Out of memory, malloc failed");
 	return ret;
@@ -71,6 +79,7 @@ static inline void *xmalloc(size_t size)
 static inline void *xrealloc(void *ptr, size_t size)
 {
 	void *ret = realloc(ptr, size);
+	debug_0alloc(size);
 	if (!ret)
 		die("Out of memory, realloc failed");
 	return ret;
@@ -79,6 +88,7 @@ static inline void *xrealloc(void *ptr, 
 static inline void *xcalloc(size_t nmemb, size_t size)
 {
 	void *ret = calloc(nmemb, size);
+	debug_0alloc(nmemb);
 	if (!ret)
 		die("Out of memory, calloc failed");
 	return ret;
