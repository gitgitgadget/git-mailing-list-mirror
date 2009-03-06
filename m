From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 2/3] bash completion: refactor --strategy completion
Date: Fri,  6 Mar 2009 11:30:44 -0500
Message-ID: <1236357044-55479-1-git-send-email-jaysoffian@gmail.com>
References: <20090306161657.GJ16213@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O . Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 17:32:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfcyd-0007ID-3a
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 17:32:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755034AbZCFQbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 11:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754823AbZCFQbR
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 11:31:17 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:51088 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753645AbZCFQbP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 11:31:15 -0500
Received: by qw-out-2122.google.com with SMTP id 5so635922qwi.37
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 08:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=w+t8MQuIAg0GsyVXrYhbURHJZ3F9Ecxm+djjlMSaWq8=;
        b=BQb6qGLxTGaRJvwekywnAO58MREY0yJ3Lk0QivNPL9jYCxTOOejigCf0d8AsGMeHTh
         q/kZyTFHnx9/9vqkmP9NsTvDl3P6u9Qmqe7KmDy1iCS3u8ZPM1mz/Qc1w64oDiBQAhQE
         Ey0H9n9S2b4plmciI7ZvYacXw/oq6qWNLGDtM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=XQ/jsLMSfYkILAhgEZz6J2zNu+b60uhMDNXCpMtVulP65U4Au41pZ80t8TAMiTvCS+
         o9mQkunS8PvfqqhlWgdjm324/u8Jc/87LbOZ6yfNmMLev+Hvt1LO/r+uXYFfMGkHyiD1
         OcTofQQ/tMVD5X7eWgtSZQ0nnMahYvlSbNuoU=
Received: by 10.224.89.74 with SMTP id d10mr3938707qam.202.1236357073262;
        Fri, 06 Mar 2009 08:31:13 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id 5sm1018689qwg.14.2009.03.06.08.31.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Mar 2009 08:31:12 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc2.332.g5d21b
In-Reply-To: <20090306161657.GJ16213@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112464>

The code to complete --strategy was duplicated between _git_rebase and
_git_merge, and is about to gain a third caller (_git_pull). This patch
factors it into its own function.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
How about like this intead? This way 3/3 doesn't need to be adjusted. The
interdiff is:

---snip---
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9e16576..056e43e 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -449,15 +449,16 @@ __git_complete_strategy ()
 	case "${COMP_WORDS[COMP_CWORD-1]}" in
 	-s|--strategy)
 		__gitcomp "$(__git_merge_strategies)"
-		return 1
+		return 0
 	esac
+	local cur="${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
 	--strategy=*)
 		__gitcomp "$(__git_merge_strategies)" "" "${cur##--strategy=}"
-		return 1
+		return 0
 		;;
 	esac
-	return 0
+	return 1
 }
 
 __git_all_commands ()
---snap---


 contrib/completion/git-completion.bash |   38 ++++++++++++++++---------------
 1 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e8c4be2..056e43e 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -444,6 +444,23 @@ __git_complete_remote_or_refspec ()
 	esac
 }
 
+__git_complete_strategy ()
+{
+	case "${COMP_WORDS[COMP_CWORD-1]}" in
+	-s|--strategy)
+		__gitcomp "$(__git_merge_strategies)"
+		return 0
+	esac
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	--strategy=*)
+		__gitcomp "$(__git_merge_strategies)" "" "${cur##--strategy=}"
+		return 0
+		;;
+	esac
+	return 1
+}
+
 __git_all_commands ()
 {
 	if [ -n "${__git_all_commandlist-}" ]; then
@@ -1095,17 +1112,10 @@ _git_log ()
 
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
@@ -1174,16 +1184,8 @@ _git_rebase ()
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
