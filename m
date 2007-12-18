From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Introduce pathexpand: syntax-level chdir into the given cwd
Date: Tue, 18 Dec 2007 21:49:47 +0100
Message-ID: <20071218204947.GE2875@steel.home>
References: <20071218173321.GB2875@steel.home> <m3d4t3q4e5.fsf@roke.D-201> <20071218204623.GC2875@steel.home> <20071218204752.GD2875@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 21:50:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4jOH-00057k-JP
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 21:50:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbXLRUtv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 15:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbXLRUtv
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 15:49:51 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:37480 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724AbXLRUtu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 15:49:50 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBsGSh4=
Received: from tigra.home (Fcb97.f.strato-dslnet.de [195.4.203.151])
	by post.webmailer.de (klopstock mo60) (RZmta 14.6)
	with ESMTP id x03cc8jBIII0tx ; Tue, 18 Dec 2007 21:49:48 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 7D56F277AE;
	Tue, 18 Dec 2007 21:49:48 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 590DB56D22; Tue, 18 Dec 2007 21:49:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071218204752.GD2875@steel.home>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68812>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

This will be used by the following patch. I actually already have sent
this one in, as suggestion for some problem back then. It is a bit
generic, so it gets its own patch.

 cache.h |    2 ++
 path.c  |   59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 054f106..25ce5da 100644
--- a/cache.h
+++ b/cache.h
@@ -383,6 +383,8 @@ static inline int is_absolute_path(const char *path)
 	return path[0] == '/';
 }
 const char *make_absolute_path(const char *path);
+/* Returns the analog of "cd path" from a directory "cwd" */
+extern char *pathexpand(const char *cwd, const char *path);
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern int sha1_object_info(const unsigned char *, unsigned long *);
diff --git a/path.c b/path.c
index 4260952..8231cd8 100644
--- a/path.c
+++ b/path.c
@@ -353,3 +353,62 @@ const char *make_absolute_path(const char *path)
 
 	return buf;
 }
+
+/*
+ * Returns the analog of "cd path" from a directory "cwd".
+ * The root is defined as empty path (instead of "/")
+ * An attempt to go past the root (with "..") leaves the path at root.
+ * The cwd is not expanded.
+ */
+char *pathexpand(const char *cwd, const char *path)
+{
+	static const char SEP[] = "/";
+	if (!*path) /* empty path -> "." (don't move) */
+		path = ".";
+	if (!cwd || !*cwd || *SEP == *path) /* no cwd, or path begins with "/" */
+		cwd = "";
+
+	while (*cwd && *SEP == *cwd)
+		++cwd;
+
+	size_t len = strlen(cwd);
+	char *out = malloc(len + 1 + strlen(path) + 1);
+	char *p = strcpy(out, cwd) + len;
+
+	for (; *path; ++path)
+	{
+		char *pl;
+		if (p > out && p[-1] != *SEP)
+			*p++ = *SEP;
+		pl = p;
+		while (*path && *SEP != *path)
+			*p++ = *path++;
+		*p = '\0';
+		/* ..."//"... */
+		if (p == pl)
+			; /* just ignore */
+		/* ..."/./"...  */
+		else if ( p - pl == 1 && '.' == *pl )
+			--p; /* just ignore */
+		/* ..."/../"...  */
+		else if ( p - pl == 2 && '.' == pl[0] && '.' == pl[1] )
+		{
+			/* drop the last element of the resulting path */
+			if (pl > out && --pl > out)
+				for (--pl; pl > out && *SEP != *pl; --pl)
+					;
+			p = pl > out ? ++pl: out;
+		}
+		/* ..."/path/"...  */
+		else if (*path)
+			*p++ = *path; /* just add the separator */
+
+		if (!*path)
+			break;
+	}
+	if (p > out+1 && *SEP == p[-1])
+		--p;
+	*p = '\0';
+	return out;
+}
+
-- 
1.5.4.rc0.86.g30f5
