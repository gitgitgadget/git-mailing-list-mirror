From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [PATCH v4 2/4] Add tests for per-repository eol normalization
Date: Thu, 13 May 2010 23:44:40 +0200
Message-ID: <c8aeeee8015650054265775aec5e67fd34b5bf21.1273786317.git.eyvind.bernhardsen@gmail.com>
References: <cover.1273786317.git.eyvind.bernhardsen@gmail.com>
Cc: msysGit <msysgit@googlegroups.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Finn Arne Gangstad <finnag@pvv.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 13 23:45:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCgDh-0005aQ-KM
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 23:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157Ab0EMVpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 17:45:08 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:52293 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758879Ab0EMVou (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 17:44:50 -0400
Received: by ewy8 with SMTP id 8so702719ewy.28
        for <git@vger.kernel.org>; Thu, 13 May 2010 14:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Y6liLaGWmsN7XLomgyxz21EpyBrICjlW8FJfO7iUMYQ=;
        b=pE1xejMB5skdaBKJ2u7VPht7lVoMaaY/oVz+up3NIWY1mEg0KeY5yrfF3M9om4wplR
         vuvE+GC2Pe1fbOM3FkXM2j3KN6bTp7MBS/lAahnv9nQJDW/68cyr5kDKABQcrnkju2Mc
         YRcG9Xg9UdjtKepmJiwhAj5evQdMCPi8qJd2s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=e+c6uXBtmaFY6ucvp/Dd9b1Nxx8YxqdVAhVL2I3hjJzEMUDcsc0IP2p5nLJnHxpLAM
         2lZdfmnydigZXDGY/7iqdVP3+5MMwZPnOmojs4foi4ggdbs/56OL1IzCPrDjzlXIgW4C
         jUVu7P9Z27WgBGVpb/lJ7keFa/BN3+eLdHcmA=
Received: by 10.213.72.138 with SMTP id m10mr1728960ebj.91.1273787089387;
        Thu, 13 May 2010 14:44:49 -0700 (PDT)
Received: from localhost.localdomain (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 15sm906408ewy.4.2010.05.13.14.44.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 May 2010 14:44:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.5.gd739a
In-Reply-To: <cover.1273786317.git.eyvind.bernhardsen@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147033>

Signed-off-by: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
---
 t/t0025-crlf-auto.sh |  143 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 143 insertions(+), 0 deletions(-)
 create mode 100755 t/t0025-crlf-auto.sh

diff --git a/t/t0025-crlf-auto.sh b/t/t0025-crlf-auto.sh
new file mode 100755
index 0000000..360117c
--- /dev/null
+++ b/t/t0025-crlf-auto.sh
@@ -0,0 +1,143 @@
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
+
+	for w in Some extra lines here; do echo $w; done >>one &&
+	git diff >patch.file &&
+	patched=`git hash-object --stdin <one` &&
+	git read-tree --reset -u HEAD &&
+
+	echo happy.
+'
+
+test_expect_success 'default settings cause no changes' '
+
+	rm -f .gitattributes tmp one two &&
+	git read-tree --reset -u HEAD &&
+
+	! has_cr one &&
+	has_cr two &&
+	onediff=`git diff one` &&
+	twodiff=`git diff two` &&
+	test -z "$onediff" -a -z "$twodiff"
+'
+
+test_expect_failure 'crlf=true causes a CRLF file to be normalized' '
+
+	rm -f .gitattributes tmp one two &&
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
+	rm -f .gitattributes tmp one two &&
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
+	rm -f .gitattributes tmp one two &&
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
+	rm -f .gitattributes tmp one two &&
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
+	rm -f .gitattributes tmp one two &&
+	git config core.autocrlf true &&
+	git read-tree --reset -u HEAD &&
+
+	has_cr one &&
+	has_cr two &&
+	onediff=`git diff one` &&
+	twodiff=`git diff two` &&
+	test -z "$onediff" -a -z "$twodiff"
+'
+
+test_expect_failure 'crlf=auto, autocrlf=true _does_ normalize CRLF files' '
+
+	rm -f .gitattributes tmp one two &&
+	git config core.autocrlf true &&
+	echo "* crlf=auto" > .gitattributes &&
+	git read-tree --reset -u HEAD &&
+
+	has_cr one &&
+	has_cr two &&
+	onediff=`git diff one` &&
+	twodiff=`git diff two` &&
+	test -z "$onediff" -a -n "$twodiff"
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
1.7.1.5.gd739a
