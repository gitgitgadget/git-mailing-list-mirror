From: Matt Kraai <kraai@ftbfs.org>
Subject: Re: [PATCH 2/4] t0024, t5000: use test_lazy_prereq for UNZIP
Date: Sun, 6 Jan 2013 10:06:21 -0800
Message-ID: <20130106180621.GA16494@ftbfs.org>
References: <7vwqw7mb09.fsf@alter.siamese.dyndns.org>
 <50E9B82D.50005@lsrfire.ath.cx>
 <50E9B90C.2060200@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Jan 06 19:07:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Truce-0004ss-PO
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 19:07:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756088Ab3AFSGm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jan 2013 13:06:42 -0500
Received: from zoom.lafn.org ([108.92.93.123]:38657 "EHLO zoom.lafn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756074Ab3AFSGl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 13:06:41 -0500
Received: from yeeloong.ftbfs.org (pool-108-23-63-172.lsanca.fios.verizon.net [108.23.63.172])
	(authenticated bits=0)
	by zoom.lafn.org (8.14.3/8.14.2) with ESMTP id r06I6Yw2020077;
	Sun, 6 Jan 2013 10:06:35 -0800 (PST)
	(envelope-from kraai@ftbfs.org)
Received: from kraai by yeeloong.ftbfs.org with local (Exim 4.80)
	(envelope-from <kraai@ftbfs.org>)
	id 1Truc2-0007me-0T; Sun, 06 Jan 2013 10:06:22 -0800
Mail-Followup-To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <50E9B90C.2060200@lsrfire.ath.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: clamav-milter 0.97 at zoom.lafn.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212832>

On Sun, Jan 06, 2013 at 06:49:00PM +0100, Ren=E9 Scharfe wrote:
> This change makes the code smaller and we can put it at the top of
> the script, its rightful place as setup code.

Would it be better to add the setting of GIT_UNZIP and
test_lazy_prereq to test-lib.sh so they aren't duplicated in both
t0024-crlf-archive.sh and t5000-tar-tree.sh, something like the
following (modulo UNZIP/GIT_UNZIP)?

--=20
Matt Kraai
https://ftbfs.org/kraai

diff --git a/t/t0024-crlf-archive.sh b/t/t0024-crlf-archive.sh
index ec6c1b3..084f33c 100755
--- a/t/t0024-crlf-archive.sh
+++ b/t/t0024-crlf-archive.sh
@@ -3,7 +3,6 @@
 test_description=3D'respect crlf in git archive'
=20
 . ./test-lib.sh
-UNZIP=3D${UNZIP:-unzip}
=20
 test_expect_success setup '
=20
@@ -26,13 +25,6 @@ test_expect_success 'tar archive' '
=20
 '
=20
-"$UNZIP" -v >/dev/null 2>&1
-if [ $? -eq 127 ]; then
-	say "Skipping ZIP test, because unzip was not found"
-else
-	test_set_prereq UNZIP
-fi
-
 test_expect_success UNZIP 'zip archive' '
=20
 	git archive --format=3Dzip HEAD >test.zip &&
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index ecf00ed..85b64ae 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -25,7 +25,6 @@ commit id embedding:
 '
=20
 . ./test-lib.sh
-UNZIP=3D${UNZIP:-unzip}
 GZIP=3D${GZIP:-gzip}
 GUNZIP=3D${GUNZIP:-gzip -d}
=20
@@ -201,13 +200,6 @@ test_expect_success \
       test_cmp a/substfile2 g/prefix/a/substfile2
 '
=20
-$UNZIP -v >/dev/null 2>&1
-if [ $? -eq 127 ]; then
-	say "Skipping ZIP tests, because unzip was not found"
-else
-	test_set_prereq UNZIP
-fi
-
 test_expect_success \
     'git archive --format=3Dzip' \
     'git archive --format=3Dzip HEAD >d.zip'
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 8a12cbb..4ceabad 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -752,6 +752,13 @@ test_lazy_prereq AUTOIDENT '
 	git var GIT_AUTHOR_IDENT
 '
=20
+UNZIP=3D${UNZIP:-unzip}
+
+test_lazy_prereq UNZIP '
+	"$UNZIP" -v >/dev/null 2>&1
+	test $? -ne 127
+'
+
 # When the tests are run as root, permission tests will report that
 # things are writable when they shouldn't be.
 test -w / || test_set_prereq SANITY
