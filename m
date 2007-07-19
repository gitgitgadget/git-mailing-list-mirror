From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [REVISED PATCH 1/2] filter-branch: provide the convenience functions
 also for commit filters
Date: Thu, 19 Jul 2007 02:25:17 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707190224010.14781@racer.site>
References: <Pine.LNX.4.64.0707181650080.14781@racer.site>
 <7vfy3l5jo4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 04:03:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBLMN-0008Fk-Mg
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 04:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760332AbXGSCDP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 22:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758332AbXGSCDO
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 22:03:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:36338 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758210AbXGSCDN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 22:03:13 -0400
Received: (qmail invoked by alias); 19 Jul 2007 01:25:20 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp001) with SMTP; 19 Jul 2007 03:25:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/q2z8FXyPqr998EdytlmeDpH5v7qwfv08Q9PhIlv
	dt5icbeXEqXcqG
X-X-Sender: gene099@racer.site
In-Reply-To: <7vfy3l5jo4.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52924>


By sourcing git-filter-branch and stopping after the function definitions,
the commit filter can now access the convenience functions like "map".

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Wed, 18 Jul 2007, Junio C Hamano wrote:

	> Exporting this_script variable, and changing the above to
	> 
	> 	filter_commit='SOURCE_FUNCTIONS=1 . "$this_script";'" $OPTARG"
	> 
	> to arrange the shell that is invoked with 'sh -c' to expand its 
	> value would make it smaller problem, I suspect.

	Hereby done.

	<shameless plug>rebase -i rocks</shameless>

 git-filter-branch.sh |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 0d000ed..3113937 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -8,9 +8,6 @@
 # a new branch. You can specify a number of filters to modify the commits,
 # files and trees.
 
-USAGE="git-filter-branch [-d TEMPDIR] [FILTERS] DESTBRANCH [REV-RANGE]"
-. git-sh-setup
-
 warn () {
         echo "$*" >&2
 }
@@ -69,6 +66,14 @@ set_ident () {
 	echo "[ -n \"\$GIT_${uid}_NAME\" ] || export GIT_${uid}_NAME=\"\${GIT_${uid}_EMAIL%%@*}\""
 }
 
+# This script can be sourced by the commit filter to get the functions
+test "a$SOURCE_FUNCTIONS" = a1 && return
+this_script="$(cd "$(dirname "$0")"; pwd)"/$(basename "$0")
+export this_script
+
+USAGE="git-filter-branch [-d TEMPDIR] [FILTERS] DESTBRANCH [REV-RANGE]"
+. git-sh-setup
+
 tempdir=.git-rewrite
 filter_env=
 filter_tree=
@@ -118,7 +123,7 @@ do
 		filter_msg="$OPTARG"
 		;;
 	--commit-filter)
-		filter_commit="$OPTARG"
+		filter_commit='SOURCE_FUNCTIONS=1 . "$this_script";'" $OPTARG"
 		;;
 	--tag-name-filter)
 		filter_tag_name="$OPTARG"
-- 
1.5.3.rc1.16.g9d6f-dirty
