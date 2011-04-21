From: Josh Stone <jistone@redhat.com>
Subject: [PATCH] blame: Improve parsing for emails with spaces
Date: Thu, 21 Apr 2011 15:07:36 -0700
Message-ID: <1303423656-32002-1-git-send-email-jistone@redhat.com>
Cc: Josh Stone <jistone@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 00:10:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QD25M-00070f-GW
	for gcvg-git-2@lo.gmane.org; Fri, 22 Apr 2011 00:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755521Ab1DUWKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2011 18:10:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51804 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755307Ab1DUWKo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2011 18:10:44 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p3LMAhAS019336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Thu, 21 Apr 2011 18:10:44 -0400
Received: from jistone-t61.redhat.com (ovpn-113-81.phx2.redhat.com [10.3.113.81])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p3LMAh3x023031;
	Thu, 21 Apr 2011 18:10:43 -0400
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171923>

One of my git repositories has some old commits where the authors
obfuscated their email address as <author at example dot com>.  To
handle this, blame needs to look for the leading '<' when scanning
to split the "name <email>", rather then only a space delimiter.

Signed-off-by: Josh Stone <jistone@redhat.com>
---
 builtin/blame.c     |    2 +-
 t/annotate-tests.sh |   12 +++++++++++-
 t/t8002-blame.sh    |    2 +-
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index f6b03f7..41525f1 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1377,7 +1377,7 @@ static void get_ac_line(const char *inbuf, const char *what,
 	timepos = tmp;
 
 	*tmp = 0;
-	while (person < tmp && *tmp != ' ')
+	while (person < tmp && !(*tmp == ' ' && tmp[1] == '<'))
 		tmp--;
 	if (tmp <= person)
 		return;
diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index d34208c..abb1885 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -1,5 +1,5 @@
 # This file isn't used as a test script directly, instead it is
-# sourced from t8001-annotate.sh and t8001-blame.sh.
+# sourced from t8001-annotate.sh and t8002-blame.sh.
 
 check_count () {
 	head=
@@ -124,3 +124,13 @@ test_expect_success \
 test_expect_success \
     'some edit' \
     'check_count A 1 B 1 B1 1 B2 1 "A U Thor" 1 C 1 D 1'
+
+test_expect_success \
+    'an obfuscated email added' \
+    'sed -e "1i No robots allowed" < file > file.new &&
+     mv file.new file &&
+     GIT_AUTHOR_NAME="E" GIT_AUTHOR_EMAIL="E at test dot git" git commit -a -m "norobots"'
+
+test_expect_success \
+    'obfuscated email parsed' \
+    'check_count A 1 B 1 B1 1 B2 1 "A U Thor" 1 C 1 D 1 E 1'
diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
index d3a51e1..e2896cf 100755
--- a/t/t8002-blame.sh
+++ b/t/t8002-blame.sh
@@ -8,7 +8,7 @@ PROG='git blame -c'
 
 PROG='git blame -c -e'
 test_expect_success 'Blame --show-email works' '
-    check_count "<A@test.git>" 1 "<B@test.git>" 1 "<B1@test.git>" 1 "<B2@test.git>" 1 "<author@example.com>" 1 "<C@test.git>" 1 "<D@test.git>" 1
+    check_count "<A@test.git>" 1 "<B@test.git>" 1 "<B1@test.git>" 1 "<B2@test.git>" 1 "<author@example.com>" 1 "<C@test.git>" 1 "<D@test.git>" 1 "<E at test dot git>" 1
 '
 
 test_done
-- 
1.7.4.4
