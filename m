From: Carlos Rica <jasampler@gmail.com>
Subject: [PATCH 1/2] Add test script for git-stripspace.
Date: Mon, 25 Jun 2007 21:24:21 +0200
Message-ID: <46801665.4050708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Johannes.Schindelin@gmx.de, krh@redhat.com
X-From: git-owner@vger.kernel.org Mon Jun 25 21:24:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2uAq-0003Km-Vq
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 21:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735AbXFYTYa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 15:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752421AbXFYTY3
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 15:24:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:10945 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbXFYTY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 15:24:28 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1358930ugf
        for <git@vger.kernel.org>; Mon, 25 Jun 2007 12:24:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=AwBbi5WMhAHnFelFoTIPR8mWdtsVKThR9QdS3ry/7u1lykj9Z/DS/P6rHnR7j6OIB1ZNbl2nhKWucwVxxdj8tdqXgfkByKnamXeQ0F+Vfn/6KlIgmi9/HCAf54fTl9VV2KDrsRR1GBYNj8ru8JbkBwT73yARyzGBfMIYcAT+8tc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=QoSE30HO1MTK7Ypic62WhCcGYiCBxlmAZWwdDe0sKP0rFID1Py/7obbY8UBm4y2m4YXzx+mw0EkBFWSalbCoM6W30N1YV/euce/Y4sDDdDstZW/MjXPf874qtoDG7rjYcA+K2bxd4RroUlpXpSx7WK0R43sIQyWdRwZXABnw1y0=
Received: by 10.67.19.13 with SMTP id w13mr5372228ugi.1182799466497;
        Mon, 25 Jun 2007 12:24:26 -0700 (PDT)
