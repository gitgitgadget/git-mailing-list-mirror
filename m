From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] New test to check the real "subtree" case
Date: Thu, 28 Feb 2008 02:51:22 +0100
Message-ID: <20080228015122.GB31441@genesis.frugalware.org>
References: <7vprun32m2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 02:52:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUXwJ-0007jn-GV
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 02:52:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754262AbYB1Bv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 20:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754712AbYB1Bv0
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 20:51:26 -0500
Received: from virgo.iok.hu ([193.202.89.103]:16607 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753708AbYB1BvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 20:51:25 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 53FF51B255B;
	Thu, 28 Feb 2008 02:51:23 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 3E5B044698;
	Thu, 28 Feb 2008 02:48:50 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 47D2811904D7; Thu, 28 Feb 2008 02:51:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vprun32m2.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75339>

t6029 already checks if subtree available and works like recursive, but
this new one actually tests the extra functionality the subtree merge
strategy provides.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Sat, Feb 23, 2008 at 11:16:21AM -0800, Junio C Hamano <gitster@pobox.com> wrote:
> A new test t6029 currently only tests the strategy is available,
> but it should be enhanced to check the real "subtree" case.

i think something like this should do it.

 t/t3035-merge-subtree.sh |   54 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 54 insertions(+), 0 deletions(-)
 create mode 100755 t/t3035-merge-subtree.sh

diff --git a/t/t3035-merge-subtree.sh b/t/t3035-merge-subtree.sh
new file mode 100755
index 0000000..e400dce
--- /dev/null
+++ b/t/t3035-merge-subtree.sh
@@ -0,0 +1,54 @@
+#!/bin/sh
+
+test_description='merge-subtree backend test'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	mkdir git-gui &&
+	cd git-gui &&
+	git init &&
+	echo git-gui > git-gui.sh &&
+	o1=$(git hash-object git-gui.sh) &&
+	git add git-gui.sh &&
+	git commit -m "initial git-gui" &&
+	cd .. &&
+	mkdir git &&
+	cd git &&
+	git init &&
+	echo git >git.c &&
+	o2=$(git hash-object git.c) &&
+	git add git.c &&
+	git commit -m "initial git"
+'
+
+test_expect_success 'initial merge' '
+	git remote add -f gui ../git-gui &&
+	git merge -s ours --no-commit gui/master &&
+	git read-tree --prefix=git-gui/ -u gui/master &&
+	git commit -m "Merge git-gui as our subdirectory" &&
+	git ls-files -s >actual &&
+	(
+		echo "100644 $o1 0	git-gui/git-gui.sh"
+		echo "100644 $o2 0	git.c"
+	) >expected &&
+	git diff -u expected actual
+'
+
+test_expect_success 'merge update' '
+	cd ../git-gui &&
+	echo git-gui2 > git-gui.sh &&
+	o3=$(git hash-object git-gui.sh) &&
+	git add git-gui.sh &&
+	git commit -m "update git-gui" &&
+	cd ../git &&
+	git pull -s subtree gui master &&
+	git ls-files -s >actual &&
+	(
+		echo "100644 $o3 0	git-gui/git-gui.sh"
+		echo "100644 $o2 0	git.c"
+	) >expected &&
+	git diff -u expected actual
+'
+
+test_done
-- 
1.5.4.3
