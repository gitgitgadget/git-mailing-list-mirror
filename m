From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] Add test that checkout does not overwrite entries in .git/info/exclude
Date: Mon, 21 Nov 2011 08:23:45 +0100
Message-ID: <4EC9FC81.3080306@viscovery.net>
References: <CAPRVejcpAZrLWCeHTZJr9Uk6_z6hTPQLLd6pCOKteYnRGMQ5ig@mail.gmail.com> <7vehx2ijf8.fsf@alter.siamese.dyndns.org> <20111120221930.GF14902@foodlogiq3-xp-d620.thebe.ath.cx> <7vzkfqgn91.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Taylor Hedberg <tmhedberg@gmail.com>,
	Bertrand BENOIT <projettwk@users.sourceforge.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 21 08:24:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSOEi-0006EW-8r
	for gcvg-git-2@lo.gmane.org; Mon, 21 Nov 2011 08:24:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753510Ab1KUHXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Nov 2011 02:23:52 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:46223 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752770Ab1KUHXv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2011 02:23:51 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1RSOEE-0004sk-95; Mon, 21 Nov 2011 08:23:46 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 00D891660F;
	Mon, 21 Nov 2011 08:23:45 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.24) Gecko/20111103 Thunderbird/3.1.16
In-Reply-To: <7vzkfqgn91.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185733>

From: Johannes Sixt <j6t@kdbg.org>

It is an unintended accident that entries matched by .git/info/exclude are
considered precious, but entries matched by .gitignore are not. That is,
'git checkout' will overwrite untracked files matched by .gitignore, but
refuses to overwrite files matched by .git/info/exclude.

It is a lucky accident: it allows the distinction between "untracked but
precious" and "untracked and garbage". And it is a doubly lucky accident:
.gitignore entries are meant for files like build products, which usually
affect all consumers of a repository, whereas .git/info/exclude is
intended for personal files, which frequently are precious (think of a
TODO file).

Add a test that codifies the accident as wanted behavior.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Am 11/21/2011 4:36, schrieb Junio C Hamano:
> As far as I am aware, info/exclude should work exactly the same as having
> a .gitignore file at the root level of the working tree. Can you show a
> minimum reproduction recipe in a form of a patch to our test scripts in t/
> hierarchy?

Here you are. As you can see from my commit message, IMO, this is
a very useful accident. Therefore, there is no 'test_expect_failure'
in the test script :-)

-- Hannes

 t/t2023-checkout-ignored.sh |   51 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)
 create mode 100755 t/t2023-checkout-ignored.sh

diff --git a/t/t2023-checkout-ignored.sh b/t/t2023-checkout-ignored.sh
new file mode 100755
index 0000000..03a5a56
--- /dev/null
+++ b/t/t2023-checkout-ignored.sh
@@ -0,0 +1,51 @@
+#!/bin/sh
+
+test_description='checkout overwrites or preserves ignored files
+
+`git checkout` makes a distinction between files mentioned in
+.gitignore and .git/info/exclude in that untracked files matched
+by the latter are considered precious and are not overwritten.
+'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+
+	echo excluded > excluded &&
+	echo ignored > ignored &&
+	git add . &&
+	test_commit initial &&
+	git checkout -b side &&
+	git rm excluded &&
+	git mv ignored .gitignore &&
+	test_commit side &&
+	echo excluded >> .git/info/exclude
+'
+
+test_expect_success 'files are ignored' '
+
+	echo keep > excluded &&
+	echo overwrite > ignored &&
+	list=$(git ls-files --others --exclude-standard) &&
+	test -z "$list"
+'
+
+test_expect_success 'entries in .git/info/exclude are precious' '
+
+	test_must_fail git checkout master 2>errors &&
+	test_i18ngrep "would be overwritten" errors &&
+	grep "	excluded" errors &&
+	! grep "	ignored" errors &&
+	grep keep excluded &&
+	grep overwrite ignored
+'
+
+test_expect_success 'entries in .gitignore are not precious' '
+
+	rm -f excluded &&
+	git checkout master &&
+	grep excluded excluded &&
+	grep ignored ignored
+'
+
+test_done
-- 
1.7.8.rc0.126.gd15506
