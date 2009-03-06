From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 1/3] bash completion: fix completion issues with fetch, pull, and push
Date: Thu,  5 Mar 2009 23:39:31 -0500
Message-ID: <07bd381f7984117681504ce57c1f6c40aecafed3.1236314073.git.jaysoffian@gmail.com>
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
X-From: git-owner@vger.kernel.org Fri Mar 06 05:41:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfRsc-0005Tp-Tg
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 05:41:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754162AbZCFEkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 23:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754036AbZCFEkG
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 23:40:06 -0500
Received: from yw-out-2324.google.com ([74.125.46.31]:27027 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892AbZCFEkE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 23:40:04 -0500
Received: by yw-out-2324.google.com with SMTP id 5so195374ywh.1
        for <git@vger.kernel.org>; Thu, 05 Mar 2009 20:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=kHq8LqaAzZpe7GmkGIARKj7sYQfhMLBU5YL5H/5CnXw=;
        b=A80AiQGY4Ohq/GTXGLp4nALNzZYKqTucMdHsccPOD+BbKWRCRNpGvvZsxyNO/UWtCd
         JhkhbN8IATaAczFA1o3nQXqELgpazY8jSXV2GNz/3iMNtnQLkcadcjXEDbhBDpewH16/
         axScBG4OuA/+ALKWA40tW4FVHb8+DghJ5Gr1s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=eegwTUtHKEXRrmwONRkZKH5SuVwwZVusCpnOYrQkKRaosajWm3IFLV/b7rm5gBM/HD
         hwyyxnHu3TJMvCqOEmFtqmpXY7tuv7JmiPGOG9psooSrTvrMIo6iTDqf4UgegShvCSGL
         0GNmJq/rsC+IXKlT8+ZLJcE6pv19yA0UhPueU=
Received: by 10.151.113.5 with SMTP id q5mr3632883ybm.89.1236314401944;
        Thu, 05 Mar 2009 20:40:01 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id n29sm1864990elf.10.2009.03.05.20.40.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Mar 2009 20:40:01 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc2.332.g5d21b
In-Reply-To: <cover.1236314073.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112375>

Sverre Rabbelier noticed a completion issue with push:

 $ git push ori<tab>
 git push origin

 $ git push -f ori<tab>
 git push -f origin/

Markus Heidelberg pointed out that the issue extends to fetch and pull.

The reason is that the current code naively assumes that if
COMP_CWORD=2, it should complete a remote name, otherwise it should
complete a refspec. This assumption fails if there are any --options.

This patch fixes that issue by instead scanning COMP_CWORDS to see if
the remote has been completed yet (we now assume the first non-dashed
argument is the remote). The new logic is factored into a function,
shared by fetch, pull, and push.

The new function also properly handles '.' as the remote.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 contrib/completion/git-completion.bash |  109 +++++++++++++++++--------------
 1 files changed, 60 insertions(+), 49 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0a3092f..b347fdd 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -383,6 +383,63 @@ __git_complete_revlist ()
 	esac
 }
 
+__git_complete_remote_or_refspec ()
+{
+	local cmd="${COMP_WORDS[1]}"
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	local i c=2 remote="" pfx="" lhs=1
+	while [ $c -lt $COMP_CWORD ]; do
+		i="${COMP_WORDS[c]}"
+		case "$i" in
+		-*) ;;
+		*) remote="$i"; break ;;
+		esac
+		c=$((++c))
+	done
+	if [ -z "$remote" ]; then
+		__gitcomp "$(__git_remotes)"
+		return
+	fi
+	[ "$remote" = "." ] && remote=
+	case "$cur" in
+	*:*)
+		case "$COMP_WORDBREAKS" in
+		*:*) : great ;;
+		*)   pfx="${cur%%:*}:" ;;
+		esac
+		cur="${cur#*:}"
+		lhs=0
+		;;
+	+*)
+		pfx="+"
+		cur="${cur#+}"
+		;;
+	esac
+	case "$cmd" in
+	fetch)
+		if [ $lhs = 1 ]; then
+			__gitcomp "$(__git_refs2 "$remote")" "$pfx" "$cur"
+		else
+			__gitcomp "$(__git_refs)" "$pfx" "$cur"
+		fi
+		;;
+	pull)
+		if [ $lhs = 1 ]; then
+			__gitcomp "$(__git_refs "$remote")" "$pfx" "$cur"
+		else
+			__gitcomp "$(__git_refs)" "$pfx" "$cur"
+		fi
+		;;
+	push)
+		if [ $lhs = 1 ]; then
+			__gitcomp "$(__git_refs)" "$pfx" "$cur"
+		else
+			__gitcomp "$(__git_refs "$remote")" "$pfx" "$cur"
+		fi
+		;;
+	esac
+}
+
 __git_all_commands ()
 {
 	if [ -n "$__git_all_commandlist" ]; then
@@ -828,25 +885,7 @@ _git_diff ()
 
 _git_fetch ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
-
-	if [ "$COMP_CWORD" = 2 ]; then
-		__gitcomp "$(__git_remotes)"
-	else
-		case "$cur" in
-		*:*)
-			local pfx=""
-			case "$COMP_WORDBREAKS" in
-			*:*) : great ;;
-			*)   pfx="${cur%%:*}:" ;;
-			esac
-			__gitcomp "$(__git_refs)" "$pfx" "${cur#*:}"
-			;;
-		*)
-			__gitcomp "$(__git_refs2 "${COMP_WORDS[2]}")"
-			;;
-		esac
-	fi
+	__git_complete_remote_or_refspec
 }
 
 _git_format_patch ()
@@ -1111,40 +1150,12 @@ _git_name_rev ()
 
 _git_pull ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
-
-	if [ "$COMP_CWORD" = 2 ]; then
-		__gitcomp "$(__git_remotes)"
-	else
-		__gitcomp "$(__git_refs "${COMP_WORDS[2]}")"
-	fi
+	__git_complete_remote_or_refspec
 }
 
 _git_push ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
-
-	if [ "$COMP_CWORD" = 2 ]; then
-		__gitcomp "$(__git_remotes)"
-	else
-		case "$cur" in
-		*:*)
-			local pfx=""
-			case "$COMP_WORDBREAKS" in
-			*:*) : great ;;
-			*)   pfx="${cur%%:*}:" ;;
-			esac
-
-			__gitcomp "$(__git_refs "${COMP_WORDS[2]}")" "$pfx" "${cur#*:}"
-			;;
-		+*)
-			__gitcomp "$(__git_refs)" + "${cur#+}"
-			;;
-		*)
-			__gitcomp "$(__git_refs)"
-			;;
-		esac
-	fi
+	__git_complete_remote_or_refspec
 }
 
 _git_rebase ()
-- 
1.6.2.rc2.332.g5d21b
