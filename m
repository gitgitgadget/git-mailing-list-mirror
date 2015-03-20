From: Jeff King <peff@peff.net>
Subject: [PATCH v2 1/5] t5312: test object deletion code paths in a corrupted
 repository
Date: Fri, 20 Mar 2015 14:43:02 -0400
Message-ID: <20150320184302.GA23849@peff.net>
References: <20150320184215.GA26368@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 19:49:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ1yb-00078T-Tp
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 19:48:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbbCTSst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 14:48:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:36028 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751219AbbCTSnF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 14:43:05 -0400
Received: (qmail 29023 invoked by uid 102); 20 Mar 2015 18:43:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 13:43:04 -0500
Received: (qmail 26938 invoked by uid 107); 20 Mar 2015 18:43:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 14:43:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2015 14:43:02 -0400
Content-Disposition: inline
In-Reply-To: <20150320184215.GA26368@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265936>

When we are doing a destructive operation like "git prune",
we want to be extra careful that the set of reachable tips
we compute is valid. If there is any corruption or oddity,
we are better off aborting the operation and letting the
user figure things out rather than plowing ahead and
possibly deleting some data that cannot be recovered.

The tests here include:

  1. Pruning objects mentioned only be refs with invalid
     names. This used to abort prior to d0f810f (refs.c:
     allow listing and deleting badly named refs,
     2014-09-03), but since then we silently ignore the tip.

     Likewise, we test repacking that can drop objects
     (either "-ad", which drops anything unreachable,
     or "-Ad --unpack-unreachable=<time>", which tries to
     optimize out a loose object write that would be
     directly pruned).

  2. Pruning objects when some refs point to missing
     objects. We don't know whether any dangling objects
     would have been reachable from the missing objects. We
     are better to keep them around, as they are better than
     nothing for helping the user recover history.

  3. Packed refs that point to missing objects can sometimes
     be dropped. By itself, this is more of an annoyance
     (you do not have the object anyway; even if you can
     recover it from elsewhere, all you are losing is a
     placeholder for your state at the time of corruption).
     But coupled with (2), if we drop the ref and then go
     on to prune, we may lose unrecoverable objects.

Note that we use test_might_fail for some of the operations.
In some cases, it would be appropriate to abort the
operation, and in others, it might be acceptable to continue
but taking the information into account. The tests don't
care either way, and check only for data loss.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5312-prune-corruption.sh | 114 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100755 t/t5312-prune-corruption.sh

diff --git a/t/t5312-prune-corruption.sh b/t/t5312-prune-corruption.sh
new file mode 100755
index 0000000..496a9f5
--- /dev/null
+++ b/t/t5312-prune-corruption.sh
@@ -0,0 +1,114 @@
+#!/bin/sh
+
+test_description='
+Test pruning of repositories with minor corruptions. The goal
+here is that we should always be erring on the side of safety. So
+if we see, for example, a ref with a bogus name, it is OK either to
+bail out or to proceed using it as a reachable tip, but it is _not_
+OK to proceed as if it did not exist. Otherwise we might silently
+delete objects that cannot be recovered.
+'
+. ./test-lib.sh
+
+test_expect_success 'disable reflogs' '
+	git config core.logallrefupdates false &&
+	rm -rf .git/logs
+'
+
+test_expect_success 'create history reachable only from a bogus-named ref' '
+	test_tick && git commit --allow-empty -m master &&
+	base=$(git rev-parse HEAD) &&
+	test_tick && git commit --allow-empty -m bogus &&
+	bogus=$(git rev-parse HEAD) &&
+	git cat-file commit $bogus >saved &&
+	echo $bogus >.git/refs/heads/bogus..name &&
+	git reset --hard HEAD^
+'
+
+test_expect_failure 'pruning does not drop bogus object' '
+	test_when_finished "git hash-object -w -t commit saved" &&
+	test_might_fail git prune --expire=now &&
+	verbose git cat-file -e $bogus
+'
+
+test_expect_success 'put bogus object into pack' '
+	git tag reachable $bogus &&
+	git repack -ad &&
+	git tag -d reachable &&
+	verbose git cat-file -e $bogus
+'
+
+test_expect_failure 'destructive repack keeps packed object' '
+	test_might_fail git repack -Ad --unpack-unreachable=now &&
+	verbose git cat-file -e $bogus &&
+	test_might_fail git repack -ad &&
+	verbose git cat-file -e $bogus
+'
+
+# subsequent tests will have different corruptions
+test_expect_success 'clean up bogus ref' '
+	rm .git/refs/heads/bogus..name
+'
+
+# We create two new objects here, "one" and "two". Our
+# master branch points to "two", which is deleted,
+# corrupting the repository. But we'd like to make sure
+# that the otherwise unreachable "one" is not pruned
+# (since it is the user's best bet for recovering
+# from the corruption).
+#
+# Note that we also point HEAD somewhere besides "two",
+# as we want to make sure we test the case where we
+# pick up the reference to "two" by iterating the refs,
+# not by resolving HEAD.
+test_expect_success 'create history with missing tip commit' '
+	test_tick && git commit --allow-empty -m one &&
+	recoverable=$(git rev-parse HEAD) &&
+	git cat-file commit $recoverable >saved &&
+	test_tick && git commit --allow-empty -m two &&
+	missing=$(git rev-parse HEAD) &&
+	git checkout --detach $base &&
+	rm .git/objects/$(echo $missing | sed "s,..,&/,") &&
+	test_must_fail git cat-file -e $missing
+'
+
+test_expect_failure 'pruning with a corrupted tip does not drop history' '
+	test_when_finished "git hash-object -w -t commit saved" &&
+	test_might_fail git prune --expire=now &&
+	verbose git cat-file -e $recoverable
+'
+
+test_expect_success 'pack-refs does not silently delete broken loose ref' '
+	git pack-refs --all --prune &&
+	echo $missing >expect &&
+	git rev-parse refs/heads/master >actual &&
+	test_cmp expect actual
+'
+
+# we do not want to count on running pack-refs to
+# actually pack it, as it is perfectly reasonable to
+# skip processing a broken ref
+test_expect_success 'create packed-refs file with broken ref' '
+	rm -f .git/refs/heads/master &&
+	cat >.git/packed-refs <<-EOF &&
+	$missing refs/heads/master
+	$recoverable refs/heads/other
+	EOF
+	echo $missing >expect &&
+	git rev-parse refs/heads/master >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'pack-refs does not silently delete broken packed ref' '
+	git pack-refs --all --prune &&
+	git rev-parse refs/heads/master >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'pack-refs does not drop broken refs during deletion' '
+	git update-ref -d refs/heads/other &&
+	git rev-parse refs/heads/master >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.3.3.520.g3cfbb5d
