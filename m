From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 9/9] sha1_name.c: get_describe_name() by definition groks
 only commits
Date: Sat, 23 Jun 2012 17:11:31 -0700
Message-ID: <1340496691-12258-10-git-send-email-gitster@pobox.com>
References: <1340496691-12258-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 24 02:12:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiaRK-0001ZB-D8
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jun 2012 02:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756784Ab2FXAM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jun 2012 20:12:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43884 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756641Ab2FXALv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2012 20:11:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA95A8F3F
	for <git@vger.kernel.org>; Sat, 23 Jun 2012 20:11:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=YVOs
	6V04+Buk9tfuFycFs6Rinww=; b=A48zliMkxmC+6uZXYv/eox+rwycNdytNOw0a
	s6+UZ/lLBUzPT3XHIKbYKghE1jw/Sncw7VsMI3yG/0a/KsS1w9VbjJTBvNCQM0pL
	J9rUBh74Q8UWUL20951rC3ykUb/BJlk+ycLFfea86aJD6nAJBMgJqRJk+9omIgnU
	x63+W8s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=AIbefO
	44Nu//8RrWJrqRU8uAoQY5O/pkMMsGyodvZVKv1I3GbqiGm73U0VwmeVbXOu1HZA
	lfOxkwUB/XCWPjLINbSar6zNDFhNvUdchet+4BCOqLl8iAk2ADdAo4cSiNtzgpBG
	aY7HWDFo/uNdEPUljd4MoBSE88IjV2fgywRRE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2C8D8F3E
	for <git@vger.kernel.org>; Sat, 23 Jun 2012 20:11:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2D1618F3C for
 <git@vger.kernel.org>; Sat, 23 Jun 2012 20:11:50 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.29.gf71be5c
In-Reply-To: <1340496691-12258-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 31D79566-BD91-11E1-A33D-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200509>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_name.c                         |   3 +-
 t/t1512-rev-parse-disambiguation.sh | 172 ++++++++++++++++++++++++++++++++++++
 2 files changed, 174 insertions(+), 1 deletion(-)
 create mode 100755 t/t1512-rev-parse-disambiguation.sh

