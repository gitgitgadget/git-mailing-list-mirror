From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] tar-tree: file/dirmode fix.
Date: Fri, 03 Mar 2006 21:35:05 -0800
Message-ID: <7vy7zqvkl2.fsf@assigned-by-dhcp.cox.net>
References: <1141446331.3171.4.camel@mattlaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt McCutchen <hashproduct@verizon.net>
X-From: git-owner@vger.kernel.org Sat Mar 04 06:35:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFPQ8-0002NS-Tm
	for gcvg-git@gmane.org; Sat, 04 Mar 2006 06:35:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbWCDFfI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Mar 2006 00:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbWCDFfI
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Mar 2006 00:35:08 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:22403 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751002AbWCDFfG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Mar 2006 00:35:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060304053203.NHUU26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 4 Mar 2006 00:32:03 -0500
To: git@vger.kernel.org
In-Reply-To: <1141446331.3171.4.camel@mattlaptop> (Matt McCutchen's message of
	"Fri, 03 Mar 2006 23:25:31 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17173>

This fixes two bugs introduced when we switched to generic tree
traversal code.

 (1) directory mode recorded silently became 0755, not 0777

 (2) if passed a tree object (not a commit), it emitted an
     alarming error message (but proceeded anyway).

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 tar-tree.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

815afaf1bd0ddf419231d2d9f129260ce1ddbecc
diff --git a/tar-tree.c b/tar-tree.c
index e85a1ed..e478e13 100644
--- a/tar-tree.c
+++ b/tar-tree.c
@@ -304,9 +304,11 @@ static void write_header(const unsigned 
 	}
 
 	if (S_ISDIR(mode))
-		mode |= 0755;	/* GIT doesn't store permissions of dirs */
-	if (S_ISLNK(mode))
-		mode |= 0777;   /* ... nor of symlinks */
+		mode |= 0777;
+	else if (S_ISREG(mode))
+		mode |= (mode & 0100) ? 0777 : 0666;
+	else if (S_ISLNK(mode))
+		mode |= 0777;
 	sprintf(&header[100], "%07o", mode & 07777);
 
 	/* XXX: should we provide more meaningful info here? */
@@ -391,7 +393,7 @@ int main(int argc, char **argv)
 		usage(tar_tree_usage);
 	}
 
-	commit = lookup_commit_reference(sha1);
+	commit = lookup_commit_reference_gently(sha1, 1);
 	if (commit) {
 		write_global_extended_header(commit->object.sha1);
 		archive_time = commit->date;
-- 
1.2.4.gfe04
