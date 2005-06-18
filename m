From: Sven Verdoolaege <Sven.Verdoolaege@cs.kuleuven.ac.be>
Subject: cvs2git and file permissions
Date: Sat, 18 Jun 2005 22:52:08 +0200
Message-ID: <20050618205208.GA4917@billie.cs.kuleuven.ac.be>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jun 18 22:48:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DjkET-000313-88
	for gcvg-git@gmane.org; Sat, 18 Jun 2005 22:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262200AbVFRUx0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Jun 2005 16:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbVFRUx0
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jun 2005 16:53:26 -0400
Received: from mailrelay2.cs.kuleuven.be ([134.58.40.2]:10639 "EHLO
	hermes2.cs.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S262200AbVFRUxR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2005 16:53:17 -0400
Received: from dr-zook2.cs.kuleuven.ac.be (dr-zook2.cs.kuleuven.be [134.58.41.21])
	by hermes2.cs.kuleuven.ac.be  with ESMTP id j5IKr5Sw010967;
	Sat, 18 Jun 2005 22:53:05 +0200
Received: from localhost (amavis@localhost [127.0.0.1])
	by dr-zook2.cs.kuleuven.ac.be (A_Good_MTA/8.13.4/Debian-3) with ESMTP id j5IKr5AY028829;
	Sat, 18 Jun 2005 22:53:05 +0200
Received: from dr-zook2.cs.kuleuven.ac.be ([127.0.0.1])
	by localhost (dr-zook2 [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 28616-05; Sat, 18 Jun 2005 22:53:01 +0200 (CEST)
Received: from iris.cs.kuleuven.ac.be (pop.cs.kuleuven.ac.be [134.58.41.11])
	by dr-zook2.cs.kuleuven.ac.be (A_Good_MTA-RX/8.13.4/Debian-3) with ESMTP id j5IKqATt028792;
	Sat, 18 Jun 2005 22:52:10 +0200
Received: from billie.cs.kuleuven.ac.be (billie.cs.kuleuven.ac.be [134.58.41.39])
	by iris.cs.kuleuven.ac.be (A_Good_MTA/0.6.11) with ESMTP id j5IKq9l12203;
	Sat, 18 Jun 2005 22:52:09 +0200 (MEST)
Received: (from sven@localhost)
	by billie.cs.kuleuven.ac.be (A_Good_MTA/0.6.11) id j5IKq8K04931;
	Sat, 18 Jun 2005 22:52:08 +0200 (MEST)
To: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at cs.kuleuven.be
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

cvs2git currently drops mode information.
I've been bitten by this behaviour twice already.
The patch below fixes that, though not very cleanly.

skimo
--
git-cvs2git: propagate mode information

Let cvs checkout in a temporary directory rather than
using the pipe option to avoid loss of mode information.

Signed-off-by: Sven Verdoolaege <skimo@liacs.nl>

---
commit df97fd9b709bd927f15adbc1a90ddfcfa79c7895
tree 0f223f52fdf7d61d7d1df0da1137a542811d27f9
parent fdf95bf8d4d1182db579bd25fe5e25811084eaa6
author Sven Verdoolaege <skimo@kotnet.org> Sat, 18 Jun 2005 22:41:46 +0200
committer Sven Verdoolaege <skimo@kotnet.org> Sat, 18 Jun 2005 22:41:46 +0200

 cvs2git.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/cvs2git.c b/cvs2git.c
--- a/cvs2git.c
+++ b/cvs2git.c
@@ -196,10 +196,15 @@ static void update_file(char *line)
 	}
 
 	dir = strrchr(name, '/');
-	if (dir)
+	if (dir) {
 		printf("mkdir -p %.*s\n", (int)(dir - name), name);
+		printf("mkdir -p .git-tmp/%.*s\n", (int)(dir - name), name);
+	}
 
-	printf("cvs -q -d %s checkout -r%s -p '%s/%s' > '%s'\n", cvsroot, version, cvsmodule, name, name);
+	printf("cvs -q -d %s checkout -N -d .git-tmp -r%s '%s/%s'\n", 
+		cvsroot, version, cvsmodule, name);
+	printf("mv -f .git-tmp/%s/%s %s\n", cvsmodule, name, name);
+	printf("rm -rf .git-tmp\n");
 	printf("git-update-cache --add -- '%s'\n", name);
 }
 
