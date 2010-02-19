From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] rebase -i: avoid --cherry-pick when rebasing to a direct ancestor
Date: Sat, 20 Feb 2010 00:30:52 +0100
Message-ID: <d1a75633daa062b25527dfb0675673480974c940.1266620423.git.trast@student.ethz.ch>
References: <dfb660301002191324i7aeca7f5x990501bbca1475a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Laine Walker-Avina <lwalkera@pasco.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 20 00:31:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NicJI-0004Kr-MC
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 00:31:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756404Ab0BSXaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 18:30:55 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:21905 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756260Ab0BSXaz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 18:30:55 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sat, 20 Feb
 2010 00:30:55 +0100
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sat, 20 Feb
 2010 00:30:53 +0100
X-Mailer: git-send-email 1.7.0.139.gd1a75
In-Reply-To: <dfb660301002191324i7aeca7f5x990501bbca1475a9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140502>

Ordinary 'rebase -i' reads the commits to rebase with (roughly)

  git rev-list --left-right --cherry-pick $upstream...

which gives it the feature of skipping commits that are already
present in $upstream.  However, in the common use-case of rewriting a
few commits up to an ancestor, as in 'git rebase -i HEAD~3', the
--cherry-pick is useless since there are no commits to compare to.

Add a check if $upstream is a direct ancestor of HEAD, and leave away
the --cherry-pick if so.  Since the --cherry-pick is already in
$MERGES_OPTION, we need to decide this before setting the latter.

For simplicity we skip --root mode.  In theory we could do the same
optimization, but using --root --onto <ancestor> is probably even more
rare than having performance issues with --cherry-pick.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

The --cherry-pick mechanism itself could get a similar optimization,
but I don't know that code.


 git-rebase--interactive.sh |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 1fda620..10b0ed8 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -870,7 +870,12 @@ first and then run 'git rebase --continue' again."
 			MERGES_OPTION=
 			first_after_upstream="$(git rev-list --reverse --first-parent $UPSTREAM..$HEAD | head -n 1)"
 		else
-			MERGES_OPTION="--no-merges --cherry-pick"
+			if test -z "$REBASE_ROOT" &&
+				test $(git merge-base $UPSTREAM $HEAD) = $UPSTREAM; then
+				MERGES_OPTION="--no-merges"
+			else
+				MERGES_OPTION="--no-merges --cherry-pick"
+			fi
 		fi
 
 		SHORTHEAD=$(git rev-parse --short $HEAD)
-- 
1.7.0.139.gd1a75
