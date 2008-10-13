From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Add testcase to ensure merging an early part of a branch is done properly
Date: Mon, 13 Oct 2008 22:54:25 +0200
Message-ID: <1223931265-8862-1-git-send-email-vmiklos@frugalware.org>
References: <1217438608-28855-1-git-send-email-vmiklos@frugalware.org>
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 22:55:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpURe-0002aX-7o
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 22:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757282AbYJMUxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 16:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756791AbYJMUxz
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 16:53:55 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:33941 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756153AbYJMUxx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 16:53:53 -0400
Received: from vmobile.example.net (dsl5401CD23.pool.t-online.hu [84.1.205.35])
	by yugo.frugalware.org (Postfix) with ESMTPA id 3E1B8149C60;
	Mon, 13 Oct 2008 22:53:51 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id DD54B19D92A; Mon, 13 Oct 2008 22:54:25 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <1217438608-28855-1-git-send-email-vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98143>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

[ Adding Shawn to CC as the interim maintainer. ]

On Wed, Jul 30, 2008 at 07:23:28PM +0200, Miklos Vajna <vmiklos@frugalware.org> wrote:
> Uh-oh. Here is a testcase that fails with master, but passes with your
> patch.

I remember you had a note about it's a bad habit to write a new test for
every bug, so here is an updated version that just improves
t7600-merge.sh and does not adds a new one.

 t/t7600-merge.sh |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 7313ac2..a4443a7 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -520,4 +520,30 @@ test_expect_success 'refresh the index before merging' '
 
 test_debug 'gitk --all'
 
+cat >expected <<EOF
+Merge branch 'c5' (early part)
+EOF
+
+test_expect_success 'merge early part of c2' '
+	git reset --hard c3 &&
+	echo c4 > c4.c &&
+	git add c4.c &&
+	git commit -m c4 &&
+	git tag c4 &&
+	echo c5 > c5.c &&
+	git add c5.c &&
+	git commit -m c5 &&
+	git tag c5 &&
+	git reset --hard c3 &&
+	echo c6 > c6.c &&
+	git add c6.c &&
+	git commit -m c6 &&
+	git tag c6 &&
+	git merge c5~1 &&
+	git show -s --pretty=format:%s HEAD > actual &&
+	test_cmp actual expected
+'
+
+test_debug 'gitk --all'
+
 test_done
-- 
1.6.0.2
