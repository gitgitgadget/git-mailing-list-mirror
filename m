From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Reinstate the old behaviour when GIT_DIR is set and GIT_WORK_TREE is unset
Date: Fri, 10 Aug 2007 22:17:16 -0700
Message-ID: <7vhcn6ps4j.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0708042319470.14781@racer.site>
	<20070809223530.GA29680@cassiopeia>
	<Pine.LNX.4.64.0708100129200.21857@racer.site>
	<7vd4xww6mr.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0708100210280.21857@racer.site>
	<7vr6mbu8iv.fsf_-_@assigned-by-dhcp.cox.net>
	<20070810112821.GA11026@informatik.uni-freiburg.de>
	<7vk5s3ry0v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Sat Aug 11 07:17:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJjM0-0003ry-6L
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 07:17:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbXHKFRU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 11 Aug 2007 01:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbXHKFRU
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 01:17:20 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:40235 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbXHKFRT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Aug 2007 01:17:19 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070811051717.WIJN7956.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sat, 11 Aug 2007 01:17:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aVHH1X00n1kojtg0000000; Sat, 11 Aug 2007 01:17:18 -0400
In-Reply-To: <7vk5s3ry0v.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 10 Aug 2007 12:26:56 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55586>

Subject: [PATCH] Revert 4465f410 and add tests

checkout-index --prefix=3D<path> does not need a working tree,
even when run from inside a bare repository.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Junio C Hamano <gitster@pobox.com> writes:

 > Uwe Kleine-K=C3=B6nig  <ukleinek@informatik.uni-freiburg.de> writes:
 >
 >> I don't know if you planed to make=20
 >>
 >> 	git checkout-index --prefix=3D/tmp/tra -a
 >>
 >> work (again) in a bare repo.  Probably not, so it's no surprise tha=
t it
 >> still doesn't work.
 >
 > I think it is now safe to revert that NEED_WORK_TREE change
 > in git.c for checkout-index.

 How does this look?  I think the second test (no GIT_DIR, just
 being in a bare repository and specifying --prefix to redirect
 the output elsewhere) never worked even before the current
 work-tree feature was started (none of v1.4.4.4, v1.5.0, nor
 v1.5.2 worked that way), so this is not even "work again", but
 more like "now works".  Later tests with exported GIT_DIR would
 work with or without reverting the NEED_WORK_TREE change in
 git.c, so in that sense reverting is probably not such a good
 idea to begin with.  I dunno.

 git.c                            |    3 +-
 t/t2008-checkout-index-prefix.sh |   78 ++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 79 insertions(+), 2 deletions(-)
 create mode 100755 t/t2008-checkout-index-prefix.sh

diff --git a/git.c b/git.c
index f8c4545..bafbb4b 100644
--- a/git.c
+++ b/git.c
@@ -315,8 +315,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "branch", cmd_branch, RUN_SETUP },
 		{ "bundle", cmd_bundle },
 		{ "cat-file", cmd_cat_file, RUN_SETUP },
-		{ "checkout-index", cmd_checkout_index,
-			RUN_SETUP | NEED_WORK_TREE},
+		{ "checkout-index", cmd_checkout_index, RUN_SETUP},
 		{ "check-ref-format", cmd_check_ref_format },
 		{ "check-attr", cmd_check_attr, RUN_SETUP | NEED_WORK_TREE },
 		{ "cherry", cmd_cherry, RUN_SETUP },
diff --git a/t/t2008-checkout-index-prefix.sh b/t/t2008-checkout-index-=
prefix.sh
new file mode 100755
index 0000000..7727f07
--- /dev/null
+++ b/t/t2008-checkout-index-prefix.sh
@@ -0,0 +1,78 @@
+#!/bin/sh
+
+test_description=3D'checkout-index --prefix=3Dfoo/'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+
+	mkdir filfre &&
+	>frotz &&
+	>filfre/nitfol &&
+	git update-index --add frotz filfre/nitfol
+
+'
+
+rm -fr f*
+
+mv .git repo.git || exit ;# very bad
+GIT_DIR=3D"$(pwd)/repo.git"
+GIT_CONFIG=3D"$GIT_DIR/config" git config core.bare true
+
+test_expect_success 'checkout with --prefix' '
+
+	(
+		cd repo.git &&
+		git checkout-index --prefix=3D../f- -a
+	) &&
+	test -f f-frotz &&
+	test -d f-filfre &&
+	test -f f-filfre/nitfol
+
+'
+
+export GIT_DIR
+
+rm -fr f*
+
+test_expect_success 'checkout with --prefix and GIT_DIR (0)' '
+
+	(
+		cd repo.git &&
+		git checkout-index --prefix=3D../f/ -a
+	) &&
+	test -d f &&
+	test -f f/frotz &&
+	test -d f/filfre &&
+	test -f f/filfre/nitfol
+
+'
+
+rm -fr f*
+
+test_expect_success 'checkout with --prefix and GIT_DIR (1)' '
+
+	git checkout-index --prefix=3Df/ -a &&
+	test -d f &&
+	test -f f/frotz &&
+	test -d f/filfre &&
+	test -f f/filfre/nitfol
+
+'
+
+rm -fr f*
+
+test_expect_success 'checkout with --prefix and GIT_DIR (2)' '
+
+	mkdir f &&
+	(
+		cd f && git checkout-index --prefix=3D../f1/ -a
+	) &&
+	test -d f1 &&
+	test -f f1/frotz &&
+	test -d f1/filfre &&
+	test -f f1/filfre/nitfol
+
+'
+
+test_done
