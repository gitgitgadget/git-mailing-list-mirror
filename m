From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git status and commit from subdirectory?
Date: Tue, 25 Oct 2005 17:16:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510251644090.10477@g5.osdl.org>
References: <Pine.LNX.4.64.0510251735500.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 02:17:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUYyd-0002Qh-51
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 02:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbVJZARH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 20:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbVJZARH
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 20:17:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55760 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932493AbVJZARG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2005 20:17:06 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9Q0H1FC028457
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 25 Oct 2005 17:17:02 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9Q0GvKI006395;
	Tue, 25 Oct 2005 17:16:59 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0510251735500.25300@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10641>



On Tue, 25 Oct 2005, Daniel Barkalow wrote:
>
> It seems like everything that "git status" does can now be done from a 
> subdirectory (giving, of course, the status of the contents of the 
> subdirectory). I think the same might be true of "git commit", but I 
> haven't checked on everything. Is there anything that has to be done to 
> enable this properly other than removing the "|| die" part of the first 
> line?

This patch _may_ work. I've not tested it a lot. Surprise surprise.

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

Testing needed. Lots of it.

		Linus

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
