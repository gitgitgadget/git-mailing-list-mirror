From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Add a test script for for-each-ref, including test of date formatting Signed-off-by: Andy Parkins <andyparkins@gmail.com>
Date: Tue, 2 Oct 2007 12:02:57 +0100
Message-ID: <200710021202.57134.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 02 13:03:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcfX0-0002re-49
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 13:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557AbXJBLDF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 07:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752205AbXJBLDD
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 07:03:03 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:62610 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752422AbXJBLDB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 07:03:01 -0400
Received: by nf-out-0910.google.com with SMTP id g13so3203240nfb
        for <git@vger.kernel.org>; Tue, 02 Oct 2007 04:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        bh=JQ12meV9Bd6aDfrAR34zYII+ziEAxbJqvTElyFUjbws=;
        b=HAFzzZjJX0zZn38haWw1E5D/6sM4VyxlFqyvCfF6s/Koe/GpfE9ayVwIp/K3ZivLiK41bKSoxk5ae97Z1vu6RUyU9h4dqxM5ofEZe8vv5Ufb21XU/VG7xO06jxywavxxSCbEOJyBNzgybZZyU3qL5SItp80ovm3ScUAffJ70muY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=HJMneBzir51uQ8zRH5SQivRl4D1x36j1uaISe+pNNI75EtjlZIj4i8ODwnyjnbnfJoEBoGM/bJxySyopAu0UeOSISZMebAO9bYxL9IxCTWLK/xt682LI/ar4pLWQG4K8gkjtkAe6euKiQty0L0olM7qTjZWtuZEXiAiHXhzVT4g=
Received: by 10.78.123.4 with SMTP id v4mr447625huc.1191322978990;
        Tue, 02 Oct 2007 04:02:58 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id 32sm1633902nfu.2007.10.02.04.02.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 02 Oct 2007 04:02:58 -0700 (PDT)
X-TUID: 88296ed6f68c74b0
X-UID: 345
X-Length: 7560
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59683>

