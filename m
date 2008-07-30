From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Add testcase to ensure merging an early part of a branch is done properly
Date: Wed, 30 Jul 2008 19:23:28 +0200
Message-ID: <1217438608-28855-1-git-send-email-vmiklos@frugalware.org>
References: <7vabfz7puk.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 19:24:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOFP8-00045s-ON
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 19:24:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752660AbYG3RXB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 13:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751877AbYG3RXB
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 13:23:01 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:43151 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819AbYG3RXA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 13:23:00 -0400
Received: from vmobile.example.net (dhcp-56.r.wlan.bme.hu [152.66.144.56])
	by yugo.frugalware.org (Postfix) with ESMTP id 861521DDC5B;
	Wed, 30 Jul 2008 19:22:58 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id AF7F01AA738; Wed, 30 Jul 2008 19:23:28 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.14.g95f8.dirty
In-Reply-To: <7vabfz7puk.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90819>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Wed, Jul 30, 2008 at 01:12:19AM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> In addition, the message forgot to skip "refs/heads/" it prefixed from
> the
> output.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  * It is a bit surprising that after beating merge-in-C to death, we
>    still find a minor breakage like this.

Uh-oh. Here is a testcase that fails with master, but passes with your
patch.

Thanks for catching this.

 t/t7607-merge-early.sh |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)
 create mode 100755 t/t7607-merge-early.sh

diff --git a/t/t7607-merge-early.sh b/t/t7607-merge-early.sh
new file mode 100755
index 0000000..9dd3ac5
--- /dev/null
+++ b/t/t7607-merge-early.sh
@@ -0,0 +1,39 @@
+#!/bin/sh
+
+test_description='git-merge
+
+Testing merging an early part of a branch.'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo c0 > c0.c &&
+	git add c0.c &&
+	git commit -m c0 &&
+	git tag c0 &&
+	echo c1 > c1.c &&
+	git add c1.c &&
+	git commit -m c1 &&
+	git tag c1 &&
+	echo c2 > c2.c &&
+	git add c2.c &&
+	git commit -m c2 &&
+	git tag c2 &&
+	git reset --hard c0 &&
+	echo c3 > c3.c &&
+	git add c3.c &&
+	git commit -m c3 &&
+	git tag c3
+'
+
+cat >expected <<EOF
+Merge branch 'c2' (early part)
+EOF
+
+test_expect_success 'merge early part of c2' '
+	git merge c2~1 &&
+	git show -s --pretty=format:%s HEAD > actual &&
+	test_cmp actual expected
+'
+
+test_done
-- 
1.6.0.rc0.14.g95f8.dirty
