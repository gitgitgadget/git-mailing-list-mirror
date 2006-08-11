From: Robert Shearman <rob@codeweavers.com>
Subject: [PATCH] git-sh-setup: Fail if the git directory was not found.
Date: Fri, 11 Aug 2006 10:23:30 +0100
Organization: CodeWeavers
Message-ID: <44DC4C92.5060009@codeweavers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080701030401040800060102"
X-From: git-owner@vger.kernel.org Fri Aug 11 11:24:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBTFX-0005jv-9X
	for gcvg-git@gmane.org; Fri, 11 Aug 2006 11:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbWHKJYG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Aug 2006 05:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbWHKJYG
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Aug 2006 05:24:06 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:11956 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1751057AbWHKJYF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Aug 2006 05:24:05 -0400
Received: from host86-139-253-196.range86-139.btcentralplus.com ([86.139.253.196] helo=[172.16.0.10])
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1GBTFK-000662-Hh
	for git@vger.kernel.org; Fri, 11 Aug 2006 04:24:02 -0500
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060725)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25221>

This is a multi-part message in MIME format.
--------------080701030401040800060102
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Always use git-rev-parse to find a valid git directory, as 
git-repo-config no longer returns an error code if a git directory 
wasn't found.

This fixes the message received when invoking certain commands 
implemented as shell scripts from outside of a git tree, so e.g. instead 
of receiving this:
/home/rob/bin/git-fetch: line 89: /FETCH_HEAD: Permission denied
We get this again:
fatal: Not a git repository: '.git'

Also, move the setting of GIT_OBJECT_DIRECTORY to outside of the 
non-subdir-ok case as it isn't specific to that case.
Signed-off-by: Robert Shearman <rob@codeweavers.com>
---
  git-sh-setup.sh |   12 +++---------
  1 files changed, 3 insertions(+), 9 deletions(-)

Hopefully this patch addresses the concerns of Junio and others by 
continuing to allow git-ls-remotes to work outside of a git repository.

--------------080701030401040800060102
Content-Type: text/x-patch;
 name="268921fd0b2e7ff56c9b455a0129b0e8712fc191.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="268921fd0b2e7ff56c9b455a0129b0e8712fc191.diff"

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index d15747f..49f9e3b 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -37,15 +37,9 @@ esac
 
 if [ -z "$SUBDIRECTORY_OK" ]
 then
-	: ${GIT_DIR=.git}
-	: ${GIT_OBJECT_DIRECTORY="$GIT_DIR/objects"}
-
-	# Make sure we are in a valid repository of a vintage we understand.
-	GIT_DIR="$GIT_DIR" git repo-config --get core.nosuch >/dev/null
-	if test $? = 128
-	then
-	    exit
-	fi
+	GIT_DIR=$(GIT_DIR=.git git-rev-parse --git-dir) || exit
 else
 	GIT_DIR=$(git-rev-parse --git-dir) || exit
 fi
+
+GIT_OBJECT_DIRECTORY="$GIT_DIR/objects"


--------------080701030401040800060102--
