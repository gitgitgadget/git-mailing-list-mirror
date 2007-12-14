From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: testsuite failures in mainline...
Date: Fri, 14 Dec 2007 22:45:33 +0100
Message-ID: <20071214214533.GA4943@steel.home>
References: <20071214.104312.103638776.davem@davemloft.net> <7vfxy5rsui.fsf@gitster.siamese.dyndns.org> <20071214.111736.258936000.davem@davemloft.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: David Miller <davem@davemloft.net>
X-From: git-owner@vger.kernel.org Fri Dec 14 22:46:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3IM3-0003to-OM
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 22:46:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753740AbXLNVph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 16:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753522AbXLNVph
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 16:45:37 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:61156 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984AbXLNVpg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 16:45:36 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTvwij8=
Received: from tigra.home (Fcaa0.f.strato-dslnet.de [195.4.202.160])
	by post.webmailer.de (klopstock mo46) (RZmta 14.6)
	with ESMTP id D03caajBEJGB7v ; Fri, 14 Dec 2007 22:45:34 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 0C5FF277AE;
	Fri, 14 Dec 2007 22:45:34 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 774FD56D22; Fri, 14 Dec 2007 22:45:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071214.111736.258936000.davem@davemloft.net>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68350>

David Miller, Fri, Dec 14, 2007 20:17:36 +0100:
> ++ git show-ref -q refs/remotes/local/master
> ++ git branch my3 local/master
> fatal: Out of memory, malloc failed

Something unusual about the system? Like a malloc debugger in
LD_PRELOAD configuration?

Maybe you could retry with a little bit instrumentation?
(The program last failed (git-branch) is normally very benign...)

Something like this:


diff --git a/git-compat-util.h b/git-compat-util.h
index 79eb10e..a9cc249 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -230,7 +230,8 @@ static inline char* xstrdup(const char *str)
 	return ret;
 }
 
-static inline void *xmalloc(size_t size)
+#define xmalloc(size) xmalloc_((size),__FILE__,__LINE__)
+static inline void *xmalloc_(size_t size, const char *file, int line)
 {
 	void *ret = malloc(size);
 	if (!ret && !size)
@@ -241,7 +242,8 @@ static inline void *xmalloc(size_t size)
 		if (!ret && !size)
 			ret = malloc(1);
 		if (!ret)
-			die("Out of memory, malloc failed");
+			die("Out of memory, malloc(%u) at %s:%d failed",
+			    size, file, line);
 	}
 #ifdef XMALLOC_POISON
 	memset(ret, 0xA5, size);
@@ -263,7 +265,8 @@ static inline char *xstrndup(const char *str, size_t len)
 	return xmemdupz(str, p ? p - str : len);
 }
 
-static inline void *xrealloc(void *ptr, size_t size)
+#define xrealloc(ptr,size) xrealloc_((ptr),(size),__FILE__,__LINE__)
+static inline void *xrealloc_(void *ptr, size_t size, const char *file, int line)
 {
 	void *ret = realloc(ptr, size);
 	if (!ret && !size)
@@ -274,7 +277,8 @@ static inline void *xrealloc(void *ptr, size_t size)
 		if (!ret && !size)
 			ret = realloc(ptr, 1);
 		if (!ret)
-			die("Out of memory, realloc failed");
+			die("Out of memory, realloc(%u) at %s:%d failed",
+			    size, file, line);
 	}
 	return ret;
 }
