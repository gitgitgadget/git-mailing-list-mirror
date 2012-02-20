From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: git status: small difference between stating whole repository and small subdirectory
Date: Mon, 20 Feb 2012 19:45:59 +0100
Message-ID: <87d3991gyg.fsf@thomas.inf.ethz.ch>
References: <20120216192001.GB4348@sigill.intra.peff.net>
	<CAA01Csq6vSekW=Fa236bB0H3LVtN43Gb2aLMVE+A1wVyUqYJ7A@mail.gmail.com>
	<20120217203755.GA30114@sigill.intra.peff.net>
	<7vaa4hrtbe.fsf@alter.siamese.dyndns.org>
	<20120217222912.GC31830@sigill.intra.peff.net>
	<CAA01CsozANwtox06iihKBL8iii175FHAhChmNhG1B0ofGKWcEA@mail.gmail.com>
	<20120220140653.GC5131@sigill.intra.peff.net>
	<87ty2l38ay.fsf@thomas.inf.ethz.ch> <20120220143644.GA13938@do>
	<20120220143952.GA8387@sigill.intra.peff.net>
	<20120220151134.GA13135@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 20 19:46:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzYFU-0007U0-1x
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 19:46:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667Ab2BTSqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 13:46:03 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:42782 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752327Ab2BTSqB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 13:46:01 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 20 Feb
 2012 19:45:59 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 20 Feb
 2012 19:45:59 +0100
In-Reply-To: <20120220151134.GA13135@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 20 Feb 2012 10:11:34 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191083>

Jeff King <peff@peff.net> writes:

> diff --git a/unpack-trees.c b/unpack-trees.c
> index 8be3f6c..e8aedea 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1135,6 +1135,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>  		}
>  	}
>  
> +	o->result.cache_tree = o->src_index->cache_tree;
>  	o->src_index = NULL;
>  	ret = check_updates(o) ? (-2) : 0;
>  	if (o->dst_index)

Brilliant.  I know I'm stealing Junio's punchline, but please make it so
:-)

Browsing around in history, it seems that this was silently broken by
34110cd (Make 'unpack_trees()' have a separate source and destination
index, 2008-03-06), which introduced the distinction between source and
destination index.  Before that they were the same, so the cache tree
would have been updated correctly.

> It makes "git checkout" with no changes just work (since we preserve the
> cache tree, and it doesn't need updated). It makes something like "git
> checkout HEAD^" work, keeping most of the cache-tree intact, but
> invalidating trees containing paths that were modified.

Great.  Here's a test you could use.  It's a bit noisy because the
shallow in test_shallow_cache_tree no longer made any sense, but I think
it tests what we want to see.

diff --git i/t/t0090-cache-tree.sh w/t/t0090-cache-tree.sh
index 6c33e28..5706305 100755
--- i/t/t0090-cache-tree.sh
+++ w/t/t0090-cache-tree.sh
@@ -16,14 +16,16 @@ cmp_cache_tree () {
 # We don't bother with actually checking the SHA1:
 # test-dump-cache-tree already verifies that all existing data is
 # correct.
-test_shallow_cache_tree () {
-	printf "SHA  (%d entries, 0 subtrees)\n" $(git ls-files|wc -l) >expect &&
+test_cache_tree () {
+	printf "SHA  (%d entries, 1 subtrees)\n" $(git ls-files|wc -l) >expect &&
+	printf "SHA sub/ (%d entries, 0 subtrees)\n" $(git ls-files sub|wc -l) >>expect &&
 	cmp_cache_tree expect
 }
 
 test_invalid_cache_tree () {
-	echo "invalid                                   (0 subtrees)" >expect &&
-	printf "SHA #(ref)  (%d entries, 0 subtrees)\n" $(git ls-files|wc -l) >>expect &&
+	echo "invalid                                   (1 subtrees)" >expect &&
+	printf "SHA #(ref)  (%d entries, 1 subtrees)\n" $(git ls-files|wc -l) >>expect &&
+	printf "SHA sub/ (%d entries, 0 subtrees)\n" $(git ls-files sub|wc -l) >>expect &&
 	cmp_cache_tree expect
 }
 
@@ -33,13 +35,16 @@ test_no_cache_tree () {
 }
 
 test_expect_failure 'initial commit has cache-tree' '
+	mkdir sub &&
+	echo bar > sub/bar &&
+	git add sub/bar &&
 	test_commit foo &&
-	test_shallow_cache_tree
+	test_cache_tree
 '
 
 test_expect_success 'read-tree HEAD establishes cache-tree' '
 	git read-tree HEAD &&
-	test_shallow_cache_tree
+	test_cache_tree
 '
 
 test_expect_success 'git-add invalidates cache-tree' '
@@ -59,7 +64,7 @@ test_expect_success 'update-index invalidates cache-tree' '
 test_expect_success 'write-tree establishes cache-tree' '
 	test-scrap-cache-tree &&
 	git write-tree &&
-	test_shallow_cache_tree
+	test_cache_tree
 '
 
 test_expect_success 'test-scrap-cache-tree works' '
@@ -70,24 +75,39 @@ test_expect_success 'test-scrap-cache-tree works' '
 
 test_expect_success 'second commit has cache-tree' '
 	test_commit bar &&
-	test_shallow_cache_tree
+	test_cache_tree
 '
 
 test_expect_success 'reset --hard gives cache-tree' '
 	test-scrap-cache-tree &&
 	git reset --hard &&
-	test_shallow_cache_tree
+	test_cache_tree
 '
 
 test_expect_success 'reset --hard without index gives cache-tree' '
 	rm -f .git/index &&
 	git reset --hard &&
-	test_shallow_cache_tree
+	test_cache_tree
 '
 
-test_expect_failure 'checkout gives cache-tree' '
+test_expect_success 'checkout HEAD leaves cache-tree intact' '
+	git read-tree HEAD &&
+	git checkout HEAD &&
+	test_cache_tree
+'
+
+# NEEDSWORK: only one of these two can succeed.  The second is there
+# because it would be the better result.
+test_expect_success 'checkout HEAD^ correctly invalidates cache-tree' '
+	git checkout HEAD^ &&
+	test_invalid_cache_tree
+'
+
+test_expect_failure 'checkout HEAD^ gives full cache-tree' '
+	git checkout master &&
+	git read-tree HEAD &&
 	git checkout HEAD^ &&
-	test_shallow_cache_tree
+	test_cache_tree
 '
 
 test_done

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
