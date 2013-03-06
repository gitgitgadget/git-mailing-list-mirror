From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH v2] tests: make sure rename pretty print works
Date: Wed,  6 Mar 2013 22:36:12 +0100
Message-ID: <1362605772-14639-1-git-send-email-apelisse@gmail.com>
References: <1362235092-16914-1-git-send-email-apelisse@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 06 22:36:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDM18-0001Mn-BE
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 22:36:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755491Ab3CFVg2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 16:36:28 -0500
Received: from mail-wg0-f53.google.com ([74.125.82.53]:59631 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354Ab3CFVg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 16:36:27 -0500
Received: by mail-wg0-f53.google.com with SMTP id fn15so8384566wgb.20
        for <git@vger.kernel.org>; Wed, 06 Mar 2013 13:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=BXctj7R5r277aKkLaalJpMRGryqqBKBZT64HEnlAy1o=;
        b=pMj/zv+FrzIxbrfWZexj0P9Wc95s0SHMWoXmL/0fQeG5ldDQJGZ4NH1k/b9+VELFzx
         5RLs6bqCgos1s41FtY0mHQVxthlk5UnmfZ9BVUwrkwrt5Ks0MH6HdBcaNu3TVwUpxKUi
         YCbDXlFAbqoc4b5GI6t74fBOvT3q4PQAXs2zzybDnNUI+F940wAzwu3f40vsvcG+40AG
         XiaGB6ZybiWGwkMmcMDOIk1xz4brEjDQkHUj483rzrFuHWEyDByBqammcGl0qJwLlkUD
         w3R8T/mCUQU1EOEMSq9waeCJlpChz30YHvbDaFlyhDxUqatzO4RdKA9YtmwvDZFj+Yqm
         l5YA==
X-Received: by 10.180.98.198 with SMTP id ek6mr29151481wib.7.1362605786751;
        Wed, 06 Mar 2013 13:36:26 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id fv2sm32401169wib.6.2013.03.06.13.36.25
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 06 Mar 2013 13:36:26 -0800 (PST)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1362235092-16914-1-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217552>

Add basic use cases and corner cases tests for
"git diff -M --summary/stat".

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
list of fixes:
 - Test using diff instead of show
 (that is more consistent with commit message).
 - add extra spaces around paths
 - Use better commit messages
 - Moved to existing t4001

 t/t4001-diff-rename.sh |   54 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index 844277c..2f327b7 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -102,4 +102,58 @@ test_expect_success 'setup for many rename source candidates' '
 	grep warning actual.err
 '

+test_expect_success 'rename pretty print with nothing in common' '
+	mkdir -p a/b/ &&
+	: >a/b/c &&
+	git add a/b/c &&
+	git commit -m "create a/b/c" &&
+	mkdir -p c/b/ &&
+	git mv a/b/c c/b/a &&
+	git commit -m "a/b/c -> c/b/a" &&
+	git diff -M --summary HEAD^ HEAD >output &&
+	test_i18ngrep " a/b/c => c/b/a " output &&
+	git diff -M --stat HEAD^ HEAD >output &&
+	test_i18ngrep " a/b/c => c/b/a " output
+'
+
+test_expect_success 'rename pretty print with common prefix' '
+	mkdir -p c/d &&
+	git mv c/b/a c/d/e &&
+	git commit -m "c/b/a -> c/d/e" &&
+	git diff -M --summary HEAD^ HEAD >output &&
+	test_i18ngrep " c/{b/a => d/e} " output &&
+	git diff -M --stat HEAD^ HEAD >output &&
+	test_i18ngrep " c/{b/a => d/e} " output
+'
+
+test_expect_success 'rename pretty print with common suffix' '
+	mkdir d &&
+	git mv c/d/e d/e &&
+	git commit -m "c/d/e -> d/e" &&
+	git diff -M --summary HEAD^ HEAD >output &&
+	test_i18ngrep " {c/d => d}/e " output &&
+	git diff -M --stat HEAD^ HEAD >output &&
+	test_i18ngrep " {c/d => d}/e " output
+'
+
+test_expect_success 'rename pretty print with common prefix and suffix' '
+	mkdir d/f &&
+	git mv d/e d/f/e &&
+	git commit -m "d/e -> d/f/e" &&
+	git diff -M --summary HEAD^ HEAD >output &&
+	test_i18ngrep " d/{ => f}/e " output &&
+	git diff -M --stat HEAD^ HEAD >output &&
+	test_i18ngrep " d/{ => f}/e " output
+'
+
+test_expect_success 'rename pretty print common prefix and suffix overlap' '
+	mkdir d/f/f &&
+	git mv d/f/e d/f/f/e &&
+	git commit -m "d/f/e d/f/f/e" &&
+	git diff -M --summary HEAD^ HEAD >output &&
+	test_i18ngrep " d/f/{ => f}/e " output &&
+	git diff -M --stat HEAD^ HEAD >output &&
+	test_i18ngrep " d/f/{ => f}/e " output
+'
+
 test_done
--
1.7.9.5
