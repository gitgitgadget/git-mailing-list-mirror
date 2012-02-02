From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH] i18n: do not define gettext/ngettext in NO_GETTEXT case
Date: Wed, 1 Feb 2012 18:20:53 -0600
Message-ID: <20120202002053.GD29599@burratino>
References: <1328019840-6168-1-git-send-email-pclouds@gmail.com>
 <1328100907-20397-1-git-send-email-pclouds@gmail.com>
 <20120201233515.GC29599@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Frederik Schwarzer <schwarzerf@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 01:21:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RskQO-0000G7-3W
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 01:21:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753462Ab2BBAVL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Feb 2012 19:21:11 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54753 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753310Ab2BBAVK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Feb 2012 19:21:10 -0500
Received: by iacb35 with SMTP id b35so2236305iac.19
        for <git@vger.kernel.org>; Wed, 01 Feb 2012 16:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dqtkyOcxP9mYBzBsLq/Yl6uaRirGd7xrcgAVeDsZKfg=;
        b=UaKZPPCBr0s7ipM+/cRZ1U207Jo/pqoIVA9BvvYbTQrocqsDcj4rlVhVkaAmlrRYAf
         qjJJSU/RmbUpUho+/ORh4Yc4f29YcVpQ2umFlUu/mx7ajQNflkl3RkMcQezEKsOp8C8H
         aAX5XwBhDVAR84J1mecugxZVL/TjBeDCPu/2A=
Received: by 10.50.222.132 with SMTP id qm4mr9700856igc.21.1328142069673;
        Wed, 01 Feb 2012 16:21:09 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ng9sm979239igc.3.2012.02.01.16.21.08
        (version=SSLv3 cipher=OTHER);
        Wed, 01 Feb 2012 16:21:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120201233515.GC29599@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189560>

gettext.h is responsible for defining the _ and  Q_ helpers which are
either simple stubs (in the NO_GETTEXT case) or synonyms for the
libintl functions used to translated git output.  As an implementation
artifact, ever since the !NO_GETTEXT case was implemented
(v1.7.9-rc0~42^2, 2011-11-18), they have also defined gettext and
ngettext macros in the NO_GETTEXT case:

	#ifdef gettext
	# undef gettext
	#endif
	#define gettext(x) (x)

New readers looking at this header might be tempted to use gettext and
ngettext directly, since they are defined in all cases, instead of
using the _ and Q_ wrappers which look like shortcuts.

However gettext and ngettext bypass the GETTEXT_POISON feature.  So
any code using them directly will produce perfectly sensible English
output when run in the test suite with GETTEXT_POISON set, instead of
the poison markers that normally would make it easy to catch output
intended for machines that has been marked for translation by mistake.

Avoid the temptation by _not_ providing fallback definitions for
gettext and ngettext ourselves.  This way, the header is less
misleading and code that uses gettext et al directly will fail to
compile when NO_GETTEXT is set so we can catch it early.

We also take the opportunity to avoid a little ifdef-ery by splitting
the NO_GETTEXT and !NO_GETTEXT implementations into different headers.
Unfortunately this involves some duplication of code.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jonathan Nieder wrote:

> This will be a problem with GETTEXT_POISON (except your patch bypasse=
s
> poison so it got missed --- will send a relevant fix as a reply).

Here's a rough patch to make that kind of thing easier to catch.  It
might make more sense to do

	#ifdef NO_GETTEXT
	#define git_gettext_(x) (x)
	#define git_ngettext_(msgid, plu, n) ...
	#else
	#define git_gettext_(x) gettext(x)
	#define git_ngettext_(msgid, plu, n) ngettext(msgid, plu, n)
	#endif

	static inline const char *_(const char *msgid)
	{
		return poisoning() ? "poison!" : git_gettext_(msgid);
	}
	...

but I didn't think of it until I had already written this patch.
Anyway, this way you get both approaches for easy comparison. ;-)

 Makefile          |    3 +++
 gettext-libintl.h |   26 ++++++++++++++++++++++++++
 gettext-noop.h    |   30 ++++++++++++++++++++++++++++++
 gettext.h         |   53 +++------------------------------------------=
--------
 git-compat-util.h |    6 ++++++
 5 files changed, 68 insertions(+), 50 deletions(-)
 create mode 100644 gettext-libintl.h
 create mode 100644 gettext-noop.h

diff --git a/Makefile b/Makefile
index c457c34f..83e8c0f1 100644
--- a/Makefile
+++ b/Makefile
@@ -1525,6 +1525,9 @@ endif
 ifdef NO_GETTEXT
 	BASIC_CFLAGS +=3D -DNO_GETTEXT
 	USE_GETTEXT_SCHEME ?=3D fallthrough
+	LIB_H +=3D gettext-noop.h
+else
+	LIB_H +=3D gettext-libintl.h
 endif
 ifdef NO_STRCASESTR
 	COMPAT_CFLAGS +=3D -DNO_STRCASESTR
