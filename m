From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: [PATCH v6 1/6] t3004: Add test for ls-files on symlinks via absolute paths
Date: Tue,  4 Feb 2014 15:25:15 +0100
Message-ID: <1391523920-26946-2-git-send-email-martinerikwerner@gmail.com>
References: <1391358940-17373-1-git-send-email-martinerikwerner@gmail.com>
 <1391523920-26946-1-git-send-email-martinerikwerner@gmail.com>
Cc: richih@debian.org, tboegi@web.de, gitster@pobox.com,
	pclouds@gmail.com, dak@gnu.org,
	Martin Erik Werner <martinerikwerner@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 04 15:27:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAgwr-0002hc-Iv
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 15:26:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629AbaBDOZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 09:25:42 -0500
Received: from mail-ee0-f43.google.com ([74.125.83.43]:45134 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbaBDOZl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 09:25:41 -0500
Received: by mail-ee0-f43.google.com with SMTP id c41so4284502eek.2
        for <git@vger.kernel.org>; Tue, 04 Feb 2014 06:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Lk+bw9mqz4WmfLuraK858oaBKPjZcjwhkZhqgT1qlaQ=;
        b=PlAb6+8CS7Dd9Oj/UF1woD10rjsYyk3NtbEuUr0675iyX8KtloP4vLgJ6B6MYPuq2L
         WpRFLVAcBMGCYy9RjgakjS7YZcFHs2k6jafTNue0mxiZNthV0McBbjcrvf3htwJWiTEz
         lIsor3LxzVVfi7zeQDmWpYkfrEoCK8dYAPkvn1i3ADH+o0CVMh2fC/o9KZxSurpFMx/e
         zSMqZl+s0/90HyFXk51mTepC+b3aWlz+2Xs+mPFNESQ+5qCwIsoPfM7MceX9+ySUMc6u
         K/GQCy0KVBmpnobuEMh+wgnl+aGHzIhFiF95OOMXNuYPN9C4QbGaZSbn8OjwXTzY6QC3
         9scQ==
X-Received: by 10.14.3.130 with SMTP id 2mr50234614eeh.36.1391523940258;
        Tue, 04 Feb 2014 06:25:40 -0800 (PST)
Received: from localhost.localdomain ([194.150.18.52])
        by mx.google.com with ESMTPSA id u7sm89446218eep.11.2014.02.04.06.25.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Feb 2014 06:25:39 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1391523920-26946-1-git-send-email-martinerikwerner@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241523>

From: Junio C Hamano <gitster@pobox.com>

When symlinks in the working tree are manipulated using the absolute
path, git dereferences them, and tries to manipulate the link target
instead.

This causes most high-level functions to misbehave when acting on
symlinks given via absolute paths. For example

  $ git add /dir/repo/symlink

attempts to add the target of the symlink rather than the symlink
itself, which is usually not what the user intends to do.

This is a regression introduced by 18e051a:
  setup: translate symlinks in filename when using absolute paths
(which did not take symlinks inside the work tree into consideration).

Add a known-breakage test using the ls-files function, checking both if
the symlink leads to a target in the same directory, and a target in the
above directory.

Signed-off-by: Martin Erik Werner <martinerikwerner@gmail.com>
Tested-by: Martin Erik Werner <martinerikwerner@gmail.com>
---
 t/t3004-ls-files-basic.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t3004-ls-files-basic.sh b/t/t3004-ls-files-basic.sh
index 8d9bc3c..e20c077 100755
--- a/t/t3004-ls-files-basic.sh
+++ b/t/t3004-ls-files-basic.sh
@@ -36,4 +36,21 @@ test_expect_success 'ls-files -h in corrupt repository' '
 	test_i18ngrep "[Uu]sage: git ls-files " broken/usage
 '
 
+test_expect_failure SYMLINKS 'ls-files with absolute paths to symlinks' '
+	mkdir subs &&
+	ln -s nosuch link &&
+	ln -s ../nosuch subs/link &&
+	git add link subs/link &&
+	git ls-files -s link subs/link >expect &&
+	git ls-files -s "$(pwd)/link" "$(pwd)/subs/link" >actual &&
+	test_cmp expect actual &&
+
+	(
+		cd subs &&
+		git ls-files -s link >../expect &&
+		git ls-files -s "$(pwd)/link" >../actual
+	) &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.8.5.2
