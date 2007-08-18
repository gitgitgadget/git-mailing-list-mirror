From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Make thin-pack generation subproject aware.
Date: Sat, 18 Aug 2007 02:54:52 -0700
Message-ID: <7vwsvtcglv.fsf_-_@gitster.siamese.dyndns.org>
References: <200707021356.58553.andyparkins@gmail.com>
	<200708170939.47214.andyparkins@gmail.com>
	<alpine.LFD.0.999.0708170956140.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 18 11:55:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IML1N-0007nH-3z
	for gcvg-git@gmane.org; Sat, 18 Aug 2007 11:55:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003AbXHRJzA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Aug 2007 05:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751992AbXHRJzA
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Aug 2007 05:55:00 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:59401 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869AbXHRJy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Aug 2007 05:54:59 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 8AB12123879;
	Sat, 18 Aug 2007 05:55:16 -0400 (EDT)
In-Reply-To: <alpine.LFD.0.999.0708170956140.30176@woody.linux-foundation.org>
	(Linus Torvalds's message of "Fri, 17 Aug 2007 09:56:54 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56105>

When a thin pack wants to send a tree object at "sub/dir", and
the commit that is common between the sender and the receiver
that is used as the base object has a subproject at that path,
we should not try to use the data at "sub/dir" of the base tree
as a tree object.  It is not a tree to begin with, and more
importantly, the commit object there does not have to even
exist.

---

 This turned out to be trickier to trigger than I thought.  One
 case to trigger is to have a subproject in the past at sub/dir
 and then turn it into a directory.

 builtin-pack-objects.c       |    2 +
 t/t3050-subprojects-fetch.sh |   52 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 0 deletions(-)
 create mode 100755 t/t3050-subprojects-fetch.sh

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 24926db..77481df 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -979,6 +979,8 @@ static void add_pbase_object(struct tree_desc *tree,
 	int cmp;
 
 	while (tree_entry(tree,&entry)) {
+		if (S_ISGITLINK(entry.mode))
+			continue;
 		cmp = tree_entry_len(entry.path, entry.sha1) != cmplen ? 1 :
 		      memcmp(name, entry.path, cmplen);
 		if (cmp > 0)
diff --git a/t/t3050-subprojects-fetch.sh b/t/t3050-subprojects-fetch.sh
new file mode 100755
index 0000000..34f26a8
--- /dev/null
+++ b/t/t3050-subprojects-fetch.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+
+test_description='fetching and pushing project with subproject'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_tick &&
+	mkdir -p sub && (
+		cd sub &&
+		git init &&
+		>subfile &&
+		git add subfile
+		git commit -m "subproject commit #1"
+	) &&
+	>mainfile
+	git add sub mainfile &&
+	test_tick &&
+	git commit -m "superproject commit #1"
+'
+
+test_expect_success clone '
+	git clone file://`pwd`/.git cloned &&
+	(git rev-parse HEAD; git ls-files -s) >expected &&
+	(
+		cd cloned &&
+		(git rev-parse HEAD; git ls-files -s) >../actual
+	) &&
+	diff -u expected actual
+'
+
+test_expect_success advance '
+	echo more >mainfile &&
+	git update-index --force-remove sub &&
+	mv sub/.git sub/.git-disabled &&
+	git add sub/subfile mainfile &&
+	mv sub/.git-disabled sub/.git &&
+	test_tick &&
+	git commit -m "superproject commit #2"
+'
+
+test_expect_success fetch '
+	(git rev-parse HEAD; git ls-files -s) >expected &&
+	(
+		cd cloned &&
+		git pull &&
+		(git rev-parse HEAD; git ls-files -s) >../actual
+	) &&
+	diff -u expected actual
+'
+
+test_done
