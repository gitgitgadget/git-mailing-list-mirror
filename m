From: Brandon Casey <bcasey@nvidia.com>
Subject: [PATCH] contrib/git-prompt.sh: handle missing 'printf -v' more gracefully
Date: Wed, 21 Aug 2013 18:39:03 -0700
Message-ID: <1377135543-19053-1-git-send-email-bcasey@nvidia.com>
References: <1377134242-15012-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, <szeder@ira.uka.de>,
	Brandon Casey <drafnel@gmail.com>
To: <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 22 03:44:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCJxC-0002Sg-3i
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 03:44:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118Ab3HVBjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 21:39:07 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11803 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673Ab3HVBjG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 21:39:06 -0400
Received: from hqnvupgp08.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com
	id <B52156bb70000>; Wed, 21 Aug 2013 18:39:03 -0700
Received: from hqemhub01.nvidia.com ([172.20.12.94])
  by hqnvupgp08.nvidia.com (PGP Universal service);
  Wed, 21 Aug 2013 18:36:48 -0700
X-PGP-Universal: processed;
	by hqnvupgp08.nvidia.com on Wed, 21 Aug 2013 18:36:48 -0700
Received: from sc-xterm-13.nvidia.com (172.20.144.16) by hqemhub01.nvidia.com
 (172.20.150.30) with Microsoft SMTP Server id 8.3.298.1; Wed, 21 Aug 2013
 18:39:04 -0700
X-Mailer: git-send-email 1.8.4.rc0.2.g6cf5c31
In-Reply-To: <1377134242-15012-1-git-send-email-bcasey@nvidia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232760>

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


On 8/21/2013 6:27 PM, Junio C Hamano wrote:> Brandon Casey <drafnel@gmail.com> writes:
>
>> Why is "${var-}" necessary?  Wouldn't that be equivalent to "${var}"
>> or "$var"?
>
> set -u

Ah.  Thanks.  Updated.  Also minor tweak to use [ ] instead of test ...
to conform with the rest of the script.

-Brandon


 contrib/completion/git-prompt.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index a81ef5a..ca7fb35 100644
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
+		if [ "${__git_printf_supports_v-}" = yes ]; then
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
