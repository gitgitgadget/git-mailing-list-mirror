From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Add new test to ensure git-merge handles pull.twohead and pull.octopus
Date: Sat,  7 Jun 2008 02:47:29 +0200
Message-ID: <1212799649-3822-1-git-send-email-vmiklos@frugalware.org>
References: <7vmylzzdyo.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 02:48:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4mbV-00047e-KX
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 02:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753070AbYFGAr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 20:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752155AbYFGAr2
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 20:47:28 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:39968 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897AbYFGAr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 20:47:28 -0400
Received: from vmobile.example.net (catv-5062e605.catv.broadband.hu [80.98.230.5])
	by yugo.frugalware.org (Postfix) with ESMTP id 030961DDC5B;
	Sat,  7 Jun 2008 02:47:25 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 417A818E2A7; Sat,  7 Jun 2008 02:47:29 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc0.dirty
In-Reply-To: <7vmylzzdyo.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84159>

Test if the given strategies are used and test the case when multiple
strategies are configured using a space separated list.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Thu, Jun 05, 2008 at 03:58:23PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> > +test_expect_success 'merge c1 with c2' '
> > +   git reset --hard c1 &&
>
> test that c0 and c1 do and c2 and c3 do not exist here, as it is
> cheap,
> and otherwise you may end up chasing wild-goose when somebody breaks
> git-reset.  No need to do so in later tests in this script, but it is
> a
> cheap protection for yourself from others' mistakes ;-).

Done.

> > +   git merge c2 &&
> > +   test -e c1.c &&
> > +   test -e c2.c
> > +'
>
> Nobody runs V7 that lacked "test -e" to run these test scripts, but
> you
> expect them to be regular files at this point of the test, so the
> correct
> way to spell these is with "test -f".
>
> In general, you are better off training yourself to think if you can
> use
> "test -f" before blindly using "test -e".

Sure, corrected.

> > +test_expect_success 'merge c1 with c2 and c3 (recursive in
> > pull.octopus)' '
> > +   git reset --hard c1 &&
> > +   git config pull.octopus "recursive" &&
> > +   ! git merge c2 c3
>
> Is it because it should dump core, or is it because the command should
> decline to work, gracefully failing with an error message and non-zero
> exit status?  Use "test_must_fail" to check for the latter.

Obviously the later, corrected.

> Don't you want to check how it fails and in what shape the command
> leaves
> the work tree?  I am assuming that recursive sees more than one
> "remote"
> head and declines to work without touching work tree nor the index, so
> if
> that is what you expect, you should check for that.  Otherwise, a
> regression that loses local changes will go unnoticed.

Hm yes. I added checks to ensure nothing happened.

> > +test_expect_success 'merge c1 with c2 and c3 (recursive and octopus
> > in pull.octopus)' '
> > +   git reset --hard c1 &&
> > +   git config pull.octopus "recursive octopus" &&
> > +   git merge c2 c3
>
> Likewise, don't you want to check the result of the merge?  Not just
> "merge exited with 0", but you would want to see that the HEAD has
> advanced, it has the expected parents, there is no unexpected local
> changes (because you did not have any when you started the merge), and
> it
> has the expected tree contents.

Corrected.

I'm sending the version I just pushed to my working branch.

 t/t7601-merge-pull-config.sh |   72 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 72 insertions(+), 0 deletions(-)
 create mode 100755 t/t7601-merge-pull-config.sh

diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
new file mode 100755
index 0000000..c0b550e
--- /dev/null
+++ b/t/t7601-merge-pull-config.sh
@@ -0,0 +1,72 @@
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
+	git tag c2
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
+	test "$(git rev-parse c3)" = "$(git rev-parse HEAD^3)"
+	test "$(git rev-parse c3)" = "$(git rev-parse HEAD^3)" &&
+	git diff --exit-code &&
+	test -f c0.c &&
+	test -f c1.c &&
+	test -f c2.c &&
+	test -f c3.c
+'
+
+test_done
-- 
1.5.6.rc0.dirty
