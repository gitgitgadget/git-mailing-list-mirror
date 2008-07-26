From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] t7601: extend the 'merge picks up the best result' test
Date: Sat, 26 Jul 2008 13:54:45 +0200
Message-ID: <1217073292-27945-1-git-send-email-vmiklos@frugalware.org>
References: <cover.1217037178.git.vmiklos@frugalware.org>
 <f311372167c02868ccf5aa4dc03c97b7f956d855.1217037178.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 26 13:55:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMiN9-0002Vg-9K
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 13:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbYGZLy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 07:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751810AbYGZLy0
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 07:54:26 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:54444 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbYGZLyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 07:54:25 -0400
Received: from vmobile.example.net (dsl5401C493.pool.t-online.hu [84.1.196.147])
	by yugo.frugalware.org (Postfix) with ESMTP id 49E971DDC5B
	for <git@vger.kernel.org>; Sat, 26 Jul 2008 13:54:23 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 349D51AA739; Sat, 26 Jul 2008 13:54:52 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.14.g95f8.dirty
In-Reply-To: <f311372167c02868ccf5aa4dc03c97b7f956d855.1217037178.git.vmiklos@frugalware.org>
In-Reply-To: <7v7ibenx75.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90215>

The test only checked if the best result picking code works if there are
multiple strategies set in the config. Add a similar one that tests if
the same true if the -s option of git merge was used multiple times.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Tue, Jul 22, 2008 at 01:24:14AM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> Don't.  pull.* has always been defined as "list of strategies", and -s
> has
> always been defined to take "a" strategy.

OK. Here is a testcase for the later. As far as I see the behaviour of
multiple -s was not checked till now.

 t/t7601-merge-pull-config.sh |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 6b9f638..55aa6b5 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -112,6 +112,21 @@ test_expect_success 'setup conflicted merge' '
 # recusive is choosen.
 
 test_expect_success 'merge picks up the best result' '
+	git config --unset-all pull.twohead &&
+	git reset --hard c5 &&
+	git merge -s resolve c6
+	resolve_count=$(conflict_count) &&
+	git reset --hard c5 &&
+	git merge -s recursive c6
+	recursive_count=$(conflict_count) &&
+	git reset --hard c5 &&
+	git merge -s recursive -s resolve c6
+	auto_count=$(conflict_count) &&
+	test $auto_count = $recursive_count &&
+	test $auto_count != $resolve_count
+'
+
+test_expect_success 'merge picks up the best result (from config)' '
 	git config pull.twohead "recursive resolve" &&
 	git reset --hard c5 &&
 	git merge -s resolve c6
-- 
1.5.6.4.433.g09651.dirty