Received: from ?192.168.0.192? ( [212.145.102.186])
        by mx.google.com with ESMTP id l40sm4950406ugc.2007.06.25.12.24.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Jun 2007 12:24:25 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (X11/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50913>

These tests check some features that git-stripspace already has
and those that it should manage well: Removing trailing spaces
from lines, removing blank lines at the beginning and end,
unifying multiple lines between paragraphs, doing the correct
when there is no newline at the last line, etc.

It seems that the implementation needs to save the whole line
in memory to be able to manage correctly long lines with
text and spaces conveniently distribuited on them.

Signed-off-by: Carlos Rica <jasampler@gmail.com>
---
t/t0030-stripspace.sh |  355
+++++++++++++++++++++++++++++++++++++++++++++++++
1 files changed, 355 insertions(+), 0 deletions(-)
create mode 100644 t/t0030-stripspace.sh

diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
new file mode 100644
index 0000000..abd82d7
--- /dev/null
+++ b/t/t0030-stripspace.sh
@@ -0,0 +1,355 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Carlos Rica
+#
+
+test_description='git-stripspace'
+
+. ./test-lib.sh
+
+t40='A quick brown fox jumps over the lazy do'
+s40='                                        '
+sss="$s40$s40$s40$s40$s40$s40$s40$s40$s40$s40" # 400
+ttt="$t40$t40$t40$t40$t40$t40$t40$t40$t40$t40" # 400
+
+test_expect_success \
+    'long lines without spaces should be unchanged' '
+    echo "$ttt" >expect &&
+    cat expect | git-stripspace >actual &&
+    git diff expect actual &&
+
+    echo "$ttt$ttt" >expect &&
+    cat expect | git-stripspace >actual &&
+    git diff expect actual &&
+
+    echo "$ttt$ttt$ttt" >expect &&
+    cat expect | git-stripspace >actual &&
+    git diff expect actual &&
+
+    echo "$ttt$ttt$ttt$ttt" >expect &&
+    cat expect | git-stripspace >actual &&
+    git diff expect actual
+'
+
+test_expect_success \
+    'lines with spaces at the beginning should be unchanged' '
+    echo "$sss$ttt" >expect &&
+    cat expect | git-stripspace >actual &&
+    git diff expect actual &&
+
+    echo "$sss$sss$ttt" >expect &&
+    cat expect | git-stripspace >actual &&
+    git diff expect actual &&
+
+    echo "$sss$sss$sss$ttt" >expect &&
+    cat expect | git-stripspace >actual &&
+    git diff expect actual
+'
+
+test_expect_success \
+    'lines with intermediate spaces should be unchanged' '
+    echo "$ttt$sss$ttt" >expect &&
+    cat expect | git-stripspace >actual &&
+    git diff expect actual &&
+
+    echo "$ttt$sss$sss$ttt" >expect &&
+    cat expect | git-stripspace >actual &&
+    git diff expect actual
+'
+
+test_expect_success \
+    'consecutive blank lines should be unified' '
+    printf "$ttt\n\n$ttt\n" > expect &&
+    printf "$ttt\n\n\n\n\n$ttt\n" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    printf "$ttt$ttt\n\n$ttt\n" > expect &&
+    printf "$ttt$ttt\n\n\n\n\n$ttt\n" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    printf "$ttt$ttt$ttt\n\n$ttt\n" > expect &&
+    printf "$ttt$ttt$ttt\n\n\n\n\n$ttt\n" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    printf "$ttt\n\n$ttt\n" > expect &&
+    printf "$ttt\n\n\n\n\n$ttt\n" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    printf "$ttt\n\n$ttt$ttt\n" > expect &&
+    printf "$ttt\n\n\n\n\n$ttt$ttt\n" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    printf "$ttt\n\n$ttt$ttt$ttt\n" > expect &&
+    printf "$ttt\n\n\n\n\n$ttt$ttt$ttt\n" | git-stripspace >actual &&
+    git diff expect actual
+'
+
+test_expect_success \
+    'consecutive blank lines at the beginning should be removed' '
+    printf "" > expect &&
+    printf "\n" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    printf "" > expect &&
+    printf "\n\n\n" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    printf "" > expect &&
+    printf "$sss\n$sss\n$sss\n" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    printf "" > expect &&
+    printf "$sss$sss\n$sss\n\n" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    printf "" > expect &&
+    printf "\n$sss\n$sss$sss\n" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    printf "" > expect &&
+    printf "$sss$sss$sss$sss\n\n\n" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    printf "" > expect &&
+    printf "\n$sss$sss$sss$sss\n\n" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    printf "" > expect &&
+    printf "\n\n$sss$sss$sss$sss\n" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    printf "$ttt\n" > expect &&
+    printf "\n$ttt\n" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    printf "$ttt\n" > expect &&
+    printf "\n\n\n$ttt\n" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    printf "$ttt$ttt\n" > expect &&
+    printf "\n\n\n$ttt$ttt\n" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    printf "$ttt$ttt$ttt\n" > expect &&
+    printf "\n\n\n$ttt$ttt$ttt\n" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    printf "$ttt$ttt$ttt$ttt\n" > expect &&
+    printf "\n\n\n$ttt$ttt$ttt$ttt\n" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    printf "$ttt\n" > expect &&
+    printf "$sss\n$sss\n$sss\n$ttt\n" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    printf "$ttt\n" > expect &&
+    printf "\n$sss\n$sss$sss\n$ttt\n" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    printf "$ttt\n" > expect &&
+    printf "$sss$sss\n$sss\n\n$ttt\n" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    printf "$ttt\n" > expect &&
+    printf "$sss$sss$sss\n\n\n$ttt\n" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    printf "$ttt\n" > expect &&
+    printf "\n$sss$sss$sss\n\n$ttt\n" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    printf "$ttt\n" > expect &&
+    printf "\n\n$sss$sss$sss\n$ttt\n" | git-stripspace >actual &&
+    git diff expect actual
+'
+
+test_expect_success \
+    'consecutive blank lines at the end should be removed' '
+    printf "$ttt\n" > expect &&
+    printf "$ttt\n\n" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    printf "$ttt\n" > expect &&
+    printf "$ttt\n\n\n\n" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    printf "$ttt$ttt\n" > expect &&
+    printf "$ttt$ttt\n\n\n\n" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    printf "$ttt$ttt$ttt\n" > expect &&
+    printf "$ttt$ttt$ttt\n\n\n\n" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    printf "$ttt$ttt$ttt$ttt\n" > expect &&
+    printf "$ttt$ttt$ttt$ttt\n\n\n\n" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    printf "$ttt\n" > expect &&
+    printf "$ttt\n$sss\n$sss\n$sss\n" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    printf "$ttt\n" > expect &&
+    printf "$ttt\n\n$sss\n$sss$sss\n" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    printf "$ttt\n" > expect &&
+    printf "$ttt\n$sss$sss\n$sss\n\n" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    printf "$ttt\n" > expect &&
+    printf "$ttt\n$sss$sss$sss\n\n\n" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    printf "$ttt\n" > expect &&
+    printf "$ttt\n\n$sss$sss$sss\n\n" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    printf "$ttt\n" > expect &&
+    printf "$ttt\n\n\n$sss$sss$sss\n" | git-stripspace >actual &&
+    git diff expect actual
+'
+
+test_expect_success \
+    'text without newline at end should end with newline' '
+    test `printf "$ttt" | git-stripspace | wc -l` -gt 0 &&
+    test `printf "$ttt$ttt" | git-stripspace | wc -l` -gt 0 &&
+    test `printf "$ttt$ttt$ttt" | git-stripspace | wc -l` -gt 0 &&
+    test `printf "$ttt$ttt$ttt$ttt" | git-stripspace | wc -l` -gt 0
+'
+
+# text plus spaces at the end:
+
+test_expect_success \
+    'text plus spaces without newline at end should end with newline' '
+    test `printf "$ttt$sss" | git-stripspace | wc -l` -gt 0 &&
+    test `printf "$ttt$ttt$sss" | git-stripspace | wc -l` -gt 0 &&
+    test `printf "$ttt$ttt$ttt$sss" | git-stripspace | wc -l` -gt 0
+    test `printf "$ttt$sss$sss" | git-stripspace | wc -l` -gt 0 &&
+    test `printf "$ttt$ttt$sss$sss" | git-stripspace | wc -l` -gt 0 &&
+    test `printf "$ttt$sss$sss$sss" | git-stripspace | wc -l` -gt 0
+'
+
+test_expect_failure \
+    'text plus spaces without newline at end should not show spaces' '
+    printf "$ttt$sss" | git-stripspace | grep -q "  " ||
+    printf "$ttt$ttt$sss" | git-stripspace | grep -q "  " ||
+    printf "$ttt$ttt$ttt$sss" | git-stripspace | grep -q "  " ||
+    printf "$ttt$sss$sss" | git-stripspace | grep -q "  " ||
+    printf "$ttt$ttt$sss$sss" | git-stripspace | grep -q "  " ||
+    printf "$ttt$sss$sss$sss" | git-stripspace | grep -q "  "
+'
+
+test_expect_success \
+    'text plus spaces without newline should show the correct lines' '
+    printf "$ttt\n" >expect &&
+    printf "$ttt$sss" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    printf "$ttt\n" >expect &&
+    printf "$ttt$sss$sss" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    printf "$ttt\n" >expect &&
+    printf "$ttt$sss$sss$sss" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    printf "$ttt$ttt\n" >expect &&
+    printf "$ttt$ttt$sss" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    printf "$ttt$ttt\n" >expect &&
+    printf "$ttt$ttt$sss$sss" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    printf "$ttt$ttt$ttt\n" >expect &&
+    printf "$ttt$ttt$ttt$sss" | git-stripspace >actual &&
+    git diff expect actual
+'
+
+test_expect_failure \
+    'text plus spaces at end should not show spaces' '
+    echo "$ttt$sss" | git-stripspace | grep -q "  " ||
+    echo "$ttt$ttt$sss" | git-stripspace | grep -q "  " ||
+    echo "$ttt$ttt$ttt$sss" | git-stripspace | grep -q "  " ||
+    echo "$ttt$sss$sss" | git-stripspace | grep -q "  " ||
+    echo "$ttt$ttt$sss$sss" | git-stripspace | grep -q "  " ||
+    echo "$ttt$sss$sss$sss" | git-stripspace | grep -q "  "
+'
+
+test_expect_success \
+    'text plus spaces at end should be cleaned and newline must remain' '
+    echo "$ttt" >expect &&
+    echo "$ttt$sss" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    echo "$ttt" >expect &&
+    echo "$ttt$sss$sss" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    echo "$ttt" >expect &&
+    echo "$ttt$sss$sss$sss" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    echo "$ttt$ttt" >expect &&
+    echo "$ttt$ttt$sss" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    echo "$ttt$ttt" >expect &&
+    echo "$ttt$ttt$sss$sss" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    echo "$ttt$ttt$ttt" >expect &&
+    echo "$ttt$ttt$ttt$sss" | git-stripspace >actual &&
+    git diff expect actual
+'
+
+# spaces only:
+
+test_expect_success \
+    'spaces with newline at end should be replaced with empty string' '
+    printf "" >expect &&
+
+    echo | git-stripspace >actual &&
+    git diff expect actual &&
+
+    echo "$sss" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    echo "$sss$sss" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    echo "$sss$sss$sss" | git-stripspace >actual &&
+    git diff expect actual &&
+
+    echo "$sss$sss$sss$sss" | git-stripspace >actual &&
+    git diff expect actual
+'
+
+test_expect_failure \
+    'spaces without newline at end should not show spaces' '
+    printf "" | git-stripspace | grep -q " " ||
+    printf "$sss" | git-stripspace | grep -q " " ||
+    printf "$sss$sss" | git-stripspace | grep -q " " ||
+    printf "$sss$sss$sss" | git-stripspace | grep -q " " ||
+    printf "$sss$sss$sss$sss" | git-stripspace | grep -q " "
+'
+
+test_expect_success \
+    'spaces without newline at end should be replaced with empty string' '
+    printf "" >expect &&
+
+    printf "" | git-stripspace >actual &&
+    git diff expect actual
+
+    printf "$sss$sss" | git-stripspace >actual &&
+    git diff expect actual
+
+    printf "$sss$sss$sss" | git-stripspace >actual &&
+    git diff expect actual
+
+    printf "$sss$sss$sss$sss" | git-stripspace >actual &&
+    git diff expect actual
+'
+
+test_done
-- 
1.5.0
