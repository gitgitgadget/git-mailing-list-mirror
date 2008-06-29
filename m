From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Add new test to ensure git-merge handles pull.twohead and pull.octopus
Date: Sun, 29 Jun 2008 16:51:38 +0200
Message-ID: <1214751098-547-1-git-send-email-vmiklos@frugalware.org>
References: <48678E90.1030608@free.fr>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Sun Jun 29 16:52:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCyGY-0004MC-Nm
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 16:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760388AbYF2Ovi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 10:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760211AbYF2Ovi
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 10:51:38 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:38672 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097AbYF2Ovh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 10:51:37 -0400
Received: from vmobile.example.net (dsl5401CEBB.pool.t-online.hu [84.1.206.187])
	by yugo.frugalware.org (Postfix) with ESMTP id D49C41DDC5B;
	Sun, 29 Jun 2008 16:51:34 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 880261A9909; Sun, 29 Jun 2008 16:51:38 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.1
In-Reply-To: <48678E90.1030608@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86809>

Test if the given strategies are used and test the case when multiple
strategies are configured using a space separated list.

Also test if the best strategy is picked if none is specified.  This is
done by adding a simple test case where recursive detects a rename, but
resolve does not, and verify that finally merge will pick up the
previous.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

On Sun, Jun 29, 2008 at 03:30:56PM +0200, Olivier Marin <dkr+ml.git@free.fr> wrote:
> > +   git tag c2
>
> Missing &&?

Fixed.

> > +   test "$(git rev-parse c3)" = "$(git rev-parse HEAD^3)"
>
> Duplicate the next line?
>
> > +   test "$(git rev-parse c3)" = "$(git rev-parse HEAD^3)" &&

Yes, it was duplicated.

> > +   test "$auto_count" = "$recursive_count"
> > +'
>
> Should not "$auto_count" != "$resolve_count" also be tested to be
> sure that recursive has been choosen?

Sure, changed.

Updated patch below.

 t/t7601-merge-pull-config.sh |  129 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 129 insertions(+), 0 deletions(-)
 create mode 100755 t/t7601-merge-pull-config.sh

diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
new file mode 100755
index 0000000..32585f8
--- /dev/null
+++ b/t/t7601-merge-pull-config.sh
@@ -0,0 +1,129 @@
+#!/bin/sh
+
+test_description='git-merge
+
+Testing pull.* configuration parsing.'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo c0 >c0.c &&
+	git add c0.c &&
+	git commit -m c0 &&
+	git tag c0 &&
+	echo c1 >c1.c &&
+	git add c1.c &&
+	git commit -m c1 &&
+	git tag c1 &&
+	git reset --hard c0 &&
+	echo c2 >c2.c &&
+	git add c2.c &&
+	git commit -m c2 &&
+	git tag c2 &&
+	git reset --hard c0 &&
+	echo c3 >c3.c &&
+	git add c3.c &&
+	git commit -m c3 &&
+	git tag c3
+'
+
+test_expect_success 'merge c1 with c2' '
+	git reset --hard c1 &&
+	test -f c0.c &&
+	test -f c1.c &&
+	test ! -f c2.c &&
+	test ! -f c3.c &&
+	git merge c2 &&
+	test -f c1.c &&
+	test -f c2.c
+'
+
+test_expect_success 'merge c1 with c2 (ours in pull.twohead)' '
+	git reset --hard c1 &&
+	git config pull.twohead ours &&
+	git merge c2 &&
+	test -f c1.c &&
+	! test -f c2.c
+'
+
+test_expect_success 'merge c1 with c2 and c3 (recursive in pull.octopus)' '
+	git reset --hard c1 &&
+	git config pull.octopus "recursive" &&
+	test_must_fail git merge c2 c3 &&
+	test "$(git rev-parse c1)" = "$(git rev-parse HEAD)"
+'
+
+test_expect_success 'merge c1 with c2 and c3 (recursive and octopus in pull.octopus)' '
+	git reset --hard c1 &&
+	git config pull.octopus "recursive octopus" &&
+	git merge c2 c3 &&
+	test "$(git rev-parse c1)" != "$(git rev-parse HEAD)" &&
+	test "$(git rev-parse c1)" = "$(git rev-parse HEAD^1)" &&
+	test "$(git rev-parse c2)" = "$(git rev-parse HEAD^2)" &&
+	test "$(git rev-parse c3)" = "$(git rev-parse HEAD^3)" &&
+	git diff --exit-code &&
+	test -f c0.c &&
+	test -f c1.c &&
+	test -f c2.c &&
+	test -f c3.c
+'
+
+conflict_count()
+{
+	eval $1=`{
+		git diff-files --name-only
+		git ls-files --unmerged
+	} | wc -l`
+}
+
+# c4 - c5
+#    \ c6
+#
+# There are two conflicts here:
+#
+# 1) Because foo.c is renamed to bar.c, recursive will handle this,
+# resolve won't.
+#
+# 2) One in conflict.c and that will always fail.
+
+test_expect_success 'setup conflicted merge' '
+	git reset --hard c0 &&
+	echo A >conflict.c &&
+	git add conflict.c &&
+	echo contents >foo.c &&
+	git add foo.c &&
+	git commit -m c4 &&
+	git tag c4 &&
+	echo B >conflict.c &&
+	git add conflict.c &&
+	git mv foo.c bar.c &&
+	git commit -m c5 &&
+	git tag c5 &&
+	git reset --hard c4 &&
+	echo C >conflict.c &&
+	git add conflict.c &&
+	echo secondline >> foo.c &&
+	git add foo.c &&
+	git commit -m c6 &&
+	git tag c6
+'
+
+# First do the merge with resolve and recursive then verify that
+# recusive is choosen.
+
+test_expect_success 'merge picks up the best result' '
+	git config pull.twohead "recursive resolve" &&
+	git reset --hard c5 &&
+	git merge -s resolve c6
+	conflict_count resolve_count &&
+	git reset --hard c5 &&
+	git merge -s recursive c6
+	conflict_count recursive_count &&
+	git reset --hard c5 &&
+	git merge c6
+	conflict_count auto_count &&
+	test "$auto_count" = "$recursive_count" &&
+	test "$auto_count" != "$resolve_count"
+'
+
+test_done
-- 
1.5.6
