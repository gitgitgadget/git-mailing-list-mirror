From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 02/73] gettext tests: add GETTEXT_POISON to simulate unfriendly translator
Date: Tue, 22 Feb 2011 23:41:21 +0000
Message-ID: <1298418152-27789-3-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:48:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1xU-0001bt-NH
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:47:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754717Ab1BVXnl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:43:41 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:39375 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754058Ab1BVXnc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:43:32 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866600bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=C7lJp+uRVG2Mw2hteuc9Vj54IcMuUvwGH9+gt9mRiTo=;
        b=f1I6lQwcot1/WU7eE+gZEsDo+FT8edx1INDcy2Ybiod69XPSR8jd/U1bCNXwvQu1RK
         a7ZzEI2QZczZLBJCFaPrmoR09ra7n50gwwh7CdHMm94fM7BdHzvH2YYEV4f4LaPFudLo
         heBM9GYbhrj3vl4M6H2B7Hgy45iyR3KfIhEtI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=AW0B82jxvIZcS2xneXsRseOuZJtqJi3F0fhhM4a3yeSuxhJUfOHVmH4chp5wqs5ccp
         nVpTyjX44E48hfpt8ZnmiR+7XXtNynBPj+HkQFiI+ucsy3HxbcNkfn4itwQbrtA4wX4r
         9GGtaTs2axY3nkUqfzEkD+zgcacdgHqCfQiA4=
Received: by 10.204.66.130 with SMTP id n2mr3058390bki.175.1298418212166;
        Tue, 22 Feb 2011 15:43:32 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.43.30
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:43:31 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167661>

Add a new GETTEXT_POISON compile-time parameter to make _(msg) always
return gibberish. So now you can run

	make GETTEXT_POISON=3DYesPlease

to get a copy of git that functions correctly (one hopes) but produces
output that is in nobody's native language at all.

This is a debugging aid for people who are working on the i18n part of
the system, to make sure that they are not marking plumbing messages
that should never be translated with _().

As new strings get marked for translation, naturally a number of tests
will be broken in this mode. Tests that depend on output from
Porcelain will need to be marked with the new C_LOCALE_OUTPUT test
prerequisite. Newly failing tests that do not depend on output from
Porcelain would be bugs due to messages that should not have been
marked for translation.

Note that the string we're using ("# GETTEXT POISON #") intentionally
starts the pound sign. Some of Git's tests such as
t3404-rebase-interactive.sh rely on interactive editing with a fake
editor, and will needlessly break if the message doesn't start with
something the interactive editor considers a comment.

A future patch will fix fix the underlying cause of that issue by
adding "#" characters to the commit advice automatically.

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
index 6949d73..3d7cf44 100644
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
+	return use_poison() ? "# GETTEXT POISON #" : msgid;
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
1.7.2.3
