From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH] prompt: fix show upstream with svn and zsh
Date: Tue, 21 May 2013 22:54:27 +0200
Message-ID: <1369169667-25166-1-git-send-email-t.gummerer@gmail.com>
Cc: felipe.contreras@gmail.com, gitster@pobox.com, szeder@ira.uka.de,
	t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 21 22:57:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UetcB-00060v-5W
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 22:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755122Ab3EUU4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 16:56:54 -0400
Received: from mail-ee0-f43.google.com ([74.125.83.43]:35910 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174Ab3EUUzE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 16:55:04 -0400
Received: by mail-ee0-f43.google.com with SMTP id d41so719077eek.16
        for <git@vger.kernel.org>; Tue, 21 May 2013 13:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=RVg/SuC0vLsfYnYd0OHaUlbTumFzBJ2dBK804KN9A1k=;
        b=UjqMsmuy5PUpUMOiCU3AcfphXCXca3ybAF9qDu0GPcwKsAqWgY84hPcd9X91dZU2HT
         7tsdh1bpHCGkAhzjXPG2vttwBY/0qqqoSlZ+0Cp7GNKCFA1uDhX81r4b0/ouVcBv3sjV
         IYQe0Cw1dY8EmoyPAC/1S19NzsJNh0DqGI+a1OpsFmiNAZu+5AOMNAhiEc3gxM3TJECV
         K/bT/6uc/YjoM2sMTmgdASFLiuR5lTGQ8Aty1TKWiF75HGW2kZNfvmvGYOl7WlhMKwx3
         Qrc4kK2kV2Mv9Hp3JYI816zbdqJto3v3Y1kesCGOPyl5qz3P4vdRS/Ai/cMUEYbUf+Ji
         9v3w==
X-Received: by 10.14.172.195 with SMTP id t43mr10761192eel.34.1369169703387;
        Tue, 21 May 2013 13:55:03 -0700 (PDT)
Received: from localhost (host41-110-dynamic.0-79-r.retail.telecomitalia.it. [79.0.110.41])
        by mx.google.com with ESMTPSA id y10sm5947841eev.3.2013.05.21.13.55.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 21 May 2013 13:55:01 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.359.g2fb82f5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225076>

Currently the __git_ps1 git prompt gives the following error with a
repository converted by git-svn, when used with zsh:

	   __git_ps1_show_upstream:19: bad pattern: svn_remote[

This was introduced by 6d158cba (bash completion: Support "divergence
from upstream" messages in __git_ps1), when the script was for bash
only.  Make it compatible with zsh.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
Tested with bash 4.2.45 and zsh 5.0.2.

 contrib/completion/git-prompt.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index eaf5c36..e537300 100644
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
@@ -146,8 +146,8 @@ __git_ps1_show_upstream ()
 	svn*)
 		# get the upstream from the "git-svn-id: ..." in a commit message
 		# (git-svn uses essentially the same procedure internally)
-		local svn_upstream=($(git log --first-parent -1 \
-					--grep="^git-svn-id: \(${svn_url_pattern#??}\)" 2>/dev/null))
+		set -a svn_upstream "$(git log --first-parent -1 \
+					--grep="^git-svn-id: \(${svn_url_pattern#??}\)" 2>/dev/null)"
 		if [[ 0 -ne ${#svn_upstream[@]} ]]; then
 			svn_upstream=${svn_upstream[ ${#svn_upstream[@]} - 2 ]}
 			svn_upstream=${svn_upstream%@*}
-- 
1.8.3.rc2.359.g2fb82f5
