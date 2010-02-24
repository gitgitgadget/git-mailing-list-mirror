From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH v2 3/4] t4124: Add additional tests of --whitespace=fix
Date: Wed, 24 Feb 2010 20:24:30 +0100
Message-ID: <4B857CEE.5090109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 20:30:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkMwg-0001Qt-PJ
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 20:30:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757755Ab0BXTaq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Feb 2010 14:30:46 -0500
Received: from mail-ew0-f212.google.com ([209.85.219.212]:57961 "EHLO
	mail-ew0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757741Ab0BXTaq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 14:30:46 -0500
Received: by ewy4 with SMTP id 4so1219194ewy.28
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 11:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=Z6WzOn9vZUrUfZ6nTgP2YREPVY6R+d6nAbL2Y9Rcz5A=;
        b=pFtqd6S0ycEQyZ7PdIZlvgsm9q0K2gOCnRWKZotgZjXCHRT6NygeLAEICU/aBJJsH9
         j0ybdfuYWFoxsEvFuQUc7ICGCEUt1sRbukFT7ZzjtWZxfBbMoPG2kx1qP6wETexSN2vv
         ZooWbWPoYcShhkcFctCszgH7OtKQOMjOwfpMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=tvDX6DKXGRip2AjJkG2d5UMFNWjFHL89NmCutkZaUBphowQC39RwRJlb5SNR49P8nK
         VMNz2eB4IMs3ocIR0YAiQpGpY7LV5Kd5DXJxEtDIYkuC2dtnRDmUvs3OWXzArbR2jdy7
         wgqkGIBeBmJ3u6fbpRMKO7Auvwx3f7Qk2hJH4=
Received: by 10.213.50.140 with SMTP id z12mr143907ebf.89.1267039471889;
        Wed, 24 Feb 2010 11:24:31 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 5sm354538eyf.35.2010.02.24.11.24.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Feb 2010 11:24:31 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140978>

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
 t/t4124-apply-ws-rule.sh |   85 ++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 85 insertions(+), 0 deletions(-)

diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index ca26397..c783710 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -261,4 +261,89 @@ test_expect_success 'blank but not empty at EOF' '
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
+	test_must_fail git apply --whitespace=3Dfix patch
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
+	test_must_fail git apply patch &&
+	git apply --whitespace=3Dfix patch &&
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
+	mv no-blank-lines one &&
+	test_must_fail git apply patch &&
+	git apply --whitespace=3Dfix patch &&
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
+	mv no-blank-lines one &&
+	test_must_fail git apply patch &&
+	git apply --whitespace=3Dfix patch &&
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
+	mv no-blank-lines one &&
+	test_must_fail git apply patch &&
+	git apply --whitespace=3Dfix patch &&
+	test_cmp one expect
+'
+
 test_done
--=20
1.7.0
