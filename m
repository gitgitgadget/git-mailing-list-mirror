From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [PATCH v3 2/5] Add tests for per-repository eol normalization
Date: Thu, 13 May 2010 01:00:52 +0200
Message-ID: <430831ddc7262b7b9675c18fee8c6ecc9d43831d.1273700831.git.eyvind.bernhardsen@gmail.com>
References: <cover.1273700831.git.eyvind.bernhardsen@gmail.com>
Cc: msysGit <msysgit@googlegroups.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 13 01:02:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCKwI-0004sz-LX
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 01:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758466Ab0ELXBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 May 2010 19:01:33 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:45995 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754564Ab0ELXBE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 May 2010 19:01:04 -0400
Received: by ewy8 with SMTP id 8so355536ewy.28
        for <git@vger.kernel.org>; Wed, 12 May 2010 16:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=rG+s7Bo6N7cUXC0n1k0neB90VgSz1u0SFYk46z/TIww=;
        b=pZ7psJxa+ZrYOBpVJqIkyLxk0KYHar3IuxKT7jhOR3IX81f/VPo104NtNrjbC9/JJX
         AvWKsVq2SfpLD8UufCCvgn19TmkIBRCOzZ4kQUT0IUisIaLBtB2NkmeVAM+Iatr9O2LR
         ZzdhsZkwsqdrTB21HR6FjgpTGC8Mucu81shI4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Y53uCadHBOXWWbopc5smewotDfFJKT6E0aFFytp1kuj+WQXpAc8NggcVKgR43QryOK
         JMzNPzN2FXQfoPNw33IDyOs0b2EJGOdc9cGcArBq0HXufPKLXv/16djcYZhHFgVOIMHg
         wVZ8vIyzyCmiqS15KEQ6GZco9RcrLnLqw24mY=
Received: by 10.213.3.152 with SMTP id 24mr935131ebn.1.1273705262899;
        Wed, 12 May 2010 16:01:02 -0700 (PDT)
Received: from localhost.localdomain (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 15sm365675ewy.4.2010.05.12.16.01.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 12 May 2010 16:01:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.5.gd739a
In-Reply-To: <cover.1273700831.git.eyvind.bernhardsen@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146966>

Signed-off-by: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
---
 t/t0025-crlf-auto.sh |  121 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 121 insertions(+), 0 deletions(-)
 create mode 100755 t/t0025-crlf-auto.sh

diff --git a/t/t0025-crlf-auto.sh b/t/t0025-crlf-auto.sh
new file mode 100755
index 0000000..40048a7
--- /dev/null
+++ b/t/t0025-crlf-auto.sh
@@ -0,0 +1,121 @@
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
+test_expect_failure 'crlf=crlf gives a normalized file CRLFs with autocrlf=false' '
+
+	rm -f .gitattributes tmp one two &&
+	git config core.autocrlf false &&
+	echo "one crlf=crlf" > .gitattributes &&
+	git read-tree --reset -u HEAD &&
+
+	has_cr one &&
+	onediff=`git diff one` &&
+	test -z "$onediff"
+'
+
+test_expect_failure 'crlf=crlf gives a normalized file CRLFs with autocrlf=input' '
+
+	rm -f .gitattributes tmp one two &&
+	git config core.autocrlf input &&
+	echo "one crlf=crlf" > .gitattributes &&
+	git read-tree --reset -u HEAD &&
+
+	has_cr one &&
+	onediff=`git diff one` &&
+	test -z "$onediff"
+'
+
+test_expect_failure 'crlf=lf gives a normalized file LFs with autocrlf=true' '
+
+	rm -f .gitattributes tmp one two &&
+	git config core.autocrlf true &&
+	echo "one crlf=lf" > .gitattributes &&
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
+# look through the logic changes and find the corner cases
+
+test_done
-- 
1.7.1.3.g448cb.dirty
