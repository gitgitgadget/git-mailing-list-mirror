From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH 2/7] git-submodule: Extract functions module_info and module_url
Date: Fri, 14 Mar 2008 01:56:36 +0800
Message-ID: <1205431001-18590-3-git-send-email-pkufranky@gmail.com>
References: <1205431001-18590-1-git-send-email-pkufranky@gmail.com>
 <1205431001-18590-2-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 13 18:58:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZrhA-0002de-67
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 18:58:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754407AbYCMR4r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 13:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757120AbYCMR4p
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 13:56:45 -0400
Received: from mail.qikoo.org ([60.28.205.235]:43766 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757093AbYCMR4n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 13:56:43 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 47659470AF; Fri, 14 Mar 2008 01:56:41 +0800 (CST)
X-Mailer: git-send-email 1.5.4.4.653.g7cf1e
In-Reply-To: <1205431001-18590-2-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77115>

module_info is extracted to remove the logic redundance which acquires
module names and urls by path filter in several places.

module_url is also extracted to prepare for an alternative logic to get url by
module name.

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 git-submodule.sh |   40 ++++++++++++++++++++++++++++------------
 1 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 2f40620..7545d1a 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -82,6 +82,25 @@ module_name()
        echo "$name"
 }
 
+module_url() {
+	git config submodule.$1.url
+}
+
+module_info() {
+	git ls-files --stage -- "$@" | grep -e '^160000 ' |
+	while read mode sha1 stage path
+	do
+		name=$(module_name "$path")
+		if test -n "$name"
+		then
+			url=$(module_url "$name")
+			echo "$sha1	$path	$name	$url"
+		else
+			echo "$sha1	$path		"
+		fi
+	done
+}
+
 #
 # Clone a submodule
 #
@@ -232,12 +251,11 @@ cmd_init()
 		shift
 	done
 
-	git ls-files --stage -- "$@" | grep -e '^160000 ' |
-	while read mode sha1 stage path
+	module_info "$@" |
+	while read sha1 path name url
 	do
+		test -n "$name" || exit
 		# Skip already registered paths
-		name=$(module_name "$path") || exit
-		url=$(git config submodule."$name".url)
 		test -z "$url" || continue
 
 		url=$(GIT_CONFIG=.gitmodules git config submodule."$name".url)
@@ -286,11 +304,10 @@ cmd_update()
 		shift
 	done
 
-	git ls-files --stage -- "$@" | grep -e '^160000 ' |
-	while read mode sha1 stage path
+	module_info "$@" |
+	while read sha1 path name url
 	do
-		name=$(module_name "$path") || exit
-		url=$(git config submodule."$name".url)
+		test -n "$name" || exit
 		if test -z "$url"
 		then
 			# Only mention uninitialized submodules when its
@@ -537,11 +554,10 @@ cmd_status()
 		shift
 	done
 
-	git ls-files --stage -- "$@" | grep -e '^160000 ' |
-	while read mode sha1 stage path
+	module_info "$@" |
+	while read sha1 path name url
 	do
-		name=$(module_name "$path") || exit
-		url=$(git config submodule."$name".url)
+		test -n "$name" || exit
 		if test -z "$url" || ! test -d "$path"/.git
 		then
 			say "-$sha1 $path"
-- 
1.5.4.4.653.g7cf1e
