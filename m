From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] t/t7001-mv.sh: Propose ability to use git-mv on conflicting
	entries
Date: Sun, 27 Jul 2008 15:47:48 +0200
Message-ID: <20080727134704.27534.86520.stgit@localhost>
References: <20080727134142.GA10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 27 15:49:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KN6cT-0005Ek-LN
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 15:49:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbYG0NsG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 09:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbYG0NsF
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 09:48:05 -0400
Received: from 159-162.104-92.cust.bluewin.ch ([92.104.162.159]:57802 "EHLO
	pixie.suse.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751355AbYG0NsE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 09:48:04 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by pixie.suse.cz (Postfix) with ESMTP id D7B52883E6;
	Sun, 27 Jul 2008 15:47:48 +0200 (CEST)
In-Reply-To: <20080727134142.GA10151@machine.or.cz>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90335>

Currently, git-mv will declare "not under source control" on an attempt
to move a conflicted index entry. This patch adds an expect_failure
testcase for this case, since this is an artificial restriction. (However,
the scenario is not critical enough for the author to fix right now.)

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

I don't really know if it is ok to make "feature requests" like this by
adding failing testcases...

 t/t7001-mv.sh |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 7e47931..241e9a2 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -173,6 +173,33 @@ test_expect_success 'git mv should not change sha1 of moved cache entry' '
 
 rm -f dirty dirty2
 
+cat >multistage <<EOT
+100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 1	staged
+100755 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 2	staged
+100755 d00491fd7e5bb6fa28c517a0bb32b8b506539d4d 3	staged
+EOT
+
+# Rationale: I cannot git mv around a conflicted file. This is unnecessary
+# restriction in case another part of conflict resolution requires me to
+# move the file around.
+test_expect_failure 'git mv should move all stages of cache entry' '
+
+	rm -fr .git &&
+	git init &&
+	# git mv requires object to exist in working tree (bug?)
+	touch staged &&
+	git update-index --index-info <multistage &&
+	git ls-files --stage >lsf_output &&
+	test_cmp multistage lsf_output &&
+	git mv staged staged-mv &&
+	sed "s/staged/staged-mv/" <multistage >multistage-mv &&
+	git ls-files --stage >lsf_output &&
+	test_cmp multistage-mv lsf_output
+
+'
+
+rm -f multistage multistage-mv lsf_output staged
+
 test_expect_failure 'git mv should overwrite symlink to a file' '
 
 	rm -fr .git &&
