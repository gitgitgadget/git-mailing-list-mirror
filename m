From: Sven Verdoolaege <skimo@liacs.nl>
Subject: [PATCH] git-ssh-pull: commit-id consistency
Date: Mon, 27 Jun 2005 21:03:07 +0200
Message-ID: <20050627210307.A3189@tin.liacs.nl>
References: <20050626214547.A29432@tin.liacs.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 27 21:00:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DmypD-0000jg-0j
	for gcvg-git@gmane.org; Mon, 27 Jun 2005 20:59:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbVF0TFw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Jun 2005 15:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbVF0TE2
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jun 2005 15:04:28 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:18048 "EHLO rhodium.liacs.nl")
	by vger.kernel.org with ESMTP id S261434AbVF0TD6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jun 2005 15:03:58 -0400
Received: from tin.liacs.nl (tin.liacs.nl [132.229.44.20])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id j5RJ379h023158;
	Mon, 27 Jun 2005 21:03:12 +0200
Received: (from sverdool@localhost)
	by tin.liacs.nl (8.11.6/8.9.3) id j5RJ38t03197;
	Mon, 27 Jun 2005 21:03:08 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050626214547.A29432@tin.liacs.nl>; from skimo@liacs.nl on Sun, Jun 26, 2005 at 09:45:47PM +0200
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

As requested by Daniel, this new version leaves *-pull alone
and only changes the behaviour of git-ssh-push.

skimo
--
In contrast to other plumbing tools, git-ssh-push only
allow a very restrictive form of commit-id filenames.
This patch removes this restriction.

Acked-by: Daniel Barkalow <barkalow@iabervon.org>
Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>

---
commit 28ec093e92206cd907249e741ca1d19f14da4cf3
tree 5ad7b33ec80c2c04272cb0abd4531e1d9abfbbe1
parent e18088451d92fbf83bfb57fd48201eda117f8103
author Sven Verdoolaege <skimo@kotnet.org> Mon, 27 Jun 2005 20:12:40 +0200
committer Sven Verdoolaege <skimo@kotnet.org> Mon, 27 Jun 2005 20:12:40 +0200

 Documentation/git-ssh-push.txt |    2 +-
 ssh-push.c                     |   18 ++++++++++++++----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-ssh-push.txt b/Documentation/git-ssh-push.txt
--- a/Documentation/git-ssh-push.txt
+++ b/Documentation/git-ssh-push.txt
@@ -20,7 +20,7 @@ git-ssh-pull, aside from which end you r
 OPTIONS
 -------
 commit-id::
-        Either the hash or the filename under $GIT_DIR/refs/ to push.
+        Id of commit to push.
 
 -c::
         Get the commit objects.
diff --git a/ssh-push.c b/ssh-push.c
--- a/ssh-push.c
+++ b/ssh-push.c
@@ -2,6 +2,8 @@
 #include "rsh.h"
 #include "refs.h"
 
+#include <string.h>
+
 unsigned char local_version = 1;
 unsigned char remote_version = 0;
 
@@ -103,6 +105,9 @@ void service(int fd_in, int fd_out) {
 	} while (1);
 }
 
+static const char *ssh_push_usage =
+	"git-ssh-push [-c] [-t] [-a] [-w ref] commit-id url";
+
 int main(int argc, char **argv)
 {
 	int arg = 1;
@@ -110,18 +115,23 @@ int main(int argc, char **argv)
         char *url;
 	int fd_in, fd_out;
 	const char *prog = getenv("GIT_SSH_PULL") ? : "git-ssh-pull";
+	unsigned char sha1[20];
+	char hex[41];
 
 	while (arg < argc && argv[arg][0] == '-') {
 		if (argv[arg][1] == 'w')
 			arg++;
                 arg++;
         }
-        if (argc < arg + 2) {
-		usage("git-ssh-push [-c] [-t] [-a] [-w ref] commit-id url");
-                return 1;
-        }
+	if (argc < arg + 2)
+		usage(ssh_push_usage);
 	commit_id = argv[arg];
 	url = argv[arg + 1];
+	if (get_sha1(commit_id, sha1))
+		usage(ssh_push_usage);
+	memcpy(hex, sha1_to_hex(sha1), sizeof(hex));
+	argv[arg] = hex;
+
 	if (setup_connection(&fd_in, &fd_out, prog, url, arg, argv + 1))
 		return 1;
 
