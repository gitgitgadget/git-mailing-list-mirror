From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 06/12] commit: add tests of commit races
Date: Thu, 12 Feb 2015 12:12:17 +0100
Message-ID: <1423739543-1025-7-git-send-email-mhagger@alum.mit.edu>
References: <1423739543-1025-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 12:13:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLrhg-0004Bo-Of
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 12:13:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755630AbbBLLMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 06:12:52 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:48319 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755613AbbBLLMs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Feb 2015 06:12:48 -0500
X-AuditID: 12074411-f79fa6d000006b8a-d4-54dc8aa8d0a4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 0F.CC.27530.8AA8CD45; Thu, 12 Feb 2015 06:12:40 -0500 (EST)
Received: from michael.fritz.box (p4FC96396.dip0.t-ipconnect.de [79.201.99.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1CBCT7Z003107
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 12 Feb 2015 06:12:39 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1423739543-1025-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsUixO6iqLui606IwYm5+hZdV7qZLBp6rzBb
	vL25hNHi9or5zBbdU94yWvT2fWK12Ly5ncWB3ePv+w9MHjtn3WX3WLCp1OPiJWWPz5vkAlij
	uG2SEkvKgjPT8/TtErgz7j6fyV6wmr9i+qQulgbG7TxdjJwcEgImEt2di9khbDGJC/fWs3Ux
	cnEICVxmlDj0ZBdYQkjgBJPErqUcIDabgK7Eop5mJhBbREBNYmLbIRYQm1lgNZPE1rtsILaw
	gLVEy7XVYDUsAqoSjTd/AsU5OHgFnCU6H8ZC7JKTOH/8JzOIzSngIvHuUgMjxCpniV1tW1gn
	MPIuYGRYxSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrqpebWaKXmlK6iRESYoI7GGeclDvEKMDB
	qMTDG2B8J0SINbGsuDL3EKMkB5OSKC9XK1CILyk/pTIjsTgjvqg0J7X4EKMEB7OSCK9vE1CO
	NyWxsiq1KB8mJc3BoiTOy7dE3U9IID2xJDU7NbUgtQgmK8PBoSTBu64TqFGwKDU9tSItM6cE
	Ic3EwQkynEtKpDg1LyW1KLG0JCMeFBfxxcDIAEnxAO0VA2nnLS5IzAWKQrSeYlSUEuddCJIQ
	AElklObBjYUljleM4kBfCvPeAaniASYduO5XQIOZgAZPnHEbZHBJIkJKqoFxifE81zeNXGFL
	7h2Zm+ndu0n+b2NcpfZMMzfxgks3E4XPP130datz8aLKwxPZ1DvarkxVu+Xz/AzrNfc99y7W
	teQ8zpCZbjXTJ7K37Ny9pTsZAtS4vj9tOXbE2X7nOsdtRhsfrv4a+aX/qsG/WpPr 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263722>

Committing involves the following steps:

1. Determine the current value of HEAD (if any).
2. Create the new commit object.
3. Update HEAD.

Please note that step 2 can take arbitrarily long, because it might
involve the user editing a commit message.

If a second process sneaks in a commit during step 2, then the first
commit process should fail. This is usually done correctly, because
step 3 verifies that HEAD still points at the same commit that it
pointed to during step 1.

However, if there is a race when creating an *orphan* commit, then the
test in step 3 is skipped.

Add tests for proper handling of such races. One of the new tests
fails. It will be fixed in a moment.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t7516-commit-races.sh | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100755 t/t7516-commit-races.sh

diff --git a/t/t7516-commit-races.sh b/t/t7516-commit-races.sh
new file mode 100755
index 0000000..08e6a6c
--- /dev/null
+++ b/t/t7516-commit-races.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+
+test_description='git commit races'
+. ./test-lib.sh
+
+test_tick
+
+test_expect_success 'set up editor' '
+	write_script editor <<-\EOF
+	git commit --allow-empty -m hare
+	echo tortoise >"$1"
+	EOF
+'
+
+test_expect_failure 'race to create orphan commit' '
+	test_must_fail env EDITOR=./editor git commit --allow-empty &&
+	git show -s --pretty=format:%s >subject &&
+	grep -q hare subject &&
+	test -z "$(git show -s --pretty=format:%P)"
+'
+
+test_expect_success 'race to create non-orphan commit' '
+	git checkout --orphan branch &&
+	git commit --allow-empty -m base &&
+	git rev-parse HEAD >base &&
+	test_must_fail env EDITOR=./editor git commit --allow-empty &&
+	git show -s --pretty=format:%s >subject &&
+	grep -q hare subject &&
+	git rev-parse HEAD^ >parent &&
+	test_cmp base parent
+'
+
+test_done
-- 
2.1.4
