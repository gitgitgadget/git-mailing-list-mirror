From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 1/3] test-lib: Add support for multiple test prerequisites
Date: Fri,  6 Aug 2010 21:19:23 +0000
Message-ID: <1281129565-26124-2-git-send-email-avarab@gmail.com>
References: <1281129565-26124-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 06 23:20:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhUKt-0005ak-Uv
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 23:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762081Ab0HFVTy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Aug 2010 17:19:54 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:55329 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762067Ab0HFVTw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 17:19:52 -0400
Received: by wwf26 with SMTP id 26so271861wwf.1
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 14:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=gk6pF6sjlPfqidLh+NqJGnHbm5fnI7uE8TkRg8fqmNA=;
        b=gl3ctn7sSNJHCbbVO37H7CgNHeOOWkeFNI9t0GuAcLe0tmqFobSfHCaKfMBCLDxECk
         iXTOg1qlYFQ61Z1dOFGauYxn5nJnDd3snM+I/VrbZwcLCFJPWlpVIvShXGZHECH5666e
         i4dJy8Ul4Iwviy2iFt2LS5ZMFjZNud2x1VKjg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=a/MJ9PS32RD/QoDSm3mpZ3R7WXJYqRYhp5fcANo8vxr1k7AnrocO9zG6xP/0ntueBu
         VOHyGJnjLwnuS821L8geMtGoxnp102o/gHOmvEVRB3dJQQkqwmiMZ86hr++t6poj6CNq
         aBvpKPgJr97adRcsVj0GHXQdpcAGlEsXCaUJw=
Received: by 10.216.160.15 with SMTP id t15mr11106308wek.75.1281129590818;
        Fri, 06 Aug 2010 14:19:50 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id k7sm1167559wej.2.2010.08.06.14.19.49
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 06 Aug 2010 14:19:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1281129565-26124-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152816>

Change the test_have_prereq function in test-lib.sh to support a
comma-separated list of prerequisites. This is useful for tests that
need e.g. both POSIXPERM and SANITY.

The implementation was stolen from Junio C Hamano and Johannes Sixt,
the tests and documentation were not. See the "Tests in Cygwin" thread
in May 2009 for the originals:

    http://thread.gmane.org/gmane.comp.version-control.git/116729/focus=
=3D118385
    http://thread.gmane.org/gmane.comp.version-control.git/116729/focus=
=3D118434

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/README         |    6 ++++++
 t/t0000-basic.sh |   17 +++++++++++++++++
 t/test-lib.sh    |   20 ++++++++++++++------
 3 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/t/README b/t/README
index 0d1183c..d07b67a 100644
--- a/t/README
+++ b/t/README
@@ -350,6 +350,12 @@ library for your script to use.
 	test_expect_success TTY 'git --paginate rev-list uses a pager' \
 	    ' ... '
=20
+   You can also supply a comma-separated list of prerequisites, in the
+   rare case where your test depends on more than one:
+
+	test_expect_success PERL,PYTHON 'yo dawg' \
+	    ' test $(perl -E 'print eval "1 +" . qx[python -c "print 2"]') =3D=
=3D "4" '
+
  - test_expect_failure [<prereq>] <message> <script>
=20
    This is NOT the opposite of test_expect_success, but is used
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index f2c7336..2887677 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -73,6 +73,23 @@ then
 	exit 1
 fi
=20
+test_set_prereq HAVETHIS
+haveit=3Dno
+test_expect_success HAVETHIS,HAVEIT 'test runs if prerequisites are sa=
tisfied' '
+    test_have_prereq HAVEIT &&
+    test_have_prereq HAVETHIS &&
+    haveit=3Dyes
+'
+donthaveit=3Dyes
+test_expect_success HAVEIT,DONTHAVEIT 'unmet prerequisites causes test=
 to be skipped' '
+    donthaveit=3Dno
+'
+if test $haveit$donthaveit !=3D yesyes
+then
+	say "bug in test framework: multiple prerequisite tags do not work re=
liably"
+	exit 1
+fi
+
 clean=3Dno
 test_expect_success 'tests clean up after themselves' '
     test_when_finished clean=3Dyes
diff --git a/t/test-lib.sh b/t/test-lib.sh
index e8f21d5..8701923 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -327,12 +327,20 @@ test_set_prereq () {
 satisfied=3D" "
=20
 test_have_prereq () {
-	case $satisfied in
-	*" $1 "*)
-		: yes, have it ;;
-	*)
-		! : nope ;;
-	esac
+	# prerequisites can be concatenated with ','
+	save_IFS=3D$IFS
+	IFS=3D,
+	set -- $*
+	IFS=3D$save_IFS
+	for prerequisite
+	do
+		case $satisfied in
+		*" $prerequisite "*)
+			: yes, have it ;;
+		*)
+			! : nope ;;
+		esac
+	done
 }
=20
 # You are not expected to call test_ok_ and test_failure_ directly, us=
e
--=20
1.7.1
