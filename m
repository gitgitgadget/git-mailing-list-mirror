From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] new test from the submodule chapter of the user manual
Date: Sat, 22 Sep 2007 22:05:35 +0200
Message-ID: <20070922200535.GE24023@genesis.frugalware.org>
References: <20070920003413.GJ16235@genesis.frugalware.org> <7v1wcum0ox.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0709201133590.28395@racer.site> <20070920170831.GQ16235@genesis.frugalware.org> <7vd4wdkokn.fsf@gitster.siamese.dyndns.org> <20070921130908.GF16235@genesis.frugalware.org> <7v1wcrki96.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 22 22:25:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZBXp-0003Vk-P1
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 22:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbXIVUZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2007 16:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752153AbXIVUZf
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Sep 2007 16:25:35 -0400
Received: from virgo.iok.hu ([193.202.89.103]:52883 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752131AbXIVUZf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2007 16:25:35 -0400
X-Greylist: delayed 1225 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Sep 2007 16:25:34 EDT
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id A2EB81B24FC;
	Sat, 22 Sep 2007 22:05:06 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id EA9446FCD4;
	Sat, 22 Sep 2007 22:04:20 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id E1D4B13A4016; Sat, 22 Sep 2007 22:05:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v1wcrki96.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13cvs-muttng-frugalware (2007-01-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58941>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Fri, Sep 21, 2007 at 11:04:05AM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> That's horrible.  Please do not depend on object SHA1's to stay
> the same.  If somebody makes a fix to the test to add a new file
> in a sample subproject it would break all the rest.  Also please
> do not depend on the progress output.

okay, here is the third try. now checking for the result using diff-tree and
ls-files. hopefully i did what you expected :)

 t/t3060-subprojects-tutorial.sh |   95 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 95 insertions(+), 0 deletions(-)
 create mode 100755 t/t3060-subprojects-tutorial.sh

diff --git a/t/t3060-subprojects-tutorial.sh b/t/t3060-subprojects-tutorial.sh
new file mode 100755
index 0000000..d46dded
--- /dev/null
+++ b/t/t3060-subprojects-tutorial.sh
@@ -0,0 +1,95 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Miklos Vajna
+#
+
+test_description='A simple subprojects tutorial in the form of a test case'
+
+. ./test-lib.sh
+
+test_expect_success "create the submodules" '
+	for i in a b c d
+	do
+		mkdir $i &&
+		cd $i &&
+		git init &&
+		echo "module $i" > $i.txt &&
+		git add $i.txt &&
+		git commit -m "Initial commit, submodule $i" &&
+		cd ..
+	done
+'
+
+mkdir super
+cd super
+cat >expected << EOF
+:000000 100644 00000... A	.gitmodules
+:000000 160000 00000... A	a
+:000000 160000 00000... A	b
+:000000 160000 00000... A	c
+:000000 160000 00000... A	d
+EOF
+
+test_expect_success "create the superproject" '
+	git init &&
+	echo super > super.txt &&
+	git add super.txt &&
+	git commit -m "initial" &&
+	for i in a b c d
+	do
+		git submodule add '`pwd`'/../$i
+	done &&
+	git commit -m "Add submodules a, b, c and d." &&
+	git diff-tree --abbrev=5 HEAD^ HEAD |cut -d" " -f-3,5- >current &&
+	cmp expected current
+'
+
+test_expect_success "checking if the correct commit is stored in the superproject" '
+	for i in a b c d
+	do
+		git ls-files -s $i|cut -d " " -f 2 > $i.actual &&
+		(cd $i && git-rev-parse HEAD) > $i.expected &&
+		cmp $i.actual $i.expected
+	done &&
+	cd ..
+'
+
+test_expect_success "clone the superproject" '
+	git clone super cloned &&
+	cd cloned
+'
+
+test_expect_success "submodule init" '
+	git submodule init
+'
+
+test_expect_success "submodule update" '
+	git submodule update
+'
+
+test_expect_success "checking the result of the commit in the cloned project" '
+	for i in a b c d
+	do
+		git ls-files -s $i|cut -d " " -f 2 > $i.actual &&
+		(cd $i && git-rev-parse HEAD) > $i.expected &&
+		cmp $i.actual $i.expected
+	done
+'
+
+test_expect_success "update the submodule from within the superproject" '
+	cd a &&
+	echo "adding a line again" >> a.txt &&
+	git commit -a -m "Updated the submodule from within the superproject." &&
+	git push &&
+	cd .. &&
+	git add a &&
+	git commit -m "Updated submodule a." &&
+	git push
+'
+
+test_expect_success "checking the result of the commit in the updated cloned project" '
+	git ls-files -s a|cut -d " " -f 2 > a.actual &&
+	(cd a && git-rev-parse HEAD) > a.expected &&
+	cmp a.actual a.expected
+'
+test_done
-- 
1.5.3.2.80.g077d6f-dirty
