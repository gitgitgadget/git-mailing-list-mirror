From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Make cg-clean faster and space-safe
Date: Thu, 27 Oct 2005 22:39:21 -0400
Message-ID: <1130467161.2186.25.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Oct 28 04:39:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVK9R-0007BE-1q
	for gcvg-git@gmane.org; Fri, 28 Oct 2005 04:39:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965060AbVJ1Cj0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 22:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965061AbVJ1Cj0
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 22:39:26 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:38630 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S965060AbVJ1CjZ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2005 22:39:25 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EVK9L-0000Sk-Uy
	for git@vger.kernel.org; Thu, 27 Oct 2005 22:39:24 -0400
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1EVK9J-00023a-MO; Thu, 27 Oct 2005 22:39:21 -0400
To: git <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10740>

Use bash pattern matching to list all parent directories instead of
using arrays.  This makes cg-clean run twice as fast on the Linux kernel
(4 seconds vs 8 seconds).

The new code is also for directory names containing spaces and other
symbols that need to be quoted.  Also, the new code is easier to read.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/cg-clean b/cg-clean
index ea00d2b..f7b5151 100755
--- a/cg-clean
+++ b/cg-clean
@@ -53,16 +53,12 @@ clean_dirs()
 	git-ls-files --cached |
 		sed -n 's|^'"$_git_relpath"'||p' |
 		sed -n 's|/[^/]*$||p' |
-		while IFS='/' read -a dir; do
-			i=0
-			while test $i != ${#dir[@]}; do
-				j=0
-				while test $i != $j; do
-					echo -n ${dir[$j]}/
-					j=$[$j+1]
-				done
-				echo ${dir[$i]}
-				i=$[$i+1]
+		while read dir; do
+			while true; do
+				echo "$dir"
+				updir="${dir%/*}"
+				test "$dir" = "$updir" && break
+				dir="$updir"
 			done
 		done |
 		sort -u >"$dirlist"


-- 
Regards,
Pavel Roskin
