From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] rerere: demonstrate a weakness with identical conflicts in
 different files
Date: Wed, 11 Aug 2010 14:16:21 +0200
Message-ID: <4C629495.60105@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 14:16:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjAER-0002Xc-1z
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 14:16:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850Ab0HKMQ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 08:16:26 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:36051 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600Ab0HKMQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 08:16:26 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OjAEH-0007wP-N0; Wed, 11 Aug 2010 14:16:21 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 662A41660F;
	Wed, 11 Aug 2010 14:16:21 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.11) Gecko/20100711 Thunderbird/3.0.6
X-Enigmail-Version: 1.0.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153229>

From: Johannes Sixt <j6t@kdbg.org>

When code sections are duplicated in different files and identical
conflicts arise simultaneously in these sections, then rerere resolves only
the first one and leaves the others unresolved.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 I encounter this situation several times a year, and every now and then
 it is particularly annoying because the conflicts are extensive.

 I would appreciate if you could have a look whether this is fixed
 easily. I tried myself, but I can't find the point where the
 subsequent conflicts are ignored.

 -- Hannes

 t/t4208-rerere-dup.sh |   77 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 77 insertions(+), 0 deletions(-)
 create mode 100755 t/t4208-rerere-dup.sh

diff --git a/t/t4208-rerere-dup.sh b/t/t4208-rerere-dup.sh
new file mode 100755
index 0000000..34c182a
--- /dev/null
+++ b/t/t4208-rerere-dup.sh
@@ -0,0 +1,77 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Johannes Sixt
+#
+
+test_description='test git rerere when sections of files are duplicated,
+and identical conflicts arise in these sections simultaneously.
+'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	cat > a1 <<- EOF &&
+	alpha
+	beta
+	gamma
+	EOF
+	sed -e s/alpha/ALPHA/ <a1 >a2 &&
+
+	git add a1 a2 &&
+	git commit -q -a -m initial &&
+
+	git checkout -b first &&
+	cat > a1 <<- EOF &&
+	alpha
+	BETA
+	gamma
+	EOF
+	sed -e s/alpha/ALPHA/ <a1 >a2 &&
+	git commit -q -a -m first &&
+
+	git checkout master &&
+	cat > a1 <<- EOF &&
+	alpha
+	----
+	gamma
+	EOF
+	sed -e s/alpha/ALPHA/ <a1 >a2 &&
+	git commit -q -a -m master &&
+	git config rerere.enabled true
+'
+
+test_expect_success 'merge records only one conflict' '
+	test_must_fail git merge first &&
+	sha1=$(ls .git/rr-cache) &&
+	test $(echo $sha1 | wc -w) = 1
+'
+
+test_expect_success 'record a resolution' '
+	cat > a1 <<- EOF &&
+	alpha
+	--beta--
+	gamma
+	EOF
+	sed -e s/alpha/ALPHA/ <a1 >a2 &&
+	git rerere 2>actual
+'
+
+test_expect_success 'postimage must exist' '
+	test -f .git/rr-cache/$sha1/postimage
+'
+
+test_expect_success 'same resolution recorded twice' '
+	test $(grep "Recorded resolution" actual | wc -l) = 2 &&
+	test $(ls .git/rr-cache | wc -w) = 1
+'
+
+test_expect_success 'repeat merge' '
+	git reset --hard &&
+	test_must_fail git merge first
+'
+
+test_expect_failure 'both files are resolved' '
+	! grep ===== a1 a2
+'
+
+test_done
-- 
1.7.2.63.g079547
