From: Abhijit Menon-Sen <ams@toroid.org>
Subject: [PATCH v2] Add a test for "git stash branch"
Date: Mon, 7 Jul 2008 02:50:10 +0530
Message-ID: <20080706212010.GA16343@toroid.org>
References: <7vvdzo9kkw.fsf@gitster.siamese.dyndns.org> <20080702195401.GA17214@toroid.org> <7vprpw80bw.fsf@gitster.siamese.dyndns.org> <20080703022316.GA25433@toroid.org> <7v63rn61yj.fsf@gitster.siamese.dyndns.org> <20080703061605.GB3815@toroid.org> <20080706112333.GA6477@toroid.org> <alpine.LSU.1.00.0807061453540.3486@wbgn129.biozentrum.uni-wuerzburg.de> <20080706144542.GA8677@toroid.org> <7v1w26eqn5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 06 23:21:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFbfS-0001l2-NF
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 23:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757623AbYGFVUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 17:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757341AbYGFVUM
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 17:20:12 -0400
Received: from fugue.toroid.org ([85.10.196.113]:52800 "EHLO fugue.toroid.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757225AbYGFVUL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 17:20:11 -0400
Received: from penne.toroid.org (penne-vpn [10.8.0.6])
	by fugue.toroid.org (Postfix) with ESMTP id 0177A558350;
	Sun,  6 Jul 2008 23:20:09 +0200 (CEST)
Received: by penne.toroid.org (Postfix, from userid 1000)
	id 00AC6840001; Mon,  7 Jul 2008 02:50:10 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <7v1w26eqn5.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87556>

Make sure that applying the stash to a new branch after a conflicting
change doesn't result in an error when you try to commit.

Signed-off-by: Abhijit Menon-Sen <ams@toroid.org>
---

At 2008-07-06 12:53:02 -0700, gitster@pobox.com wrote:
>
> The title is probably not 'stash apply' but 'stash branch'.

Fixed, thanks.

> Don't you want to also validate that: [...]

Done.

-- ams

 t/t3903-stash.sh |   61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 54d99ed..bd1cdab 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -117,4 +117,65 @@ test_expect_success 'stash pop' '
 	test 0 = $(git stash list | wc -l)
 '
 
+cat > expect << EOF
+diff --git a/file2 b/file2
+new file mode 100644
+index 0000000..1fe912c
+--- /dev/null
++++ b/file2
+@@ -0,0 +1 @@
++bar2
+EOF
+
+cat > expect1 << EOF
+diff --git a/file b/file
+index 257cc56..5716ca5 100644
+--- a/file
++++ b/file
+@@ -1 +1 @@
+-foo
++bar
+EOF
+
+cat > expect2 << EOF
+diff --git a/file b/file
+index 7601807..5716ca5 100644
+--- a/file
++++ b/file
+@@ -1 +1 @@
+-baz
++bar
+diff --git a/file2 b/file2
+new file mode 100644
+index 0000000..1fe912c
+--- /dev/null
++++ b/file2
+@@ -0,0 +1 @@
++bar2
+EOF
+
+test_expect_success 'stash branch' '
+	echo foo > file &&
+	git commit file -m first
+	echo bar > file &&
+	echo bar2 > file2 &&
+	git add file2 &&
+	git stash &&
+	echo baz > file &&
+	git commit file -m second &&
+	git stash branch stashbranch &&
+	test refs/heads/stashbranch = $(git symbolic-ref HEAD) &&
+	test $(git rev-parse HEAD) = $(git rev-parse master^) &&
+	git diff --cached > output &&
+	test_cmp output expect &&
+	git diff > output &&
+	test_cmp output expect1 &&
+	git add file &&
+	git commit -m alternate\ second &&
+	git diff master..stashbranch &&
+	git diff master..stashbranch > output &&
+	test_cmp output expect2 &&
+	test 0 = $(git stash list | wc -l)
+'
+
 test_done
-- 
1.5.6
