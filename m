From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: [TopGit PATCH] tg import: fix + make more robust
Date: Thu, 18 Sep 2008 20:29:30 +0400
Message-ID: <1221755370-6817-4-git-send-email-kirr@landau.phys.spbu.ru>
References: <1221755370-6817-1-git-send-email-kirr@landau.phys.spbu.ru>
Cc: Git Mailing List <git@vger.kernel.org>,
	Kirill Smelkov <kirr@landau.phys.spbu.ru>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Sep 18 19:19:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgNAB-0002JT-G4
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 19:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754452AbYIRRSX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 13:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754356AbYIRRSX
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 13:18:23 -0400
Received: from vs281.server4u.cz ([81.91.85.31]:35259 "EHLO vs281.server4u.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754219AbYIRRSW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 13:18:22 -0400
Received: from localhost ([127.0.0.1] helo=roro3)
	by vs281.server4u.cz with esmtp (Exim 4.69)
	(envelope-from <kirr@landau.phys.spbu.ru>)
	id 1KgMcM-000089-Tg; Thu, 18 Sep 2008 18:44:35 +0200
Received: from kirr by roro3 with local (Exim 4.69)
	(envelope-from <kirr@roro3>)
	id 1KgMNm-0001nk-4n; Thu, 18 Sep 2008 20:29:30 +0400
X-Mailer: git-send-email 1.6.0.2.250.g965aa
In-Reply-To: <1221755370-6817-1-git-send-email-kirr@landau.phys.spbu.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96223>

a5bf892d0900cbf9949f628c3e05db599341a02c (tg import: Check out new files
as we go) broke tg-import. This is how it fails after that change:

    $ tg import Z~~..Z
    tg: ---- Importing e3e8c1382fe4cedca31e955910914ae0033455eb to t/Z
    tg: Automatically marking dependency on master
    tg: Creating t/Z base from master...
    Switched to a new branch "t/Z"
    tg: Topic branch t/Z set up. Please fill .topmsg now and make initial commit.
    tg: To abort: git rm -f .top* && git checkout master && tg delete t/Z
    fatal: pathspec '.topdeps' did not match any files

That's why, when we do git read-tree -u -m it _kills_ .topmsg and
.topdep both in index and in working tree!

Also, imagine that we are going to import patch C onto A

o---B---A
     \
      C

With read-tree we'll *override* any change in common files between A and
B, so I think read-tree is wrong here (it was ok if we are importing
on top of B).

What is right it seems, is to work on diff level -- to use cherry-pick.
And since cherry-pick does not kill our already-in-index .topmsg and
.topdeps we automatically fix the breakage.

Signed-off-by: Kirill Smelkov <kirr@landau.phys.spbu.ru>
---
 tg-import.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tg-import.sh b/tg-import.sh
index 68477f0..799efc9 100644
--- a/tg-import.sh
+++ b/tg-import.sh
@@ -61,7 +61,7 @@ process_commit()
 	branch_name=$(get_branch_name "$commit")
 	info "---- Importing $commit to $branch_prefix$branch_name"
 	tg create "$branch_prefix""$branch_name"
-	git read-tree -u -m "$commit"
+	git cherry-pick --no-commit "$commit"
 	get_commit_msg "$commit" > .topmsg
 	git add -f .topmsg .topdeps
 	git commit -C "$commit"
-- 
1.6.0.2.250.g965aa
