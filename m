From: Stefan Naewe <stefan.naewe@gmail.com>
Subject: [PATCH] completion: fix issue with process substitution not working on Git for Windows
Date: Tue, 25 Oct 2011 20:01:35 +0200
Message-ID: <1319565695-5976-1-git-send-email-stefan.naewe@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Stefan Naewe <stefan.naewe@gmail.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Tue Oct 25 20:01:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIlJr-0005Ei-TQ
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 20:01:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115Ab1JYSBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Oct 2011 14:01:44 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50977 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583Ab1JYSBn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2011 14:01:43 -0400
Received: by faan17 with SMTP id n17so777523faa.19
        for <git@vger.kernel.org>; Tue, 25 Oct 2011 11:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=md62sXa4JPrJs75X00/QDbN0tNisht3MTMuYfRov/LM=;
        b=pCR2jAB7sjDpJckvJliuTakMmnGTD/VFnhhGvrkERrSHKMIBkEgyKlaaP6bk4FBN8/
         hGR4oqlcisZ9xi/Om1rWbjY/+6HmWTU/poWjh+gWbHd4uuQM6cYse50AnVlx2JNBiXBw
         eG61lWDEzZI5N9vyFc7zE8qamQqVyI8wteV+Q=
Received: by 10.223.77.69 with SMTP id f5mr52884994fak.3.1319565702140;
        Tue, 25 Oct 2011 11:01:42 -0700 (PDT)
Received: from localhost.localdomain (dslc-082-083-206-079.pools.arcor-ip.net. [82.83.206.79])
        by mx.google.com with ESMTPS id j5sm16749034faf.14.2011.10.25.11.01.40
        (version=SSLv3 cipher=OTHER);
        Tue, 25 Oct 2011 11:01:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184229>

Git for Windows comes with a bash that doesn't support process substitution.
It issues the following error when using git-completion.bash with
GIT_PS1_SHOWUPSTREAM set:

$ export GIT_PS1_SHOWUPSTREAM=1
sh.exe": cannot make pipe for process substitution: Function not implemented
sh.exe": cannot make pipe for process substitution: Function not implemented
sh.exe": <(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n '): ambiguous redirect

Replace the process substitution with a simple "echo $var | while...".

Signed-off-by: Stefan Naewe <stefan.naewe@gmail.com>
---
 contrib/completion/git-completion.bash |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8648a36..926db80 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -110,6 +110,8 @@ __git_ps1_show_upstream ()
 	local upstream=git legacy="" verbose=""
 
 	# get some config options from git-config
+	output="$(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')"
+	echo "$output" | \
 	while read key value; do
 		case "$key" in
 		bash.showupstream)
@@ -125,7 +127,7 @@ __git_ps1_show_upstream ()
 			upstream=svn+git # default upstream is SVN if available, else git
 			;;
 		esac
-	done < <(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')
+	done
 
 	# parse configuration values
 	for option in ${GIT_PS1_SHOWUPSTREAM}; do
-- 
1.7.7.1
