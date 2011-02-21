From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 03/15] i18n: do not poison translations unless
 GIT_GETTEXT_POISON envvar is set
Date: Mon, 21 Feb 2011 04:14:17 -0600
Message-ID: <20110221101417.GD32137@elie>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
 <20110221040012.GB26968@elie>
 <20110221101229.GA32137@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 11:17:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrSpy-0001yu-MO
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 11:17:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754873Ab1BUKRq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Feb 2011 05:17:46 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45892 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753884Ab1BUKRp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Feb 2011 05:17:45 -0500
Received: by iyb26 with SMTP id 26so556870iyb.19
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 02:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=IBcQcpZ8lEOTN3bua/OD1dsYYwxlMAlUQziWQnkZNCk=;
        b=YvnwfvMtgUkPRABMeFDyk8Jwvs35/5IziylH+A2QTlePwIAS3v4z1eBSGEQPPCmPKY
         KsQLpoZ1L8BPUx8kWEfYCnBN4lJSzrjz7AZ/JSO/YETbjVdSm0qauZDd47JaFlwrbJel
         FNk93abuvkXQlWabG7LZ9SlHSWXwfLpg0/t1E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=yDOclN5llw5tUPtw+vyCv07aaeAEwXQvQgGXP12NpBbl55ZyNRXRw/KOzvFhSOE9jk
         kH3ZhdeVgXyI+ERR0o02EteTRQ30EdpLK5ZWQmk3MetK5h8C5NeqLIVseqzCJytbFfmW
         n8P165ysu4Vv9FnENw5YQvI0m2nbzuRFXdPq4=
Received: by 10.42.137.74 with SMTP id x10mr1675589ict.452.1298283261948;
        Mon, 21 Feb 2011 02:14:21 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.sbcglobal.net [69.209.53.52])
        by mx.google.com with ESMTPS id 8sm5059191iba.22.2011.02.21.02.14.20
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Feb 2011 02:14:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110221101229.GA32137@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167459>

Tweak the GETTEXT_POISON facility so it is activated at run time
instead of compile time.  If the GIT_GETTEXT_POISON environment
variable is set, _(msg) will result in gibberish as before; but if the
GIT_GETTEXT_POISON variable is not set, it will return the message for
human-readable output.  So the behavior of mistranslated and
untranslated git can be compared without rebuilding git in between.

=46or simplicity we always set the GIT_GETTEXT_POISON variable in tests=
=2E

This does not affect builds without the GETTEXT_POISON compile-time
option set, so non-i18n git will not be slowed down.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile      |    5 ++++-
 gettext.c     |   14 ++++++++++++++
 gettext.h     |    2 +-
 t/test-lib.sh |    8 +++++++-
 4 files changed, 26 insertions(+), 3 deletions(-)
 create mode 100644 gettext.c

diff --git a/Makefile b/Makefile
index c348bb7..4e9d935 100644
--- a/Makefile
+++ b/Makefile
@@ -217,7 +217,9 @@ all::
 # Define NO_REGEX if you have no or inferior regex support in your C l=
ibrary.
 #
 # Define GETTEXT_POISON if you are debugging the choice of strings mar=
ked
-# for translation.  This will turn all strings that use gettext into g=
ibberish.
+# for translation.  In a GETTEXT_POISON build, you can turn all string=
s marked
+# for translation into gibberish by setting the GIT_GETTEXT_POISON var=
iable
+# (to any value) in your environment.
 #
 # Define JSMIN to point to JavaScript minifier that functions as
 # a filter to have gitweb.js minified.
@@ -1374,6 +1376,7 @@ ifdef NO_SYMLINK_HEAD
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
index 68e3a19..4d2338b 100644
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
