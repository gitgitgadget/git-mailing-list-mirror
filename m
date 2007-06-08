From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix push with refspecs containing wildcards
Date: Fri, 08 Jun 2007 00:42:47 -0700
Message-ID: <7vodjqlwnc.fsf@assigned-by-dhcp.cox.net>
References: <20070607225302.GA10633@steel.home>
	<20070607234305.GB10633@steel.home>
	<7v4pljlzm3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 08 09:43:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwZ7w-0003Jz-Fm
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 09:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938896AbXFHHmv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 03:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938927AbXFHHmu
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 03:42:50 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:63471 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S939005AbXFHHmt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 03:42:49 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070608074249.MHYI14072.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Fri, 8 Jun 2007 03:42:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8vin1X00C1kojtg0000000; Fri, 08 Jun 2007 03:42:48 -0400
In-Reply-To: <7v4pljlzm3.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 07 Jun 2007 23:38:44 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49446>

Junio C Hamano <gitster@pobox.com> writes:

> Sending a fix is a good thing, but whenever doing one, could
> people please also do a testcase that demonstrates the original
> bug, and also a demonstration that the fix does not introduce
> regression?
>
> For this one, obviously a test for push that uses such wildcard
> ref is needed but at the same time we would want a test for push
> that does _not_ use a wildcard, fetch that uses a wildcard, and
> a fetch that does not use a wildcard.

How about this?
---

 t/t5516-fetch-push.sh |   82 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 82 insertions(+), 0 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
new file mode 100755
index 0000000..dba018f
--- /dev/null
+++ b/t/t5516-fetch-push.sh
@@ -0,0 +1,80 @@
+#!/bin/sh
+
+test_description='fetching and pushing, with or without wildcard'
+
+. ./test-lib.sh
+
+mk_empty () {
+	rm -fr testrepo &&
+	mkdir testrepo &&
+	(
+		cd testrepo &&
+		git init
+	)
+}
+
+test_expect_success setup '
+
+	: >path1 &&
+	git add path1 &&
+	test_tick &&
+	git commit -a -m repo &&
+	the_commit=$(git show-ref -s --verify refs/heads/master)
+
+'
+
+test_expect_success 'fetch without wildcard' '
+	mk_empty &&
+	(
+		cd testrepo &&
+		git fetch .. refs/heads/master:refs/remotes/origin/master &&
+
+		r=$(git show-ref -s --verify refs/remotes/origin/master) &&
+		test "z$r" = "z$the_commit" &&
+
+		test 1 = $(git for-each-ref refs/remotes/origin | wc -l)
+	)
+'
+
+test_expect_success 'fetch with wildcard' '
+	mk_empty &&
+	(
+		cd testrepo &&
+		git config remote.up.url .. &&
+		git config remote.up.fetch "refs/heads/*:refs/remotes/origin/*" &&
+		git fetch up &&
+
+		r=$(git show-ref -s --verify refs/remotes/origin/master) &&
+		test "z$r" = "z$the_commit" &&
+
+		test 1 = $(git for-each-ref refs/remotes/origin | wc -l)
+	)
+'
+
+test_expect_success 'push without wildcard' '
+	mk_empty &&
+
+	git push testrepo refs/heads/master:refs/remotes/origin/master &&
+	(
+		cd testrepo &&
+		r=$(git show-ref -s --verify refs/remotes/origin/master) &&
+		test "z$r" = "z$the_commit" &&
+
+		test 1 = $(git for-each-ref refs/remotes/origin | wc -l)
+	)
+'
+
+test_expect_success 'push with wildcard' '
+	mk_empty &&
+
+	git push testrepo "refs/heads/*:refs/remotes/origin/*" &&
+	(
+		cd testrepo &&
+		r=$(git show-ref -s --verify refs/remotes/origin/master) &&
+		test "z$r" = "z$the_commit" &&
+
+		test 1 = $(git for-each-ref refs/remotes/origin | wc -l)
+	)
+'
+
+test_done
