From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [PATCH/RFC v2 2/4] Add tests for per-repository eol normalization
Date: Sat,  8 May 2010 23:46:19 +0200
Message-ID: <8372bad8c69c3d6a14ee7c18e0757710e1be2297.1273352819.git.eyvind.bernhardsen@gmail.com>
References: <cover.1273352819.git.eyvind.bernhardsen@gmail.com>
Cc: mat <matthieu.stigler@gmail.com>, hasen j <hasan.aljudy@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 08 23:47:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OArrO-0005mb-FF
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 23:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754246Ab0EHVqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 17:46:37 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:2895 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801Ab0EHVqe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 17:46:34 -0400
Received: by ey-out-2122.google.com with SMTP id d26so178336eyd.19
        for <git@vger.kernel.org>; Sat, 08 May 2010 14:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ZXsTzqPC/oclnn1FYKONKbUdOeMUgia6ShTn1ZHEPEI=;
        b=rImLjK2uLkqOHW8RACPOkyIigH13Lflo/f8Ut2aIrL16R1YdLca07FmGhj64yjnM+t
         1MxXkCRYVRgwnEd4fFRzJuFxrVH61p6pqHfKtJdYtHBQRbY52OOMriNykNqGPOr1+3CZ
         HX+9wZ5pUp5Z5tUyjYFJorl/AkTTnFzV0+014=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nkKvYOBduKP0/UnRiJatkcSZhh2luyfTPPAUgd3fnaKpa1TNLbkSqMCCcnlisjD3tJ
         d6/RrW/ANG/sJek3IsyWx9RhV+zdB11s2RXRH19vxgNkDkTjkjOHZLSmdsy+LScBXKOM
         MbEf05BSZDEyh0a8hpbk1ShaklNuHFT++BL7M=
Received: by 10.213.54.4 with SMTP id o4mr805768ebg.34.1273355192982;
        Sat, 08 May 2010 14:46:32 -0700 (PDT)
Received: from localhost.localdomain (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 14sm1782464ewy.6.2010.05.08.14.46.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 May 2010 14:46:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.3.gb95c9
In-Reply-To: <cover.1273352819.git.eyvind.bernhardsen@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146677>


Signed-off-by: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
---
 t/t0025-crlf-auto.sh |  180 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 180 insertions(+), 0 deletions(-)
 create mode 100755 t/t0025-crlf-auto.sh

diff --git a/t/t0025-crlf-auto.sh b/t/t0025-crlf-auto.sh
new file mode 100755
index 0000000..367b459
--- /dev/null
+++ b/t/t0025-crlf-auto.sh
@@ -0,0 +1,180 @@
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
+	if has_cr one || ! has_cr two
+	then
+		echo "Eh? $f"
+		false
+	fi &&
+	onediff=`git diff one` &&
+	twodiff=`git diff two` &&
+	test -z "$onediff" -a -z "$twodiff"
+'
+
+test_expect_success 'no crlf=auto, explicit eolstyle=native causes no changes' '
+
+	rm -f .gitattributes tmp one two &&
+	git config core.eolstyle native &&
+	git read-tree --reset -u HEAD &&
+
+	if has_cr one || ! has_cr two
+	then
+		echo "Eh? $f"
+		false
+	fi &&
+	onediff=`git diff one` &&
+	twodiff=`git diff two` &&
+	test -z "$onediff" -a -z "$twodiff"
+'
+
+test_expect_failure 'crlf=auto, eolStyle=crlf <=> autocrlf=true' '
+
+	rm -f .gitattributes tmp one two &&
+	git config core.autocrlf false &&
+	git config core.eolstyle crlf &&
+	echo "* crlf=auto" > .gitattributes &&
+	git read-tree --reset -u HEAD &&
+	unset missing_cr &&
+
+	for f in one two
+	do
+		if ! has_cr "$f"
+		then
+			echo "Eh? $f"
+			missing_cr=1
+			break
+		fi
+	done &&
+	test -z "$missing_cr"
+'
+
+test_expect_failure 'crlf=auto, eolStyle=lf <=> autocrlf=input' '
+
+	rm -f .gitattributes tmp one two &&
+	git config core.autocrlf false &&
+	git config core.eolstyle lf &&
+	echo "* crlf=auto" > .gitattributes &&
+	git read-tree --reset -u HEAD &&
+
+	if has_cr one || ! has_cr two
+	then
+		echo "Eh? $f"
+		false
+	fi &&
+	onediff=`git diff one` &&
+	twodiff=`git diff two` &&
+	test -z "$onediff" -a -n "$twodiff"
+'
+
+test_expect_success 'crlf=auto, eolStyle=false <=> autocrlf=false' '
+
+	rm -f .gitattributes tmp one two &&
+	git config core.autocrlf false &&
+	git config core.eolstyle false &&
+	echo "* crlf=auto" > .gitattributes &&
+	git read-tree --reset -u HEAD &&
+
+	if has_cr one || ! has_cr two
+	then
+		echo "Eh? $f"
+		false
+	fi
+	onediff=`git diff one` &&
+	twodiff=`git diff two` &&
+	test -z "$onediff" -a -z "$twodiff"
+'
+
+test_expect_success 'autocrlf=true overrides crlf=auto, eolStyle=lf' '
+
+	rm -f .gitattributes tmp one two &&
+	git config core.autocrlf true &&
+	git config core.eolstyle lf &&
+	echo "* crlf=auto" > .gitattributes &&
+	git read-tree --reset -u HEAD &&
+	unset missing_cr &&
+
+	for f in one two
+	do
+		if ! has_cr "$f"
+		then
+			echo "Eh? $f"
+			missing_cr=1
+			break
+		fi
+	done &&
+	test -z "$missing_cr"
+'
+
+test_expect_success 'autocrlf=input overrides crlf=auto, eolStyle=crlf' '
+
+	rm -f .gitattributes tmp one two &&
+	git config core.autocrlf input &&
+	git config core.eolstyle crlf &&
+	echo "* crlf=auto" > .gitattributes &&
+	git read-tree --reset -u HEAD &&
+
+	if has_cr one || ! has_cr two
+	then
+		echo "Eh? $f"
+		false
+	fi &&
+	onediff=`git diff one` &&
+	twodiff=`git diff two` &&
+	test -z "$onediff" -a -n "$twodiff"
+'
+
+test_expect_success 'autocrlf=true overrides crlf=auto, eolStyle=false' '
+
+	rm -f .gitattributes tmp one two &&
+	git config core.autocrlf true &&
+	git config core.eolstyle false &&
+	echo "* crlf=auto" > .gitattributes &&
+	git read-tree --reset -u HEAD &&
+	unset missing_cr &&
+
+	for f in one two
+	do
+		if ! has_cr "$f"
+		then
+			echo "Eh? $f"
+			missing_cr=1
+			break
+		fi
+	done &&
+	test -z "$missing_cr"
+'
+
+test_done
-- 
1.7.1.3.gb95c9
