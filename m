From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/2] web--browse: use custom commands defined at config time
Date: Fri, 14 Mar 2008 05:56:49 +0100
Message-ID: <20080314055649.0bd59b47.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>,
	Xavier Maillard <xma@gnu.org>
To: Junio Hamano <junkio@cox.net>, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Mar 14 05:52:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja1th-0001Jd-OQ
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 05:52:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153AbYCNEvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 00:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbYCNEvL
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 00:51:11 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:48006 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347AbYCNEvK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 00:51:10 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 668F51AB2B5;
	Fri, 14 Mar 2008 05:51:08 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id D7B711AB2A9;
	Fri, 14 Mar 2008 05:51:07 +0100 (CET)
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77175>

This a steal from 964473a0429f625d019c69ab55644540174acf85 by
Charles Bailey.

Currently "git web--browse" is restricted to a set of commands defined
in the script. You can subvert the "browser.<tool>.path" to force "git
web--browse" to use a different command, but if you have a command
whose invocation syntax does not match one of the current tools then
you would have to write a wrapper script for it.

This patch adds a git config variable "browser.<tool>.cmd" which
allows a more flexible browser choice.

If you run "git web--browse" with -t/--tool, -b/--browser or the
"web.browser" config variable set to an unrecognized tool then "git
web--browse" will query the "browser.<tool>.cmd" config variable. If
this variable exists, then "git web--browse" will treat the specified
tool as a custom command and will use a shell eval to run the command
with the URLs added as extra parameters.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-web--browse.sh |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/git-web--browse.sh b/git-web--browse.sh
index 1023b90..384148a 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -23,12 +23,18 @@ USAGE='[--browser=browser|--tool=browser] [--config=conf.var] url/file ...'
 NONGIT_OK=Yes
 . git-sh-setup
 
+valid_custom_tool()
+{
+	browser_cmd="$(git config "browser.$1.cmd")"
+	test -n "$browser_cmd"
+}
+
 valid_tool() {
 	case "$1" in
 		firefox | iceweasel | konqueror | w3m | links | lynx | dillo | open)
 			;; # happy
 		*)
-			return 1
+			valid_custom_tool "$1" || return 1
 			;;
 	esac
 }
@@ -122,7 +128,7 @@ else
 
     init_browser_path "$browser"
 
-    if ! type "$browser_path" > /dev/null 2>&1; then
+    if test -z "$browser_cmd" && ! type "$browser_path" > /dev/null 2>&1; then
 	die "The browser $browser is not available as '$browser_path'."
     fi
 fi
@@ -157,4 +163,9 @@ case "$browser" in
     dillo)
 	"$browser_path" "$@" &
 	;;
+    *)
+	if test -n "$browser_cmd"; then
+	    ( eval $browser_cmd "$@" )
+	fi
+	;;
 esac
-- 
1.5.4.4.598.gcdb00b
