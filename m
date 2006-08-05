From: Jeff King <peff@peff.net>
Subject: [PATCH] git-status: support always/auto/never in colorization
Date: Sat, 5 Aug 2006 19:57:56 -0400
Message-ID: <20060805235756.GA15075@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 06 01:58:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9W1p-000166-Fw
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 01:58:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWHEX57 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 19:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbWHEX56
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 19:57:58 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:28106 "HELO
	peff.net") by vger.kernel.org with SMTP id S1750760AbWHEX56 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Aug 2006 19:57:58 -0400
Received: (qmail 21052 invoked from network); 5 Aug 2006 19:57:23 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 5 Aug 2006 19:57:23 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat,  5 Aug 2006 19:57:56 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24942>

Signed-off-by: Jeff King <peff@peff.net>
---
This is on top of the previous two patches:
    git-status: colorize status output (me)
    git-status: do not use colors all the time (Matthias)

I was hoping to join the term selection logic with the diff.color logic
in git_config_termbool or similar (and a git-repo-config --termbool),
but unfortunately that doesn't work since git-repo-config can't do an
isatty test (since we call it as `git-repo-config`). In general, config
parsing is a little awkward (and inefficient) in sh. Is there any
interest in me converting git-commit/git-status to C builtins (I know
Johannes will be happy...)?

 Documentation/config.txt |    4 +++-
 git-commit.sh            |   13 ++++++++-----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 83f4627..43766bd 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -224,7 +224,9 @@ showbranch.default::
 
 status.color::
 	A boolean to enable/disable color in the output of
-	gitlink:git-status[1]. Defaults to false.
+	gitlink:git-status[1]. May be set to `true` (or `always`),
+	`false` (or `never`) or `auto`, in which case colors are used
+	only when the output is to a terminal. Defaults to false.
 
 status.color.<slot>::
 	Use customized color for status colorization. `<slot>` is
diff --git a/git-commit.sh b/git-commit.sh
index ad0cbb1..2ab1974 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -20,11 +20,14 @@ case "$0" in
 *status)
 	status_only=t
 	unmerged_ok_if_status=--unmerged
-	[ "`git-repo-config --bool --get status.color`" = 'true' ] &&
-		([ -t 1 ] || (
-			[ -n "$GIT_PAGER_IN_USE" ] &&
-			[ "`git-repo-config --bool --get pager.color`" != 'false' ]
-		)) && color=true
+	case "`git-repo-config --get status.color`" in
+	  always) color=true ;;
+	  never ) color=false ;;
+	  auto  ) test -t 1 -o \( -n "$GIT_PAGER_IN_USE" -a \
+		     "`git-repo-config --bool --get pager.color`" != false \) \
+		  && color=true ;;
+	  *     ) color="`git-repo-config --bool --get status.color`" ;;
+	esac
 	eval `git-repo-config --get-regexp status.color. \
 	      | while read k v; do
 	          echo color_${k#status.color.}=$v
-- 
1.4.2.rc3.gf3bd-dirty
