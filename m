From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/4] short circuit out of a few places where we would allocate zero bytes
Date: Tue, 27 Dec 2005 21:07:28 -0800
Message-ID: <7vpsnh24j3.fsf@assigned-by-dhcp.cox.net>
References: <20051224121007.GA19136@mail.yhbt.net>
	<20051224121243.GA3963@mail.yhbt.net> <43B21312.50603@zytor.com>
	<Pine.LNX.4.64.0512272036380.14098@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 28 06:11:47 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ErTXx-0002tu-Ty
	for gcvg-git@gmane.org; Wed, 28 Dec 2005 06:08:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbVL1FHb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Dec 2005 00:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbVL1FHb
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Dec 2005 00:07:31 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:37788 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751134AbVL1FHa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Dec 2005 00:07:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051228050629.JDKG6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 28 Dec 2005 00:06:29 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0512272036380.14098@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 27 Dec 2005 20:38:10 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14094>

Linus Torvalds <torvalds@osdl.org> writes:

> That said, I think that would be preferable to changing the source code to 
> unnecessarily avoid zero-sized allocations.

Yes, that has essentially been the plan (according to the
discussion lead to 7e4a2a848377241b8fb4f624d1151bbf2f8d5814
commit on the list).

After eradicating zero-sized allocations where that change makes
the overall code cleaner (which Johannes and Eric did most of
the heavylifting and I think mostly done), we would apply
something like this, instead of doing x*alloc(size ? size : 1)
at the calling site.

About die(), I think the current code structure is fine.  If we
were doing a library, propagating NULL from C library *alloc()
back to our caller and having the caller deal with it is the
right thing, but most of the callers of x*alloc() are our main
programs and there aren't much they can do when we run out of
memory.

---
diff --git a/git-compat-util.h b/git-compat-util.h
index 0c98c99..a71728e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -63,6 +63,8 @@ extern char *gitstrcasestr(const char *h
 static inline void *xmalloc(size_t size)
 {
 	void *ret = malloc(size);
+	if (!ret && !size)
+		ret = malloc(1); /* funny c library */
 	if (!ret)
 		die("Out of memory, malloc failed");
 	return ret;
@@ -71,6 +73,8 @@ static inline void *xmalloc(size_t size)
 static inline void *xrealloc(void *ptr, size_t size)
 {
 	void *ret = realloc(ptr, size);
+	if (!ret && !size)
+		ret = realloc(ptr, 1); /* funny c library */
 	if (!ret)
 		die("Out of memory, realloc failed");
 	return ret;
@@ -79,6 +83,8 @@ static inline void *xrealloc(void *ptr, 
 static inline void *xcalloc(size_t nmemb, size_t size)
 {
 	void *ret = calloc(nmemb, size);
+	if (!ret && (!nmemb || !size))
+		ret = calloc(1, 1); /* funny c library */
 	if (!ret)
 		die("Out of memory, calloc failed");
 	return ret;
