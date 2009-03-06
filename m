From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 2/3] bash completion: refactor --strategy completion
Date: Thu,  5 Mar 2009 23:39:32 -0500
Message-ID: <2d83927582e9eed004b9fd12b77105a184277229.1236314073.git.jaysoffian@gmail.com>
References: <cover.1236314073.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O . Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 05:41:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfRsd-0005Tp-Kw
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 05:41:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253AbZCFEkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 23:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754068AbZCFEkI
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 23:40:08 -0500
Received: from el-out-1112.google.com ([209.85.162.183]:27639 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754004AbZCFEkG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 23:40:06 -0500
Received: by el-out-1112.google.com with SMTP id b25so209513elf.1
        for <git@vger.kernel.org>; Thu, 05 Mar 2009 20:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=jn2/rSO3otKsu1VgTC1tpYEkTyONiMCjZZn9krm7WGc=;
        b=JuJ7EswId+Emq3DoTWWjkU04YEr+5gASzTxK4dFLrCRjSdefeTIPz/cj2sPOdRQXAe
         LrY3OLofcQJME2/GFmlgGDioXEgOcv4DE/bp7J7MMUj6zOaAqyCu9zsPSfwYYAXPn1FU
         uNy16F9t8nF4yPRwVHKDlV0H5JpgmXK/9hZAc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=fVeLPhCYEysQlecLSaRBjHJuxBf2ilZCnO8EdXr3fbM3h43DFkBSfVFPr/7qc4XI5r
         LJkhsfT7oGbZAyhQzMn1Cx0mRzc3fWB9Bvjtj40RBkdNgAMPScFKrlsWWmeELm3e3a3w
         2k7GUjjqhNkEW5TviKogpN/loQxh4fKGqBstc=
Received: by 10.150.121.2 with SMTP id t2mr3616840ybc.86.1236314404035;
        Thu, 05 Mar 2009 20:40:04 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id q26sm1877779ele.5.2009.03.05.20.40.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Mar 2009 20:40:03 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc2.332.g5d21b
In-Reply-To: <cover.1236314073.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112376>

The code to complete --strategy was duplicated between _git_rebase and
_git_merge, and is about to gain a third caller (_git_pull). This patch
factors it into its own function.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 contrib/completion/git-completion.bash |   37 ++++++++++++++++---------------
 1 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b347fdd..8924185 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -440,6 +440,22 @@ __git_complete_remote_or_refspec ()
 	esac
 }
 
+__git_complete_strategy ()
+{
+	case "${COMP_WORDS[COMP_CWORD-1]}" in
+	-s|--strategy)
+		__gitcomp "$(__git_merge_strategies)"
+		return 1
+	esac
+	case "$cur" in
+	--strategy=*)
+		__gitcomp "$(__git_merge_strategies)" "" "${cur##--strategy=}"
+		return 1
+		;;
+	esac
+	return 0
+}
+
 __git_all_commands ()
 {
 	if [ -n "$__git_all_commandlist" ]; then
@@ -1086,17 +1102,10 @@ _git_log ()
 
 _git_merge ()
 {
+	__git_complete_strategy && return
+
 	local cur="${COMP_WORDS[COMP_CWORD]}"
-	case "${COMP_WORDS[COMP_CWORD-1]}" in
-	-s|--strategy)
-		__gitcomp "$(__git_merge_strategies)"
-		return
-	esac
 	case "$cur" in
-	--strategy=*)
-		__gitcomp "$(__git_merge_strategies)" "" "${cur##--strategy=}"
-		return
-		;;
 	--*)
 		__gitcomp "
 			--no-commit --no-stat --log --no-log --squash --strategy
@@ -1165,16 +1174,8 @@ _git_rebase ()
 		__gitcomp "--continue --skip --abort"
 		return
 	fi
-	case "${COMP_WORDS[COMP_CWORD-1]}" in
-	-s|--strategy)
-		__gitcomp "$(__git_merge_strategies)"
-		return
-	esac
+	__git_complete_strategy && return
 	case "$cur" in
-	--strategy=*)
-		__gitcomp "$(__git_merge_strategies)" "" "${cur##--strategy=}"
-		return
-		;;
 	--*)
 		__gitcomp "--onto --merge --strategy --interactive"
 		return
-- 
1.6.2.rc2.332.g5d21b
