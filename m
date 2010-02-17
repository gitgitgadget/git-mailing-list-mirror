From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [RFC/PATCH 3/3] t3417: Add test cases for "rebase --whitespace=fix"
Date: Wed, 17 Feb 2010 08:03:37 +0100
Message-ID: <4B7B94C9.1050708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 08:03:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nhdwn-0006xw-Td
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 08:03:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933949Ab0BQHDl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Feb 2010 02:03:41 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:46844 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933771Ab0BQHDj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 02:03:39 -0500
Received: by mail-ew0-f228.google.com with SMTP id 28so2494610ewy.28
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 23:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=OA6Yd0MR1oNtgGwzXurVz/EDvW+oCvhMAYcL4wr5/Ug=;
        b=di2lPuZJUYGEEQAcUhhjsa4AR2qodpYCQpVpW+gyEykmb7j+SUUOBzRHgbiCDJ5c1v
         AedUvgAmPf6k3zRdQ6jqnwPgA30sAAMhSvJ6O8INzMRNV7lHZ4aFNHAPW7jU2pWj/0IV
         ppoxk8NTPfnAnqSYAtJI5Kf3+b8I63M89QvLw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=F7lQvGigXz97i7Y0BSmlarTJ22iF1Hq3DT2wfen0+uVfhu+6gEnAnZgwWgDr1soYBv
         YQxHjPdVxNYGCdpvrH7VLyocOg00ZlmjvejQP+j/c+RxloWKZYh7cZDxtGJKA2o2vFte
         9csuMz50eESAHdJLDnEdWmt9HHbLqqHWxX9u8=
Received: by 10.213.67.205 with SMTP id s13mr4852503ebi.1.1266390218573;
        Tue, 16 Feb 2010 23:03:38 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 28sm20084790eye.31.2010.02.16.23.03.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 23:03:38 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140210>

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
