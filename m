From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] pull: use merge-base --fork-point when appropriate
Date: Sun,  8 Dec 2013 12:47:25 +0000
Message-ID: <b208a2edcaf47bf1a97ec19718854dc1b3646828.1386506845.git.john@keeping.me.uk>
Cc: Martin von Zweigbergk <martinvonz@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 08 13:47:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vpdly-000585-6K
	for gcvg-git-2@plane.gmane.org; Sun, 08 Dec 2013 13:47:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754184Ab3LHMrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Dec 2013 07:47:42 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:52993 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765Ab3LHMrl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Dec 2013 07:47:41 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 8E5C6CDA59E;
	Sun,  8 Dec 2013 12:47:40 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dlfwb3PVWLsk; Sun,  8 Dec 2013 12:47:39 +0000 (GMT)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 1A36DCDA566;
	Sun,  8 Dec 2013 12:47:31 +0000 (GMT)
X-Mailer: git-send-email 1.8.5.226.g0d60d77
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239044>

Since commit d96855f (merge-base: teach "--fork-point" mode, 2013-10-23)
we can replace a shell loop in git-pull with a single call to
git-merge-base.  So let's do so.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git-pull.sh | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index b946fd9..605e957 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -229,15 +229,7 @@ test true = "$rebase" && {
 	test -n "$curr_branch" &&
 	. git-parse-remote &&
 	remoteref="$(get_remote_merge_branch "$@" 2>/dev/null)" &&
-	oldremoteref="$(git rev-parse -q --verify "$remoteref")" &&
-	for reflog in $(git rev-list -g $remoteref 2>/dev/null)
-	do
-		if test "$reflog" = "$(git merge-base $reflog $curr_branch)"
-		then
-			oldremoteref="$reflog"
-			break
-		fi
-	done
+	oldremoteref=$(git merge-base --fork-point "$remoteref" $curr_branch)
 }
 orig_head=$(git rev-parse -q --verify HEAD)
 git fetch $verbosity $progress $dry_run $recurse_submodules --update-head-ok "$@" || exit 1
-- 
1.8.5.226.g0d60d77
