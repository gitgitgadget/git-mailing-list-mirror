From: Junio C Hamano <junkio@cox.net>
Subject: Re: Bootstrapping into git, commit gripes at me
Date: Mon, 11 Jul 2005 16:15:31 -0700
Message-ID: <7v8y0dndd8.fsf@assigned-by-dhcp.cox.net>
References: <20050708230750.GA23847@buici.com>
	<Pine.LNX.4.58.0507081842550.17536@g5.osdl.org>
	<20050711222046.GA21376@buici.com>
	<7vll4dndwu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Singer <elf@buici.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 01:21:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds7Zi-0004Qx-AS
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 01:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbVGKXTw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 19:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbVGKXSb
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 19:18:31 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:63978 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261818AbVGKXPi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 19:15:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050711231532.BGJX17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 11 Jul 2005 19:15:32 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vll4dndwu.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Mon, 11 Jul 2005 16:03:45 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

>
>  - git-commit-tree says check_valid("commit") and barfs.
>
> My current preference is to keep .git/refs/heads tag free.  At
> least, I do not think we should ever write non commits to
> .git/*_HEAD.
>
> What do you think?  An alternative would be to allow tags
> (recursively) pointing at a commit as a commit parent, but I do
> not think we would want to go that route.

Or, just dereferencing tags for commit parents in commit-tree
would be fine as well.

------------
Dereference tags given as commit-tree -p parameters.

Marc Singer noticed that when he has a tag instead of a commit
in his .git/HEAD (this happens after git checkout -f <tag>), git
commit barfs.  This patch makes commit-tree dereference tags
like everybody else does.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

cd /opt/packrat/playpen/public/in-place/git/git.junio/
jit-diff
# - master: [PATCH] git-cvsimport-script: add "import only" option
# + (working tree)
diff --git a/commit-tree.c b/commit-tree.c
--- a/commit-tree.c
+++ b/commit-tree.c
@@ -8,6 +8,7 @@
 #include <pwd.h>
 #include <time.h>
 #include <ctype.h>
+#include "commit.h"
 
 #define BLOCKING (1ul << 14)
 
@@ -133,10 +134,14 @@ int main(int argc, char **argv)
 	check_valid(tree_sha1, "tree");
 	for (i = 2; i < argc; i += 2) {
 		char *a, *b;
+		struct commit *commit;
 		a = argv[i]; b = argv[i+1];
 		if (!b || strcmp(a, "-p") || get_sha1(b, parent_sha1[parents]))
 			usage(commit_tree_usage);
-		check_valid(parent_sha1[parents], "commit");
+		commit = lookup_commit_reference(parent_sha1[parents]);
+		if (!commit)
+			usage(commit_tree_usage);
+		memcpy(parent_sha1[parents], commit->object.sha1, 20);
 		if (new_parent(parents))
 			parents++;
 	}

Compilation finished at Mon Jul 11 16:12:36
