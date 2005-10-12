From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Refuse to create funny refs in clone-pack, git-fetch and receive-pack.
Date: Wed, 12 Oct 2005 15:01:46 -0700
Message-ID: <7vzmpebdit.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90510062014l7f5740e0l77fc53b50f822e8f@mail.gmail.com>
	<46a038f90510082014i6b296f2bvbac56e25344cbdf2@mail.gmail.com>
	<4349ED5D.6020703@catalyst.net.nz>
	<7v4q7p927d.fsf@assigned-by-dhcp.cox.net>
	<7vzmpgznfj.fsf_-_@assigned-by-dhcp.cox.net>
	<7virw4zlod.fsf_-_@assigned-by-dhcp.cox.net>
	<7vzmpgy4g4.fsf@assigned-by-dhcp.cox.net>
	<7vk6gjl2uu.fsf@assigned-by-dhcp.cox.net> <434D2D8F.2020407@zytor.com>
	<7v4q7mip30.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Oct 13 00:03:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPofa-0000yr-VP
	for gcvg-git@gmane.org; Thu, 13 Oct 2005 00:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbVJLWBt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 18:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbVJLWBt
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 18:01:49 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:64729 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932468AbVJLWBs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2005 18:01:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051012220148.WUDE9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 12 Oct 2005 18:01:48 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10054>

Using git-check-ref-format, make sure we do not create refs with
funny names when cloning from elsewhere (clone-pack), fast forwarding
local heads (git-fetch), or somebody pushes into us (receive-pack).

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * This is the second installment.  Cloning over HTTP uses the
   commit walker '-w' ref updates, and should already be covered
   by the previous "check_ref_format()" updates.

 clone-pack.c        |    6 ++++++
 git-parse-remote.sh |    6 ++++++
 receive-pack.c      |    4 ++++
 3 files changed, 16 insertions(+), 0 deletions(-)

applies-to: 409fe70483c97167e9b7d396334ec5f96932694d
8da42e4b3363de13ede2f006ad96ee8268e52250
diff --git a/clone-pack.c b/clone-pack.c
index c102ca8..48bee96 100644
--- a/clone-pack.c
+++ b/clone-pack.c
@@ -34,6 +34,12 @@ static void write_one_ref(struct ref *re
 	int fd;
 	char *hex;
 
+	if (!strncmp(ref->name, "refs/", 5) &&
+	    check_ref_format(ref->name + 5)) {
+		error("refusing to create funny ref '%s' locally", ref->name);
+		return;
+	}
+
 	if (safe_create_leading_directories(path))
 		die("unable to create leading directory for %s", ref->name);
 	fd = open(path, O_CREAT | O_EXCL | O_WRONLY, 0666);
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 5e75e15..aea7b0e 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -94,6 +94,12 @@ canon_refs_list_for_fetch () {
 		heads/* | tags/* ) local="refs/$local" ;;
 		*) local="refs/heads/$local" ;;
 		esac
+
+		if local_ref_name=$(expr "$local" : 'refs/\(.*\)')
+		then
+		   git-check-ref-format "$local_ref_name" ||
+		   die "* refusing to create funny ref '$local_ref_name' locally"
+		fi
 		echo "${dot_prefix}${force}${remote}:${local}"
 		dot_prefix=.
 	done
diff --git a/receive-pack.c b/receive-pack.c
index 06857eb..8f157bc 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -95,6 +95,10 @@ static int update(const char *name,
 	char new_hex[60], *old_hex, *lock_name;
 	int newfd, namelen, written;
 
+	if (!strncmp(name, "refs/", 5) && check_ref_format(name + 5))
+		return error("refusing to create funny ref '%s' locally",
+			     name);
+
 	namelen = strlen(name);
 	lock_name = xmalloc(namelen + 10);
 	memcpy(lock_name, name, namelen);
---
0.99.8.GIT
