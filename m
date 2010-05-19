From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [PATCH v5 1/4] Add tests for per-repository eol normalization
Date: Wed, 19 May 2010 22:43:09 +0200
Message-ID: <5d98ce018581830f7ae14a3abfe96800487b803e.1274301351.git.eyvind.bernhardsen@gmail.com>
References: <cover.1274301351.git.eyvind.bernhardsen@gmail.com>
Cc: msysGit <msysgit@googlegroups.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 19 22:43:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEq7E-0005M7-HO
	for gcvg-git-2@lo.gmane.org; Wed, 19 May 2010 22:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754220Ab0ESUnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 May 2010 16:43:21 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:54748 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000Ab0ESUnT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 May 2010 16:43:19 -0400
Received: by ey-out-2122.google.com with SMTP id d26so38627eyd.19
        for <git@vger.kernel.org>; Wed, 19 May 2010 13:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=DAqavM59JEW+YO4knWHSmM40zHSg5YFFBXJAnS574y0=;
        b=Bb8jSCSyjfJY58b6WsK+o80qxk6wUU9Q3N3+WemZs4O1H5zvdeDtRB/Qanj1kh5Cfz
         +H5D2FMncBE0DPngoUQCUw7AqTwFRmr2myHVIWdWqfguG+YCLFA2l1tJ67jO3otjga4T
         0mEmtOENEoRhfwbFuibW1hbTFuMFir6W8/bYA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=F3DWVmZewqRpZjk9KIrIJqzn9iQSW5wF0YjhjtIWxNWRraD967740E0CZf/pFLvFxr
         A6Gznnhovm8qtfq0CGa3Ui0252u1pshR3J2SlNIr7XoqSn8sQsnwKqNWH+H4GDR4CGdQ
         84xgnF84Uabey2UkxFED90RBMAXHhHcOp2vds=
Received: by 10.213.52.6 with SMTP id f6mr3574053ebg.51.1274301797899;
        Wed, 19 May 2010 13:43:17 -0700 (PDT)
Received: from localhost.localdomain (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 13sm3814591ewy.9.2010.05.19.13.43.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 May 2010 13:43:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.5.gc3ee8
In-Reply-To: <cover.1274301351.git.eyvind.bernhardsen@gmail.com>
In-Reply-To: <cover.1274301351.git.eyvind.bernhardsen@gmail.com>
References: <cover.1274301351.git.eyvind.bernhardsen@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147343>

Signed-off-by: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
---
 t/t0025-crlf-auto.sh |  142 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 142 insertions(+), 0 deletions(-)
 create mode 100755 t/t0025-crlf-auto.sh

diff --git a/t/t0025-crlf-auto.sh b/t/t0025-crlf-auto.sh
new file mode 100755
index 0000000..2c98338
--- /dev/null
+++ b/t/t0025-crlf-auto.sh
@@ -0,0 +1,142 @@
+#!/bin/sh
+
+test_description='CRLF conversion'
+
+. ./test-lib.sh
+
+has_cr() {
+	tr '\015' Q <"$1" | grep Q >/dev/null
+}
+
+test_expect_success setup '
+
+	git config core.autocrlf false &&
+
+	for w in Hello world how are you; do echo $w; done >one &&
+	for w in I am very very fine thank you; do echo ${w}Q; done | q_to_cr >two &&
+	for w in Oh here is a QNUL byte how alarming; do echo ${w}; done | q_to_nul >three &&
+	git add . &&
+
+	git commit -m initial &&
+
+	one=`git rev-parse HEAD:one` &&
+	two=`git rev-parse HEAD:two` &&
+	three=`git rev-parse HEAD:three` &&
+
+	echo happy.
+'
+
+test_expect_success 'default settings cause no changes' '
+
+	rm -f .gitattributes tmp one two three &&
+	git read-tree --reset -u HEAD &&
+
+	! has_cr one &&
+	has_cr two &&
+	onediff=`git diff one` &&
+	twodiff=`git diff two` &&
+	threediff=`git diff three` &&
+	test -z "$onediff" -a -z "$twodiff" -a -z "$threediff"
+'
+
+test_expect_failure 'crlf=true causes a CRLF file to be normalized' '
+
+	rm -f .gitattributes tmp one two three &&
+	echo "two crlf" > .gitattributes &&
+	git read-tree --reset -u HEAD &&
+
+	# Note, "normalized" means that git will normalize it if added
+	has_cr two &&
+	twodiff=`git diff two` &&
+	test -n "$twodiff"
+'
+
+test_expect_failure 'eol=crlf gives a normalized file CRLFs with autocrlf=false' '
+
+	rm -f .gitattributes tmp one two three &&
+	git config core.autocrlf false &&
+	echo "one eol=crlf" > .gitattributes &&
+	git read-tree --reset -u HEAD &&
+
+	has_cr one &&
+	onediff=`git diff one` &&
+	test -z "$onediff"
+'
+
+test_expect_failure 'eol=crlf gives a normalized file CRLFs with autocrlf=input' '
+
+	rm -f .gitattributes tmp one two three &&
+	git config core.autocrlf input &&
+	echo "one eol=crlf" > .gitattributes &&
+	git read-tree --reset -u HEAD &&
+
+	has_cr one &&
+	onediff=`git diff one` &&
+	test -z "$onediff"
+'
+
+test_expect_failure 'eol=lf gives a normalized file LFs with autocrlf=true' '
+
+	rm -f .gitattributes tmp one two three &&
+	git config core.autocrlf true &&
+	echo "one eol=lf" > .gitattributes &&
+	git read-tree --reset -u HEAD &&
+
+	! has_cr one &&
+	onediff=`git diff one` &&
+	test -z "$onediff"
+'
+
+test_expect_success 'autocrlf=true does not normalize CRLF files' '
+
+	rm -f .gitattributes tmp one two three &&
+	git config core.autocrlf true &&
+	git read-tree --reset -u HEAD &&
+
+	has_cr one &&
+	has_cr two &&
+	onediff=`git diff one` &&
+	twodiff=`git diff two` &&
+	threediff=`git diff three` &&
+	test -z "$onediff" -a -z "$twodiff" -a -z "$threediff"
+'
+
+test_expect_failure 'crlf=auto, autocrlf=true _does_ normalize CRLF files' '
+
+	rm -f .gitattributes tmp one two three &&
+	git config core.autocrlf true &&
+	echo "* crlf=auto" > .gitattributes &&
+	git read-tree --reset -u HEAD &&
+
+	has_cr one &&
+	has_cr two &&
+	onediff=`git diff one` &&
+	twodiff=`git diff two` &&
+	threediff=`git diff three` &&
+	test -z "$onediff" -a -n "$twodiff" -a -z "$threediff"
+'
+
+test_expect_success 'crlf=auto, autocrlf=true does not normalize binary files' '
+
+	rm -f .gitattributes tmp one two three &&
+	git config core.autocrlf true &&
+	echo "* crlf=auto" > .gitattributes &&
+	git read-tree --reset -u HEAD &&
+
+	! has_cr three &&
+	threediff=`git diff three` &&
+	test -z "$threediff"
+'
+
+test_expect_failure 'eol=crlf _does_ normalize binary files' '
+
+	rm -f .gitattributes tmp one two three &&
+	echo "three eol=crlf" > .gitattributes &&
+	git read-tree --reset -u HEAD &&
+
+	has_cr three &&
+	threediff=`git diff three` &&
+	test -z "$threediff"
+'
+
+test_done
-- 
1.7.1.5.gc3ee8
