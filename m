From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH] diff: Fix rename pretty-print when suffix and prefix overlap
Date: Thu, 28 Feb 2013 22:55:40 +0100
Message-ID: <1362088540-14564-1-git-send-email-apelisse@gmail.com>
References: <CALWbr2yviqF68zF7mBbhaXW7oFar0YRqROBWXwqjo7UNgZNVBQ@mail.gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 28 22:56:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBBSa-0003Cp-Dz
	for gcvg-git-2@plane.gmane.org; Thu, 28 Feb 2013 22:56:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759906Ab3B1Vzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2013 16:55:51 -0500
Received: from mail-wg0-f46.google.com ([74.125.82.46]:65135 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758662Ab3B1Vzv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2013 16:55:51 -0500
Received: by mail-wg0-f46.google.com with SMTP id fg15so1837066wgb.25
        for <git@vger.kernel.org>; Thu, 28 Feb 2013 13:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=U3B+GvdmV6RncuBiwQvfV8L0f/2WwpRoRjd/p60+n2E=;
        b=VFnn6X+/RQrrz/A8MZA4x8d1W7ROwQEY5Aql3DtZWeKhxnle7mpiNuRoMIh6y1qWq1
         jvWtiUIFag6HJqwTnpWILnN7oNHl5fRPKf4UbOMkLbNaRBrVMCDHW//RQORNWsWlvYCt
         lDZiC0sJWLJpzxOojQsBWaeP4JKYDsPX9W4wGJT0hmvfwp0iRWdXAHIxrdzmmBmIt6vO
         3HnOniFNj268FqEe9za9S5BI/FkpU4uYMaFiWJKTdqxQMtci/Ub4D0a+X8M/2Q3OQo4o
         Xph8dfCYHL7UJA1Zci0Rkb3po6acMtAXavjbyhzbC3IwugzoR9g5O0U4alcKnN9ED+VM
         lXyA==
X-Received: by 10.194.9.166 with SMTP id a6mr13962026wjb.2.1362088549861;
        Thu, 28 Feb 2013 13:55:49 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id j4sm36081345wiz.10.2013.02.28.13.55.48
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 28 Feb 2013 13:55:48 -0800 (PST)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <CALWbr2yviqF68zF7mBbhaXW7oFar0YRqROBWXwqjo7UNgZNVBQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217259>

When considering a rename for two files that have a suffix and a prefix
that can overlap, a confusing line is shown. As an example, renaming
"a/b/b/c" to "a/b/c" shows "a/b/{ => }/b/c", instead of "a/b/{b => }/c"

Currently, what we do is calculate the common prefix ("a/b/"), and the
common suffix ("/b/c"), but the same "/b/" is actually counted both in
prefix and suffix. Then when calculating the size of the non-common part,
we end-up with a negative value which is reset to 0, thus the "{ => }".

Do not allow the common suffix to overlap the common prefix and stop
when reaching a "/" that would be in both.

Also add some test file to place corner-cases we could met (and this one)
with rename pretty print.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 diff.c                   |   11 +++++++++-
 t/t4056-rename-pretty.sh |   54 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 1 deletion(-)
 create mode 100755 t/t4056-rename-pretty.sh

diff --git a/diff.c b/diff.c
index 9038f19..e1d82c9 100644
--- a/diff.c
+++ b/diff.c
@@ -1177,7 +1177,16 @@ static char *pprint_rename(const char *a, const char *b)
 	old = a + len_a;
 	new = b + len_b;
 	sfx_length = 0;
-	while (a <= old && b <= new && *old == *new) {
+	/*
+	 * Note:
+	 * if pfx_length is 0, old/new will never reach a - 1 because it
+	 * would mean the whole string is common suffix. But then, the
+	 * whole string would also be a common prefix, and we would not
+	 * have pfx_length equals 0.
+	 */
+	while (a + pfx_length - 1 <= old &&
+	       b + pfx_length - 1 <= new &&
+	       *old == *new) {
 		if (*old == '/')
 			sfx_length = len_a - (old - a);
 		old--;
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
