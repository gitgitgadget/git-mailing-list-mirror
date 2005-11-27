From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/8] git-apply: work from subdirectory.
Date: Sat, 26 Nov 2005 20:06:41 -0800
Message-ID: <7v4q5yohta.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0511221854120.27872@wbgn013.biozentrum.uni-wuerzburg.de>
	<438371E8.2030701@op5.se>
	<Pine.LNX.4.63.0511231553390.8191@wbgn013.biozentrum.uni-wuerzburg.de>
	<7viruj3q7z.fsf@assigned-by-dhcp.cox.net> <4384FB61.40506@op5.se>
	<Pine.LNX.4.63.0511240042350.11106@wbgn013.biozentrum.uni-wuerzburg.de>
	<43857430.7060103@op5.se> <7vsltmwiky.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511241127020.12985@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v8xveth4l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511241419390.14297@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vmzjtn3h1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511242252080.26485@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vy83cdu7r.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511251953081.13959@g5.osdl.org>
	<7voe477n4i.fsf_-_@assigned-by-dhcp.c
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 27 05:07:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgDoz-0007rX-Qf
	for gcvg-git@gmane.org; Sun, 27 Nov 2005 05:07:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbVK0EGo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Nov 2005 23:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbVK0EGo
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Nov 2005 23:06:44 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:48112 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750833AbVK0EGn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Nov 2005 23:06:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051127040516.OSYA17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 26 Nov 2005 23:05:16 -0500
To: Linus Torvalds <torvalds@osdl.org>
cc: larsi+gmane@gnus.org
In-Reply-To: <Pine.LNX.4.64.0511260932080.13959@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 26 Nov 2005 09:36:21 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12795>

Linus Torvalds <torvalds@osdl.org> writes:

> This breaks git-apply when used to just do a "diffstat", or
> when used on a non-git repository.

You are right.  Something like this?


An off-topic note (that's why this message is CC'd to larsi).
People may notice messages in this thread have accumulated a
modest number of References: entries.  I read git list via
new.gmane.org NNTP server (running fetchnews locally to slurp
from there) and noticed droppage on my end --- whose cause turns
out to be that gmane NNTP server chops References: entries in
the middle and fetchnews rejects such messages, and I am sure I
am _not_ going to see this message on my local machine.  Has
anybody else noticed this problem?

-- >8 --
[PATCH] apply: only do GIT_DIR discovery when running with --index.
    
It does not have to be run in git repository unless we are
applying or checking the patch to the index file.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff --git a/apply.c b/apply.c
index ae06d41..1742ab2 100644
--- a/apply.c
+++ b/apply.c
@@ -17,7 +17,7 @@
 //  --index-info shows the old and new index info for paths if available.
 //
 static const char *prefix;
-static int prefix_length;
+static int prefix_length = -1;
 
 static int allow_binary_replacement = 0;
 static int check_index = 0;
@@ -1709,7 +1709,7 @@ static int use_patch(struct patch *p)
 			return 0;
 		x = x->next;
 	}
-	if (prefix && *prefix) {
+	if (0 < prefix_length) {
 		int pathlen = strlen(pathname);
 		if (pathlen <= prefix_length ||
 		    memcmp(prefix, pathname, prefix_length))
@@ -1793,10 +1793,6 @@ int main(int argc, char **argv)
 	int i;
 	int read_stdin = 1;
 
-	prefix = setup_git_directory();
-	prefix_length = prefix ? strlen(prefix) : 0;
-	git_config(git_default_config);
-
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		int fd;
@@ -1858,7 +1854,14 @@ int main(int argc, char **argv)
 			line_termination = 0;
 			continue;
 		}
-		arg = prefix_filename(prefix, prefix_length, arg);
+
+		if (check_index && prefix_length < 0) {
+			prefix = setup_git_directory();
+			prefix_length = prefix ? strlen(prefix) : 0;
+			git_config(git_default_config);
+		}
+		if (0 < prefix_length)
+			arg = prefix_filename(prefix, prefix_length, arg);
 
 		fd = open(arg, O_RDONLY);
 		if (fd < 0)
