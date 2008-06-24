From: Christian Holtje <docwhat@gmail.com>
Subject: [PATCH v2] pre-commit hook should ignore carriage returns at EOL
Date: Tue, 24 Jun 2008 15:21:22 -0400
Message-ID: <3BA781AD-4C44-4F43-902A-07580B6CA075@gmail.com>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 21:22:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBE6E-0007cH-Vr
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 21:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091AbYFXTVr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Jun 2008 15:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751712AbYFXTVr
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 15:21:47 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:47464 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbYFXTVq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jun 2008 15:21:46 -0400
Received: by an-out-0708.google.com with SMTP id d40so733491and.103
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 12:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date:cc
         :x-mailer;
        bh=wStyn5wAoI8iBZJKMBQg7qlPJ1fvQKJwAk9HSJEcZT8=;
        b=I9Vzbv5s5n4DjQtj3LAknUa0GLMvRGQzShmpDn0kJrlYmOt2pigVnzgCF6HebFx8r8
         LOaturS5O/WHTLSFk+22NwfK+XnRiM1h2rquO6Oo16NW9Ipl29q+TGlqbNtQM5Le6d38
         7oRppmyhRm2c+DYkwKeaP0NyQM0WXxGPc+aTI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:cc:x-mailer;
        b=PBe7EQLJhKwcq4NhNCSz7SozN7zH+IKVULEWmymdblkujQ7lIUxzf3GLSqFR7SAUPF
         aQUMDCHz45vFax7jKHb8qo1+qQIqp8PgpT6J+ea7ntOF+T49CUK+BgliOSCiLlYLwGsU
         xmgtIEzaRVUdClIsk7LGrYkx7idO4fGeeaIwg=
Received: by 10.100.120.6 with SMTP id s6mr11103959anc.72.1214335305350;
        Tue, 24 Jun 2008 12:21:45 -0700 (PDT)
Received: from ?192.168.0.161? ( [206.210.75.84])
        by mx.google.com with ESMTPS id y67sm497525pyg.33.2008.06.24.12.21.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Jun 2008 12:21:40 -0700 (PDT)
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86116>

When commit files that use DOS style CRLF end-of-lines, the pre-commit
hook would raise an error.  When combined with the fact that the hooks
get activated by default on windows, it makes life difficult for
people working with DOS files.

This patch causes the pre-commit hook to deal with crlf files
correctly.

Signed-off-by: Christian H=F6ltje <docwhat@gmail.com>
---
  t/t7503-template-hook--pre-commit.sh |   75 +++++++++++++++++++++++++=
=20
+++++++++
  templates/hooks--pre-commit          |   10 ++++-
  2 files changed, 83 insertions(+), 2 deletions(-)
  create mode 100755 t/t7503-template-hook--pre-commit.sh

diff --git a/t/t7503-template-hook--pre-commit.sh b/t/t7503-template-=20
hook--pre-commit.sh
new file mode 100755
index 0000000..c78a507
--- /dev/null
+++ b/t/t7503-template-hook--pre-commit.sh
@@ -0,0 +1,75 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Christian H=F6ltje
+#
+
+test_description=3D't7503 templates-hooks--pre-commit
+
+This test verifies that the pre-commit hook shipped with
+git by default works correctly.
+'
+
+. ./test-lib.sh
+
+test_expect_success 'verify that autocrlf is unset' '
+   if git config core.autocrlf
+   then
+     false
+   else
+     test $? -eq 1
+   fi
+'
+
+test_expect_success 'lf without hook' '
+
+	printf "foo" > lf.txt &&
+	git add lf.txt &&
+	git commit -m "lf without hook" lf.txt
+
+'
+
+test_expect_success 'crlf without hook' '
+
+	printf "foo\r" > crlf.txt &&
+	git add crlf.txt &&
+	git commit -m "crlf without hook" crlf.txt
+
+'
+
+# Set up the pre-commit hook.
+HOOKDIR=3D"$(git rev-parse --git-dir)/hooks"
+mkdir -p "${HOOKDIR}"
+cp -r "${HOOKDIR}-disabled/pre-commit" "${HOOKDIR}/pre-commit"
+chmod +x "${HOOKDIR}/pre-commit"
+
+test_expect_success 'lf with hook' '
+
+	printf "bar" >> lf.txt &&
+	git add lf.txt &&
+	git commit -m "lf with hook" lf.txt
+
+'
+test_expect_success 'crlf with hook' '
+
+	printf "bar\r" >> crlf.txt &&
+	git add crlf.txt &&
+	git commit -m "crlf with hook" crlf.txt
+
+'
+
+test_expect_success 'lf with hook white-space failure' '
+
+	printf "bar " >> lf.txt &&
+	git add lf.txt &&
+	! git commit -m "lf with hook" lf.txt
+
+'
+test_expect_success 'crlf with hook white-space failure' '
+
+	printf "bar \r" >> crlf.txt &&
+	git add crlf.txt &&
+	! git commit -m "crlf with hook" crlf.txt
+
+'
+
+test_done
diff --git a/templates/hooks--pre-commit b/templates/hooks--pre-commit
index b25dce6..335ca09 100644
--- a/templates/hooks--pre-commit
+++ b/templates/hooks--pre-commit
@@ -55,8 +55,14 @@ perl -e '
  	if (s/^\+//) {
  	    $lineno++;
  	    chomp;
-	    if (/\s$/) {
-		bad_line("trailing whitespace", $_);
+	    if (/\r$/) {
+		if (/\s\r$/) {
+		    bad_line("trailing whitespace", $_);
+		}
+	    } else {
+		if (/\s$/) {
+		    bad_line("trailing whitespace", $_);
+		}
  	    }
  	    if (/^\s* \t/) {
  		bad_line("indent SP followed by a TAB", $_);
--=20
1.5.5.4
