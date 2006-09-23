From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Fetch: default remote repository from branch properties
Date: Sat, 23 Sep 2006 03:40:37 -0700
Message-ID: <7vr6y2uaqi.fsf@assigned-by-dhcp.cox.net>
References: <87venex5je.fsf@gmail.com> <87r6y2x5hk.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 12:40:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GR4wA-0001Ya-5Z
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 12:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbWIWKkj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 06:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbWIWKki
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 06:40:38 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:14549 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751488AbWIWKki (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Sep 2006 06:40:38 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060923104037.GHKU12909.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Sat, 23 Sep 2006 06:40:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Rmgf1V00D1kojtg0000000
	Sat, 23 Sep 2006 06:40:39 -0400
To: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>
In-Reply-To: <87r6y2x5hk.fsf@gmail.com> (Santi =?iso-8859-1?Q?B=E9jar's?=
 message of "Sat, 23
	Sep 2006 12:05:43 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27579>

You would need a new test in the testsuite for this.

-- >8 --
[PATCH] Add t5510 to test per branch configuration affecting git-fetch.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 t/t5510-fetch.sh |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
new file mode 100755
index 0000000..e71581a
--- /dev/null
+++ b/t/t5510-fetch.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+# Copyright (c) 2006, Junio C Hamano.
+
+test_description='Per branch config variables affects "git fetch".
+
+'
+
+. ./test-lib.sh
+
+D=`pwd`
+
+test_expect_success setup '
+	echo >file original &&
+	git add file &&
+	git commit -a -m original'
+
+test_expect_success "clone and setup child repos" '
+	git clone . one &&
+	cd one &&
+	echo >file updated by one &&
+	git commit -a -m "updated by one" &&
+	cd .. &&
+	git clone . two &&
+	cd two &&
+	git repo-config branch.master.remote one &&
+	{
+		echo "URL: ../one/.git/"
+		echo "Pull: refs/heads/master:refs/heads/one"
+	} >.git/remotes/one
+'
+
+test_expect_success "fetch test" '
+	cd "$D" &&
+	echo >file updated by origin &&
+	git commit -a -m "updated by origin" &&
+	cd two &&
+	git fetch &&
+	test -f .git/refs/heads/one &&
+	mine=`git rev-parse refs/heads/one` &&
+	his=`cd ../one && git rev-parse refs/heads/master` &&
+	test "z$mine" = "z$his"
+'
+
+test_done
-- 
1.4.2.1.ga89e
