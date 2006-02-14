From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 2/2] Workaround git < 1.2.0 ignoring .gitignore in parent directories
Date: Tue, 14 Feb 2006 13:05:22 -0500
Message-ID: <20060214180522.13766.22633.stgit@dv.roinet.com>
References: <20060214180520.13766.78172.stgit@dv.roinet.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 19:06:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F94Z3-0006cf-3D
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 19:06:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422739AbWBNSFv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 13:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422742AbWBNSFv
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 13:05:51 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:27321 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1422739AbWBNSFu
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 13:05:50 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1F94Yc-0006Ia-Lh
	for git@vger.kernel.org; Tue, 14 Feb 2006 13:05:47 -0500
Received: from localhost.roinet.com ([127.0.0.1] helo=dv.roinet.com)
	by dv.roinet.com with esmtp (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1F94YE-0003aU-DK; Tue, 14 Feb 2006 13:05:22 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060214180520.13766.78172.stgit@dv.roinet.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16146>

Add --exclude-from for all existing .gitignore files in parent
directories up to the repository root.  This is not needed for git 1.2.0
and newer.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 cg-Xlib |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/cg-Xlib b/cg-Xlib
index 85a21c2..af278b6 100644
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -230,6 +230,22 @@ list_untracked_files()
 			EXCLUDE[${#EXCLUDE[@]}]="--exclude-from=$EXCLUDEFILE"
 		fi
 		EXCLUDE[${#EXCLUDE[@]}]="--exclude-per-directory=.gitignore"
+		# Workaround for git < 1.2.0
+		if [ -n "$_git_relpath" ]; then
+			local dir="${_git_relpath%/}"
+			local reldir=".."
+			while [ "$dir" != "." ]; do
+				if [ "${dir%/*}" = "$dir" ]; then
+					dir="."
+				else
+					dir="${dir%/*}"
+				fi
+				if [ -f "$reldir/.gitignore" ]; then
+					EXCLUDE[${#EXCLUDE[@]}]="--exclude-from=$dir/.gitignore"
+				fi
+				reldir="../$reldir"
+			done
+		fi
 	fi
 	local listdirs=
 	[ "$squashflag" = "squashdirs" ] && listdirs=--directory
