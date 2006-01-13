From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-push: avoid falling back on pushing "matching" refs.
Date: Thu, 12 Jan 2006 17:54:55 -0800
Message-ID: <7v1wzcj3io.fsf@assigned-by-dhcp.cox.net>
References: <7vslrtq05h.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0601121006040.3535@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 02:55:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExE9d-0004T5-Pk
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 02:55:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161445AbWAMBy5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 20:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161635AbWAMBy5
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 20:54:57 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:45733 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1161445AbWAMBy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 20:54:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060113015406.OPIQ3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 12 Jan 2006 20:54:06 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14596>

Linus Torvalds <torvalds@osdl.org> writes:

> Having to list all tags/branches is slightly painful. I currently push out 
> all my tags with
>
> 	./push-all $(cd .git/refs ; find -type f tags)
>
> which works but isn't exactly user-friendly ("push-all" is just a script 
> that uses "git push" to push to multiple repositories).

So here it is, to add --tags and avoid falling back to
"matching" default.

-- >8 --
The underlying "git send-pack remote.host:path" pushes all the
matching refs that both local and remote have, and "git push"
blindly inherits this property.  Which probably was a mistake.

A typical cloned repository (e.g. a subsystem repository cloned
from Linus repository) has at least two branches, "master" to
keep the subsystem and "origin" that records tip of Linus
"master" when the repository was cloned.  If this is the public
repository for the subsystem, then subsystem developers would
clone it, and then cloned ones have "master" and "origin".  When
developers use this public subsystem repository as a shared
repository, pushing into it via "git push subsys:/path/name"
would try to push the matching refs, "master" and "origin", from
the developers' repositories.  The "origin" in the public shared
repository does not have much relevance, yet pushing into
"origin" would cause "not a fast forward" checks to be
triggered.  Arguably "git push subsys:/path/name master" would
work it around, but having them to say it explicitly to avoid
pushing into "origin" as well is bad.

This commit requires you to give at least one refspec to
git-push.  You could "give" by either:

 (1) Listing the refspec(s) explicitly on the command line.
     E.g. "git push subsys:/path/name master".

 (2) Using --all or --tags on the command line.
     E.g. "git push --tags subsys:/path/name".

 (3) Using a $GIT_DIR/remotes shorthand with 'Push: refspec'
     line in it.

Unlike pull that can happen pretty much promiscuously, people
will push into the same set of a limited number of remote
repositories repeatedly over the life of the project, so it is
reasonable to assume they would want to keep a $GIT_DIR/remotes/
entry for those repositories even only to save typing the URL,
so keeping the default 'Push: refspec' line in such is a
sensible thing to do.

It was suggested to further fall back on pushing the current
branch, but this commit does not implement it.  If developers
adopt topic branch workflow, pushing to public while on a topic
branch by mistake would expose the topic branch to the public
repository.  Not falling back to the current branch prevents
that mistake from happening.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-push.sh |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

85393139981c28a2df93950b00e4712dc4bca56c
diff --git a/git-push.sh b/git-push.sh
index 1c5cf80..2b97e09 100755
--- a/git-push.sh
+++ b/git-push.sh
@@ -9,12 +9,15 @@ has_all=
 has_force=
 has_exec=
 remote=
+do_tags=
 
 while case "$#" in 0) break ;; esac
 do
 	case "$1" in
 	--all)
 		has_all=--all ;;
+	--tags)
+		do_tags=yes ;;
 	--force)
 		has_force=--force ;;
 	--exec=*)
@@ -33,6 +36,10 @@ case "$#" in
 	echo "Where would you want to push today?"
         usage ;;
 esac
+if test ",$has_all,$do_tags," = ",--all,yes,"
+then
+	do_tags=
+fi
 
 . git-parse-remote
 remote=$(get_remote_url "$@")
@@ -42,6 +49,20 @@ case "$has_all" in
 esac
 shift
 
+case "$do_tags" in
+yes)
+	set "$@" $(cd "$GIT_DIR/refs" && find tags -type f -print) ;;
+esac
+
+# Now we have explicit refs from the command line or from remotes/
+# shorthand, or --tags.  Falling back on the current branch if we still
+# do not have any may be an alternative, but prevent mistakes for now.
+
+case "$#,$has_all" in
+0,)
+	die "No refs given to be pushed." ;;
+esac
+
 case "$remote" in
 git://*)
 	die "Cannot use READ-ONLY transport to push to $remote" ;;
-- 
1.1.1-g6009