diff --git a/sha1_name.c b/sha1_name.c
index 58dbbe2..15e97eb 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -606,6 +606,7 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
 static int get_describe_name(const char *name, int len, unsigned char *sha1)
 {
 	const char *cp;
+	unsigned flags = GET_SHORT_QUIETLY | GET_SHORT_COMMIT_ONLY;
 
 	for (cp = name + len - 1; name + 2 <= cp; cp--) {
 		char ch = *cp;
@@ -616,7 +617,7 @@ static int get_describe_name(const char *name, int len, unsigned char *sha1)
 			if (ch == 'g' && cp[-1] == '-') {
 				cp++;
 				len -= cp - name;
-				return get_short_sha1(cp, len, sha1, GET_SHORT_QUIETLY);
+				return get_short_sha1(cp, len, sha1, flags);
 			}
 		}
 	}
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
new file mode 100755
index 0000000..ad16f32
--- /dev/null
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -0,0 +1,172 @@
+#!/bin/sh
+
+test_description='object name disambiguation
+
+Create blobs, trees, commits and a tag that all share the same
+prefix, and make sure "git rev-parse" can take advantage of
+type information to disambiguate short object names that are
+not necessarily unique.
+
+The final history used in the test has five commits, with the bottom
+one tagged as v1.0.0.  They all have one regular file each.
+
+  +-------------------------------------------+
+  |                                           |
+  |           .-------cs60sb5----- d59np2z    |
+  |          /                   /            |
+  |  d8znjge0 ---a2dit76---b4crl15            |
+  |                                           |
+  +-------------------------------------------+
+
+'
+
+. ./test-lib.sh
+
+test_expect_success 'blob and tree' '
+	(
+		for i in 0 1 2 3 4 5 6 7 8 9
+		do
+			echo $i
+		done
+		echo
+		echo cbpkuqa
+	) >bz01t33 &&
+
+	# create one blob 1102198254
+	git add bz01t33 &&
+
+	# create one tree 1102198206
+	git write-tree
+'
+
+test_expect_failure 'disambiguate tree-ish' '
+	# feed tree-ish in an unambiguous way
+	git rev-parse --verify 1102198206:bz01t33 &&
+
+	# ambiguous at the object name level, but there is only one
+	# such tree-ish (the other is a blob)
+	git rev-parse --verify 11021982:bz01t33
+'
+
+test_expect_success 'first commit' '
+	# create one commit 1102198268
+	test_tick &&
+	git commit -m d8znjge0
+'
+
+test_expect_failure 'disambiguate commit-ish' '
+	# feed commit-ish in an unambiguous way
+	git rev-parse --verify 1102198268^{commit} &&
+
+	# ambiguous at the object name level, but there is only one
+	# such commit (the others are tree and blob)
+	git rev-parse --verify 11021982^{commit} &&
+
+	# likewise
+	git rev-parse --verify 11021982^0
+'
+
+test_expect_success 'first tag' '
+	# create one tag 1102198256
+	git tag -a -m d3g97ek v1.0.0
+'
+
+test_expect_failure 'two semi-ambiguous commit-ish' '
+	# Once the parser becomes ultra-smart, it could notice that
+	# 110282 before ^{commit} name many different objects, but
+	# that only two (HEAD and v1.0.0 tag) can be peeled to commit,
+	# and that peeling them down to commit yield the same commit
+	# without ambiguity.
+	git rev-parse --verify 110282^{commit}
+'
+
+test_expect_failure 'three semi-ambiguous tree-ish' '
+	# Likewise for tree-ish.  HEAD, v1.0.0 and HEAD^{tree} share
+	# the prefix but peeling them to tree yields the same thing
+	git rev-parse --verify 110282^{tree}
+'
+
+test_expect_success 'parse describe name' '
+	# feed an unambiguous describe name
+	git rev-parse --verify v1.0.0-0-g1102198268 &&
+
+	# ambiguous at the object name level, but there is only one
+	# such commit (others are blob, tree and tag)
+	git rev-parse --verify v1.0.0-0-g11021982
+'
+
+test_expect_success 'more history' '
+	# commit 110219822
+	git mv bz01t33 b90au8x &&
+	echo bdc8xi8 >>b90au8x &&
+	git add b90au8x &&
+
+	test_tick &&
+	git commit -m a2dit76 &&
+
+	# commit 110219828
+	git mv b90au8x djintr2 &&
+	echo a2a49zt >>djintr2 &&
+	git add djintr2 &&
+
+	test_tick &&
+	git commit -m b4crl15 &&
+
+	# commit 11021982d
+	git checkout v1.0.0^0 &&
+	git mv bz01t33 ddp2qt1 &&
+
+	for i in bdc8xi8 a2a49zt c0l9aeu
+	do
+		echo $i
+	done >>ddp2qt1 &&
+	git add ddp2qt1 &&
+
+	test_tick &&
+	git commit -m cs60sb5 &&
+	side=$(git rev-parse HEAD) &&
+
+	# commit 11021982a
+	git checkout master &&
+
+	# If you use recursive, merge will fail and you will need to
+	# clean up bz01t33 as well.  If you use resolve, merge will
+	# succeed.
+	test_might_fail git merge --no-commit -s resolve $side &&
+	git rm -f ddp2qt1 djintr2 &&
+	test_might_fail git rm -f bz01t33 &&
+	(
+		git cat-file blob $side:ddp2qt1
+		echo d4o8f4f
+	) >c3q9963 &&
+	git add c3q9963 &&
+
+	test_tick &&
+	git commit -m d59np2z
+
+'
+
+test_expect_failure 'parse describe name taking advantage of generation' '
+	# ambiguous at the object name level, but there is only one
+	# such commit at generation 0
+	git rev-parse --verify v1.0.0-0-g11021982 &&
+
+	# likewise for generation 2 and 4
+	git rev-parse --verify v1.0.0-2-g11021982 &&
+	git rev-parse --verify v1.0.0-4-g11021982
+'
+
+# Note: because rev-parse does not even try to disambiguate based on
+# the generation number, this test currently succeeds for a wrong
+# reason.  When it learns to use the generation number, the previous
+# test should succeed, and also this test should fail because the
+# describe name used in the test with generation number can name two
+# commits.  Make sure that such a future enhancement does not randomly
+# pick one.
+test_expect_success 'parse describe name not ignoring ambiguity' '
+	# ambiguous at the object name level, and there are two such
+	# commits at generation 1
+	test_must_fail git rev-parse --verify v1.0.0-1-g11021982
+'
+
+test_done
-- 
1.7.11.1.29.gf71be5c