diff --git a/gettext-libintl.h b/gettext-libintl.h
new file mode 100644
index 00000000..c9199703
--- /dev/null
+++ b/gettext-libintl.h
@@ -0,0 +1,26 @@
+#ifndef GETTEXT_LIBINTL_H
+#define GETTEXT_LIBINTL_H
+
+#include <libintl.h>
+
+#define FORMAT_PRESERVING(n) __attribute__((format_arg(n)))
+
+extern void git_setup_gettext(void);
+
+static inline FORMAT_PRESERVING(1) const char *_(const char *msgid)
+{
+	return use_gettext_poison() ? "# GETTEXT POISON #" : gettext(msgid);
+}
+
+static inline FORMAT_PRESERVING(1) FORMAT_PRESERVING(2)
+const char *Q_(const char *msgid, const char *plu, unsigned long n)
+{
+	if (use_gettext_poison())
+		return "# GETTEXT POISON #";
+	return ngettext(msgid, plu, n);
+}
+
+/* Mark msgid for translation but do not translate it. */
+#define N_(msgid) msgid
+
+#endif
diff --git a/gettext-noop.h b/gettext-noop.h
new file mode 100644
index 00000000..28843a61
--- /dev/null
+++ b/gettext-noop.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright (c) 2010-2011 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
+ *
+ * This is a skeleton no-op implementation of gettext for Git.
+ */
+
+#ifndef GETTEXT_NOOP_H
+#define GETTEXT_NOOP_H
+
+#define FORMAT_PRESERVING(n) __attribute__((format_arg(n)))
+
+static inline void git_setup_gettext(void) { }
+
+static inline FORMAT_PRESERVING(1) const char *_(const char *msgid)
+{
+	return use_gettext_poison() ? "# GETTEXT POISON #" : msgid;
+}
+
+static inline FORMAT_PRESERVING(1) FORMAT_PRESERVING(2)
+const char *Q_(const char *msgid, const char *plu, unsigned long n)
+{
+	if (use_gettext_poison())
+		return "# GETTEXT POISON #";
+	return n =3D=3D 1 ? msgid : plu;
+}
+
+/* Mark msgid for translation but do not translate it. */
+#define N_(msgid) msgid
+
+#endif
diff --git a/gettext.h b/gettext.h
index 57ba8bb0..9bc67243 100644
--- a/gettext.h
+++ b/gettext.h
@@ -1,11 +1,3 @@
-/*
- * Copyright (c) 2010-2011 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
- *
- * This is a skeleton no-op implementation of gettext for Git.
- * You can replace it with something that uses libintl.h and wraps
- * gettext() to try out the translations.
- */
-
 #ifndef GETTEXT_H
 #define GETTEXT_H
=20
@@ -13,49 +5,10 @@
 #error "namespace conflict: '_' or 'Q_' is pre-defined?"
 #endif
=20
-#ifndef NO_GETTEXT
-#	include <libintl.h>
+#ifdef NO_GETTEXT
+#include "gettext-noop.h"
 #else
-#	ifdef gettext
-#		undef gettext
-#	endif
-#	define gettext(s) (s)
-#	ifdef ngettext
-#		undef ngettext
-#	endif
-#	define ngettext(s, p, n) ((n =3D=3D 1) ? (s) : (p))
+#include "gettext-libintl.h"
 #endif
=20
-#define FORMAT_PRESERVING(n) __attribute__((format_arg(n)))
-
-#ifndef NO_GETTEXT
-extern void git_setup_gettext(void);
-#else
-static inline void git_setup_gettext(void)
-{
-}
-#endif
-
-#ifdef GETTEXT_POISON
-extern int use_gettext_poison(void);
-#else
-#define use_gettext_poison() 0
-#endif
-
-static inline FORMAT_PRESERVING(1) const char *_(const char *msgid)
-{
-	return use_gettext_poison() ? "# GETTEXT POISON #" : gettext(msgid);
-}
-
-static inline FORMAT_PRESERVING(1) FORMAT_PRESERVING(2)
-const char *Q_(const char *msgid, const char *plu, unsigned long n)
-{
-	if (use_gettext_poison())
-		return "# GETTEXT POISON #";
-	return ngettext(msgid, plu, n);
-}
-
-/* Mark msgid for translation but do not translate it. */
-#define N_(msgid) msgid
-
 #endif
diff --git a/git-compat-util.h b/git-compat-util.h
index 8f3972cd..ca4a4f19 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -236,6 +236,12 @@ extern char *gitbasename(char *);
 #endif
 #endif
=20
+#ifdef GETTEXT_POISON
+extern int use_gettext_poison(void);
+#else
+#define use_gettext_poison() 0
+#endif
+
 #include "compat/bswap.h"
=20
 /* General helper functions */
--=20
1.7.9
