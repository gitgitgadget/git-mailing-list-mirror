From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Improve t6029 to check the real "subtree" case
Date: Thu, 28 Feb 2008 13:36:54 +0100
Message-ID: <20080228123654.GE31441@genesis.frugalware.org>
References: <7vprun32m2.fsf@gitster.siamese.dyndns.org> <20080228015122.GB31441@genesis.frugalware.org> <alpine.LSU.1.00.0802280944110.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 13:37:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUi11-0000gh-Kg
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 13:37:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752910AbYB1Mg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 07:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752260AbYB1Mg5
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 07:36:57 -0500
Received: from virgo.iok.hu ([193.202.89.103]:17253 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752071AbYB1Mg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 07:36:56 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id F1A0C1B2564;
	Thu, 28 Feb 2008 13:36:54 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 225B644698;
	Thu, 28 Feb 2008 13:34:21 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 24FEE11904D7; Thu, 28 Feb 2008 13:36:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802280944110.22527@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75393>

t6029 already checks if subtree available and works like recursive. This
patch adds code to test test the extra functionality the subtree merge
strategy provides.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Thu, Feb 28, 2008 at 09:45:03AM +0000, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Why yet another file?  Why not enhance t6029, as suggested?

here it is.

 t/t6029-merge-subtree.sh |   47 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/t/t6029-merge-subtree.sh b/t/t6029-merge-subtree.sh
index 3900a05..35d66e8 100755
--- a/t/t6029-merge-subtree.sh
+++ b/t/t6029-merge-subtree.sh
@@ -29,4 +29,51 @@ test_expect_success 'subtree available and works like recursive' '
 
 '
 
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
 test_done
-- 
1.5.4
