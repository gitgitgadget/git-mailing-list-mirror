From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] cg-clean -d removes "arch" and "include" in Linux
Date: Tue, 13 Sep 2005 18:04:35 -0400
Message-ID: <1126649075.28384.15.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Sep 14 00:13:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFItV-00030H-8r
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 00:04:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbVIMWEr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Sep 2005 18:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbVIMWEq
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Sep 2005 18:04:46 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:36511 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932417AbVIMWEq
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2005 18:04:46 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EFItK-0004SF-FV
	for git@vger.kernel.org; Tue, 13 Sep 2005 18:04:38 -0400
Received: from proski by dv.roinet.com with local (Exim 4.52)
	id 1EFItH-0007bX-Ef
	for git@vger.kernel.org; Tue, 13 Sep 2005 18:04:35 -0400
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8495>

Hello!

"cg-clean -d" would delete directories that don't have versioned files
in them, even if their subdirectories do.  "arch" and "include" in Linux
sources are such directories.

To be safe, every directory in the directory list should be complemented
by all its parent directories.

The patch below is a quick hack that shows that bash is not the best
language to implement this.  Still, it's better to have such fix than
having cg-clean remove source files.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/cg-clean b/cg-clean
--- a/cg-clean
+++ b/cg-clean
@@ -53,6 +53,18 @@ clean_dirs()
 	git-ls-files --cached |
 		sed -n 's|^'"$_git_relpath"'||p' |
 		sed -n 's|/[^/]*$||p' |
+		while IFS='/' read -a dir; do
+			i=0
+			while test $i != ${#dir[@]}; do
+				j=0
+				while test $i != $j; do
+					echo -n ${dir[$j]}/
+					j=$[$j+1]
+				done
+				echo ${dir[$i]}
+				i=$[$i+1]
+			done
+		done |
 		sort -u >"$dirlist"
 
 	save_IFS="$IFS"


-- 
Regards,
Pavel Roskin
