From: Abhijit Menon-Sen <ams@toroid.org>
Subject: [PATCH] Add a test for "git stash branch"
Date: Sun, 6 Jul 2008 20:15:42 +0530
Message-ID: <20080706144542.GA8677@toroid.org>
References: <20080702195947.6117@nanako3.lavabit.com> <alpine.DEB.1.00.0807021447200.9925@racer> <7vvdzo9kkw.fsf@gitster.siamese.dyndns.org> <20080702195401.GA17214@toroid.org> <7vprpw80bw.fsf@gitster.siamese.dyndns.org> <20080703022316.GA25433@toroid.org> <7v63rn61yj.fsf@gitster.siamese.dyndns.org> <20080703061605.GB3815@toroid.org> <20080706112333.GA6477@toroid.org> <alpine.LSU.1.00.0807061453540.3486@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 06 16:46:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFVVh-0000Uf-Ew
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 16:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756856AbYGFOpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 10:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756905AbYGFOpn
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 10:45:43 -0400
Received: from fugue.toroid.org ([85.10.196.113]:34432 "EHLO fugue.toroid.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756900AbYGFOpn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 10:45:43 -0400
Received: from penne.toroid.org (penne-vpn [10.8.0.6])
	by fugue.toroid.org (Postfix) with ESMTP id 979F1558320;
	Sun,  6 Jul 2008 16:45:41 +0200 (CEST)
Received: by penne.toroid.org (Postfix, from userid 1000)
	id 41C0B840001; Sun,  6 Jul 2008 20:15:43 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0807061453540.3486@wbgn129.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87533>

Make sure that applying the stash to a new branch after a conflicting
change doesn't result in an error when you try to commit.

Signed-off-by: Abhijit Menon-Sen <ams@toroid.org>
---

At 2008-07-06 14:54:44 +0200, Johannes.Schindelin@gmx.de wrote:
>
> AFAICS the previous version is in 'next' already: 
> 656b50345239293929ad8c639c5f1941c6b867ad

Oh, I see, thanks. I misunderstood the request. Here's a separate patch
to just add the test.

Sorry for the noise.

-- ams

 t/t3903-stash.sh |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 54d99ed..6d89218 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -117,4 +117,28 @@ test_expect_success 'stash pop' '
 	test 0 = $(git stash list | wc -l)
 '
 
+cat > expect << EOF
+diff --git a/file b/file
+index 7601807..5716ca5 100644
+--- a/file
++++ b/file
+@@ -1 +1 @@
+-baz
++bar
+EOF
+
+test_expect_success 'stash apply' '
+	echo foo > file &&
+	git commit file -m first
+	echo bar > file &&
+	git stash &&
+	echo baz > file &&
+	git commit file -m second &&
+	git stash branch stashbranch &&
+	git commit file -m alternate\ second &&
+	git diff master..stashbranch > output &&
+	test_cmp output expect &&
+	test 0 = $(git stash list | wc -l)
+'
+
 test_done
-- 
1.5.6
