From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH v3 4/5] t4124: Add additional tests of --whitespace=fix
Date: Sat, 27 Feb 2010 14:52:40 +0100
Message-ID: <4B8923A8.3080507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 14:52:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlN68-0007nJ-5H
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 14:52:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968357Ab0B0Nwn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2010 08:52:43 -0500
Received: from mail-ew0-f220.google.com ([209.85.219.220]:55312 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968349Ab0B0Nwm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2010 08:52:42 -0500
Received: by mail-ew0-f220.google.com with SMTP id 20so535804ewy.21
        for <git@vger.kernel.org>; Sat, 27 Feb 2010 05:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=SuMg5CqTe/3iYqANQjanhHuKKzQmHNJSB0psMofu/30=;
        b=i9kdOFEt3MsBxsmR73SrNQ3FCOmu2J35ToVwpKvKfT3tPdRIvq5ZM161YwtoYeKhuu
         56R1GuuTdk8fHWlusGg5rQzz9la173rUhqFd6rQnTFgewIVd0LqGOrqi89SxMT57UGcM
         TJ+ZuHy7Z5cb1FmPwlBwy5CVBPAv8z5gx/QJI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=P0RDdUc7MnYPkUFf0IDmbOWWxYTdNs5ROjSYRWcrLe9uOqZFHzF40KvT09zQuv7R0M
         JaBTaqGCFcB+SIgaTPUeoqvAyaEK5edZUEWuihjgiYJglYWULGscXYcNoIZGRTb24tmv
         S7QHTe14/USdLs7s49hNsSNNXSbhoVB0zrolQ=
Received: by 10.213.24.17 with SMTP id t17mr1230436ebb.19.1267278761844;
        Sat, 27 Feb 2010 05:52:41 -0800 (PST)
Received: from [10.0.1.10] (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 24sm1353713eyx.6.2010.02.27.05.52.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Feb 2010 05:52:41 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141208>

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
 t/t4124-apply-ws-rule.sh |  119 ++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 119 insertions(+), 0 deletions(-)

diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index ca26397..f4540e8 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -261,4 +261,123 @@ test_expect_success 'blank but not empty at EOF' =
'
 	grep "new blank line at EOF" error
 '
=20
+test_expect_success 'applying beyond EOF requires one non-blank contex=
t line' '
+	{ echo; echo; echo; echo; } >one &&
+	git add one &&
+	{ echo b; } >>one &&
+	git diff -- one >patch &&
+
+	git checkout one &&
+	{ echo a; echo; } >one &&
+	cp one expect &&
+	test_must_fail git apply --whitespace=3Dfix patch &&
+	test_cmp one expect &&
+	test_must_fail git apply --ignore-space-change --whitespace=3Dfix pat=
ch &&
+	test_cmp one expect
+'
+
+test_expect_success 'tons of blanks at EOF should not apply' '
+	for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16; do
+		echo; echo; echo; echo;
+	done >one &&
+	git add one &&
+	echo a >>one &&
+	git diff -- one >patch &&
+
+	>one &&
+	test_must_fail git apply --whitespace=3Dfix patch &&
+	test_must_fail git apply --ignore-space-change --whitespace=3Dfix pat=
ch
+'
+
+test_expect_success 'missing blank line at end with --whitespace=3Dfix=
' '
+	echo a >one &&
+	echo >>one &&
+	git add one &&
+	echo b >>one &&
+	cp one expect &&
+	git diff -- one >patch &&
+	echo a >one &&
+	cp one saved-one &&
+	test_must_fail git apply patch &&
+	git apply --whitespace=3Dfix patch &&
+	test_cmp one expect &&
+	mv saved-one one &&
+	git apply --ignore-space-change --whitespace=3Dfix patch &&
+	test_cmp one expect
+'
+
+test_expect_success 'two missing blank lines at end with --whitespace=3D=
fix' '
+	{ echo a; echo; echo b; echo c; } >one &&
+	cp one no-blank-lines &&
+	{ echo; echo; } >>one &&
+	git add one &&
+	echo d >>one &&
+	cp one expect &&
+	echo >>one &&
+	git diff -- one >patch &&
+	cp no-blank-lines one &&
+	test_must_fail git apply patch &&
+	git apply --whitespace=3Dfix patch &&
+	test_cmp one expect &&
+	mv no-blank-lines one &&
+	test_must_fail git apply patch &&
+	git apply --ignore-space-change --whitespace=3Dfix patch &&
+	test_cmp one expect
+'
+
+test_expect_success 'shrink file with tons of missing blanks at end of=
 file' '
+	{ echo a; echo b; echo c; } >one &&
+	cp one no-blank-lines &&
+	for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16; do
+		echo; echo; echo; echo;
+	done >>one &&
+	git add one &&
+	echo a >one &&
+	cp one expect &&
+	git diff -- one >patch &&
+	cp no-blank-lines one &&
+	test_must_fail git apply patch &&
+	git apply --whitespace=3Dfix patch &&
+	test_cmp one expect &&
+	mv no-blank-lines one &&
+	git apply --ignore-space-change --whitespace=3Dfix patch &&
+	test_cmp one expect
+'
+
+test_expect_success 'missing blanks at EOF must only match blank lines=
' '
+	{ echo a; echo b; } >one &&
+	git add one &&
+	{ echo c; echo d; } >>one &&
+	git diff -- one >patch &&
+
+	echo a >one &&
+	test_must_fail git apply patch
+	test_must_fail git apply --whitespace=3Dfix patch &&
+	test_must_fail git apply --ignore-space-change --whitespace=3Dfix pat=
ch
+'
+
+sed -e's/Z//' >one <<EOF
+a
+b
+c
+                      Z
+EOF
+
+test_expect_success 'missing blank line should match context line with=
 spaces' '
+	git add one &&
+	echo d >>one &&
+	git diff -- one >patch &&
+	{ echo a; echo b; echo c; } >one &&
+	cp one expect &&
+	{ echo; echo d; } >>expect &&
+	git add one &&
+
+	git apply --whitespace=3Dfix patch &&
+	test_cmp one expect &&
+
+	git checkout-index -f one &&
+	git apply --ignore-space-change --whitespace=3Dfix patch &&
+	test_cmp one expect
+'
+
 test_done
--=20
1.7.0
