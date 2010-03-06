From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH v4 4/5] t4124: Add additional tests of --whitespace=fix
Date: Sat, 06 Mar 2010 15:31:04 +0100
Message-ID: <4B926728.1060003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 06 22:26:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No1ae-0006hn-8f
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 22:31:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753498Ab0CFObL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Mar 2010 09:31:11 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:54614 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217Ab0CFObJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 09:31:09 -0500
Received: by ey-out-2122.google.com with SMTP id 25so693637eya.19
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 06:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=7O9jxD4vwNHdCRR21bVwUXXg9XxDGR/rc218C44zsqU=;
        b=jJharotYd1D+naRmyHJgpCfXrONSccLchdMfQw/zxtJQugryzkdQOBJ3LpMYveIK3j
         FdsWCxhnebsDnwOL0crI9I4uFVt4pB27Nn2IoXAC9K1VRY53sFG3H11rb79qC1OmJG17
         C6eCU0iEzcNCGMfrHsqZCLpxGQ6KRCC0/f72M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=ITM6Z5SkYdrtuQQb/a1x0fevLj+SKEEd3bZvH3yYRFVnjXr24IHwn6NdPZXT1S8gYF
         Yjw5uOE8ByJMua9DfxehGU4pVYMp/95bANMdIVaNAe+ASmHmBYXYrzOffeD/mjMCXtun
         y+oM6F3fk8mwtwbO9e6/w7lXO1oP3F2pVD7Vk=
Received: by 10.213.40.133 with SMTP id k5mr1622984ebe.94.1267885866443;
        Sat, 06 Mar 2010 06:31:06 -0800 (PST)
Received: from [10.0.1.10] (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 7sm6371894eyb.17.2010.03.06.06.31.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Mar 2010 06:31:05 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
 t/t4124-apply-ws-rule.sh |  170 ++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 170 insertions(+), 0 deletions(-)

diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index ca26397..37bb767 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -261,4 +261,174 @@ test_expect_success 'blank but not empty at EOF' =
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
+		      Z
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
+	test_cmp one expect
+'
+
+sed -e's/Z//' >one <<EOF
+a
+b
+c
+                      Z
+EOF
+
+test_expect_success 'same, but with the --ignore-space-option' '
+	git add one &&
+	echo d >>one &&
+	cp one expect &&
+	git diff -- one >patch &&
+	{ echo a; echo b; echo c; } >one &&
+	git add one &&
+
+	git checkout-index -f one &&
+	git apply --ignore-space-change --whitespace=3Dfix patch &&
+	test_cmp one expect
+'
+
+test_expect_success 'same, but with CR-LF line endings && cr-at-eol se=
t' '
+	git config core.whitespace cr-at-eol &&
+	printf "a\r\n" >one &&
+	printf "b\r\n" >>one &&
+	printf "c\r\n" >>one &&
+	cp one save-one &&
+	printf "                 \r\n" >>one
+	git add one &&
+	printf "d\r\n" >>one &&
+	cp one expect &&
+	git diff -- one >patch &&
+	mv save-one one &&
+
+	git apply --ignore-space-change --whitespace=3Dfix patch &&
+	test_cmp one expect
+'
+
+test_expect_success 'same, but with CR-LF line endings && cr-at-eol un=
set' '
+	git config --unset core.whitespace &&
+	printf "a\r\n" >one &&
+	printf "b\r\n" >>one &&
+	printf "c\r\n" >>one &&
+	cp one save-one &&
+	printf "                 \r\n" >>one
+	git add one &&
+	cp one expect &&
+	printf "d\r\n" >>one &&
+	git diff -- one >patch &&
+	mv save-one one &&
+	echo d >>expect &&
+
+	git apply --ignore-space-change --whitespace=3Dfix patch &&
+	test_cmp one expect
+'
+
 test_done
--=20
1.7.0
