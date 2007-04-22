From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Simplify calling of CR/LF conversion routines
Date: Sun, 22 Apr 2007 18:16:02 +0200
Message-ID: <20070422161602.GD2431@steel.home>
References: <20070418222827.GB2477@steel.home> <20070422134505.GF27208@admingilde.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Sun Apr 22 18:16:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hfejf-0006cO-34
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 18:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161337AbXDVQQI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 12:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161338AbXDVQQI
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 12:16:08 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:61692 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161337AbXDVQQG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 12:16:06 -0400
Received: from tigra.home (Fcb6c.f.strato-dslnet.de [195.4.203.108])
	by post.webmailer.de (mrclete mo44) (RZmta 5.6)
	with ESMTP id E035d7j3MFfGa0 ; Sun, 22 Apr 2007 18:16:03 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 1A66E277BD;
	Sun, 22 Apr 2007 18:16:03 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 7EBD4BDDE; Sun, 22 Apr 2007 18:16:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070422134505.GF27208@admingilde.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBsD+I4=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45246>


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Martin Waitz, Sun, Apr 22, 2007 15:45:06 +0200:
> hoi :)
> 
> For me (on glibc-2.5) the testsuite fails in t0020-crlf.sh, test 14:
> 
> *** glibc detected *** git: free(): invalid next size (fast): 0x081097b8 ***

Yep, already fixed. The patches attached (I forgot which one was the
fix for this particular problem).


--opJtzjQTFsWo+cga
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-Fix-crash-in-t0020-crlf-conversion.patch"

>From 001f0b86bc4142743eea242649fb188807e03c16 Mon Sep 17 00:00:00 2001
From: Alex Riesen <raa.lkml@gmail.com>
Date: Sun, 22 Apr 2007 16:03:49 +0200
Subject: [PATCH] Fix crash in t0020 (crlf conversion)

Reallocated wrong size.
Noticed on Ubuntu 7.04 probably because it has some malloc diagnostics in libc:
"git-read-tree --reset -u HEAD" aborted in the test. Valgrind sped up the
debugging greatly: took me 10 minutes.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 attr.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/attr.c b/attr.c
index 285e689..a071254 100644
--- a/attr.c
+++ b/attr.c
@@ -300,7 +300,8 @@ static struct attr_stack *read_attr_from_array(const char **list)
 		a = parse_attr_line(line, "[builtin]", ++lineno, 1);
 		if (!a)
 			continue;
-		res->attrs = xrealloc(res->attrs, res->num_matches + 1);
+		res->attrs = xrealloc(res->attrs,
+			sizeof(struct match_attr *) * (res->num_matches + 1));
 		res->attrs[res->num_matches++] = a;
 	}
 	return res;
@@ -324,7 +325,8 @@ static struct attr_stack *read_attr_from_file(const char *path, int macro_ok)
 		a = parse_attr_line(buf, path, ++lineno, macro_ok);
 		if (!a)
 			continue;
-		res->attrs = xrealloc(res->attrs, res->num_matches + 1);
+		res->attrs = xrealloc(res->attrs,
+			sizeof(struct match_attr *) * (res->num_matches + 1));
 		res->attrs[res->num_matches++] = a;
 	}
 	fclose(fp);
-- 
1.5.1.1.946.gdb75a


--opJtzjQTFsWo+cga
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0002-Fix-a-typo-in-crlf-conversion-code.patch"

>From e306988bdabf5dec30c945167bfaa5f5f2c16835 Mon Sep 17 00:00:00 2001
From: Alex Riesen <raa.lkml@gmail.com>
Date: Sun, 22 Apr 2007 16:07:19 +0200
Subject: [PATCH] Fix a typo in crlf conversion code

Also, noticed by valgrind: the code caused a read out-of-bounds.
Some comments updated as well (they still reflected old calling
conventions).

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 convert.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/convert.c b/convert.c
index 37239ac..ad106ef 100644
--- a/convert.c
+++ b/convert.c
@@ -115,8 +115,8 @@ static char *crlf_to_git(const char *path, const char *src, unsigned long *sizep
 	}
 
 	/*
-	 * Ok, allocate a new buffer, fill it in, and return true
-	 * to let the caller know that we switched buffers on it.
+	 * Ok, allocate a new buffer, fill it in, and return it
+	 * to let the caller know that we switched buffers.
 	 */
 	nsize = size - stats.crlf;
 	buffer = xmalloc(nsize);
@@ -137,7 +137,7 @@ static char *crlf_to_git(const char *path, const char *src, unsigned long *sizep
 	} else {
 		do {
 			unsigned char c = *src++;
-			if (! (c == '\r' && (1 < size && *buffer == '\n')))
+			if (! (c == '\r' && (1 < size && *src == '\n')))
 				*dst++ = c;
 		} while (--size);
 	}
@@ -180,8 +180,8 @@ static char *crlf_to_worktree(const char *path, const char *src, unsigned long *
 	}
 
 	/*
-	 * Ok, allocate a new buffer, fill it in, and return true
-	 * to let the caller know that we switched buffers on it.
+	 * Ok, allocate a new buffer, fill it in, and return it
+	 * to let the caller know that we switched buffers.
 	 */
 	nsize = size + stats.lf - stats.crlf;
 	buffer = xmalloc(nsize);
-- 
1.5.1.1.946.gdb75a


--opJtzjQTFsWo+cga--
