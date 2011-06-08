From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 07/48] t6039: Ensure rename/rename conflicts leave index and workdir in sane state
Date: Wed,  8 Jun 2011 01:30:37 -0600
Message-ID: <1307518278-23814-8-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:32:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDFT-0007JK-SS
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754708Ab1FHH3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:29:12 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35036 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754575Ab1FHH3G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:29:06 -0400
Received: by mail-pw0-f46.google.com with SMTP id 15so118980pwi.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=CZRlGumIiGUGPGtTeqbZU632TmVBkmnQyQCllHfb8w8=;
        b=gV0YGaPee1DSbs0j8+JcbStYm5DbN1jy8KTtOAEWWh+3q4txikzGnBMPWt7buiGM3O
         AXpR6pdUcdVjF9Kxm4viQWAGuLozcnVxBk4Q6ror7f6tsO/gnvMFIZ1CQCOS9wwd+AFS
         LsgeUgnCS7bP1Z/uKqTgDpypoXOp/T1MLWNdc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=B0f5dwO/w8viC4UrHiq1QpVJBVQF7i/CgrS7nAkgc24sxy9qEpI5TBQ+hbWaAleDE2
         tkHW2i1wgE/CwVwQRroxIWiTzfuO1Z3/3ABzlFIitEWW9QXYKXswmJ6ubp1zXex8CFAk
         hQtjMcwMRHfR5/NY/Mcto5DIICEGisKsozcZA=
Received: by 10.68.19.35 with SMTP id b3mr596412pbe.512.1307518146527;
        Wed, 08 Jun 2011 00:29:06 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.29.03
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:29:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175341>

rename/rename conflicts, both with one file being renamed to two different
files and with two files being renamed to the same file, should leave the
index and the working copy in a sane state with appropriate conflict
recording, auxiliary files, etc.  Git seems to handle one of the two cases
alright, but has some problems with the two files being renamed to one
case.  Add tests for both cases.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6039-merge-rename-corner-cases.sh |   93 ++++++++++++++++++++++++++++++++++
 1 files changed, 93 insertions(+), 0 deletions(-)

diff --git a/t/t6039-merge-rename-corner-cases.sh b/t/t6039-merge-rename-corner-cases.sh
index fd8337f..06c7ea5 100755
--- a/t/t6039-merge-rename-corner-cases.sh
+++ b/t/t6039-merge-rename-corner-cases.sh
@@ -451,4 +451,97 @@ test_expect_failure 'rename/rename/add-dest merge still knows about conflicting
 	test $(git rev-parse :3:c) = $(git rev-parse B:c)
 '
 
+test_expect_success 'setup simple rename/rename (1to2) conflict' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	echo stuff >a &&
+	git add a &&
+	test_tick &&
+	git commit -m A &&
+	git tag A &&
+
+	git checkout -b B A &&
+	git mv a b &&
+	test_tick &&
+	git commit -m B &&
+
+	git checkout -b C A &&
+	git mv a c &&
+	test_tick &&
+	git commit -m C
+'
+
+test_expect_success 'merge has correct working tree contents' '
+	git checkout C^0 &&
+
+	test_must_fail git merge -s recursive B^0 &&
+
+	test 3 -eq $(git ls-files -s | wc -l) &&
+	test 3 -eq $(git ls-files -u | wc -l) &&
+	test 0 -eq $(git ls-files -o | wc -l) &&
+
+	test -f b &&
+	test -f c
+'
+
+# Test for all kinds of things that can go wrong with rename/rename (2to1):
+#   Commit A: new files: a & b
+#   Commit B: rename a->c, modify b
+#   Commit C: rename b->c, modify a
+#
+# Merging of B & C should NOT be clean.  Questions:
+#   * Both a & b should be removed by the merge; are they?
+#   * The two c's should contain modifications to a & b; do they?
+#   * The index should contain two files, both for c; does it?
+#   * The working copy should have two files, both of form c~<unique>; does it?
+#   * Nothing else should be present.  Is anything?
+
+test_expect_success 'setup rename/rename (2to1) + modify/modify' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	printf "1\n2\n3\n4\n5\n" >a &&
+	printf "5\n4\n3\n2\n1\n" >b &&
+	git add a b &&
+	git commit -m A &&
+	git tag A &&
+
+	git checkout -b B A &&
+	git mv a c &&
+	echo 0 >>b &&
+	git add b &&
+	git commit -m B &&
+
+	git checkout -b C A &&
+	git mv b c &&
+	echo 6 >>a &&
+	git add a &&
+	git commit -m C
+'
+
+test_expect_failure 'handle rename/rename (2to1) conflict correctly' '
+	git checkout B^0 &&
+
+	test_must_fail git merge -s recursive C^0 >out &&
+	grep "CONFLICT (rename/rename)" out &&
+
+	test 2 -eq $(git ls-files -s | wc -l) &&
+	test 2 -eq $(git ls-files -u | wc -l) &&
+	test 2 -eq $(git ls-files -u c | wc -l) &&
+	test 3 -eq $(git ls-files -o | wc -l) &&
+
+	test ! -f a &&
+	test ! -f b &&
+	test -f c~HEAD &&
+	test -f c~C^0 &&
+
+	test $(git hash-object c~HEAD) = $(git rev-parse C:a) &&
+	test $(git hash-object c~C^0) = $(git rev-parse B:b)
+'
+
 test_done
-- 
1.7.6.rc0.62.g2d69f
