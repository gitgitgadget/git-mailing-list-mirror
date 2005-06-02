From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] cg-log: cleanup line wrapping by using bash internals
Date: Thu, 2 Jun 2005 16:46:21 +0200
Message-ID: <20050602144621.GB16143@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 16:46:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ddqww-0000EJ-Tn
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 16:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVFBOs1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 10:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261152AbVFBOs1
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 10:48:27 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:22749 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261151AbVFBOru (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2005 10:47:50 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id CD8C46E135F; Thu,  2 Jun 2005 16:45:44 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 854856E1349; Thu,  2 Jun 2005 16:45:44 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 96D3F61FE0; Thu,  2 Jun 2005 16:46:21 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Use ${#var} instead of echo + wc combo. Additionally also gives
a minor speedup.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

cg-log -f

new code:
	real    1m15.462s
	user    0m27.195s
	sys     0m40.639s

old code:
	real    1m38.222s
	user    0m32.563s
	sys     0m56.034s

BTW, I noticed the following errors:

	fatal: internal error in diffcore: unmodified entry remains
	fatal: internal error in diffcore: unmodified entry remains
	fatal: internal error in diffcore: unmodified entry remains

with both current cogito and git.

To reproduce run either of the following in the cogito repo:

git-diff-tree -r 7c1f9aa894ce91928d982a0b197ab596375825a3 e30dd6c68e576d37bddd011aa7131a6d30297b4c	
git-diff-tree -r c49cd3e4f1dfe4ccbf2b8d00188beaa251fee028 9fec8b26eff58e1f595e8619abf1e42c07645ff8

The last one also triggers in the git repo.
The log entries for the two commits are:

commit 6616d1835e81ac0d2304702102d210451c04832a
tree 7c1f9aa894ce91928d982a0b197ab596375825a3
parent e30dd6c68e576d37bddd011aa7131a6d30297b4c
parent e8871e88adca0637eb0299a41d85400beac928bd
author Petr Baudis <pasky@ucw.cz> Sun, 17 Apr 2005 19:30:32 +0200
committer Petr Baudis <xpasky@machine> Sun, 17 Apr 2005 19:30:32 +0200

    Merging: d72ff74f5fd172c6ec9630ee8e08895a0525dcfe

    Merge with Linus. Nothing particularily interesting.

commit e44794706eeb57f2ee38ed1604821aa38b8ad9d2
tree c49cd3e4f1dfe4ccbf2b8d00188beaa251fee028
parent 9fec8b26eff58e1f595e8619abf1e42c07645ff8
author Linus Torvalds <torvalds@ppc970.osdl.org> Sat, 16 Apr 2005 22:26:31 -0700
committer Linus Torvalds <torvalds@ppc970.osdl.org> Sat, 16 Apr 2005 22:26:31 -0700

    Be much more liberal about the file mode bits.

    We only really care about the difference between a file being executable
    or not (by its owner). Everything else we leave for the user umask to
    decide.

Any ideas?

 cg-log |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/cg-log b/cg-log
--- a/cg-log
+++ b/cg-log
@@ -129,8 +129,8 @@ list_commit_files()
 	$list_cmd | cut -f 2- | while read file; do
 		echo -n "$sep"
 		sep=", "
-		if [ $(echo "$line$sep$file" | wc -c) -le 75 ]; then
-			line="$line$sep$file"
+		line="$line$sep$file"
+		if [ "${#line}" -le 74 ]; then
 			echo -n "$file"
 		else
 			line="      $file"
-- 
Jonas Fonseca
