From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/3] tests: let GETTEXT_POISON be disabled at run time
Date: Sun, 20 Feb 2011 22:05:17 -0600
Message-ID: <20110221040517.GE26968@elie>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
 <20110221040012.GB26968@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 05:05:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrN1t-0007hq-S1
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 05:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235Ab1BUEFc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Feb 2011 23:05:32 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38607 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932182Ab1BUEFV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Feb 2011 23:05:21 -0500
Received: by iyb26 with SMTP id 26so312426iyb.19
        for <git@vger.kernel.org>; Sun, 20 Feb 2011 20:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=KE3vctqBT/dJIL5prjGpWZDd6gfQ8OZzCTSXul3326w=;
        b=Iu+f9Zb7UHIIbsCg21bSlLSWNciqA3urmPKJzXo+R3zTMVcTRbdGUbC4+OmZ7vC+k/
         qWCDprjVDZCsBlRqkSAUXNK31M3Ap62YEexEjtZAs8jHL+ruMO8/8buO9Rl1YMLL7lXx
         BTInCJ4ZoVjwSFbWKt+ScEvdVLRpsZJB6Oab4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=eFLZtE5CBxNgWT+6E7YAf751T6dOv8uJOcgGeEoYE2KuMQBIfkbCCCg1MtXanprgam
         P0olEa4LBBltWW3jWY0pV85UHqI91/NSFAJ5wbA83CMYwqiqBYla3FXP9uUDUbOtjHZW
         sy3VEWKi8x56pr7F+xgkR02jB7zTN445+/nQg=
Received: by 10.231.182.10 with SMTP id ca10mr819159ibb.28.1298261121384;
        Sun, 20 Feb 2011 20:05:21 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.sbcglobal.net [69.209.53.52])
        by mx.google.com with ESMTPS id u9sm4745612ibe.20.2011.02.20.20.05.19
        (version=SSLv3 cipher=OTHER);
        Sun, 20 Feb 2011 20:05:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110221040012.GB26968@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167439>

Do not poison translations unless the GIT_GETTEXT_POISON environment
variable is set.  This way, a copy of git with GETTEXT_POISON set is
still generally usable and testers can avoid building two copies of
git to compare behavior with and without poison.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks again for your help.  Hopefully that turned out okay.  Please
feel free to ack or complain to indicate either way.

 Makefile      |    1 +
 gettext.c     |   14 ++++++++++++++
 gettext.h     |    2 +-
 t/test-lib.sh |    8 +++++++-
 4 files changed, 23 insertions(+), 2 deletions(-)
 create mode 100644 gettext.c

diff --git a/Makefile b/Makefile
index c348bb7..142ed86 100644
--- a/Makefile
+++ b/Makefile
@@ -1374,6 +1374,7 @@ ifdef NO_SYMLINK_HEAD
 	BASIC_CFLAGS +=3D -DNO_SYMLINK_HEAD
 endif
 ifdef GETTEXT_POISON
+	LIB_OBJS +=3D gettext.o
 	BASIC_CFLAGS +=3D -DGETTEXT_POISON
 endif
 ifdef NO_STRCASESTR
diff --git a/gettext.c b/gettext.c
new file mode 100644
index 0000000..9688c8b
--- /dev/null
+++ b/gettext.c
@@ -0,0 +1,14 @@
+/*
+ * Copyright (c) 2010 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
+ */
+
+#include "git-compat-util.h"
+#include "gettext.h"
+
+int use_poison(void)
+{
+	static int poison_requested =3D -1;
+	if (poison_requested =3D=3D -1)
+		poison_requested =3D getenv("GIT_GETTEXT_POISON") ? 1 : 0;
+	return poison_requested;
+}
diff --git a/gettext.h b/gettext.h
index 6daa57c..051bf11 100644
--- a/gettext.h
+++ b/gettext.h
@@ -16,7 +16,7 @@
 #define FORMAT_PRESERVING(n) __attribute__((format_arg(n)))
=20
 #ifdef GETTEXT_POISON
-#define use_poison() 1
+extern int use_poison(void);
 #else
 #define use_poison() 0
 #endif
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0840e4a..f4c1e04 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1080,7 +1080,13 @@ test -z "$NO_PERL" && test_set_prereq PERL
 test -z "$NO_PYTHON" && test_set_prereq PYTHON
=20
 # Can we rely on git's output in the C locale?
-test -z "$GETTEXT_POISON" && test_set_prereq C_LOCALE_OUTPUT
+if test -n "$GETTEXT_POISON"
+then
+	GIT_GETTEXT_POISON=3DYesPlease
+	export GIT_GETTEXT_POISON
+else
+	test_set_prereq C_LOCALE_OUTPUT
+fi
=20
 # test whether the filesystem supports symbolic links
 ln -s x y 2>/dev/null && test -h y 2>/dev/null && test_set_prereq SYML=
INKS
--=20
1.7.4.1
