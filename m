From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH] Speedup bash completion loading
Date: Mon,  5 Oct 2009 14:03:59 +0400
Message-ID: <1254737039-10404-1-git-send-email-kirr@mns.spb.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 05 12:28:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MuklL-00024T-HA
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 12:25:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758589AbZJEKWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 06:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758557AbZJEKWs
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 06:22:48 -0400
Received: from mail.mnsspb.ru ([84.204.75.2]:55445 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751986AbZJEKWr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 06:22:47 -0400
X-Greylist: delayed 1010 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Oct 2009 06:22:47 EDT
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1MukRH-0000m7-If; Mon, 05 Oct 2009 14:05:07 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.69)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1MukQd-0002iL-2s; Mon, 05 Oct 2009 14:04:27 +0400
X-Mailer: git-send-email 1.6.5.rc2.17.gdbc1b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129550>

On my slow laptop (P3 700MHz), system-wide bash completions take too
much time to load (> 1s), and significant fraction of this time is spent
loading git-completion.bash:

    $ time bash -c '. git-completion.bash'  # before this patch

    real    0m0.317s
    user    0m0.250s
    sys     0m0.060s

I've tracked down that the most time is spent warming up merge_strategy,
all_command & porcelain_command caches.

Since git is not used in each and every interactive xterm, I think it
would be perfectly ok to load completion support with cold caches, and
then load needed thing lazily.

As __git_merge_stratiegies(), __git_all_commands() &
__git_porcelain_command() already cache their results, we can safely
remove associated cache initialization code and be done with it:

    $ time bash -c '. git-completion.bash'  # after this patch

    real    0m0.069s
    user    0m0.050s
    sys     0m0.020s

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---
 contrib/completion/git-completion.bash |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 2c2a0d4..4c09d41 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -340,7 +340,6 @@ __git_merge_strategies ()
 	}'
 }
 __git_merge_strategylist=
-__git_merge_strategylist=$(__git_merge_strategies 2>/dev/null)
 
 __git_complete_file ()
 {
@@ -505,7 +504,6 @@ __git_all_commands ()
 	done
 }
 __git_all_commandlist=
-__git_all_commandlist="$(__git_all_commands 2>/dev/null)"
 
 __git_porcelain_commands ()
 {
@@ -596,7 +594,6 @@ __git_porcelain_commands ()
 	done
 }
 __git_porcelain_commandlist=
-__git_porcelain_commandlist="$(__git_porcelain_commands 2>/dev/null)"
 
 __git_aliases ()
 {
-- 
1.6.5.rc2.17.gdbc1b
