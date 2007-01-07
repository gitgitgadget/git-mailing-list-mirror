From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-fetch: allow updating the current branch in a bare repository.
Date: Sun, 07 Jan 2007 02:19:28 -0800
Message-ID: <7vy7of16mn.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vbqlb2nqe.fsf@assigned-by-dhcp.cox.net>
	<20070107093725.GB10351@spearce.org>
	<7v4pr32mcn.fsf@assigned-by-dhcp.cox.net>
	<20070107100559.GC10351@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 11:19:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3V7l-0004G0-9z
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 11:19:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbXAGKTb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 05:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932469AbXAGKTa
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 05:19:30 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:46797 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932472AbXAGKTa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 05:19:30 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070107101929.WUUK25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Sun, 7 Jan 2007 05:19:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8AKk1W00H1kojtg0000000; Sun, 07 Jan 2007 05:19:45 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070107100559.GC10351@spearce.org> (Shawn O. Pearce's message
	of "Sun, 7 Jan 2007 05:05:59 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36148>

Sometimes, people have only fetch access into a bare repository
that is used as a back-up location (or a distribution point) but
does not have a push access for networking reasons, e.g. one end
being behind a firewall, and updating the "current branch" in
such a case is perfectly fine.

This allows such a fetch without --update-head-ok, which is a
flag that should never be used by end users otherwise.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 "Shawn O. Pearce" <spearce@spearce.org> writes:

 > Junio C Hamano <junkio@cox.net> wrote:
 >> ...
 >> Here is what I have as a follow-up patch to the one you are
 >> responding to.
 >
 > I like.  :-)
 >
 > Worthy of 1.5.0 me thinks.

 And here is an example of what you would do in the scripts.

 git-fetch.sh    |    9 +++++----
 git-sh-setup.sh |    8 ++++++++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/git-fetch.sh b/git-fetch.sh
index 466fe59..c58704d 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -231,11 +231,12 @@ update_local_ref () {
     esac
 }
 
-case "$update_head_ok" in
-'')
+# updating the current HEAD with git-fetch in a bare
+# repository is always fine.
+if test -z "$update_head_ok" && test $(is_bare_repository) = false
+then
 	orig_head=$(git-rev-parse --verify HEAD 2>/dev/null)
-	;;
-esac
+fi
 
 # If --tags (and later --heads or --all) is specified, then we are
 # not talking about defaults stored in Pull: line of remotes or
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 87b939c..7fdc912 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -28,6 +28,14 @@ set_reflog_action() {
 	fi
 }
 
+is_bare_repository () {
+	git-repo-config --bool --get core.bare ||
+	case "$GIT_DIR" in
+	.git | */.git) echo false ;;
+	*) echo true ;;
+	esac
+}
+
 if [ -z "$LONG_USAGE" ]
 then
 	LONG_USAGE="Usage: $0 $USAGE"
