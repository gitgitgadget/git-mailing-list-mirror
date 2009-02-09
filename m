From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] t5400: allow individual tests to fail
Date: Mon, 09 Feb 2009 13:39:52 -0800
Message-ID: <7vab8vthlj.fsf@gitster.siamese.dyndns.org>
References: <1234170565-6740-1-git-send-email-gitster@pobox.com>
 <1234170565-6740-2-git-send-email-gitster@pobox.com>
 <1234170565-6740-3-git-send-email-gitster@pobox.com>
 <20090209184625.GA27037@coredump.intra.peff.net>
 <7v4oz3v36a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 09 22:42:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWdtE-0002hc-4L
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 22:42:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756017AbZBIVkB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 16:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755991AbZBIVkA
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 16:40:00 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46794 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755967AbZBIVj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 16:39:58 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 688522ACA4;
	Mon,  9 Feb 2009 16:39:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2071A2AC9A; Mon, 
 9 Feb 2009 16:39:53 -0500 (EST)
In-Reply-To: <7v4oz3v36a.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 09 Feb 2009 11:08:29 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 321AD57E-F6F2-11DD-9718-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109138>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> All minor things, of course, but while we're cleaning up... :)
>
> Sure.  This was made as a quick-fix to a mess others created, so I did not
> study them very deeply.
>
> Will reroll if I have the time but it is likely that I may be tending
> other topics first.

-- >8 --
Subject: [PATCH] Modernize t5400 test script

Many tests checked for failure by hand without using test_must_fail (they
probably predate the shell function).

When we know the desired outcome, explicitly check for it, instead of
checking if the result does not match one possible incorrect outcome.
E.g. if you expect a push to be refused, you do not test if the result is
different from what was pushed.  Instead, make sure that the ref did not
before and after the push.

The test sequence chdir'ed around and any failure at one point could have
started the next test in an unexpected directory.  Fix this problem by
using subshells as necessary.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5400-send-pack.sh |  180 ++++++++++++++++++++++++++------------------------
 1 files changed, 94 insertions(+), 86 deletions(-)

diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index b21317d..785c2f4 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -32,9 +32,7 @@ test_expect_success setup '
 	done &&
 	git update-ref HEAD "$commit" &&
 	git clone ./. victim &&
-	cd victim &&
-	git log &&
-	cd .. &&
+	( cd victim && git log ) &&
 	git update-ref HEAD "$zero" &&
 	parent=$zero &&
 	i=0 &&
@@ -59,88 +57,84 @@ test_expect_success 'pack the source repository' '
 '
 
 test_expect_success 'pack the destination repository' '
+    (
 	cd victim &&
 	git repack -a -d &&
-	git prune &&
-	cd ..
+	git prune
+    )
 '
 
-test_expect_success \
-        'pushing rewound head should not barf but require --force' '
-	# should not fail but refuse to update.
-	if git send-pack ./victim/.git/ master
-	then
-		# now it should fail with Pasky patch
-		echo >&2 Gaah, it should have failed.
-		false
-	else
-		echo >&2 Thanks, it correctly failed.
-		true
-	fi &&
-	if cmp victim/.git/refs/heads/master .git/refs/heads/master
-	then
-		# should have been left as it was!
-		false
-	else
-		true
-	fi &&
+test_expect_success 'refuse pushing rewound head without --force' '
+	pushed_head=$(git rev-parse --verify master) &&
+	victim_orig=$(cd victim && git rev-parse --verify master) &&
+	test_must_fail git send-pack ./victim master &&
+	victim_head=$(cd victim && git rev-parse --verify master) &&
+	test "$victim_head" = "$victim_orig" &&
 	# this should update
-	git send-pack --force ./victim/.git/ master &&
-	cmp victim/.git/refs/heads/master .git/refs/heads/master
+	git send-pack --force ./victim master &&
+	victim_head=$(cd victim && git rev-parse --verify master) &&
+	test "$victim_head" = "$pushed_head"
 '
 
 test_expect_success \
         'push can be used to delete a ref' '
-	cd victim &&
-	git branch extra master &&
-	cd .. &&
-	test -f victim/.git/refs/heads/extra &&
-	git send-pack ./victim/.git/ :extra master &&
-	! test -f victim/.git/refs/heads/extra
+	( cd victim && git branch extra master ) &&
+	git send-pack ./victim :extra master &&
+	( cd victim &&
+	  test_must_fail git rev-parse --verify extra )
 '
 
-unset GIT_CONFIG
-HOME=`pwd`/no-such-directory
-export HOME ;# this way we force the victim/.git/config to be used.
-
-test_expect_success \
-	'pushing a delete should be denied with denyDeletes' '
-	cd victim &&
-	git config receive.denyDeletes true &&
-	git branch extra master &&
-	cd .. &&
-	test -f victim/.git/refs/heads/extra &&
-	test_must_fail git send-pack ./victim/.git/ :extra master
+test_expect_success 'refuse deleting push with denyDeletes' '
+	(
+	    cd victim &&
+	    ( git branch -D extra || : ) &&
+	    git config receive.denyDeletes true &&
+	    git branch extra master
+	) &&
+	test_must_fail git send-pack ./victim :extra master
 '
