From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=20v4=2003/73=5D=20gettext=3A=20do=20not=20poison=20translations=20unless=20GIT=5FGETTEXT=5FPOISON=20envvar=20is=20set?=
Date: Tue, 22 Feb 2011 23:41:22 +0000
Message-ID: <1298418152-27789-4-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:43:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1tR-0007sP-Ey
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:43:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754580Ab1BVXnf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:43:35 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:39209 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754539Ab1BVXnd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:43:33 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866615bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=CqBlk6EtVrXnX/P65V3fXpbc5Z5WFKjkwcpdSOQQAc0=;
        b=v4Ecp+Suu2+1C7FZZOO/wLlENuaW2bh0ks8wo1UqCO8D9hPlhlPYGSW8wayCzVOS1m
         ni/PB1ZZXbfWlJlhu4G9jpdRECZmL/R54NuEa3FVgwEFn3TvheRA8oawNOsl8B5y2+ZU
         GfAxMcWalFg4peQhsYEASkfvpg7SpnM9g3+jw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=WzdZFQHz6cDXViHoDvlGMhWeePE+tLijQova5Zw6aPIfbfLUVyn26FhTBERkoX8L+t
         uAQNtZOBBYcixxdmVr++IjBJeqDMBFhqzOUpp2dLctR//RylqQsySb69zops2v2dYd+9
         quUzMMEIP0ZMIB2WqtH0mfIaxNkgtVLR8rIHE=
Received: by 10.204.123.140 with SMTP id p12mr3104471bkr.176.1298418212918;
        Tue, 22 Feb 2011 15:43:32 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.43.32
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:43:32 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167590>

=46rom: Jonathan Nieder <jrnieder@gmail.com>

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
index 3d7cf44..ee7d41d 100644
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
1.7.2.3
