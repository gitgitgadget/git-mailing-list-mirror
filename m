From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] t5000 on Windows: do not mistake "sh.exe" as "sh"
Date: Mon, 24 Nov 2014 19:29:37 +0100
Message-ID: <54737911.2040502@kdbg.org>
References: <5471EC26.3040705@web.de> <5472159B.4060905@ramsay1.demon.co.uk> <xmqqegstychq.fsf@gitster.dls.corp.google.com> <54726A8C.4040600@ramsay1.demon.co.uk> <5472DC24.9010008@web.de> <54735638.9000502@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Nov 24 19:29:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XsyOQ-00023X-Ou
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 19:29:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753170AbaKXS3n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Nov 2014 13:29:43 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:8840 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751930AbaKXS3m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 13:29:42 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3jmcN32yxtz5tlQ;
	Mon, 24 Nov 2014 19:29:39 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 4A71519F7E4;
	Mon, 24 Nov 2014 19:29:38 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <54735638.9000502@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260137>

In their effort to emulate POSIX as close as possible, the MSYS tools
and Cygwin treat the file name "foo.exe" as "foo" when the latter is
asked for, but not present, but the former is present.

=46ollowing this rule, 'cp /bin/sh a/bin' actually copies the file
/bin/sh.exe, so that we now have a/bin/sh.exe in the repository. This
difference did not matter in the tests in the past because we were only
interested in the equality of contents generated in various ways. But
recently added tests check file names, in particular, the presence of
"a/bin/sh". This test fails on Windows, as we do not have a file by thi=
s
name, but "a/bin/sh.exe".

Use test-genrandom to generate the large binary file in the repository
under the expected name.

We could change the guilty line to 'cat /bin/sh >a/bin/sh', but it is
better for test reproducibility to ensure that the test data is the sam=
e
across platforms, which test-genrandom can guarantee.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Am 24.11.2014 um 17:00 schrieb Torsten B=C3=B6gershausen:
> The test suite passes, except
> t5000 - not ok 48 - archive and :(glob)
>=20
> fatal: pathspec '*.abc' did not match any files

I've this patch in my tree for a while.

 t/t5000-tar-tree.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index d01bbdc..4b68bba 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -101,7 +101,7 @@ test_expect_success \
      ten=3D0123456789 && hundred=3D$ten$ten$ten$ten$ten$ten$ten$ten$te=
n$ten &&
      echo long filename >a/four$hundred &&
      mkdir a/bin &&
-     cp /bin/sh a/bin &&
+     test-genrandom "frotz" 500000 >a/bin/sh &&
      printf "A\$Format:%s\$O" "$SUBSTFORMAT" >a/substfile1 &&
      printf "A not substituted O" >a/substfile2 &&
      if test_have_prereq SYMLINKS; then
--=20
2.0.0.12.gbcf935e
