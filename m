From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 4/4] git-compat-util.h: dietlibc-friendly x{malloc,realloc,calloc}
Date: Sat, 24 Dec 2005 13:15:46 -0800
Message-ID: <20051224211546.GG3963@mail.yhbt.net>
References: <20051224121007.GA19136@mail.yhbt.net> <20051224121454.GC3963@mail.yhbt.net> <7v3bkis631.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 24 22:15:55 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EqGk2-00030F-Bp
	for gcvg-git@gmane.org; Sat, 24 Dec 2005 22:15:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbVLXVPr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Dec 2005 16:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbVLXVPr
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Dec 2005 16:15:47 -0500
Received: from hand.yhbt.net ([66.150.188.102]:46467 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S1750724AbVLXVPr (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Dec 2005 16:15:47 -0500
Received: by mail.yhbt.net (Postfix, from userid 500)
	id 801ED7DC005; Sat, 24 Dec 2005 13:15:46 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v3bkis631.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14036>

Junio C Hamano <junkio@cox.net> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > dietlibc versions of these allocators returns NULL if a size of zero is
> > specified.  Obviously, this is a problem with the x* wrappers since
> > we check for them returning NULL.
> >
> > Down the line, it'd be better to hunt down and eliminate all calls to
> > these functions when they are called with a zero argument.  I've already
> > added some checks for these cases that were exposed by tests.
> 
> I agree that it is a bug to rely on *alloc(0) not returning
> NULL, but this patch is too risky.  It would be a good thing to
> have debugging variant of x* wrappers that barf on a 0-byte
> allocation request to find the offending callers, instead of
> returning NULL, maybe like the attached patch.
> 
> Since eradicating *alloc(0) calls is the right way to go, but it
> takes time.  Touching x* wrappers for general public should not
> be done before it is done.  It breaks things for everybody,
> while the current code is broken only for diet people and
> developers that use the debugging variant of x* wrappers.

I'll be using the following patch to collect results for the next few
days without interrupting my work on other projects.  I'll post
patches to remove *alloc(0) calls when I find them.

diff --git a/git-compat-util.h b/git-compat-util.h
index 0c98c99..43be289 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -60,9 +60,41 @@ extern int gitsetenv(const char *, const
 extern char *gitstrcasestr(const char *haystack, const char *needle);
 #endif
 
+static void fork_for_core (const char * caller)
+{
+	pid_t child = fork();
+	if (child == 0) {
+		int i;
+		char out[4096];
+		char * progname = "unknown";
+		FILE * dbg = fopen("/var/tmp/git_alloc_dbg.log","a");
+
+		for(i = 0; environ[i]; i++) {
+			if (strstr(environ[i],"_=") == environ[i])
+				progname = environ[i];
+		}
+		
+		snprintf(out, 4096, "%s:%s: pid %d dumping core for pid %d\n",
+				progname, caller, getpid(), getppid());
+
+		fputs(out, stderr);
+		fputs(out, dbg);
+		fflush(NULL);
+		
+		abort();
+	}
+}
+
 static inline void *xmalloc(size_t size)
 {
-	void *ret = malloc(size);
+	void *ret;
+	
+	if (!size) {
+		fork_for_core(__func__);
+		return NULL;
+	}
+	
+	ret = malloc(size);
 	if (!ret)
 		die("Out of memory, malloc failed");
 	return ret;
@@ -70,7 +102,15 @@ static inline void *xmalloc(size_t size)
 
 static inline void *xrealloc(void *ptr, size_t size)
 {
-	void *ret = realloc(ptr, size);
+	void *ret;
+	
+	if (!size) {
+		fork_for_core(__func__);
+		free(ptr);
+		return NULL;
+	}
+	
+	ret = realloc(ptr, size);
 	if (!ret)
 		die("Out of memory, realloc failed");
 	return ret;
@@ -78,7 +118,14 @@ static inline void *xrealloc(void *ptr, 
 
 static inline void *xcalloc(size_t nmemb, size_t size)
 {
-	void *ret = calloc(nmemb, size);
+	void *ret;
+	
+	if (!nmemb || !size) {
+		fork_for_core(__func__);
+		return NULL;
+	}
+
+	ret = calloc(nmemb, size);
 	if (!ret)
 		die("Out of memory, calloc failed");
 	return ret;

-- 
Eric Wong
