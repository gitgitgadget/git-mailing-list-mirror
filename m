From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2] prompt: fix show upstream with svn and zsh
Date: Wed, 22 May 2013 09:40:39 +0200
Message-ID: <1369208439-20061-1-git-send-email-t.gummerer@gmail.com>
References: <1369169667-25166-1-git-send-email-t.gummerer@gmail.com>
Cc: felipe.contreras@gmail.com, szeder@ira.uka.de,
	t.gummerer@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 22 09:41:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uf3gE-0004Pt-72
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 09:41:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753234Ab3EVHln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 03:41:43 -0400
Received: from mail-ee0-f53.google.com ([74.125.83.53]:39687 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445Ab3EVHln (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 03:41:43 -0400
Received: by mail-ee0-f53.google.com with SMTP id c1so897624eek.26
        for <git@vger.kernel.org>; Wed, 22 May 2013 00:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=HwS/j+sDTdpNNkgI60m5cUeUFni5R3Mk4MVFhkM+9Uw=;
        b=obD9fUjsWxr2qDjcOiM2RadHqvuyIxHQgCP/NabGhD4Wd+U35645dagjnU3lMm8HZo
         laKMoc0mEPKDwrerPDw9xCBtFVAACGscAaQf5x344xsnunvNL5qZjF+LdFeWkyQMG5r6
         h0uWfhOiYGeHn6EqocPeTRcm5V+cYxYJw1hzkmHcbWArKdMNA73vhW6+wUQWDCAIvNsK
         KJh8ckOypkOHMprAQ9/x7OYkbvqhnm2j0eLczND+R7+zEZu0me32J9TI2MtC+erGO1x4
         A3ET63YP5+IDk7qpWypsXtFeAxBWzVollpORcbcIcRkH4dxPzTlWgWXEXZjK9TkbRaBg
         YhJA==
X-Received: by 10.14.246.137 with SMTP id q9mr15952192eer.39.1369208501744;
        Wed, 22 May 2013 00:41:41 -0700 (PDT)
Received: from localhost (nat5.unibz.it. [46.18.27.5])
        by mx.google.com with ESMTPSA id bn53sm8284838eeb.7.2013.05.22.00.41.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 22 May 2013 00:41:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.359.g2fb82f5
In-Reply-To: <1369169667-25166-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225136>

Currently the __git_ps1 git prompt gives the following error with a
repository converted by git-svn, when used with zsh:

   __git_ps1_show_upstream:19: bad pattern: svn_remote[
   __git_ps1_show_upstream:45: bad substitution

To reproduce the problem, the __git_ps1_show_upstream function can be
executed in a repository converted with git-svn.  Both those errors are
triggered by spaces after the '['.

Zsh also doesn't support initializing an array with `local var=(...)`.
This triggers the following error:

   __git_ps1_show_upstream:41: bad pattern: svn_upstream=(commit

Use
   local -a
   var=(...)
instead to make is compatible.

This was introduced by 6d158cba (bash completion: Support "divergence
from upstream" messages in __git_ps1), when the script was for bash
only.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 contrib/completion/git-prompt.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index eaf5c36..b6b1534 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -124,7 +124,7 @@ __git_ps1_show_upstream ()
 			fi
 			;;
 		svn-remote.*.url)
-			svn_remote[ $((${#svn_remote[@]} + 1)) ]="$value"
+			svn_remote[$((${#svn_remote[@]} + 1))]="$value"
 			svn_url_pattern+="\\|$value"
 			upstream=svn+git # default upstream is SVN if available, else git
 			;;
@@ -146,10 +146,11 @@ __git_ps1_show_upstream ()
 	svn*)
 		# get the upstream from the "git-svn-id: ..." in a commit message
 		# (git-svn uses essentially the same procedure internally)
-		local svn_upstream=($(git log --first-parent -1 \
+		local -a svn_upstream
+		svn_upstream=($(git log --first-parent -1 \
 					--grep="^git-svn-id: \(${svn_url_pattern#??}\)" 2>/dev/null))
 		if [[ 0 -ne ${#svn_upstream[@]} ]]; then
-			svn_upstream=${svn_upstream[ ${#svn_upstream[@]} - 2 ]}
+			svn_upstream=${svn_upstream[${#svn_upstream[@]} - 2]}
 			svn_upstream=${svn_upstream%@*}
 			local n_stop="${#svn_remote[@]}"
 			for ((n=1; n <= n_stop; n++)); do
-- 
1.8.3.rc2.359.g2fb82f5
