From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 4/8] mergetool: refactor git-mergetool to use git-sh-tools
Date: Sun, 29 Mar 2009 22:03:44 -0700
Message-ID: <1238389428-69328-5-git-send-email-davvid@gmail.com>
References: <1238389428-69328-1-git-send-email-davvid@gmail.com>
 <1238389428-69328-2-git-send-email-davvid@gmail.com>
 <1238389428-69328-3-git-send-email-davvid@gmail.com>
 <1238389428-69328-4-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 30 07:06:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lo9h8-0004he-Up
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 07:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754857AbZC3FEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 01:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbZC3FER
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 01:04:17 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:12124 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251AbZC3FEP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 01:04:15 -0400
Received: by qw-out-2122.google.com with SMTP id 8so2354643qwh.37
        for <git@vger.kernel.org>; Sun, 29 Mar 2009 22:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=8z8hkl6alfBn1eOnt/KFE3/73T9yJF8uZt2DyG9n5rw=;
        b=OH9w+b+35u5P5KPJ9ekqtB/smLyN8HnAZ4+y/iz+sVvS+MQJpdBc4AFBv/kbeMX3lj
         +cJKWbqIKM5Bwnx0juJM+WBMKJywqQLwPwxAzmgHylQKpcIYjbTeXJVxILD3akdqt5Cw
         oOMLxj0PBRDwV7u4z7FXtybln8H/JI28GWEB4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bfDWMrDb9nWzt+r74wMLwzP1ZnV6zGYDT00Rr7r85VpoqxuysTZcOmjFHJ4cwjYV4/
         EfjgPNkOiTpxAl2mk1Zt/HTGrQ2n4CVti7oxcyFLfGzYKOSal/RSSBeCH7vqXpbnLQ/f
         akIj7R7a81CylTAygXJhh2emG3CXnJfg6R3ck=
Received: by 10.224.73.196 with SMTP id r4mr3413285qaj.318.1238389453938;
        Sun, 29 Mar 2009 22:04:13 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 5sm5366948qwh.29.2009.03.29.22.04.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Mar 2009 22:04:13 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.404.gb0085
In-Reply-To: <1238389428-69328-4-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115073>

This removes the common valid_tool functions from git-mergetool.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-mergetool.sh |   35 ++---------------------------------
 1 files changed, 2 insertions(+), 33 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 5ea126c..ec20030 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -11,7 +11,9 @@
 USAGE='[--tool=tool] [-y|--no-prompt|--prompt] [file to merge] ...'
 SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
+TOOL_MODE=merge
 . git-sh-setup
+. git-sh-tools
 require_work_tree
 
 # Returns true if the mode reflects a symlink
@@ -351,39 +353,6 @@ do
 	shift
 done
 
-valid_custom_tool()
-{
-	merge_tool_cmd="$(git config mergetool.$1.cmd)"
-	test -n "$merge_tool_cmd"
-}
-
-valid_tool() {
-	case "$1" in
-		kdiff3 | tkdiff | xxdiff | meld | opendiff | \
-		emerge | vimdiff | gvimdiff | ecmerge)
-			;; # happy
-		*)
-			if ! valid_custom_tool "$1"; then
-				return 1
-			fi
-			;;
-	esac
-}
-
-init_merge_tool_path() {
-	merge_tool_path=$(git config mergetool.$1.path)
-	if test -z "$merge_tool_path" ; then
-		case "$1" in
-			emerge)
-				merge_tool_path=emacs
-				;;
-			*)
-				merge_tool_path=$1
-				;;
-		esac
-	fi
-}
-
 prompt_after_failed_merge() {
 	while true; do
 		printf "Continue merging other unresolved paths (y/n) ? "
-- 
1.6.1.3
