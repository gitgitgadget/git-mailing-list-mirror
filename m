From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 3/3] rebase: error out for NO_PYTHON if they use recursive merge
Date: Wed, 21 Jun 2006 03:04:42 -0700
Message-ID: <11508842853098-git-send-email-normalperson@yhbt.net>
References: <20060621100138.GA15748@localdomain> <11508842824018-git-send-email-normalperson@yhbt.net> <11508842842125-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jun 21 12:05:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FszZs-0006Ob-7y
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 12:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbWFUKEs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 06:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWFUKEs
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 06:04:48 -0400
Received: from hand.yhbt.net ([66.150.188.102]:9372 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751461AbWFUKEs (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jun 2006 06:04:48 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id A1FEC7DC024;
	Wed, 21 Jun 2006 03:04:45 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 21 Jun 2006 03:04:45 -0700
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-Mailer: git-send-email 1.4.0.g65f3
In-Reply-To: <11508842842125-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22254>

recursive merge relies on Python, and we can't perform
rename-aware merges without the recursive merge.  So bail out
before trying it.

The test won't work w/o recursive merge, either, so skip that,
too.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-rebase.sh           |    9 +++++++++
 t/t3402-rebase-merge.sh |    6 ++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index bce7bf8..b9ce112 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -300,6 +300,15 @@ then
 	exit $?
 fi
 
+if test "@@NO_PYTHON@@" && test "$strategy" = "recursive"
+then
+	die 'The recursive merge strategy currently relies on Python,
+which this installation of git was not configured with.  Please consider
+a different merge strategy (e.g. octopus, resolve, stupid, ours)
+or install Python and git with Python support.'
+
+fi
+
 # start doing a rebase with git-merge
 # this is rename-aware if the recursive (default) strategy is used
 
diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
index 8c7a519..f1c1f35 100755
--- a/t/t3402-rebase-merge.sh
+++ b/t/t3402-rebase-merge.sh
@@ -7,6 +7,12 @@ test_description='git rebase --merge tes
 
 . ./test-lib.sh
 
+if test "$no_python"; then
+	echo "Skipping: no python => no recursive merge"
+	test_done
+	exit 0
+fi
+
 T="A quick brown fox
 jumps over the lazy dog."
 for i in 1 2 3 4 5 6 7 8 9 10
-- 
1.4.0.g65f3
