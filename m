From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Rename git-config-set to git-repo-config
Date: Fri, 25 Nov 2005 20:05:46 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511251953081.13959@g5.osdl.org>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0511200935081.13959@g5.osdl.org> <200511210026.30280.Josef.Weidendorfer@gmx.de>
 <200511221831.03954.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.63.0511221854120.27872@wbgn013.biozentrum.uni-wuerzburg.de>
 <438371E8.2030701@op5.se> <Pine.LNX.4.63.0511231553390.8191@wbgn013.biozentrum.uni-wuerzburg.de>
 <7viruj3q7z.fsf@assigned-by-dhcp.cox.net> <4384FB61.40506@op5.se>
 <Pine.LNX.4.63.0511240042350.11106@wbgn013.biozentrum.uni-wuerzburg.de>
 <43857430.7060103@op5.se> <7vsltmwiky.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0511241127020.12985@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v8xveth4l.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0511241419390.14297@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmzjtn3h1.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0511242252080.26485@wbgn013.biozentrum.uni-w
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 26 05:07:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfrKZ-0005Kg-KS
	for gcvg-git@gmane.org; Sat, 26 Nov 2005 05:06:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932715AbVKZEF4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Nov 2005 23:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932718AbVKZEF4
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Nov 2005 23:05:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61677 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932715AbVKZEFz (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Nov 2005 23:05:55 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAQ45lnO000788
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 25 Nov 2005 20:05:47 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAQ45kkK027152;
	Fri, 25 Nov 2005 20:05:46 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy83cdu7r.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.56__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12765>



On Fri, 25 Nov 2005, Junio C Hamano wrote:
>
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >>  - Natively, they work only from the project toplevel.  Period.
> >
> > How about changing *that*?
> 
> I once advocated for an environment to name the top of working
> tree directory --- it might make sense to resurrect that one.

Please don't. 

We should just make the scripts do it automatically instead.

"git-rev-parse" already has support for all of this, and you can do

	GIT_DIR=$(git-rev-parse --git-dir)
	GIT_PREFIX=$(git-rev-parse --show-prefix)

where the first one shows the GIT_DIR, and the second one shows where in a 
git directory we are (empty if we're at the root).

And most of the git commands written in C (where it makes sense) can 
already handle being inside a subdirectory. So can a number of the 
shell-scripts (for example, doing a "git log" inside a subdirectory 
already does the log for just that subdirectory).

In fact, I'd prefer if _every_ command just did the right thing inside a 
subdirectory. 

I sent out this patch a week or two ago - it still applies, and it still 
mostly does the right thing. It makes at least "gitk" work right inside a 
subdirectory, and might make things like "git commit" and friends do the 
same.

More testing still needed, but I think this is going in the right 
direction.

Comments? I got none the first time around.

		Linus

----

NOTE! This has some seriously far-reaching implications. One of them is 
that a few programs will automagically start working inside some random 
directories.

And probably others won't. Instead of saying "Not a git archive", they 
might run and do strange things.

The patch is definitely a big step in the right direction: it makes the 
shell scripts that include "git-sh-setup" act a lot more like the programs 
that automatically find the git directory. But everybody that includes 
git-sh-setup should be verified.

This fixes gitk to also work the same way, btw.

---
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index dbb9884..044b0b4 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -3,7 +3,7 @@
 # Set up GIT_DIR and GIT_OBJECT_DIRECTORY
 # and return true if everything looks ok
 #
-: ${GIT_DIR=.git}
+: ${GIT_DIR=$(git-rev-parse --git-dir)} || exit
 : ${GIT_OBJECT_DIRECTORY="$GIT_DIR/objects"}
 
 # Having this variable in your environment would break scripts because
diff --git a/gitk b/gitk
index a9d37d9..a934255 100755
--- a/gitk
+++ b/gitk
@@ -12,7 +12,7 @@ proc gitdir {} {
     if {[info exists env(GIT_DIR)]} {
 	return $env(GIT_DIR)
     } else {
-	return ".git"
+	return [exec git-rev-parse --git-dir]
     }
 }
 
diff --git a/setup.c b/setup.c
index c487d7e..96085dd 100644
--- a/setup.c
+++ b/setup.c
@@ -53,11 +53,10 @@ const char **get_pathspec(const char *pr
 	const char **p;
 	int prefixlen;
 
-	if (!prefix && !entry)
-		return NULL;
-
 	if (!entry) {
 		static const char *spec[2];
+		if (!prefix || !*prefix)
+			return NULL;
 		spec[0] = prefix;
 		spec[1] = NULL;
 		return spec;
@@ -120,9 +119,19 @@ const char *setup_git_directory(void)
 
 	if (offset == len)
 		return NULL;
-
 	/* Make "offset" point to past the '/', and add a '/' at the end */
 	offset++;
+
+	/*
+	 * If we're inside the ".git" directory, we have an empty prefix
+	 */
+	if (!strncmp(cwd + offset, ".git", 4)) {
+		switch (cwd[offset+4]) {
+		case '\0': case '/':
+			return "";
+		}
+	}
+
 	cwd[len++] = '/';
 	cwd[len] = 0;
 	return cwd + offset;
