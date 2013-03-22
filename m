From: Kacper Kornet <draenog@pld-linux.org>
Subject: [PATCH v2] Fix revision walk for commits with the same dates
Date: Fri, 22 Mar 2013 19:38:19 +0100
Message-ID: <20130322183819.GA18210@camk.edu.pl>
References: <20130307180321.GA26756@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 22 19:39:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ6rx-00073w-6W
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 19:39:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754575Ab3CVSip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 14:38:45 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:50851 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754499Ab3CVSio (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 14:38:44 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id CE4A65F0001
	for <git@vger.kernel.org>; Fri, 22 Mar 2013 19:38:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id yjFFUjYL+gUT for <git@vger.kernel.org>;
	Fri, 22 Mar 2013 19:38:37 +0100 (CET)
Received: from gatekeeper.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id B98285F0004
	for <git@vger.kernel.org>; Fri, 22 Mar 2013 19:38:31 +0100 (CET)
Received: by gatekeeper.camk.edu.pl (Postfix, from userid 1293)
	id 89D744838A; Fri, 22 Mar 2013 19:38:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20130307180321.GA26756@camk.edu.pl>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218835>

Logic in still_interesting function allows to stop the commits
traversing if the oldest processed commit is not older then the
youngest commit on the list to process and the list contains only
commits marked as not interesting ones. It can be premature when dealing
with a set of coequal commits. For example git rev-list A^! --not B
provides wrong answer if all commits in the range A..B had the same
commit time and there are more then 7 of them.

To fix this problem the relevant part of the logic in still_interesting
is changed to: the walk can be stopped if the oldest processed commit is
younger then the youngest commit on the list to processed.

Signed-off-by: Kacper Kornet <draenog@pld-linux.org>
---

I don't know whether the first version was overlooked or deemed as not
worthy. So just in case I resend it. Changes since the first version:

1. The test has been added
2. The commit log has been rewritten


 revision.c                 |  2 +-
 t/t6009-rev-list-parent.sh | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index ef60205..cf620c6 100644
--- a/revision.c
+++ b/revision.c
@@ -709,7 +709,7 @@ static int still_interesting(struct commit_list *src, unsigned long date, int sl
 	 * Does the destination list contain entries with a date
 	 * before the source list? Definitely _not_ done.
 	 */
-	if (date < src->item->date)
+	if (date <= src->item->date)
 		return SLOP;
 
 	/*
diff --git a/t/t6009-rev-list-parent.sh b/t/t6009-rev-list-parent.sh
index 3050740..66cda17 100755
--- a/t/t6009-rev-list-parent.sh
+++ b/t/t6009-rev-list-parent.sh
@@ -133,4 +133,17 @@ test_expect_success 'dodecapus' '
 	check_revlist "--min-parents=13" &&
 	check_revlist "--min-parents=4 --max-parents=11" tetrapus
 '
+
+test_expect_success 'ancestors with the same commit time' '
+
+	test_tick_keep=$test_tick &&
+	for i in 1 2 3 4 5 6 7 8; do
+		test_tick=$test_tick_keep
+		test_commit t$i
+	done &&
+	git rev-list t1^! --not t$i >result &&
+	>expect &&
+	test_cmp expect result
+'
+
 test_done
-- 
1.8.2

-- 
  Kacper Kornet
