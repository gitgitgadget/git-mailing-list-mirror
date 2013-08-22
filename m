From: Brandon Casey <bcasey@nvidia.com>
Subject: [PATCH] contrib/git-prompt.sh: handle missing 'printf -v' more gracefully
Date: Wed, 21 Aug 2013 18:17:22 -0700
Message-ID: <1377134242-15012-1-git-send-email-bcasey@nvidia.com>
References: <CA+sFfMfa422PF1inOOeTBRE7HRqL5zwCJNagx9Ya0i_LbpwQcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, <szeder@ira.uka.de>,
	Brandon Casey <drafnel@gmail.com>
To: <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 22 03:17:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCJWq-0004FG-En
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 03:17:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753134Ab3HVBRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 21:17:32 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9510 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752468Ab3HVBRb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 21:17:31 -0400
Received: from hqnvupgp07.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com
	id <B521566a80000>; Wed, 21 Aug 2013 18:17:28 -0700
Received: from hqemhub01.nvidia.com ([172.20.12.94])
  by hqnvupgp07.nvidia.com (PGP Universal service);
  Wed, 21 Aug 2013 18:17:31 -0700
X-PGP-Universal: processed;
	by hqnvupgp07.nvidia.com on Wed, 21 Aug 2013 18:17:31 -0700
Received: from sc-xterm-13.nvidia.com (172.20.144.16) by hqemhub01.nvidia.com
 (172.20.150.30) with Microsoft SMTP Server id 8.3.298.1; Wed, 21 Aug 2013
 18:17:31 -0700
X-Mailer: git-send-email 1.8.4.rc0.2.g6cf5c31
In-Reply-To: <CA+sFfMfa422PF1inOOeTBRE7HRqL5zwCJNagx9Ya0i_LbpwQcg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232757>

From: Brandon Casey <drafnel@gmail.com>

Old Bash (3.0) which is distributed with RHEL 4.X and other ancient
platforms that are still in wide use, do not have a printf that
supports -v.  Neither does Zsh (which is already handled in the code).

As suggested by Junio, let's test whether printf supports the -v
option and store the result.  Then later, we can use it to
determine whether 'printf -v' can be used, or whether printf
must be called in a subshell.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---

This replaces [PATCH 3/3] Revert "bash prompt: avoid command substitution
when finalizing gitstring".

This may or may not need to be updated to use "${var-}" depending on
your response to my other email, but this seems sufficient.

-Brandon

 contrib/completion/git-prompt.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index a81ef5a..639888a 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -84,6 +84,10 @@
 # the colored output of "git status -sb" and are available only when
 # using __git_ps1 for PROMPT_COMMAND or precmd.
 
+# check whether printf supports -v
+__git_printf_supports_v=
+printf -v __git_printf_supports_v -- '%s' yes >/dev/null 2>&1
+
 # stores the divergence from upstream in $p
 # used by GIT_PS1_SHOWUPSTREAM
 __git_ps1_show_upstream ()
@@ -433,10 +437,10 @@ __git_ps1 ()
 	local gitstring="$c${b##refs/heads/}${f:+$z$f}$r$p"
 
 	if [ $pcmode = yes ]; then
-		if [[ -n ${ZSH_VERSION-} ]]; then
-			gitstring=$(printf -- "$printf_format" "$gitstring")
-		else
+		if test "$__git_printf_supports_v" = yes; then
 			printf -v gitstring -- "$printf_format" "$gitstring"
+		else
+			gitstring=$(printf -- "$printf_format" "$gitstring")
 		fi
 		PS1="$ps1pc_start$gitstring$ps1pc_end"
 	else
-- 
1.8.4.rc0.2.g6cf5c31


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
