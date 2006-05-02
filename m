From: Robert Shearman <rob@codeweavers.com>
Subject: [PATCH] Give the user a hint for how to continue in the case that
 git-am fails because it requires user intervention
Date: Tue, 02 May 2006 13:32:43 +0100
Organization: CodeWeavers
Message-ID: <4457516B.9010103@codeweavers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010801050603070307060903"
X-From: git-owner@vger.kernel.org Tue May 02 14:33:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fau4C-0003Si-Ij
	for gcvg-git@gmane.org; Tue, 02 May 2006 14:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWEBMdR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 08:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWEBMdR
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 08:33:17 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:8855 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S932110AbWEBMdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 May 2006 08:33:16 -0400
Received: from host86-141-84-223.range86-141.btcentralplus.com ([86.141.84.223] helo=[192.168.0.180])
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Fau43-0002mP-Gp
	for git@vger.kernel.org; Tue, 02 May 2006 07:33:15 -0500
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19416>

This is a multi-part message in MIME format.
--------------010801050603070307060903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Give the user a hint for how to continue in the case that git-am fails 
because it requires user intervention.

Signed-off-by: Robert Shearman <rob@codeweaves.com>

---

When git-am fails because it needs user intervention, the user may not 
know what they need to do to continue with applying the mailbox. This 
patch gives them a hint to use git-am (as they may have started the 
operation from another tool, such as git-rebase). As the threeway, 
interactive and dotest options are not persisted, the user may also 
forget to include them (or not realise at all that they should be 
included), so we should also tell the user to include these options if 
they were orignally specified.

  git-am.sh |   26 +++++++++++++++++++++++---
  1 files changed, 23 insertions(+), 3 deletions(-)


--------------010801050603070307060903
Content-Type: text/x-patch;
 name="ead48bae7157a30589791165b7b71208b68cf229.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ead48bae7157a30589791165b7b71208b68cf229.diff"

ead48bae7157a30589791165b7b71208b68cf229
diff --git a/git-am.sh b/git-am.sh
index 872145b..507ae4d 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -14,6 +14,26 @@ stop_here () {
     exit 1
 }
 
+stop_here_user_resolve () {
+    cmdline=$(basename $0)
+    if test '' != "$interactive"
+    then
+        cmdline="$cmdline -i"
+    fi
+    if test '' != "$threeway"
+    then
+        cmdline="$cmdline -3"
+    fi
+    if test '.dotest' != "$dotest"
+    then
+        cmdline="$cmdline -d=$dotest"
+    fi
+    echo "When you have resolved this problem run \"$cmdline --resolved\"."
+    echo "If you would prefer to skip this patch, instead run \"$cmdline --skip\"."
+
+    stop_here $1
+}
+
 go_next () {
 	rm -f "$dotest/$msgnum" "$dotest/msg" "$dotest/msg-clean" \
 		"$dotest/patch" "$dotest/info"
@@ -374,14 +394,14 @@ do
 		if test '' = "$changed"
 		then
 			echo "No changes - did you forget update-index?"
-			stop_here $this
+			stop_here_user_resolve $this
 		fi
 		unmerged=$(git-ls-files -u)
 		if test -n "$unmerged"
 		then
 			echo "You still have unmerged paths in your index"
 			echo "did you forget update-index?"
-			stop_here $this
+			stop_here_user_resolve $this
 		fi
 		apply_status=0
 		;;
@@ -407,7 +427,7 @@ do
 	if test $apply_status != 0
 	then
 		echo Patch failed at $msgnum.
-		stop_here $this
+		stop_here_user_resolve $this
 	fi
 
 	if test -x "$GIT_DIR"/hooks/pre-applypatch


--------------010801050603070307060903--
