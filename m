From: tboegi@web.de
Subject: [PATCH v7 01/10] t0027: Make commit_chk_wrnNNO() reliable
Date: Mon, 25 Apr 2016 18:56:27 +0200
Message-ID: <1461603387-30639-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 18:52:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aujkW-0000Rw-HH
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 18:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933151AbcDYQwV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Apr 2016 12:52:21 -0400
Received: from mout.web.de ([212.227.17.12]:53553 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933140AbcDYQwR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 12:52:17 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0Lp6xk-1bOauS0ZCW-00eq5I; Mon, 25 Apr 2016 18:52:08
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:iayo0vnCpqvZgO1VoGBmqxqVZjsoxpVyKFjGXhro6ChN0Whz+oI
 74FEtiuSJKbrsLNq0aTlmXVQTnWKE2QbJDb+f8xibvihe/aw3fntKGgdPwWqNhK/OhuJ16g
 o9mQlvV52N804AQNHoVHomFnk0b3X//MBHob9VFeI0bPZLeBLRZm9nvOxKWY/476q4Dp1tX
 RW0v/QRIn40N4uBfcI+zw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IXYjBQ2BuG8=:bwyJ2F56Z6GTewzVJJNeZO
 UcO0eku3BR49KsKOihP33dUHSoTdyLFZABybCCPqsEkp8pqgZQ6AoXU6Lk1np8zNFUu51eM6L
 NGeNdr4Mqv8s8vHprktMkgp8KHcCsmobnlFotyJv2fwTHMa+ohWrvWSVEITS42r8pOOSD/Mhk
 dxPdW7WX6sP4VqjSUpP4zjL6CUhemEDc1YiV5tcWcApHmIu6pfPkWO7SZxUA4VqfBVEn/VqFr
 qIKpdpVSa2vk/oU6xvKmhQ17fZc+k3VMQJ9iWNbj/ebKz0Q62/OYyEF7RN0fYWkWmBud+tqFX
 5qRmS27J44HwrqpHrwV2vyVKThNTO9H2QTyRBorfFV0kunuhZHxacCloI/nsJZxipV1Y/PgQn
 I+fW3dAMAWShikxmrCsq1KxWd4KBjnFq6HksT7D/afUXl+5y9mRQhQ0mw+5OywQdDiL+7RmU/
 h60UBg8tCQl5zjsyz24Mgytg1TQe2Ygmt+bsbW9sqt6D+/gfUxB+0UPNaYbOgFh3BczsC2frs
 o+MkK/yhVH+mw7ZltUXFioDvQgfmIVbDxLTLlNLwuW/8FNkQTS2bFEc7OLtibZo7sx8b0wvYZ
 4XEjpwcyvg39oyDshinT/kiJPdyyK/AWn9OvtpNX4L80lGnrofL2uBVVNLA3qqAIk55P3EX+u
 +wvfdEeIyLwYjhTGMjL8vxPW70fz3GK6unJd7fQbNOIcpx3r8FUcQy/YZZ1qxkhXEu6LoSPw0
 MtPfMRe0d6NB+xoYIRfyNlcBy5lKyElqGXvc2wEPdPyTHfqiIxsUFr3CI8p0/+PwxoCN7058 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292521>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

When the content of a commited file is unchanged and the attributes are=
 changed,
Git may not detect that the next commit must treat the file as changed.
This happens when lstat() doesn't detect a change, since neither inode,
mtime nor size are changed.

Add a singe "Z" character to change the file size (and content).
When the files are compared later in checkout_files(), the "Z" is remov=
ed
before the comparison.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 Change since v6b:
 - Remove 2 sparse warnings, thanks Ramsay

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index f33962b..9fe539b 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -12,7 +12,7 @@ fi
=20
 compare_files () {
 	tr '\015\000' QN <"$1" >"$1".expect &&
-	tr '\015\000' QN <"$2" >"$2".actual &&
+	tr '\015\000' QN <"$2" | tr -d 'Z' >"$2".actual &&
 	test_cmp "$1".expect "$2".actual &&
 	rm "$1".expect "$2".actual
 }
@@ -114,6 +114,7 @@ commit_chk_wrnNNO () {
 	do
 		fname=3D${pfx}_$f.txt &&
 		cp $f $fname &&
+		printf Z >>"$fname" &&
 		git -c core.autocrlf=3D$crlf add $fname 2>/dev/null &&
 		git -c core.autocrlf=3D$crlf commit -m "commit_$fname" $fname >"${pf=
x}_$f.err" 2>&1
 	done
--=20
2.0.0.rc1.6318.g0c2c796
