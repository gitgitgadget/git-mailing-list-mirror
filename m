From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] date: recognize bogus FreeBSD gmtime output
Date: Tue, 1 Apr 2014 03:42:51 -0400
Message-ID: <20140401074251.GA22550@sigill.intra.peff.net>
References: <20140401073848.GA22023@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Charles Bailey <cbailey32@bloomberg.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 09:43:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUtLW-0007wT-RZ
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 09:42:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbaDAHmy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Apr 2014 03:42:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:51544 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751000AbaDAHmx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 03:42:53 -0400
Received: (qmail 11113 invoked by uid 102); 1 Apr 2014 07:42:53 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 Apr 2014 02:42:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Apr 2014 03:42:51 -0400
Content-Disposition: inline
In-Reply-To: <20140401073848.GA22023@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245573>

Most gmtime implementations return a NULL value when they
encounter an error (and this behavior is specified by ANSI C
and POSIX).  FreeBSD's implementation, however, will
indicate an error by returning a pointer to a "struct tm"
with all fields set to zero. Let's also recognize this and
convert it to a NULL (with this patch, t4212 should pass on
=46reeBSD).

Reported-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
Signed-off-by: Jeff King <peff@peff.net>
---
There are actually a few callers to gmtime and gmtime_r, so I pushed
this fix up into a compat wrapper rather than in time_to_tm to get them
all. It's possible that localtime() would want to receive the same
treatment, too.  It's not strictly necessary to make the wrapper
conditional, but it was easy to do so. We could also just run this code
all the time.

I don't have a FreeBSD VM handy to test this, so confirmation that it
passes the test would be nice.

 Makefile          |  8 ++++++++
 compat/gmtime.c   | 26 ++++++++++++++++++++++++++
 config.mak.uname  |  1 +
 git-compat-util.h |  7 +++++++
 4 files changed, 42 insertions(+)
 create mode 100644 compat/gmtime.c

diff --git a/Makefile b/Makefile
index 3646391..2f3758c 100644
--- a/Makefile
+++ b/Makefile
@@ -338,6 +338,9 @@ all::
 # Define TEST_GIT_INDEX_VERSION to 2, 3 or 4 to run the test suite
 # with a different indexfile format version.  If it isn't set the inde=
x
 # file format used is index-v[23].
+#
+# Define GMTIME_UNRELIABLE_ERRORS if your gmtime() function does not
+# return NULL when it receives a bogus time_t.
=20
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -1489,6 +1492,11 @@ ifneq (,$(XDL_FAST_HASH))
 	BASIC_CFLAGS +=3D -DXDL_FAST_HASH
 endif
=20
+ifdef GMTIME_UNRELIABLE_ERRORS
+	COMPAT_OBJS +=3D compat/gmtime.o
+	BASIC_CFLAGS +=3D -DGMTIME_UNRELIABLE_ERRORS
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK =3D NoThanks
 endif
diff --git a/compat/gmtime.c b/compat/gmtime.c
new file mode 100644
index 0000000..ffcabf4
--- /dev/null
+++ b/compat/gmtime.c
@@ -0,0 +1,26 @@
+#include "../git-compat-util.h"
+#undef gmtime
+#undef gmtime_r
+
+struct tm *git_gmtime(const time_t *timep)
+{
+	static struct tm result;
+	return git_gmtime_r(timep, &result);
+}
+
+struct tm *git_gmtime_r(const time_t *timep, struct tm *result)
+{
+	struct tm *ret;
+
+	ret =3D gmtime_r(timep, result);
+
+	/*
+	 * Rather than NULL, FreeBSD gmtime will return a "struct tm" with al=
l
+	 * fields zeroed. Since "mday" cannot otherwise be zero, we can test
+	 * this very quickly.
+	 */
+	if (ret && !ret->tm_mday)
+		ret =3D NULL;
+
+	return ret;
+}
diff --git a/config.mak.uname b/config.mak.uname
index 6069a44..0e22ac0 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -187,6 +187,7 @@ ifeq ($(uname_S),FreeBSD)
 	endif
 	PYTHON_PATH =3D /usr/local/bin/python
 	HAVE_PATHS_H =3D YesPlease
+	GMTIME_UNRELIABLE_ERRORS =3D UnfortunatelyYes
 endif
 ifeq ($(uname_S),OpenBSD)
 	NO_STRCASESTR =3D YesPlease
diff --git a/git-compat-util.h b/git-compat-util.h
index 892032b..5191866 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -716,4 +716,11 @@ void warn_on_inaccessible(const char *path);
 /* Get the passwd entry for the UID of the current process. */
 struct passwd *xgetpwuid_self(void);
=20
+#ifdef GMTIME_UNRELIABLE_ERRORS
+struct tm *git_gmtime(const time_t *);
+struct tm *git_gmtime_r(const time_t *, struct tm *);
+#define gmtime git_gmtime
+#define gmtime_r git_gmtime_r
+#endif
+
 #endif
--=20
1.9.1.656.ge8a0637
