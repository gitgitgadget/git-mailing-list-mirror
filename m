From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/4] help--browse: add '--config' option to check a config
 option for a browser.
Date: Sat, 2 Feb 2008 07:32:41 +0100
Message-ID: <20080202073241.925461ec.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Feb 02 07:27:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLBqN-0000my-QK
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 07:27:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755075AbYBBG0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 01:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755045AbYBBG0o
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 01:26:44 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:54010 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751342AbYBBG0i (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 01:26:38 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 0BBDD1AB2C1;
	Sat,  2 Feb 2008 07:26:37 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id C047A1AB2B4;
	Sat,  2 Feb 2008 07:26:36 +0100 (CET)
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72225>

The value of this new command line option will be used as a key to
check the configuration for an help browser.

This should remove the last bit in 'git-help--browse' that was
specific to 'git-help', so that other git command can use
'git-help--browse'.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-help--browse.sh |   23 ++++++++++++++++++-----
 help.c              |    2 +-
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/git-help--browse.sh b/git-help--browse.sh
index 8189c08..9953e16 100755
--- a/git-help--browse.sh
+++ b/git-help--browse.sh
@@ -16,7 +16,7 @@
 # git maintainer.
 #
 
-USAGE='[--browser=browser|--tool=browser] url/file ...'
+USAGE='[--browser=browser|--tool=browser] [--config=conf.var] url/file ...'
 
 # This must be capable of running outside of git directory, so
 # the vanilla git-sh-setup should not be used.
@@ -53,6 +53,18 @@ do
 		    shift ;;
 	    esac
 	    ;;
+	-c|--config*)
+	    case "$#,$1" in
+		*,*=*)
+		    conf=`expr "z$1" : 'z-[^=]*=\(.*\)'`
+		    ;;
+		1,*)
+		    usage ;;
+		*)
+		    conf="$2"
+		    shift ;;
+	    esac
+	    ;;
 	--)
 	    break
 	    ;;
@@ -70,15 +82,16 @@ test $# = 0 && usage
 
 if test -z "$browser"
 then
-    for opt in "help.browser" "web.browser"
+    for opt in "$conf" "web.browser"
     do
+	test -z "$opt" && continue
 	browser="`git config $opt`"
 	test -z "$browser" || break
     done
     if test -n "$browser" && ! valid_tool "$browser"; then
-	    echo >&2 "git config option $opt set to unknown browser: $browser"
-	    echo >&2 "Resetting to default..."
-	    unset browser
+	echo >&2 "git config option $opt set to unknown browser: $browser"
+	echo >&2 "Resetting to default..."
+	unset browser
     fi
 fi
 
diff --git a/help.c b/help.c
index b929899..058a397 100644
--- a/help.c
+++ b/help.c
@@ -347,7 +347,7 @@ static void show_html_page(const char *git_cmd)
 
 	get_html_page_path(&page_path, page);
 
-	execl_git_cmd("help--browse", page_path.buf, NULL);
+	execl_git_cmd("help--browse", "-c", "help.browser", page_path.buf, NULL);
 }
 
 void help_unknown_cmd(const char *cmd)
-- 
1.5.4.rc5.25.g7a831-dirty