---
 t/t6300-for-each-ref.sh |  164 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 164 insertions(+), 0 deletions(-)
 create mode 100644 t/t6300-for-each-ref.sh

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
new file mode 100644
index 0000000..b07f157
--- /dev/null
+++ b/t/t6300-for-each-ref.sh
@@ -0,0 +1,164 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Andy Parkins
+#
+
+test_description='for-each-ref test'
+
+. ./test-lib.sh
+
+# Mon Jul 3 15:18:43 2006 +0000
+datestamp=1151939923
+setdate_and_increment () {
+    GIT_COMMITTER_DATE="$datestamp +0200"
+    datestamp=$(expr "$datestamp" + 1)
+    GIT_AUTHOR_DATE="$datestamp +0200"
+    datestamp=$(expr "$datestamp" + 1)
+    export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
+}
+
+test_expect_success 'Create sample commit with known timestamp' '
+	setdate_and_increment &&
+	echo "Using $datestamp" > one &&
+	git add one &&
+	git commit -m "Initial" &&
+	setdate_and_increment &&
+	git tag -a -m "Tagging at $datestamp" testtag
+'
+
+test_expect_success 'Check atom names are valid' '
+	git for-each-ref --format="refname=%(refname)" refs/heads &&
+	git for-each-ref --format="objecttype=%(objecttype)" refs/heads &&
+	git for-each-ref --format="objectsize=%(objectsize)" refs/heads &&
+	git for-each-ref --format="objectname=%(objectname)" refs/heads &&
+	git for-each-ref --format="tree=%(tree)" refs/heads &&
+	git for-each-ref --format="parent=%(parent)" refs/heads &&
+	git for-each-ref --format="numparent=%(numparent)" refs/heads &&
+	git for-each-ref --format="object=%(object)" refs/heads &&
+	git for-each-ref --format="type=%(type)" refs/heads &&
+	git for-each-ref --format="author=%(author)" refs/heads &&
+	git for-each-ref --format="authorname=%(authorname)" refs/heads &&
+	git for-each-ref --format="authoremail=%(authoremail)" refs/heads &&
+	git for-each-ref --format="authordate=%(authordate)" refs/heads &&
+	git for-each-ref --format="committer=%(committer)" refs/heads &&
+	git for-each-ref --format="committername=%(committername)" refs/heads &&
+	git for-each-ref --format="committeremail=%(committeremail)" refs/heads &&
+	git for-each-ref --format="committerdate=%(committerdate)" refs/heads &&
+	git for-each-ref --format="tag=%(tag)" refs/tags &&
+	git for-each-ref --format="tagger=%(tagger)" refs/tags &&
+	git for-each-ref --format="taggername=%(taggername)" refs/tags &&
+	git for-each-ref --format="taggeremail=%(taggeremail)" refs/tags &&
+	git for-each-ref --format="taggerdate=%(taggerdate)" refs/tags &&
+	git for-each-ref --format="creator=%(creator)" refs/tags &&
+	git for-each-ref --format="creatordate=%(creatordate)" refs/tags &&
+	git for-each-ref --format="subject=%(subject)" refs/heads &&
+	git for-each-ref --format="body=%(body)" refs/heads &&
+	git for-each-ref --format="contents=%(contents)" refs/heads
+'
+
+test_expect_failure 'Check invalid atoms names are errors' '
+	git-for-each-ref --format="%(INVALID)" refs/heads
+'
+
+test_expect_success 'Check format specifiers are ignored in naming date atoms' '
+	git-for-each-ref --format="%(authordate)" refs/heads &&
+	git-for-each-ref --format="%(authordate:default) %(authordate)" refs/heads &&
+	git-for-each-ref --format="%(authordate) %(authordate:default)" refs/heads &&
+	git-for-each-ref --format="%(authordate:default) %(authordate:default)" refs/heads
+'
+
+test_expect_success 'Check valid format specifiers for date fields' '
+	git-for-each-ref --format="%(authordate:default)" refs/heads &&
+	git-for-each-ref --format="%(authordate:relative)" refs/heads &&
+	git-for-each-ref --format="%(authordate:short)" refs/heads &&
+	git-for-each-ref --format="%(authordate:local)" refs/heads &&
+	git-for-each-ref --format="%(authordate:iso8601)" refs/heads &&
+	git-for-each-ref --format="%(authordate:rfc2822)" refs/heads
+'
+
+test_expect_failure 'Check invalid format specifiers are errors' '
+	git-for-each-ref --format="%(authordate:INVALID)" refs/heads
+'
+
+cat >expected <<\EOF
+'refs/heads/master' 'Mon Jul 3 17:18:43 2006 +0200' 'Mon Jul 3 17:18:44 2006 +0200'
+'refs/tags/testtag' 'Mon Jul 3 17:18:45 2006 +0200'
+EOF
+
+test_expect_success 'Check unformatted date fields output' '
+	(git for-each-ref --shell --format="%(refname) %(committerdate) %(authordate)" refs/heads &&
+	git for-each-ref --shell --format="%(refname) %(taggerdate)" refs/tags) >actual &&
+	git diff expected actual
+'
+
+test_expect_success 'Check format "default" formatted date fields output' '
+	f=default &&
+	(git for-each-ref --shell --format="%(refname) %(committerdate:$f) %(authordate:$f)" refs/heads &&
+	git for-each-ref --shell --format="%(refname) %(taggerdate:$f)" refs/tags) >actual &&
+	git diff expected actual
+'
+
+# Don't know how to do relative check because I can't know when this script
+# is going to be run and can't fake the current time to git, and hence can't
+# provide expected output.  Instead, I'll just make sure that "relative"
+# doesn't exit in error
+#
+#cat >expected <<\EOF
+#
+#EOF
+#
+test_expect_success 'Check format "relative" date fields output' '
+	f=relative &&
+	(git for-each-ref --shell --format="%(refname) %(committerdate:$f) %(authordate:$f)" refs/heads &&
+	git for-each-ref --shell --format="%(refname) %(taggerdate:$f)" refs/tags) >actual
+'
+
+cat >expected <<\EOF
+'refs/heads/master' '2006-07-03' '2006-07-03'
+'refs/tags/testtag' '2006-07-03'
+EOF
+
+test_expect_success 'Check format "short" date fields output' '
+	f=short &&
+	(git for-each-ref --shell --format="%(refname) %(committerdate:$f) %(authordate:$f)" refs/heads &&
+	git for-each-ref --shell --format="%(refname) %(taggerdate:$f)" refs/tags) >actual &&
+	git diff expected actual
+'
+
+cat >expected <<\EOF
+'refs/heads/master' 'Mon Jul 3 15:18:43 2006' 'Mon Jul 3 15:18:44 2006'
+'refs/tags/testtag' 'Mon Jul 3 15:18:45 2006'
+EOF
+
+test_expect_success 'Check format "local" date fields output' '
+	f=local &&
+	(git for-each-ref --shell --format="%(refname) %(committerdate:$f) %(authordate:$f)" refs/heads &&
+	git for-each-ref --shell --format="%(refname) %(taggerdate:$f)" refs/tags) >actual &&
+	git diff expected actual
+'
+
+cat >expected <<\EOF
+'refs/heads/master' '2006-07-03 17:18:43 +0200' '2006-07-03 17:18:44 +0200'
+'refs/tags/testtag' '2006-07-03 17:18:45 +0200'
+EOF
+
+test_expect_success 'Check format "iso8601" date fields output' '
+	f=iso8601 &&
+	(git for-each-ref --shell --format="%(refname) %(committerdate:$f) %(authordate:$f)" refs/heads &&
+	git for-each-ref --shell --format="%(refname) %(taggerdate:$f)" refs/tags) >actual &&
+	git diff expected actual
+'
+
+cat >expected <<\EOF
+'refs/heads/master' 'Mon, 3 Jul 2006 17:18:43 +0200' 'Mon, 3 Jul 2006 17:18:44 +0200'
+'refs/tags/testtag' 'Mon, 3 Jul 2006 17:18:45 +0200'
+EOF
+
+test_expect_success 'Check format "rfc2822" date fields output' '
+	f=rfc2822 &&
+	(git for-each-ref --shell --format="%(refname) %(committerdate:$f) %(authordate:$f)" refs/heads &&
+	git for-each-ref --shell --format="%(refname) %(taggerdate:$f)" refs/tags) >actual &&
+	git diff expected actual
+'
+
+test_done
-- 
1.5.3.2.105.gf47f2-dirty
