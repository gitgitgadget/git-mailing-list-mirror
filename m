From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 02/15] tests: add GETTEXT_POISON to simulate unfriendly
 translator
Date: Mon, 21 Feb 2011 04:13:52 -0600
Message-ID: <20110221101352.GC32137@elie>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
 <20110221040012.GB26968@elie>
 <20110221101229.GA32137@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 11:17:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrSpI-0001gf-4P
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 11:17:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754871Ab1BUKRD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Feb 2011 05:17:03 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51832 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753889Ab1BUKRA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Feb 2011 05:17:00 -0500
Received: by iyb26 with SMTP id 26so556307iyb.19
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 02:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=bI7Ih1KM3FGPIbrBzXxwZIInEm8N+zTwoH6bn/Q5uwM=;
        b=oRWwKQRGTivV5NWVdku1gZRD8HnNLpJphp4jtDat9rppvPxLbvea27auGlXn/cDfdH
         mA6WALU3SBuK/N177qWf34rJLRShz2ZAI7IAv3UlzPF6HcpwR3fBme3A7xLkI3gemmNm
         ujKgX07E6SqRPlqMQVpYI9VpBrewVtCYk93H4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=OIbqsHOzU6i7da7RgUOQ11MoVG1ZF+pR2LtL8tOreNNtBMJtf9MwC2ecSHS7ot7JZ5
         UQcvNsmtACtbjH5U89bXn8SP8PRLSoY8FjU+UXGrD+XsKwbU5AyHExoiS0FiUQR//a2C
         B0eIvow2ALm2LLyOfAoDEwQk9HReB3xP5nMAc=
Received: by 10.42.223.198 with SMTP id il6mr1699468icb.284.1298283237855;
        Mon, 21 Feb 2011 02:13:57 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.sbcglobal.net [69.209.53.52])
        by mx.google.com with ESMTPS id gy41sm970684ibb.11.2011.02.21.02.13.56
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Feb 2011 02:13:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110221101229.GA32137@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167458>

=46rom: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

Add a new GETTEXT_POISON compile-time parameter to make _(msg) always
return gibberish.  So now you can run

	make GETTEXT_POISON=3DYesPlease

to get a copy of git that functions correctly (one hopes) but produces
output that is in nobody's native language at all.

This is a debugging aid for people who are working on the i18n part of
the system, to make sure that they are not marking plumbing messages
that should never be translated with _().

As new strings get marked for translation, naturally a number of tests
will be broken in this mode.  Tests that depend on output from
Porcelain will need to be marked with the new C_LOCALE_OUTPUT test
prerequisite.  Newly failing tests that do not depend on output from
Porcelain would be bugs due to messages that should not have been
marked for translation.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile      |    7 +++++++
 gettext.h     |    8 +++++++-
 t/test-lib.sh |    3 +++
 3 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index c153f45..c348bb7 100644
--- a/Makefile
+++ b/Makefile
@@ -216,6 +216,9 @@ all::
 #
 # Define NO_REGEX if you have no or inferior regex support in your C l=
ibrary.
 #
+# Define GETTEXT_POISON if you are debugging the choice of strings mar=
ked
+# for translation.  This will turn all strings that use gettext into g=
ibberish.
+#
 # Define JSMIN to point to JavaScript minifier that functions as
 # a filter to have gitweb.js minified.
 #
@@ -1370,6 +1373,9 @@ endif
 ifdef NO_SYMLINK_HEAD
 	BASIC_CFLAGS +=3D -DNO_SYMLINK_HEAD
 endif
+ifdef GETTEXT_POISON
+	BASIC_CFLAGS +=3D -DGETTEXT_POISON
+endif
 ifdef NO_STRCASESTR
 	COMPAT_CFLAGS +=3D -DNO_STRCASESTR
 	COMPAT_OBJS +=3D compat/strcasestr.o
@@ -2089,6 +2095,7 @@ endif
 ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
 	@echo GIT_TEST_CMP_USE_COPIED_CONTEXT=3DYesPlease >>$@
 endif
+	@echo GETTEXT_POISON=3D\''$(subst ','\'',$(subst ','\'',$(GETTEXT_POI=
SON)))'\' >>$@
=20
 ### Detect Tck/Tk interpreter path changes
 ifndef NO_TCLTK
diff --git a/gettext.h b/gettext.h
index dc44825..68e3a19 100644
--- a/gettext.h
+++ b/gettext.h
@@ -15,9 +15,15 @@
=20
 #define FORMAT_PRESERVING(n) __attribute__((format_arg(n)))
=20
+#ifdef GETTEXT_POISON
+#define use_poison() 1
+#else
+#define use_poison() 0
+#endif
+
 static inline FORMAT_PRESERVING(1) const char *_(const char *msgid)
 {
-	return msgid;
+	return use_poison() ? "Malkovich" : msgid;
 }
=20
 /* Mark msgid for translation but do not translate it. */
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0fdc541..0840e4a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1079,6 +1079,9 @@ esac
 test -z "$NO_PERL" && test_set_prereq PERL
 test -z "$NO_PYTHON" && test_set_prereq PYTHON
=20
+# Can we rely on git's output in the C locale?
+test -z "$GETTEXT_POISON" && test_set_prereq C_LOCALE_OUTPUT
+
 # test whether the filesystem supports symbolic links
 ln -s x y 2>/dev/null && test -h y 2>/dev/null && test_set_prereq SYML=
INKS
 rm -f y
--=20
1.7.4.1
