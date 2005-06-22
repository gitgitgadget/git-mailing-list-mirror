From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] local-pull: implement fetch_ref()
Date: Wed, 22 Jun 2005 01:52:06 -0700
Message-ID: <7v8y12ixjd.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.21.0506212043540.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jun 22 10:55:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dl10w-0001dx-Jj
	for gcvg-git@gmane.org; Wed, 22 Jun 2005 10:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262881AbVFVI7v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Jun 2005 04:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbVFVI6k
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jun 2005 04:58:40 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:53444 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S262843AbVFVIwM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2005 04:52:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050622085206.EZUF12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 22 Jun 2005 04:52:06 -0400
To: Linus Torvalds <torvalds@osdl.org>
cc: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0506212043540.30848-100000@iabervon.org> (Daniel
 Barkalow's message of "Tue, 21 Jun 2005 20:45:49 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This makes "-w ref" usable for git-local-pull.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Documentation/git-local-pull.txt |    7 +++++--
 local-pull.c                     |   31 ++++++++++++++++++++++++++++---
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-local-pull.txt b/Documentation/git-local-pull.txt
--- a/Documentation/git-local-pull.txt
+++ b/Documentation/git-local-pull.txt
@@ -9,7 +9,7 @@ git-local-pull - Duplicates another GIT 
 
 SYNOPSIS
 --------
-'git-local-pull' [-c] [-t] [-a] [-l] [-s] [-n] [-v] [-d] [--recover] commit-id path
+'git-local-pull' [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] [-l] [-s] [-n] commit-id path
 
 DESCRIPTION
 -----------
@@ -32,10 +32,13 @@ OPTIONS
 	usual, to recover after earlier pull that was interrupted.
 -v::
 	Report what is downloaded.
+-w::
+        Writes the commit-id into the filename under $GIT_DIR/refs/ on
+        the local end after the transfer is complete.
 
 Author
 ------
-Written by Linus Torvalds <torvalds@osdl.org>
+Written by Junio C Hamano <junkio@cox.net>
 
 Documentation
 --------------
diff --git a/local-pull.c b/local-pull.c
--- a/local-pull.c
+++ b/local-pull.c
@@ -9,7 +9,7 @@ static int use_link = 0;
 static int use_symlink = 0;
 static int use_filecopy = 1;
 
-static char *path;
+static char *path; /* "Remote" git repository */
 
 int fetch(unsigned char *sha1)
 {
@@ -75,11 +75,34 @@ int fetch(unsigned char *sha1)
 
 int fetch_ref(char *ref, unsigned char *sha1)
 {
-	return -1;
+	static int ref_name_start = -1;
+	static char filename[PATH_MAX];
+	static char hex[41];
+	int ifd;
+
+	if (ref_name_start < 0) {
+		sprintf(filename, "%s/refs/", path);
+		ref_name_start = strlen(filename);
+	}
+	strcpy(filename + ref_name_start, ref);
+	ifd = open(filename, O_RDONLY);
+	if (ifd < 0) {
+		close(ifd);
+		fprintf(stderr, "cannot open %s\n", filename);
+		return -1;
+	}
+	if (read(ifd, hex, 40) != 40 || get_sha1_hex(hex, sha1)) {
+		close(ifd);
+		fprintf(stderr, "cannot read from %s\n", filename);
+		return -1;
+	}
+	close(ifd);
+	pull_say("ref %s\n", sha1_to_hex(sha1));
+	return 0;
 }
 
 static const char *local_pull_usage = 
-"git-local-pull [-c] [-t] [-a] [-l] [-s] [-n] [-v] [-d] [--recover] commit-id path";
+"git-local-pull [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] [-l] [-s] [-n] commit-id path";
 
 /* 
  * By default we only use file copy.
@@ -114,6 +137,8 @@ int main(int argc, char **argv)
 			use_filecopy = 0;
 		else if (argv[arg][1] == 'v')
 			get_verbosely = 1;
+		else if (argv[arg][1] == 'w')
+			write_ref = argv[++arg];
 		else
 			usage(local_pull_usage);
 		arg++;
------------------------------------------------

