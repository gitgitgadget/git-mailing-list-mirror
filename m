From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 5/8] difftool: refactor git-difftool to use git-sh-tools
Date: Sun, 29 Mar 2009 22:03:45 -0700
Message-ID: <1238389428-69328-6-git-send-email-davvid@gmail.com>
References: <1238389428-69328-1-git-send-email-davvid@gmail.com>
 <1238389428-69328-2-git-send-email-davvid@gmail.com>
 <1238389428-69328-3-git-send-email-davvid@gmail.com>
 <1238389428-69328-4-git-send-email-davvid@gmail.com>
 <1238389428-69328-5-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 30 07:06:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lo9h9-0004he-NX
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 07:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754977AbZC3FEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 01:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbZC3FEV
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 01:04:21 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:39536 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754241AbZC3FET (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 01:04:19 -0400
Received: by mail-qy0-f118.google.com with SMTP id 16so3307690qyk.33
        for <git@vger.kernel.org>; Sun, 29 Mar 2009 22:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=EcKeD6CCsSfuujp/LienuWzw20OuBMTeLfgE7UJPocc=;
        b=fjN6rq5RVYMpBysXVWf+jERO0pSg7V8toFd4bPiTcGj94RCsjPfoqU3FhNPaDImLI4
         UKI0HyFqsMOUCduaPisVqBoiGbc7QHe/AIcNZ7e04eet0P/jvDZgSEdQgVzvwyx5kbqn
         BfxoKj0OnbaQTfl7VpNpatoJJPl3U3rsLdoA4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VlL4oWRHgivbJ8J4wdGSbIEzcmg9IPBhDF89M93qn5SGPwAzQ0hLt9yNIFiQBhgPLL
         YkCzm0SMivdix7yZcsMBo78p23fN7fAgmjYnYijaahD4bcHS4wkdOShM3WWqyS4dkHJ7
         gu3gadpT1XWQ+drIAXCjBHrSu1agYX+1nXhC0=
Received: by 10.224.60.203 with SMTP id q11mr5573491qah.239.1238389457492;
        Sun, 29 Mar 2009 22:04:17 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 6sm5358135qwd.58.2009.03.29.22.04.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Mar 2009 22:04:16 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.404.gb0085
In-Reply-To: <1238389428-69328-5-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115071>

This removes the common valid_tool functions from git-difftool.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-difftool-helper.sh |   45 +++------------------------------------------
 1 files changed, 3 insertions(+), 42 deletions(-)

diff --git a/git-difftool-helper.sh b/git-difftool-helper.sh
index 02bb135..2051a35 100755
--- a/git-difftool-helper.sh
+++ b/git-difftool-helper.sh
@@ -7,6 +7,9 @@
 #
 # Copyright (c) 2009 David Aguilar
 
+TOOL_MODE=diff
+. git-sh-tools
+
 # difftool.prompt controls the default prompt/no-prompt behavior
 # and is overridden with $GIT_DIFFTOOL*_PROMPT.
 should_prompt () {
@@ -102,48 +105,6 @@ launch_merge_tool () {
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
-# Sets up the merge_tool_path variable.
-# This handles the difftool.<tool>.path configuration.
-# This also falls back to mergetool defaults.
-init_merge_tool_path() {
-	merge_tool_path=$(git config difftool."$1".path)
-	test -z "$merge_tool_path" &&
-	merge_tool_path=$(git config mergetool."$1".path)
-	if test -z "$merge_tool_path"; then
-		case "$1" in
-		emerge)
-			merge_tool_path=emacs
-			;;
-		*)
-			merge_tool_path="$1"
-			;;
-		esac
-	fi
-}
-
 # Allow GIT_DIFF_TOOL and GIT_MERGE_TOOL to provide default values
 test -n "$GIT_MERGE_TOOL" && merge_tool="$GIT_MERGE_TOOL"
 test -n "$GIT_DIFF_TOOL" && merge_tool="$GIT_DIFF_TOOL"
-- 
1.6.1.3
