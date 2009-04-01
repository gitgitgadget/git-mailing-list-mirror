From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 07/10] difftool: use valid_tool from git-mergetool-lib
Date: Wed,  1 Apr 2009 05:55:11 -0700
Message-ID: <1238590514-41893-8-git-send-email-davvid@gmail.com>
References: <1238590514-41893-1-git-send-email-davvid@gmail.com>
 <1238590514-41893-2-git-send-email-davvid@gmail.com>
 <1238590514-41893-3-git-send-email-davvid@gmail.com>
 <1238590514-41893-4-git-send-email-davvid@gmail.com>
 <1238590514-41893-5-git-send-email-davvid@gmail.com>
 <1238590514-41893-6-git-send-email-davvid@gmail.com>
 <1238590514-41893-7-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com, charles@hashpling.org
X-From: git-owner@vger.kernel.org Wed Apr 01 14:58:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp01j-0004A8-8B
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 14:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764319AbZDAMzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 08:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764699AbZDAMzt
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 08:55:49 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:8981 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764695AbZDAMzn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 08:55:43 -0400
Received: by rv-out-0506.google.com with SMTP id f9so29200rvb.1
        for <git@vger.kernel.org>; Wed, 01 Apr 2009 05:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=BATW8LtUA0CoyJK8ermFRFNc8hSGBcYOzes6n7AbZbs=;
        b=uavaJw7JT11HKBQ/RoLd8jsInSOGJBiT+W2h5CrE7lrBA/lyGA8bzcTrjfIw50flve
         L6kNeGjCt0Qt71hbxzRmRF82r5BYBs5tdDM7zA2BTXIZZfHti7VmoJu0L785jWKAXDBn
         tg7MdQaPifzXZV24gP0+a2ArzwQ6LLXtCmOtc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JVU3/g62Rvz8y7enBvV8sYWSJHJYzVCWctQXfCXq+qRBCoHmbFH2QK8l6Xaeodm3QT
         RrtjvcADD8xFvGvKtHwsh0FeqydFHtCoV6xWRccUDIwrZDud3erOmlt3LEddRRfvtFPs
         sig2FwqrAxjzrAilvTgCL35kC8HPUFShFz/Pc=
Received: by 10.114.184.11 with SMTP id h11mr5209598waf.100.1238590541431;
        Wed, 01 Apr 2009 05:55:41 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id n9sm1382982wag.46.2009.04.01.05.55.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Apr 2009 05:55:41 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.423.g442d
In-Reply-To: <1238590514-41893-7-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115383>

This refactors difftool to use valid_tool fro git-mergetool-lib

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-difftool-helper.sh |   29 +++--------------------------
 1 files changed, 3 insertions(+), 26 deletions(-)

diff --git a/git-difftool-helper.sh b/git-difftool-helper.sh
index d1bea18..6cc5ab5 100755
--- a/git-difftool-helper.sh
+++ b/git-difftool-helper.sh
@@ -8,6 +8,7 @@
 # Copyright (c) 2009 David Aguilar
 
 # Load common functions from git-mergetool-lib
+TOOL_MODE=diff
 . git-mergetool-lib
 
 # difftool.prompt controls the default prompt/no-prompt behavior
@@ -105,29 +106,6 @@ launch_merge_tool () {
 	esac
 }
 
-# Verifies that (difftool|mergetool).<tool>.cmd exists
-valid_custom_tool() {
-	merge_tool_cmd="$(git config difftool.$1.cmd)"
-	test -z "$merge_tool_cmd" &&
-	merge_tool_cmd="$(git config mergetool.$1.cmd)"
-	test -n "$merge_tool_cmd"
-}
-
-# Verifies that the chosen merge tool is properly setup.
-# Built-in merge tools are always valid.
-valid_tool() {
-	case "$1" in
-	kdiff3 | kompare | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | ecmerge)
-		;; # happy
-	*)
-		if ! valid_custom_tool "$1"
-		then
-			return 1
-		fi
-		;;
-	esac
-}
-
 # Allow GIT_DIFF_TOOL and GIT_MERGE_TOOL to provide default values
 test -n "$GIT_MERGE_TOOL" && merge_tool="$GIT_MERGE_TOOL"
 test -n "$GIT_DIFF_TOOL" && merge_tool="$GIT_DIFF_TOOL"
@@ -183,6 +161,7 @@ if test -z "$merge_tool"; then
 		exit 1
 	fi
 
+	merge_tool_cmd=$(get_custom_cmd "$merge_tool")
 else
 	# A merge tool has been set, so verify that it's valid.
 	if ! valid_tool "$merge_tool"; then
@@ -190,9 +169,7 @@ else
 		exit 1
 	fi
 
-	# Sets up the merge_tool_path variable.
-	# This handles the difftool.<tool>.path configuration variable
-	# and falls back to mergetool defaults.
+	merge_tool_cmd=$(get_custom_cmd "$merge_tool")
 	merge_tool_path=$(git config difftool."$1".path)
 	test -z "$merge_tool_path" &&
 	merge_tool_path=$(git config mergetool."$1".path)
-- 
1.6.1.3
