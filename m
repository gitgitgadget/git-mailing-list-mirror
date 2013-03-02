From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH] tests: make sure rename pretty print works
Date: Sat,  2 Mar 2013 15:38:12 +0100
Message-ID: <1362235092-16914-1-git-send-email-apelisse@gmail.com>
References: <7vip5cgjhp.fsf@alter.siamese.dyndns.org>
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 02 15:39:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBnag-0003gy-Eu
	for gcvg-git-2@plane.gmane.org; Sat, 02 Mar 2013 15:39:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752561Ab3CBOip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Mar 2013 09:38:45 -0500
Received: from mail-wg0-f54.google.com ([74.125.82.54]:55652 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752506Ab3CBOio (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Mar 2013 09:38:44 -0500
Received: by mail-wg0-f54.google.com with SMTP id fm10so3124865wgb.33
        for <git@vger.kernel.org>; Sat, 02 Mar 2013 06:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=3z05dcRGBsJnrfFMIgcQVrbrMaZQ+paXDkUIn2L9umE=;
        b=VXvhxhlrP+iCzb1Ei9pQR8BEUiVP0Vi9lDGe0ps64nSapY6z99BRIs0NUQGudDpkvu
         UwukYJUS9b9UHTKkcaoSQdHTgOllAq3tsMu5ivaRhd/BlYHeLnltM1gSkTwffk/HR2Ec
         gdVM8R0NXCbKqUQK+eGqBmD1AaqKeZdLoLSrK3Gw9FLVzx1Jt1E48bpiiEuG7WaSF4Tm
         qIzO4Beyfk38wLih7aycaCz+jfx/A6vHC7lSjieKndBpX42QDhy2gDnomSriqi/Q3SYN
         ljAX32E38bpqNN0AP4H9Z+KJQAfnWWVzfPcZR3y0u9I3dFuGRXRRzxyVuyqPE2xXZfHn
         ZKtg==
X-Received: by 10.194.83.105 with SMTP id p9mr23095110wjy.56.1362235123198;
        Sat, 02 Mar 2013 06:38:43 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id q13sm3979074wie.0.2013.03.02.06.38.41
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 02 Mar 2013 06:38:42 -0800 (PST)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <7vip5cgjhp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217329>

Add basic use cases and corner cases tests for
"git diff -M --summary/stat".

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 t/t4056-rename-pretty.sh |   54 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100755 t/t4056-rename-pretty.sh

diff --git a/t/t4056-rename-pretty.sh b/t/t4056-rename-pretty.sh
new file mode 100755
index 0000000..806046f
--- /dev/null
+++ b/t/t4056-rename-pretty.sh
@@ -0,0 +1,54 @@
+#!/bin/sh
+
+test_description='Rename pretty print
+
+'
+
+. ./test-lib.sh
+
+test_expect_success nothing_common '
+	mkdir -p a/b/ &&
+	: >a/b/c &&
+	git add a/b/c &&
+	git commit -m. &&
+	mkdir -p c/b/ &&
+	git mv a/b/c c/b/a &&
+	git commit -m. &&
+	git show -M --summary >output &&
+	test_i18ngrep "a/b/c => c/b/a" output
+'
+
+test_expect_success common_prefix '
+	mkdir -p c/d &&
+	git mv c/b/a c/d/e &&
+	git commit -m. &&
+	git show -M --summary >output &&
+	test_i18ngrep "c/{b/a => d/e}" output
+'
+
+test_expect_success common_suffix '
+	mkdir d &&
+	git mv c/d/e d/e &&
+	git commit -m. &&
+	git show -M --summary >output &&
+	test_i18ngrep "{c/d => d}/e" output
+'
+
+test_expect_success common_suffix_prefix '
+	mkdir d/f &&
+	git mv d/e d/f/e &&
+	git commit -m. &&
+	git show -M --summary >output &&
+	test_i18ngrep "d/{ => f}/e" output
+'
+
+test_expect_success common_overlap '
+	mkdir d/f/f &&
+	git mv d/f/e d/f/f/e &&
+	git commit -m. &&
+	git show -M --summary >output &&
+	test_i18ngrep "d/f/{ => f}/e" output
+'
+
+
+test_done
-- 
1.7.9.5
