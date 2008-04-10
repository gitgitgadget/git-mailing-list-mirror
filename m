From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH/RFC 1/7] git-submodule: Extract functions module_info and module_url
Date: Thu, 10 Apr 2008 23:50:16 +0800
Message-ID: <1207842625-9210-2-git-send-email-pkufranky@gmail.com>
References: <1207842625-9210-1-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 17:51:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjz3P-00052w-Vw
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 17:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756684AbYDJPua (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 11:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756704AbYDJPu3
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 11:50:29 -0400
Received: from mail.qikoo.org ([60.28.205.235]:37782 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757273AbYDJPu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 11:50:28 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 9534E470AF; Thu, 10 Apr 2008 23:50:25 +0800 (CST)
X-Mailer: git-send-email 1.5.5.23.g2a5f
In-Reply-To: <1207842625-9210-1-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79222>

module_info is extracted to remove the logic redundance which acquires
module names and urls by path filter in several places.

module_url is also extracted to prepare for an alternative logic to get url by
module name.

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 git-submodule.sh |   40 ++++++++++++++++++++++++++++------------
 1 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 56ec353..a5002e1 100755
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
 
-	git ls-files --stage -- "$@" | grep '^160000 ' |
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
 
-	git ls-files --stage -- "$@" | grep '^160000 ' |
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
 
-	git ls-files --stage -- "$@" | grep '^160000 ' |
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
1.5.5.23.g2a5f
