From: Stefan Naewe <stefan.naewe@gmail.com>
Subject: [PATCH v2] completion: fix issue with process substitution not working on Git for Windows
Date: Wed, 26 Oct 2011 21:13:09 +0200
Message-ID: <1319656389-9515-1-git-send-email-stefan.naewe@gmail.com>
References: <CAJzBP5QYKOf4OUMm4vfVay=b7F_fHJf40JgzDAZZa7p0fxLpyA@mail.gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Stefan Naewe <stefan.naewe@gmail.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Oct 26 21:13:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJ8uv-0002t4-Fw
	for gcvg-git-2@lo.gmane.org; Wed, 26 Oct 2011 21:13:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571Ab1JZTN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Oct 2011 15:13:28 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34731 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389Ab1JZTN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2011 15:13:27 -0400
Received: by faan17 with SMTP id n17so1877919faa.19
        for <git@vger.kernel.org>; Wed, 26 Oct 2011 12:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=np7VpzRDG5n/W1Wyx546PsS5D5UBsXrd7GkN7YbNGCI=;
        b=LETva0C7a2qJsr+3GzSS05fdiHWnLv1pDy9EUDnDczAchqbEIvPd71dLOQQQeY8k5N
         Z9jj/zxh9Hc1AEgdMz7AEA4keh8wJPurkima/QMcqxDLBfzUXDFe3rOLckFNcHSFDt0a
         MXOk5144jAdP7cmEVHafBEn+UXvFQqqF8Sw7s=
Received: by 10.223.61.211 with SMTP id u19mr60805048fah.29.1319656406659;
        Wed, 26 Oct 2011 12:13:26 -0700 (PDT)
Received: from localhost.localdomain (dslc-082-083-206-079.pools.arcor-ip.net. [82.83.206.79])
        by mx.google.com with ESMTPS id v19sm5757969faa.13.2011.10.26.12.13.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 26 Oct 2011 12:13:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <CAJzBP5QYKOf4OUMm4vfVay=b7F_fHJf40JgzDAZZa7p0fxLpyA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184271>

Git for Windows comes with a bash that doesn't support process substitution.
It issues the following error when using git-completion.bash with
GIT_PS1_SHOWUPSTREAM set:

$ export GIT_PS1_SHOWUPSTREAM=1
sh.exe": cannot make pipe for process substitution: Function not implemented
sh.exe": cannot make pipe for process substitution: Function not implemented
sh.exe": <(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n '): ambiguous redirect

Replace the process substitution with a 'here string'.

Signed-off-by: Stefan Naewe <stefan.naewe@gmail.com>
---
 contrib/completion/git-completion.bash |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8648a36..0b3d47e 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -110,6 +110,7 @@ __git_ps1_show_upstream ()
 	local upstream=git legacy="" verbose=""
 
 	# get some config options from git-config
+	output="$(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')"
 	while read key value; do
 		case "$key" in
 		bash.showupstream)
@@ -125,7 +126,7 @@ __git_ps1_show_upstream ()
 			upstream=svn+git # default upstream is SVN if available, else git
 			;;
 		esac
-	done < <(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')
+	done <<< "$output"
 
 	# parse configuration values
 	for option in ${GIT_PS1_SHOWUPSTREAM}; do
-- 
1.7.7.1
