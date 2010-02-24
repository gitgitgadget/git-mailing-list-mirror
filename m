From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH v2 4/4] t3417: Add test cases for "rebase --whitespace=fix"
Date: Wed, 24 Feb 2010 20:24:37 +0100
Message-ID: <4B857CF5.6010908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 20:30:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkMvn-000105-IH
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 20:29:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757728Ab0BXT3y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Feb 2010 14:29:54 -0500
Received: from mail-ew0-f212.google.com ([209.85.219.212]:48949 "EHLO
	mail-ew0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757723Ab0BXT3x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 14:29:53 -0500
X-Greylist: delayed 353 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Feb 2010 14:29:52 EST
Received: by ewy4 with SMTP id 4so1218620ewy.28
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 11:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=OA6Yd0MR1oNtgGwzXurVz/EDvW+oCvhMAYcL4wr5/Ug=;
        b=h9tDjBCvxUiV+RhBGcfBNNI0UZGZqm4T1vCWigxKFj65eWNkWrR2n2qjq0VT+2o8EJ
         L2bc1mrEw7QcAuqb6vNGIUuILbssgi2HMT/sOP93rNnxQ0LvhRxNeVYVT17/S7bbVDnr
         uR4sWHIYtLaUGJaSjnj4VV/tzt7wVNoAw2FnA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=A/ar7IAKnyoF+kab/lSsDaiXEslV6eKauA5thP1tyWXpcOhpItvoxbEamIbhY4WzVd
         bld4B1iiRy5sOnCstbIMWElyOR7b8OM3/oGugb7qIx5mFDfIph6+0GoXyvhoPNC9912E
         Y3KfOZMsRBKr8zTabf+JeW4T3zsEtX02HGbUo=
Received: by 10.213.100.226 with SMTP id z34mr624238ebn.74.1267039479269;
        Wed, 24 Feb 2010 11:24:39 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 7sm359334eyg.40.2010.02.24.11.24.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Feb 2010 11:24:38 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140977>

The command "git rebase --whitespace=3Dfix HEAD~<N>" is supposed to
only clean up trailing whitespace, and the expectation is that it
cannot fail.

Unfortunately, if one commit adds a blank line at the end of a file
and a subsequent commit adds more non-blank lines after the blank
line, "git apply" (used indirectly by "git rebase") will fail to apply
the patch of the second commit.

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
 t/t3417-rebase-whitespace-fix.sh |  126 ++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 126 insertions(+), 0 deletions(-)
 create mode 100755 t/t3417-rebase-whitespace-fix.sh

diff --git a/t/t3417-rebase-whitespace-fix.sh b/t/t3417-rebase-whitespa=
ce-fix.sh
new file mode 100755
index 0000000..417d109
--- /dev/null
+++ b/t/t3417-rebase-whitespace-fix.sh
@@ -0,0 +1,126 @@
+#!/bin/sh
+
+test_description=3D'git rebase --whitespace=3Dfix
+
+This test runs git rebase --whitespace=3Dfix and make sure that it wor=
ks.
+'
+
+. ./test-lib.sh
+
+# prepare initial revision of "file" with a blank line at the end
+cat >file <<EOF
+a
+b
+c
+
+EOF
+
+# expected contents in "file" after rebase
+cat >expect-first <<EOF
+a
+b
+c
+EOF
+
+# prepare second revision of "file"
+cat >second <<EOF
+a
+b
+c
+
+d
+e
+f
+
+
+
+
+EOF
+
+# expected contents in second revision after rebase
+cat >expect-second <<EOF
+a
+b
+c
+
+d
+e
+f
+EOF
+
+test_expect_success 'blank line at end of file; extend at end of file'=
 '
+	git commit --allow-empty -m "Initial empty commit" &&
+	git add file && git commit -m first &&
+	mv second file &&
+	git add file &&	git commit -m second &&
+	git rebase --whitespace=3Dfix HEAD^^ &&
+	git diff --exit-code HEAD^:file expect-first &&
+	test_cmp file expect-second
+'
+
+# prepare third revision of "file"
+sed -e's/Z//' >third <<EOF
+a
+b
+c
+
+d
+e
+f
+    Z
+ Z
+h
+i
+j
+k
+l
+EOF
+
+sed -e's/ //g' <third >expect-third
+
+test_expect_success 'two blanks line at end of file; extend at end of =
file' '
+	cp third file && git add file && git commit -m third &&
+	git rebase --whitespace=3Dfix HEAD^^ &&
+	git diff --exit-code HEAD^:file expect-second &&
+	test_cmp file expect-third
+'
+
+test_expect_success 'same, but do not remove trailing spaces' '
+	git config core.whitespace "-blank-at-eol" &&
+	git reset --hard HEAD^ &&
+	cp third file && git add file && git commit -m third &&
+	git rebase --whitespace=3Dfix HEAD^^
+	git diff --exit-code HEAD^:file expect-second &&
+	test_cmp file third
+'
+
+sed -e's/Z//' >beginning <<EOF
+a
+                    Z
+       Z
+EOF
+
+cat >expect-beginning <<EOF
+a
+
+
+1
+2
+3
+4
+5
+EOF
+
+test_expect_success 'at beginning of file' '
+	git config core.whitespace "blank-at-eol" &&
+	cp beginning file &&
+	git commit -m beginning file &&
+	for i in 1 2 3 4 5; do
+		echo $i
+	done >> file &&
+	git commit -m more file	&&
+	git rebase --whitespace=3Dfix HEAD^^ &&
+	test_cmp file expect-beginning
+'
+
+test_done
--=20
1.7.0
