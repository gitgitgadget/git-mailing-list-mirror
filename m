From: Jiang Xin <worldhello.net@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=20v2=5D=20test=3A=20set=20the=20realpath=20of=20CWD=20as=20TRASH=5FDIRECTORY?=
Date: Mon, 27 Aug 2012 13:13:36 +0800
Message-ID: <f58965733e604a9fe6ed72384d0307062403b478.1346043214.git.worldhello.net@gmail.com>
References: <5030F0BF.2090500@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Aug 27 07:14:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5reP-0004oZ-8m
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 07:14:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903Ab2H0FNi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Aug 2012 01:13:38 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42505 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806Ab2H0FNh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 01:13:37 -0400
Received: by pbbrr13 with SMTP id rr13so6775155pbb.19
        for <git@vger.kernel.org>; Sun, 26 Aug 2012 22:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=dh4oU4LebHKZNpZrUdGjJHuV7WxhDQBM3UAbM81kDtY=;
        b=0u8ArqQQIkGyK3hJLMaiUR3Y8LlQXb8rm2PFUpmwrcXaZn7gLPe5GZZ/sYgM4JmovW
         MiY6LzxRnbN4cKcKbNJUn94ajvIvRMNoKAqOhFeUzjgrrrFOqMTQI2RzLXMmFNND4/I7
         Db3RFsFpJaxPQaKZkx0XCUWz/aFVKaUKfg2FJY8GXu9xKnN/rMAOpwF6h3/QkZM0wC9d
         08uyN1iRTp/8kt5pc25vvGBSbSYdqkDFM6o4C1rOb+uFrdYbb9qVxSO+PchxL0EbdB0w
         8AzoqmeM3eSuhav2bpsyxBKbrkIs/4PORQMT+f4SLD0sLiTdjQHZhiJjVIZkKhlJR8Kg
         5pbQ==
Received: by 10.66.76.231 with SMTP id n7mr27417268paw.68.1346044416844;
        Sun, 26 Aug 2012 22:13:36 -0700 (PDT)
Received: from localhost.foo.bar ([123.116.231.150])
        by mx.google.com with ESMTPS id iu10sm13898450pbc.45.2012.08.26.22.13.31
        (version=SSLv3 cipher=OTHER);
        Sun, 26 Aug 2012 22:13:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.92.gaa91cb5
In-Reply-To: <5030F0BF.2090500@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204318>

Some testcases will fail if current work directory is on a symlink.

    symlink$ sh ./t4035-diff-quiet.sh
    $ sh ./t4035-diff-quiet.sh --root=3D/symlink
    $ TEST_OUTPUT_DIRECTORY=3D/symlink sh ./t4035-diff-quiet.sh

This is because the realpath of ".git" directory will be returned when
running the command 'git rev-parse --git-dir' in a subdir of the work
tree, and the realpath may not equal to "$TRASH_DIRECTORY".

In this fix, "$TRASH_DIRECTORY" is determined right after the realpath
of CWD is resolved.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Reported-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 t/test-lib.sh | 9 +++++----
 1 =E4=B8=AA=E6=96=87=E4=BB=B6=E8=A2=AB=E4=BF=AE=E6=94=B9=EF=BC=8C=E6=8F=
=92=E5=85=A5 5 =E8=A1=8C(+)=EF=BC=8C=E5=88=A0=E9=99=A4 4 =E8=A1=8C(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 78c42..9a59ca8 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -531,17 +531,17 @@ fi
 test=3D"trash directory.$(basename "$0" .sh)"
 test -n "$root" && test=3D"$root/$test"
 case "$test" in
-/*) TRASH_DIRECTORY=3D"$test" ;;
- *) TRASH_DIRECTORY=3D"$TEST_OUTPUT_DIRECTORY/$test" ;;
+/*) ;;
+ *) test=3D"$TEST_OUTPUT_DIRECTORY/$test" ;;
 esac
-test ! -z "$debug" || remove_trash=3D$TRASH_DIRECTORY
+test ! -z "$debug" || remove_trash=3D$test
 rm -fr "$test" || {
 	GIT_EXIT_OK=3Dt
 	echo >&5 "FATAL: Cannot prepare test area"
 	exit 1
 }
=20
-HOME=3D"$TRASH_DIRECTORY"
+HOME=3D"$test"
 export HOME
=20
 if test -z "$TEST_NO_CREATE_REPO"; then
@@ -552,6 +552,7 @@ fi
 # Use -P to resolve symlinks in our working directory so that the cwd
 # in subprocesses like git equals our $PWD (for pathname comparisons).
 cd -P "$test" || exit 1
+TRASH_DIRECTORY=3D"$(pwd)"
=20
 this_test=3D${0##*/}
 this_test=3D${this_test%%-*}
--=20
1.7.12.92.gaa91cb5
