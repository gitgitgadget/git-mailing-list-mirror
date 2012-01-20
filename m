From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=5D=20git-sh-i18n=3A=20detect=20and=20avoid=20broken=20gettext=281=29=20implementation?=
Date: Fri, 20 Jan 2012 12:49:35 +0000
Message-ID: <1327063775-28420-1-git-send-email-avarab@gmail.com>
References: <CALxABCZWBtgX736Acoy-CCAz8RJb0EKnHf+7g72dOdVS+BOhSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 20 13:49:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoDui-0003qY-2S
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 13:49:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853Ab2ATMtr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Jan 2012 07:49:47 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:34216 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950Ab2ATMtq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 07:49:46 -0500
Received: by wics10 with SMTP id s10so364115wic.19
        for <git@vger.kernel.org>; Fri, 20 Jan 2012 04:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Fg4scEb+Qo9iAInJQf/3Z5zRyo4QHodOht3ZJ8uRU4A=;
        b=snwACtPWj7/pIPDl682TYrd6u+TiQXkyiKWKIiC7QeR5p4XTEGEDYtckGFFkjTYh1A
         VFIU+TS/CW/ZU9bKcwA7z5wLxxw0iaBx9cNLmfsT+eGe7HIwJ15BK+m0BQfKcVxYiWNW
         yIqHfJHp9OVIcSbkCSO+HlfjrX6bobG823NAw=
Received: by 10.180.99.100 with SMTP id ep4mr8555368wib.7.1327063785608;
        Fri, 20 Jan 2012 04:49:45 -0800 (PST)
Received: from w.nix.is (w.nix.is. [188.40.98.140])
        by mx.google.com with ESMTPS id fy5sm8738177wib.7.2012.01.20.04.49.44
        (version=SSLv3 cipher=OTHER);
        Fri, 20 Jan 2012 04:49:45 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <CALxABCZWBtgX736Acoy-CCAz8RJb0EKnHf+7g72dOdVS+BOhSw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188874>

Even though we can load gettext.sh the gettext(1) and eval_gettext
functions it provides might be completely broken. This reportedly
happens on some Cygwin installations where we can load gettext.sh, but
gettext and eval_gettext both return exit code 127 and no output.

The reason we're trying to load gettext.sh (or the equivalent Solaris
implementation) at all is so we don't have to provide our own fallback
implementation if the OS already has one installed, but because we
didn't test whether it actually worked under GNU gettext we might end
up with broken functions.

Change the detection in git-sh-i18n so that it tests that the output
of "gettext test" produces "test", on Solaris we already test that
"gettext -h" produces "-h", so we were already guarded against the
same sort of failure there.

Reported-by: Alex Riesen <raa.lkml@gmail.com>
---
Here's a minimal patch to git-sh-i18n that should make things work on
Cygwin and any other platforms with broken gettext functions while
also using the OS-provided functions if they work.

I've added a new t0201-gettext-fallbacks-broken-gettext.sh test that
tests this. This required a small change in lib-gettext.sh so I
wouldn't load test-lib.sh twice.

Note that there's already a t0201* test in the repo. Maybe we want to
increment all the gettext test numbers by one to make room for it?

As an aside I'm really not a big fan of having hardcoded numbers in
the test files like this. We don't care about the order of execution
here.

 git-sh-i18n.sh                              |    2 +-
 t/lib-gettext.sh                            |    7 +++++-
 t/t0201-gettext-fallbacks-broken-gettext.sh |   28 +++++++++++++++++++=
++++++++
 3 files changed, 35 insertions(+), 2 deletions(-)
 create mode 100755 t/t0201-gettext-fallbacks-broken-gettext.sh

diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
index b4575fb..26a57b0 100644
--- a/git-sh-i18n.sh
+++ b/git-sh-i18n.sh
@@ -18,7 +18,7 @@ export TEXTDOMAINDIR
=20
 if test -z "$GIT_GETTEXT_POISON"
 then
-	if test -z "$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS" && type gettext.sh =
>/dev/null 2>&1
+	if test -z "$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS" && type gettext.sh =
>/dev/null 2>&1 && test "$(gettext test 2>&1)" =3D "test"
 	then
 		# This is GNU libintl's gettext.sh, we don't need to do anything
 		# else than setting up the environment and loading gettext.sh
diff --git a/t/lib-gettext.sh b/t/lib-gettext.sh
index 0f76f6c..2c5b758 100644
--- a/t/lib-gettext.sh
+++ b/t/lib-gettext.sh
@@ -3,7 +3,12 @@
 # Copyright (c) 2010 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
 #
=20
-. ./test-lib.sh
+if test -z "$TEST_DIRECTORY"
+then
+	# In case the test loaded test-lib.sh by itself to do some tests
+	# prior to loading us.
+	. ./test-lib.sh
+fi
=20
 GIT_TEXTDOMAINDIR=3D"$GIT_BUILD_DIR/po/build/locale"
 GIT_PO_PATH=3D"$GIT_BUILD_DIR/po"
diff --git a/t/t0201-gettext-fallbacks-broken-gettext.sh b/t/t0201-gett=
ext-fallbacks-broken-gettext.sh
new file mode 100755
index 0000000..92b95ae
--- /dev/null
+++ b/t/t0201-gettext-fallbacks-broken-gettext.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+#
+# Copyright (c) 2012 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
+#
+
+test_description=3D'Gettext Shell fallbacks with broken gettext'
+
+. ./test-lib.sh
+
+test_expect_success 'set up a fake broken gettext(1)' '
+	cat >gettext <<-\EOF &&
+	#!/bin/sh
+	exit 1
+	EOF
+	chmod +x gettext &&
+    ! ./gettext
+'
+
+PATH=3D.:$PATH
+. "$TEST_DIRECTORY"/lib-gettext.sh
+
+test_expect_success C_LOCALE_OUTPUT '$GIT_INTERNAL_GETTEXT_SH_SCHEME" =
is fallthrough with broken gettext(1)' '
+    echo fallthrough >expect &&
+    echo $GIT_INTERNAL_GETTEXT_SH_SCHEME >actual &&
+    test_cmp expect actual
+'
+
+test_done
--=20
1.7.7.3