-rm -f victim/.git/refs/heads/extra
 
-test_expect_success \
-        'pushing with --force should be denied with denyNonFastforwards' '
-	cd victim &&
-	git config receive.denyNonFastforwards true &&
-	cd .. &&
-	git update-ref refs/heads/master master^ || return 1
-	git send-pack --force ./victim/.git/ master && return 1
-	! test_cmp .git/refs/heads/master victim/.git/refs/heads/master
+test_expect_success 'denyNonFastforwards trumps --force' '
+	(
+	    cd victim &&
+	    ( git branch -D extra || : ) &&
+	    git config receive.denyNonFastforwards true
+	) &&
+	victim_orig=$(cd victim && git rev-parse --verify master) &&
+	test_must_fail git send-pack --force ./victim master^:master &&
+	victim_head=$(cd victim && git rev-parse --verify master) &&
+	test "$victim_orig" = "$victim_head"
 '
 
-test_expect_success \
-	'pushing does not include non-head refs' '
-	mkdir parent && cd parent &&
-	git init && touch file && git add file && git commit -m add &&
-	cd .. &&
-	git clone parent child && cd child && git push --all &&
-	cd ../parent &&
-	git branch -a >branches && ! grep origin/master branches
+test_expect_success 'push --all excludes remote tracking hierarchy' '
+	mkdir parent &&
+	(
+	    cd parent &&
+	    git init && : >file && git add file && git commit -m add
+	) &&
+	git clone parent child &&
+	(
+	    cd child && git push --all
+	) &&
+	(
+	    cd parent &&
+	    test -z "$(git for-each-ref refs/remotes/origin)"
+	)
 '
 
 rewound_push_setup() {
 	rm -rf parent child &&
-	mkdir parent && cd parent &&
-	git init && echo one >file && git add file && git commit -m one &&
-	echo two >file && git commit -a -m two &&
-	cd .. &&
-	git clone parent child && cd child && git reset --hard HEAD^
+	mkdir parent &&
+	(
+	    cd parent &&
+	    git init &&
+	    echo one >file && git add file && git commit -m one &&
+	    echo two >file && git commit -a -m two
+	) &&
+	git clone parent child &&
+	(
+	    cd child && git reset --hard HEAD^
+	)
 }
 
 rewound_push_succeeded() {
@@ -156,30 +150,44 @@ rewound_push_failed() {
 	fi
 }
 
-test_expect_success \
-	'pushing explicit refspecs respects forcing' '
+test_expect_success 'pushing explicit refspecs respects forcing' '
 	rewound_push_setup &&
-	if git send-pack ../parent/.git refs/heads/master:refs/heads/master
-	then
-		false
-	else
-		true
-	fi && rewound_push_failed &&
-	git send-pack ../parent/.git +refs/heads/master:refs/heads/master &&
-	rewound_push_succeeded
+	parent_orig=$(cd parent && git rev-parse --verify master) &&
+	(
+	    cd child &&
+	    test_must_fail git send-pack ../parent \
+		refs/heads/master:refs/heads/master
+	) &&
+	parent_head=$(cd parent && git rev-parse --verify master) &&
+	test "$parent_orig" = "$parent_head"
+	(
+	    cd child &&
+	    git send-pack ../parent \
+	        +refs/heads/master:refs/heads/master
+	) &&
+	parent_head=$(cd parent && git rev-parse --verify master) &&
+	child_head=$(cd parent && git rev-parse --verify master) &&
+	test "$parent_head" = "$child_head"
 '
 
-test_expect_success \
-	'pushing wildcard refspecs respects forcing' '
+test_expect_success 'pushing wildcard refspecs respects forcing' '
 	rewound_push_setup &&
-	if git send-pack ../parent/.git refs/heads/*:refs/heads/*
-	then
-		false
-	else
-		true
-	fi && rewound_push_failed &&
-	git send-pack ../parent/.git +refs/heads/*:refs/heads/* &&
-	rewound_push_succeeded
+	parent_orig=$(cd parent && git rev-parse --verify master) &&
+	(
+	    cd child &&
+	    test_must_fail git send-pack ../parent \
+	        "refs/heads/*:refs/heads/*"
+	) &&
+	parent_head=$(cd parent && git rev-parse --verify master) &&
+	test "$parent_orig" = "$parent_head"
+	(
+	    cd child &&
+	    git send-pack ../parent \
+	        "+refs/heads/*:refs/heads/*"
+	) &&
+	parent_head=$(cd parent && git rev-parse --verify master) &&
+	child_head=$(cd parent && git rev-parse --verify master) &&
+	test "$parent_head" = "$child_head"
 '
 
 test_done
-- 
1.6.2.rc0.36.g8307
