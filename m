From: koreth@midwinter.com
Subject: [PATCH] Change to the repository's root directory if needed.
Date: Fri, 12 Jan 2007 11:10:44 -0800
Message-ID: <20070112191044.GA5113@midwinter.com>
References: <7v8xg9x8uu.fsf@assigned-by-dhcp.cox.net> <200701121501.24642.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 20:11:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5Rnl-0002hR-S4
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 20:10:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbXALTKt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 14:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbXALTKt
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 14:10:49 -0500
Received: from tater.midwinter.com ([216.32.86.90]:44179 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964958AbXALTKs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 14:10:48 -0500
Received: (qmail 5305 invoked by uid 1001); 12 Jan 2007 19:10:44 -0000
To: Andy Parkins <andyparkins@gmail.com>
Content-Disposition: inline
In-Reply-To: <200701121501.24642.andyparkins@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36693>

Signed-off-by: Steven Grimm <koreth@midwinter.com>
---

Or try this instead. It seems to work in my limited testing, but it's
possible this breaks something somewhere. The only weird thing here
is that if, e.g., you have a file foo.c in the top-level directory and
you run "git pull" from a subdirectory, you'll see a message indicating
that "foo.c" was updated, implying that it's updating that file in the
current directory. (Output about files in subdirectories, to my eye,
feels less ambiguous in that respect.) But after running with this for
just a few minutes, I'm willing to put up with that in exchange for
not having to manually cd.

 git-sh-setup.sh |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 4a02b38..d1c78c4 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -59,8 +59,13 @@ esac
 # Make sure we are in a valid repository of a vintage we understand.
 if [ -z "$SUBDIRECTORY_OK" ]
 then
-	: ${GIT_DIR=.git}
-	GIT_DIR=$(GIT_DIR="$GIT_DIR" git-rev-parse --git-dir) || exit
+	GIT_DIR=$(git-rev-parse --git-dir) || exit
+	if [ "$GIT_DIR" != ".git" -a "$(basename \"$GIT_DIR\")" = ".git" ]
+	then
+		# In a subdirectory of a non-bare repository; move to root dir
+		cd "`dirname \"$GIT_DIR\"`" || \
+			die "Can't change to repository root directory"
+	fi
 else
 	GIT_DIR=$(git-rev-parse --git-dir) || exit
 fi
-- 
1.5.0.rc0.g4083
