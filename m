From: Andreas Ericsson <ae@op5.se>
Subject: [PATCH 3/3] git pull: Support --preserve-merges as a flag to rebase
Date: Tue, 23 Sep 2008 22:58:20 +0200
Message-ID: <48D9586C.4010102@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 22:59:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiEyp-0008Ke-2Z
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 22:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754789AbYIWU6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 16:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754786AbYIWU6Z
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 16:58:25 -0400
Received: from mail.op5.se ([193.201.96.20]:34474 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754788AbYIWU6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 16:58:24 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id AEE651B8004D;
	Tue, 23 Sep 2008 22:48:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.199
X-Spam-Level: 
X-Spam-Status: No, score=-3.199 tagged_above=-10 required=6.6
	tests=[AWL=-0.700, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5zerPG0AfWwr; Tue, 23 Sep 2008 22:48:55 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.6])
	by mail.op5.se (Postfix) with ESMTP id 6E90324B0D2C;
	Tue, 23 Sep 2008 22:48:55 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96595>

Now that "git rebase" supports non-interactive rebases
preserving merges, this patch is the next logical step
for those who wish to use such a workflow.

Since this patch makes the last test marked as expecting
failure in t3409-rebase-preserve-merges, we now alter it
to expect success.

Signed-off-by: Andreas Ericsson <ae@op5.se>
---
 Documentation/git-pull.txt        |    4 ++++
 git-pull.sh                       |    6 +++++-
 t/t3409-rebase-preserve-merges.sh |    2 +-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 7578623..333fc55 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -47,6 +47,10 @@ unless you have read linkgit:git-rebase[1] carefully.
 --no-rebase::
 	Override earlier --rebase.
 
+--preserve-merges::
+	Preserves merge commits when rebasing. Implies --rebase,
+	so the same warnings naturally apply.
+
 include::fetch-options.txt[]
 
 include::pull-fetch-param.txt[]
diff --git a/git-pull.sh b/git-pull.sh
index 75c3610..270a50d 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -58,6 +58,10 @@ do
 	-r|--r|--re|--reb|--reba|--rebas|--rebase)
 		rebase=true
 		;;
+	--preserve-merges) # no short option for this
+		preserve_merges="--preserve-merges"
+		rebase=true
+		;;
 	--no-r|--no-re|--no-reb|--no-reba|--no-rebas|--no-rebase)
 		rebase=false
 		;;
@@ -179,7 +183,7 @@ fi
 
 merge_name=$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || exit
 test true = "$rebase" &&
-	exec git-rebase $strategy_args --onto $merge_head \
+	exec git-rebase $preserve_merges $strategy_args --onto $merge_head \
 	${oldremoteref:-$merge_head}
 exec git-merge $no_stat $no_commit $squash $no_ff $log_arg $strategy_args \
 	"$merge_name" HEAD $merge_head
diff --git a/t/t3409-rebase-preserve-merges.sh b/t/t3409-rebase-preserve-merges.sh
index 21b8c79..9a376ef 100644
--- a/t/t3409-rebase-preserve-merges.sh
+++ b/t/t3409-rebase-preserve-merges.sh
@@ -51,7 +51,7 @@ test_expect_success 'setup for merge-preserving rebase' \
 	git commit -a -m "Modify B2"
 '
 
-test_expect_failure 'git pull --rebase -p on moved topic' '
+test_expect_success 'git pull --rebase -p on moved topic' '
 	cd clone1 &&
 	git pull --rebase --preserve-merges &&
 	test $(git rev-list --all --pretty=oneline | grep "Modify A" | wc -l) = 1
-- 
1.6.0.2.307.gc4275.dirty
