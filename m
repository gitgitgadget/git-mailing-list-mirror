From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 3/5] test-lib: output a newline before "ok" under a TAP harness
Date: Thu, 24 Jun 2010 17:44:47 +0000
Message-ID: <1277401489-27885-4-git-send-email-avarab@gmail.com>
References: <1277401489-27885-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 24 19:45:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORqUt-0005T5-8D
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 19:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755273Ab0FXRpm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jun 2010 13:45:42 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42245 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755233Ab0FXRpl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 13:45:41 -0400
Received: by mail-wy0-f174.google.com with SMTP id 11so1893480wyi.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 10:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=E+00Vtr60tXYdxvVm/kdjVmZmc9AWRROatv2AcojltU=;
        b=wC2WQFs+2glo8COCDpDm0bYQEOqETBMbX2FbhCHsZIYmICcmCFv5UtyGjdoxUHAxfR
         KJkX8+2Rz+VpnfGjsw42AIuJnmbRxcyahNYjAEoeRe6NtmX6aLZFKKNKQRG8WBlX6Fhj
         2ITBwX1hf5iZ36GiGwuj1z9VbHvoArics4ufI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=II44BLG1HJ1s/KTj+iY87u5UpAV/v4bX9poZuY/Xnq52+2kefGhmr+I4EnuJJRGGrn
         Y+OGgpZ9ju+0unJ2cMeIMUb9xaZYkBKzCepSjOc1gb+JXkknQMtpGLlC4yYPad5A/bvS
         YHphfeOG2avUlvdAYxAZTCYg4PT8UYTHeMnLU=
Received: by 10.216.182.7 with SMTP id n7mr7610095wem.91.1277401540510;
        Thu, 24 Jun 2010 10:45:40 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id h1sm1043062wee.31.2010.06.24.10.45.38
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 24 Jun 2010 10:45:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
In-Reply-To: <1277401489-27885-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149611>

Some tests in the testsuite will emit a line that doesn't end with a
newline, right before we're about to output "ok" or "not ok". This
breaks the TAP output with "Tests out of sequence" errors since a TAP
harness can't understand this:

    ok 1 - A test
    [some output here]ok 2 - Another test
    ok 3 - Yet another test

Work around it by emitting an empty line before we're about to say
"ok" or "not ok", but only if we're running under --verbose and
HARNESS_ACTIVE=3D1 is set, which'll only be the case when running under
a harnesses like prove(1).

I think it's better to do this than fix each tests by adding `&& echo'
everywhere. More tests might be added that break TAP in the future,
and a human isn't going to look at the extra whitespace, since
HARNESS_ACTIVE=3D1 always means a harness is reading it.

The tests that had issues were:

   t1007, t3410, t3413, t3409, t3414, t3415, t3416, t3412, t3404,
   t5407, t7402, t7003, t9001

With this workaround the entire test suite runs without errors under:

    prove -j 10 ./t[0-9]*.sh :: --verbose

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/test-lib.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7077210..ac496aa 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -371,6 +371,9 @@ test_run_ () {
 	eval >&3 2>&4 "$1"
 	eval_ret=3D$?
 	eval >&3 2>&4 "$test_cleanup"
+	if test "$verbose" =3D "t" && test -n "$HARNESS_ACTIVE"; then
+		echo ""
+	fi
 	return 0
 }
=20
--=20
1.7.1.251.g92a7
