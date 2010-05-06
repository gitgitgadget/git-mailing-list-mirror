From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [PATCH/RFC 2/3] Add tests for per-repository eol normalization
Date: Fri,  7 May 2010 00:27:34 +0200
Message-ID: <38d9735b135503ca444e82d3aaa9107ea18439e6.1273183206.git.eyvind.bernhardsen@gmail.com>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com> <cover.1273183206.git.eyvind.bernhardsen@gmail.com>
Cc: hasan.aljudy@gmail.com, kusmabite@googlemail.com,
	torvalds@linux-foundation.org, prohaska@zib.de, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 07 00:27:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OA9Xv-0003zw-SW
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 00:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753637Ab0EFW1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 18:27:50 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:44803 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753492Ab0EFW1p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 18:27:45 -0400
Received: by ey-out-2122.google.com with SMTP id d26so89461eyd.19
        for <git@vger.kernel.org>; Thu, 06 May 2010 15:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=M+hMAhDBUMcBr7iFajVyQnNI+P90ZasRA3U5NJxI44Q=;
        b=oCpH3ny8VciOTWcCtsbn3OS52EFESiPj/YSO/ox5kLLtKHVutmSoLuq5cSe8DhbAfi
         uqnBUzjEk5se4l3ggBBDHv2ESIHeAnWhXlK2nF21uLVnZiYdiZsix0ET0/aEWPCMcZID
         U+mgY3yfHI5DUroVp9IUe3ivYBfb/CpCN7S7o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vifUbp8KJufczru7Bh5Pqp8cNm4YXZNW1bu/U9rfaFM11bCwxoHYGsHROcpHST7Cc6
         CGi1S9OYk7ZcBTihrBlepO9L+fYSLJP/tr0wCfDJy/1OZdsG3lLhR6n685eZciTqSDM/
         fEIKhc60OC3i7dFmyMaYOvQ4a5WH9oJPQL+vI=
Received: by 10.213.42.74 with SMTP id r10mr3744601ebe.58.1273184865046;
        Thu, 06 May 2010 15:27:45 -0700 (PDT)
Received: from localhost.localdomain (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 16sm843521ewy.15.2010.05.06.15.27.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 May 2010 15:27:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.3.gb95c9
In-Reply-To: <cover.1273183206.git.eyvind.bernhardsen@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146506>


Signed-off-by: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
---
 t/t0025-auto-eol.sh |  180 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 180 insertions(+), 0 deletions(-)
 create mode 100755 t/t0025-auto-eol.sh

diff --git a/t/t0025-auto-eol.sh b/t/t0025-auto-eol.sh
new file mode 100755
index 0000000..5acee2d
--- /dev/null
+++ b/t/t0025-auto-eol.sh
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
+test_expect_success 'no auto-eol, explicit eolstyle=native causes no changes' '
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
+test_expect_failure 'auto-eol=true, eolStyle=crlf <=> autocrlf=true' '
+
+	rm -f .gitattributes tmp one two &&
+	git config core.autocrlf false &&
+	git config core.eolstyle crlf &&
+	echo "* auto-eol" > .gitattributes &&
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
+test_expect_failure 'auto-eol=true, eolStyle=lf <=> autocrlf=input' '
+
+	rm -f .gitattributes tmp one two &&
+	git config core.autocrlf false &&
+	git config core.eolstyle lf &&
+	echo "* auto-eol" > .gitattributes &&
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
+test_expect_success 'auto-eol=true, eolStyle=false <=> autocrlf=false' '
+
+	rm -f .gitattributes tmp one two &&
+	git config core.autocrlf false &&
+	git config core.eolstyle false &&
+	echo "* auto-eol" > .gitattributes &&
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
+test_expect_success 'autocrlf=true overrides auto-eol=true, eolStyle=lf' '
+
+	rm -f .gitattributes tmp one two &&
+	git config core.autocrlf true &&
+	git config core.eolstyle lf &&
+	echo "* auto-eol" > .gitattributes &&
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
+test_expect_success 'autocrlf=input overrides auto-eol=true, eolStyle=crlf' '
+
+	rm -f .gitattributes tmp one two &&
+	git config core.autocrlf input &&
+	git config core.eolstyle crlf &&
+	echo "* auto-eol" > .gitattributes &&
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
+test_expect_success 'autocrlf=true overrides auto-eol=true, eolStyle=false' '
+
+	rm -f .gitattributes tmp one two &&
+	git config core.autocrlf true &&
+	git config core.eolstyle false &&
+	echo "* auto-eol" > .gitattributes &&
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
