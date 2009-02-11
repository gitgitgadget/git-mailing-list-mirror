From: Ted Pavlic <ted@tedpavlic.com>
Subject: [PATCH 3/3] completion: Prevents GIT_PS1_DIRTYSTATE from breaking when CWD is .git
Date: Wed, 11 Feb 2009 10:37:14 -0500
Message-ID: <1234366634-17900-4-git-send-email-ted@tedpavlic.com>
References: <1234366634-17900-1-git-send-email-ted@tedpavlic.com>
 <1234366634-17900-2-git-send-email-ted@tedpavlic.com>
 <1234366634-17900-3-git-send-email-ted@tedpavlic.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Ted Pavlic <ted@tedpavlic.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Feb 11 16:39:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXHBJ-0002IF-RE
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 16:39:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756003AbZBKPhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 10:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756035AbZBKPhd
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 10:37:33 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:35911 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757419AbZBKPh1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Feb 2009 10:37:27 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 28A5880D8065;
	Wed, 11 Feb 2009 10:30:55 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wPsJ-hNdGah3; Wed, 11 Feb 2009 10:30:55 -0500 (EST)
Received: from localhost.localdomain (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 0A66F80D8086;
	Wed, 11 Feb 2009 10:30:55 -0500 (EST)
X-Mailer: git-send-email 1.6.1.2.390.gba743
In-Reply-To: <1234366634-17900-3-git-send-email-ted@tedpavlic.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109430>

The GIT_PS1_DIRTYSTATE support uses a "git diff" to see if a "*" should
be placed after the branch name. The "git diff" fails with an ugly error
if the user has just changed directory into GIT_DIR.

This patch uses "git rev-parse --is-inside-work-tree" to determine
whether a "--work-tree=.." should be added to the "git diff".

Signed-off-by: Ted Pavlic <ted@tedpavlic.com>
---
 contrib/completion/git-completion.bash |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6772be7..ffde82a 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -115,10 +115,14 @@ __git_ps1 ()
 
 		local w
 		local i
+		local worktreestr
 
 		if test -n "${GIT_PS1_SHOWDIRTYSTATE-}"; then
 			if test "$(git config --bool bash.showDirtyState)" != "false"; then
-				git diff --no-ext-diff --ignore-submodules \
+				if test "false" = "$(git rev-parse --is-inside-work-tree 2>/dev/null)"; then
+					worktreestr="--work-tree=.."
+				fi
+				git ${worktreestr} diff --no-ext-diff --ignore-submodules \
 					--quiet --exit-code || w="*"
 				if git rev-parse --quiet --verify HEAD >/dev/null; then
 					git diff-index --cached --quiet \
-- 
1.6.1.2.390.gba743
