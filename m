From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to clone-pack the HEAD?
Date: Wed, 14 Dec 2005 21:29:10 -0800
Message-ID: <7vpsnzq66x.fsf@assigned-by-dhcp.cox.net>
References: <20051215004440.GM22159@pasky.or.cz>
	<7vfyovtaub.fsf@assigned-by-dhcp.cox.net>
	<20051215013201.GD10680@pasky.or.cz>
	<7vpsnzrv43.fsf@assigned-by-dhcp.cox.net>
	<7vlkynrurh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 15 06:29:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Emlg3-0007XR-Ru
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 06:29:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161118AbVLOF3N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 00:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161120AbVLOF3N
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 00:29:13 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:47256 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1161118AbVLOF3M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2005 00:29:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051215052826.EKD20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 15 Dec 2005 00:28:26 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <7vlkynrurh.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 14 Dec 2005 17:53:06 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13677>

Junio C Hamano <junkio@cox.net> writes:

> Not really.  I take this back.  What you want to do I did not
> understand well enough.
>
> HEAD is kinda special.  A hack I can think of is to do ls-remote
> first and do the guess clone-pack does for full clone case, and
> then give a specific branch name to clone.  That might work.

... and another way would be to do this; I'll put this (with
fixes if there is some needed) in "master" tonight.

Also I might want to give --keep option to fetch-pack as well;
clone-pack has some static functions that we can extract out to
a common file to link to both.

-- >8 --
Subject: [PATCH] clone-pack: make it usable for partial branch cloning.

clone-pack had some logic to accept subset of remote refs from
the command line and clone from there.  However, it was never
used in practice and its problems were not found out so far.

This commit changes the command to output the object names of
refs to the standard output instead of making a clone of the
remote repository when explicit <head> parameters are given; the
output format is the same as fetch-pack.

The traditional behaviour of cloning the whole repository by
giving no explicit <head> parameters stays the same.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 Documentation/git-clone-pack.txt |    6 +++++-
 clone-pack.c                     |   13 +++++++++++--
 2 files changed, 16 insertions(+), 3 deletions(-)

31ec6abf887ec95642cbe82fe61076e975494ab0
diff --git a/Documentation/git-clone-pack.txt b/Documentation/git-clone-pack.txt
index cfc7b62..39906fc 100644
--- a/Documentation/git-clone-pack.txt
+++ b/Documentation/git-clone-pack.txt
@@ -43,7 +43,11 @@ OPTIONS
 	The heads to update.  This is relative to $GIT_DIR
 	(e.g. "HEAD", "refs/heads/master").  When unspecified,
 	all heads are updated to match the remote repository.
-
++
+Usually all the refs from existing repository are stored
+under the same name in the new repository.  Giving explicit
+<head> arguments instead writes the object names and refs to
+the standard output, just like get-fetch-pack does.
 
 Author
 ------
diff --git a/clone-pack.c b/clone-pack.c
index a99a95c..b5ce5d3 100644
--- a/clone-pack.c
+++ b/clone-pack.c
@@ -259,8 +259,17 @@ static int clone_pack(int fd[2], int nr_
 
 	status = clone_without_unpack(fd);
 
-	if (!status)
-		write_refs(refs);
+	if (!status) {
+		if (nr_match == 0)
+			write_refs(refs);
+		else
+			while (refs) {
+				printf("%s %s\n",
+				       sha1_to_hex(refs->old_sha1),
+				       refs->name);
+				refs = refs->next;
+			}
+	}
 	return status;
 }
 
-- 
0.99.9n
