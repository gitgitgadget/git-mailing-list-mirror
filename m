From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 3/3] bash completion: teach fetch, pull, and push to complete their options
Date: Thu,  5 Mar 2009 23:39:33 -0500
Message-ID: <5576c9f6e10a6efec0b2bbbd156a25852506cc49.1236314073.git.jaysoffian@gmail.com>
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
X-From: git-owner@vger.kernel.org Fri Mar 06 05:41:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfRse-0005Tp-CJ
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 05:41:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754197AbZCFEkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 23:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753200AbZCFEkO
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 23:40:14 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:64728 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754036AbZCFEkI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 23:40:08 -0500
Received: by gxk22 with SMTP id 22so608164gxk.13
        for <git@vger.kernel.org>; Thu, 05 Mar 2009 20:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=6RcRVA/ipYfXYVfcjks/l+pTH7ryTQI8fPtUQjRfeRQ=;
        b=GSY13+CP1tGd8BxM0G6/2zIgKrkPhrsyn3N5SL5hNKPpFVb4ZUhpqCD3foS/8no7be
         TyBnZ3DPXxniam2+JcnBaFnuCbPsazVp1UIjwxyTbwHRtMYfFGOJ7exnJ9d4ssbmQFE1
         u02IEcOOLeYW2qyqrj6H9PL+LL7HEwLYRRo2M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=wQ5OWZ0Ac8dmelgTnpQdQTPlL/AsRBkOT3CXEKs87mlVO9E/PkPVOWwn0sZzCkYmR9
         6PVBdgRgJUdnj3prhjIsFWzRO8bOHCNog5rodM3/X3i5RX/OTpcDeclSo1l2N02CKkAb
         IjNy9ujCxK+EMNyUEwL/mb7EmNc/jrV4dFIxM=
Received: by 10.151.38.12 with SMTP id q12mr3595586ybj.113.1236314406389;
        Thu, 05 Mar 2009 20:40:06 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id z26sm1876715ele.0.2009.03.05.20.40.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Mar 2009 20:40:05 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc2.332.g5d21b
In-Reply-To: <cover.1236314073.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112377>

fetch, pull, and push didn't know their options. They do now. merge's
options are factored into a variable so they can be shared between
_git_merge and _git_pull

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 contrib/completion/git-completion.bash |   61 +++++++++++++++++++++++++++++---
 1 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8924185..3ebedea 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -387,10 +387,11 @@ __git_complete_remote_or_refspec ()
 {
 	local cmd="${COMP_WORDS[1]}"
 	local cur="${COMP_WORDS[COMP_CWORD]}"
-	local i c=2 remote="" pfx="" lhs=1
+	local i c=2 remote="" pfx="" lhs=1 no_complete_refspec=0
 	while [ $c -lt $COMP_CWORD ]; do
 		i="${COMP_WORDS[c]}"
 		case "$i" in
+		--all|--mirror) [ "$cmd" = "push" ] && no_complete_refspec=1 ;;
 		-*) ;;
 		*) remote="$i"; break ;;
 		esac
@@ -400,6 +401,10 @@ __git_complete_remote_or_refspec ()
 		__gitcomp "$(__git_remotes)"
 		return
 	fi
+	if [ $no_complete_refspec = 1 ]; then
+		COMPREPLY=()
+		return
+	fi
 	[ "$remote" = "." ] && remote=
 	case "$cur" in
 	*:*)
@@ -899,8 +904,20 @@ _git_diff ()
 	__git_complete_file
 }
 
+__git_fetch_options="
+	--quiet --verbose --append --upload-pack --force --keep --depth=
+	--tags --no-tags
+"
+
 _git_fetch ()
 {
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	--*)
+		__gitcomp "$__git_fetch_options"
+		return
+		;;
+	esac
 	__git_complete_remote_or_refspec
 }
 
@@ -1100,6 +1117,11 @@ _git_log ()
 	__git_complete_revlist
 }
 
+__git_merge_options="
+	--no-commit --no-stat --log --no-log --squash --strategy
+	--commit --stat --no-squash --ff --no-ff
+"
+
 _git_merge ()
 {
 	__git_complete_strategy && return
@@ -1107,10 +1129,7 @@ _git_merge ()
 	local cur="${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
 	--*)
-		__gitcomp "
-			--no-commit --no-stat --log --no-log --squash --strategy
-			--commit --stat --no-squash --ff --no-ff
-			"
+		__gitcomp "$__git_merge_options"
 		return
 	esac
 	__gitcomp "$(__git_refs)"
@@ -1159,11 +1178,43 @@ _git_name_rev ()
 
 _git_pull ()
 {
+	__git_complete_strategy && return
+
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	--*)
+		__gitcomp "
+			--rebase --no-rebase
+			$__git_merge_options
+			$__git_fetch_options
+		"
+		return
+		;;
+	esac
 	__git_complete_remote_or_refspec
 }
 
 _git_push ()
 {
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "${COMP_WORDS[COMP_CWORD-1]}" in
+	--repo)
+		__gitcomp "$(__git_remotes)"
+		return
+	esac
+	case "$cur" in
+	--repo=*)
+		__gitcomp "$(__git_remotes)" "" "${cur##--repo=}"
+		return
+		;;
+	--*)
+		__gitcomp "
+			--all --mirror --tags --dry-run --force --verbose
+			--receive-pack= --repo=
+		"
+		return
+		;;
+	esac
 	__git_complete_remote_or_refspec
 }
 
-- 
1.6.2.rc2.332.g5d21b
