From: Sven Verdoolaege <Sven.Verdoolaege@cs.kuleuven.ac.be>
Subject: Re: cvs2git and file permissions
Date: Sun, 19 Jun 2005 00:31:15 +0200
Message-ID: <20050618223115.GA5505@billie.cs.kuleuven.ac.be>
References: <20050618205208.GA4917@billie.cs.kuleuven.ac.be> <Pine.LNX.4.58.0506181421070.2268@ppc970.osdl.org>
Reply-To: Sven Verdoolaege <skimo@liacs.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 19 00:27:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DjlmU-0002TL-PN
	for gcvg-git@gmane.org; Sun, 19 Jun 2005 00:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbVFRWcm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Jun 2005 18:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262179AbVFRWcl
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jun 2005 18:32:41 -0400
Received: from hermes2.cs.kuleuven.be ([134.58.40.2]:49809 "EHLO
	hermes2.cs.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S262177AbVFRWcO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2005 18:32:14 -0400
Received: from dr-zook2.cs.kuleuven.ac.be (dr-zook2.cs.kuleuven.be [134.58.41.21])
	by hermes2.cs.kuleuven.ac.be  with ESMTP id j5IMW3Y4012057;
	Sun, 19 Jun 2005 00:32:03 +0200
Received: from localhost (amavis@localhost [127.0.0.1])
	by dr-zook2.cs.kuleuven.ac.be (A_Good_MTA/8.13.4/Debian-3) with ESMTP id j5IMW3FB032548;
	Sun, 19 Jun 2005 00:32:03 +0200
Received: from dr-zook2.cs.kuleuven.ac.be ([127.0.0.1])
	by localhost (dr-zook2 [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 32358-02; Sun, 19 Jun 2005 00:32:01 +0200 (CEST)
Received: from iris.cs.kuleuven.ac.be (pop.cs.kuleuven.ac.be [134.58.41.11])
	by dr-zook2.cs.kuleuven.ac.be (A_Good_MTA-RX/8.13.4/Debian-3) with ESMTP id j5IMVI5W032520;
	Sun, 19 Jun 2005 00:31:18 +0200
Received: from billie.cs.kuleuven.ac.be (billie.cs.kuleuven.ac.be [134.58.41.39])
	by iris.cs.kuleuven.ac.be (A_Good_MTA/0.6.11) with ESMTP id j5IMVIl18558;
	Sun, 19 Jun 2005 00:31:18 +0200 (MEST)
Received: (from sven@localhost)
	by billie.cs.kuleuven.ac.be (A_Good_MTA/0.6.11) id j5IMVFI05735;
	Sun, 19 Jun 2005 00:31:15 +0200 (MEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506181421070.2268@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at cs.kuleuven.be
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 18, 2005 at 02:23:48PM -0700, Linus Torvalds wrote:
> On Sat, 18 Jun 2005, Sven Verdoolaege wrote:
> > 
> > Let cvs checkout in a temporary directory rather than
> > using the pipe option to avoid loss of mode information.
> 
> Hmm.. Why do you use the "-N" flag?

I didn't quite know how to interpret the "as short as possible" in

              Use the -d dir option to create a directory  called
              dir  for  the  working  files, instead of using the
              module name.  Unless you also  use  -N,  the  paths
              created under dir will be as short as possible.

It would appear you do.

> Wouldn't it be much cleaner to _not_ create all those sub-directories 
> under ".git-tmp", and instead do something like
> 
> 	"cvs -q -d %s checkout -d .git-tmp -r%s '%s/%s'" ...
> 	"mv -f .git-tmp/%s %s\n", dir ? dir+1 : name, name
> 
> With that changed (and tested ;), I'll happily take it.

Seems to work.

The rm is still needed though.  Without it, cvs can get confused.

skimo
--
git-cvs2git: propagate mode information

Let cvs checkout in a temporary directory rather than
using the pipe option to avoid loss of mode information.

Signed-off-by: Sven Verdoolaege <skimo@liacs.nl>

---
commit 188ea2ee70413147fc1b80fedc3fbee02843e590
tree f122fcf591013aff299a4d072eed47255892d3a1
parent fdf95bf8d4d1182db579bd25fe5e25811084eaa6
author Sven Verdoolaege <skimo@kotnet.org> Sat, 18 Jun 2005 23:55:49 +0200
committer Sven Verdoolaege <skimo@kotnet.org> Sat, 18 Jun 2005 23:55:49 +0200

 cvs2git.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/cvs2git.c b/cvs2git.c
--- a/cvs2git.c
+++ b/cvs2git.c
@@ -199,7 +199,10 @@ static void update_file(char *line)
 	if (dir)
 		printf("mkdir -p %.*s\n", (int)(dir - name), name);
 
-	printf("cvs -q -d %s checkout -r%s -p '%s/%s' > '%s'\n", cvsroot, version, cvsmodule, name, name);
+	printf("cvs -q -d %s checkout -d .git-tmp -r%s '%s/%s'\n", 
+		cvsroot, version, cvsmodule, name);
+	printf("mv -f .git-tmp/%s %s\n", dir ? dir+1 : name, name);
+	printf("rm -rf .git-tmp\n");
 	printf("git-update-cache --add -- '%s'\n", name);
 }
 
