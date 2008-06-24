From: Christian Holtje <docwhat@gmail.com>
Subject: [PATCH] pre-commit hook should ignore carriage returns at EOL
Date: Tue, 24 Jun 2008 12:23:38 -0400
Message-ID: <53A5AFCF-94C7-465E-A181-1DA69F251F5B@gmail.com>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=UTF-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 18:25:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBBKm-0007dU-Lf
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 18:25:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755174AbYFXQYP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Jun 2008 12:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754733AbYFXQYO
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 12:24:14 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:21203 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699AbYFXQYM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jun 2008 12:24:12 -0400
Received: by an-out-0708.google.com with SMTP id d40so717939and.103
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 09:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date:cc
         :x-mailer;
        bh=i00TBPKY2jYNA4ej7LCqjbS+ploSBLupum1JuLz74KM=;
        b=i3NrSF7wP+aJ8wlpKTYLYh1iTAWJAzQFBTJfqgt1yt3hVblqNdoQXCrZVd06M/b3iY
         zdK0mixPZjSvz+VAEysyuEdY6f9v+8kMGUF97LRuHw5sXka5KUZNfeGEDM8uVBDDbEA5
         Au+AF47xZBMz7WEVMFQIuZZNDnLxX4BeQLROI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:cc:x-mailer;
        b=IOjbhHPUSz3/E1eRo+ksIQaXaVa3UrDdcOoJ699r1TWZYnS93EUwKyKyc9CiiHrkxx
         /JxIoO8Z7C3mi8//G6p+R4fbifFp6e6dG4SSXqZOFmIK0Ezo+vYwSxREpDDFkJvzkRm8
         1aKjBefnu1FnJGKShaL9V5+3vWapPPj8AnrII=
Received: by 10.100.119.17 with SMTP id r17mr16208374anc.7.1214324650201;
        Tue, 24 Jun 2008 09:24:10 -0700 (PDT)
Received: from ?192.168.0.161? ( [206.210.75.84])
        by mx.google.com with ESMTPS id x56sm4965036pyg.10.2008.06.24.09.23.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Jun 2008 09:24:03 -0700 (PDT)
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86080>

When commit files that use DOS style CRLF end-of-lines, the pre-commit
hook would raise an error.  When combined with the fact that the hooks
get activated by default on windows, it makes life difficult for
people working with DOS files.

This patch causes the pre-commit hook to deal with crlf files
correctly.

Signed-off-by: Christian H=E2=88=9A=E2=88=82ltje <docwhat@gmail.com>
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
index 0000000..8f0c3c9
--- /dev/null
+++ b/t/t7503-template-hook--pre-commit.sh
@@ -0,0 +1,75 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Christian H=E2=88=9A=E2=88=82ltje
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
+	echo "foo" > lf.txt &&
+	git add lf.txt &&
+	git commit -m "lf without hook" lf.txt
+
+'
+
+test_expect_success 'crlf without hook' '
+
+	echo "foo\r" > crlf.txt &&
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
+	echo "bar" >> lf.txt &&
+	git add lf.txt &&
+	git commit -m "lf with hook" lf.txt
+
+'
+test_expect_success 'crlf with hook' '
+
+	echo "bar\r" >> crlf.txt &&
+	git add crlf.txt &&
+	git commit -m "crlf with hook" crlf.txt
+
+'
+
+test_expect_success 'lf with hook white-space failure' '
+
+	echo "bar " >> lf.txt &&
+	git add lf.txt &&
+	! git commit -m "lf with hook" lf.txt
+
+'
+test_expect_success 'crlf with hook white-space failure' '
+
+	echo "bar \r" >> crlf.txt &&
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
