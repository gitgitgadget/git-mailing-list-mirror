From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Don't create broken symlinks
Date: Tue, 20 Sep 2005 11:59:55 -0400
Message-ID: <1127231995.8374.6.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Sep 20 18:04:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHkXm-0003eR-5d
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 18:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965051AbVITQAP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 12:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965055AbVITQAP
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 12:00:15 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:62421 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S965051AbVITQAN
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2005 12:00:13 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EHkXG-0000NK-51
	for git@vger.kernel.org; Tue, 20 Sep 2005 12:00:11 -0400
Received: from proski by dv.roinet.com with local (Exim 4.52)
	id 1EHkXD-0004Ou-Us
	for git@vger.kernel.org; Tue, 20 Sep 2005 11:59:55 -0400
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9002>

cmd-rename.sh creates links for files that are not installed.
git-send-email is not installed by default, so git-send-email-script is
a broken link.

cmd-rename.sh should only create a link if the link target exists.
Also, the patchs add explicit exit codes for failures and ensures exit
code 0 if the script is successful.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/cmd-rename.sh b/cmd-rename.sh
--- a/cmd-rename.sh
+++ b/cmd-rename.sh
@@ -1,10 +1,12 @@
 #!/bin/sh
 d="$1"
-test -d "$d" || exit
+test -d "$d" || exit 1
 while read old new
 do
-	rm -f "$d/$old"
-	ln -s "$new" "$d/$old"
+	rm -f "$d/$old" || exit 1
+	if [ -f "$new/$d" ]; then
+		ln -s "$new" "$d/$old"
+	fi
 done <<\EOF
 git-add-script	git-add
 git-archimport-script	git-archimport
@@ -53,3 +55,5 @@ EOF
 # These two are a bit more than symlinks now.
 # git-ssh-push	git-ssh-upload
 # git-ssh-pull	git-ssh-fetch
+
+exit 0


-- 
Regards,
Pavel Roskin
