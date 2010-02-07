From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH] Add a test for a problem in "rebase --whitespace=fix"
Date: Sun, 07 Feb 2010 09:10:12 +0100
Message-ID: <4B6E7564.7040109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 07 09:12:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ne2Fu-0002uy-K5
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 09:12:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013Ab0BGIKU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Feb 2010 03:10:20 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:28332 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930Ab0BGIKT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2010 03:10:19 -0500
Received: by ey-out-2122.google.com with SMTP id d26so1119250eyd.19
        for <git@vger.kernel.org>; Sun, 07 Feb 2010 00:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=lNpw/DX6wxsv4SBr4gUWkNQG3O1nSbzMMVhT3nZtapc=;
        b=iR4NGDHH1rRATq2biwKu5fX/PN7vwYzpVeeRorSGvjoo4pnD3+blIomW/fWkjy0jMK
         NrHZ4wgc4axlawEOSHZFvowctL+yXMsh+o/8DSkBGoy+eYCooZir7vfiaZXUy1rM3DAG
         l0NoAGBS2u5nU+xoLkOLzch6eWSAPLw+AN+OI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=ocSrY5lOMUe38Ghy8pfzF93Y/98/u30xPmZvsjiHKkTP6DNHct3841R0DDvk46y7n/
         VFmgy9LkZqYh1d7A6oHKua8PiDcFkrAMdraKSHbOlxFAU4EU3NG8SLRMcNmJFXeT51Dl
         G0E3KHVv5CPxfg1RVcCFcPWoSqQYGbnaIbEeU=
Received: by 10.213.96.229 with SMTP id i37mr3122625ebn.56.1265530214121;
        Sun, 07 Feb 2010 00:10:14 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 15sm2179168ewy.0.2010.02.07.00.10.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Feb 2010 00:10:13 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139224>

The command "git rebase --whitespace=3Dfix HEAD~<N>" is supposed to
only clean up trailing whitespace, and the expectation is that it
cannot fail.

Unfortunately, if one commit adds a blank line at the end of a file
and a subsequent commit adds more non-blank lines after the blank
line, "git apply" (used indirectly by "git rebase") will fail to apply
the patch of the second commit.

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
 t/t3417-rebase-whitespace-fix.sh |   45 ++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)
 create mode 100755 t/t3417-rebase-whitespace-fix.sh

diff --git a/t/t3417-rebase-whitespace-fix.sh b/t/t3417-rebase-whitespa=
ce-fix.sh
new file mode 100755
index 0000000..55cbce7
--- /dev/null
+++ b/t/t3417-rebase-whitespace-fix.sh
@@ -0,0 +1,45 @@
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
+cat >expect <<EOF
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
+EOF
+
+test_expect_failure 'blanks line at end of file; extend at end of file=
' '
+	git commit --allow-empty -m "Initial empty commit" &&
+	git add file && git commit -m first &&
+	mv second file &&
+	git add file &&	git commit -m second &&
+	git rebase --whitespace=3Dfix HEAD^^ &&
+	git diff --exit-code HEAD^:file expect
+'
+
+test_done
--=20
1.7.0.rc1.46.g04bf4
