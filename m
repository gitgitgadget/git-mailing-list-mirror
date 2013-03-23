From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [RFC] test-lib.sh: No POSIXPERM for cygwin
Date: Sat, 23 Mar 2013 13:40:29 +0100
Message-ID: <201303231340.29687.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: j6t@kdbg.org, git@vger.kernel.org, ramsay@ramsay1.demon.co.uk,
	tboegi@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 23 13:41:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJNkw-00073D-H8
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 13:41:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836Ab3CWMkj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Mar 2013 08:40:39 -0400
Received: from mout.web.de ([212.227.15.4]:60731 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750729Ab3CWMkh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Mar 2013 08:40:37 -0400
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb003) with
 ESMTPA (Nemesis) id 0MJTYJ-1UHSsD1NBD-002fkS; Sat, 23 Mar 2013 13:40:34 +0100
X-Provags-ID: V02:K0:7Sk91jNui5KzG7uAYLq45KXqQ1ECnXGIkFzBLMuj1XE
 RocDTGODqqRKq4932CAPuPNHwtP9ZgDd5eaTMUKggNk0RThc+m
 X9mfVKC6HpLKrVjJTuSHfgmtF0Rrba9/JqNFDBvVJ6Ex0IF6xg
 zfkaSO+gWmxYfl0Tir7VpfyGNKIyw81jsllipg76sUJfoRkIWv
 QkSOJf2Cjb9JcO0rXdc6g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218910>

On 19.03.13 22:03, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>> Use a compile switch IGNORECYGWINFSTRICKS to disable the usage
>> of cygwin_lstat_fn() only in path.c
>=20
> The analysis of the problem and the basic idea to disable the
> fast-but-lying fstricks in the code that matters may be good, but
> the implementation is questionable.
>=20
> What if we later need to move functions around, etc., so that some
> other calls in path.c still do want to use the fstricks bit while
> the existing ones in the file want the real lstat() information?
>=20
> Actually, that already is the case.  The call to lstat() in
> validate_headref() only cares about the S_ISXXX() type and can
> afford to use the fast-and-lying one, no?
>=20
> How about doing something like this in the generic codepath, and
> implement your own cygwin_true_mode_bits() function at the cygwin
> compatibility layer, and add
>=20
>     #define true_mode_bits cygwin_true_mode_bits
>=20
> in the compat/cygwin.h file?  The change has the documentation value
> to clarify what each lstat() is used for, too.
>=20
> Ideally, the "#ifndef true_mode_bits" part may want to become a
> generic helper function if there are lstat() calls in other files
> that cygwin wants to use the real lstat() not the fast-but-lying
> one, but one step at a time.
>=20
> Hrm?
>=20
>  path.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>=20
> diff --git a/path.c b/path.c
> index d3d3f8b..d0b31e5 100644
> --- a/path.c
> +++ b/path.c
> @@ -14,6 +14,21 @@
>  #include "strbuf.h"
>  #include "string-list.h"
> =20
> +#ifndef true_mode_bits
> +/*
> + * The replacement lstat(2) we use on Cygwin is incomplete and
> + * lies about permission bits; most of the time we do not care,
> + * but the callsites of this wrpper do care.
> + */
> +static int true_mode_bits(const char *path, int *mode)
> +{
> +	struct stat st;
> +	if (lstat(path, &st) < 0)
> +		return -1;
> +	return st.st_mode;
> +}
> +#endif
> +
>  static char bad_path[] =3D "/bad-path/";
> =20
>  static char *get_pathname(void)
> @@ -400,9 +415,8 @@ int set_shared_perm(const char *path, int mode)
>  		return 0;
>  	}
>  	if (!mode) {
> -		if (lstat(path, &st) < 0)
> +		if (true_mode_bits(path, &mode) < 0)
>  			return -1;
> -		mode =3D st.st_mode;
>  		orig_mode =3D mode;
>  	} else
>  		orig_mode =3D 0;
>=20
Thanks for review, I Changed the function name into get_st_mode_bits(),
but that is only a suggestion.

-- >8 --
Subject: [PATCH] Make core.sharedRepository work under cygwin 1.7

When core.sharedRepository is used, set_shared_perm() in path.c
needs lstat() to return the correct POSIX permissions.

The default for cygwin is core.ignoreCygwinFSTricks =3D false, which
means that the fast implementation in do_stat() is used instead of lsta=
t().

lstat() under cygwin uses the Windows security model to implement
POSIX-like permissions.
The user, group or everyone bits can be set individually.

do_stat() simplifes the file permission bits, and may return a wrong va=
lue:
The read-only attribute of a file is used to calculate
the permissions, resulting in either rw-r--r-- or r--r--r--

One effect of the simplified do_stat() is that t1301 failes.

Add a function cygwin_get_st_mode_bits() which returns the POSIX permis=
sions.
When not compiling for cygwin, true_mode_bits() in path.c is used.

Side note:
t1301 passes under cygwin 1.5.
The "user write" bit is synchronized with the "read only" attribute of =
a file:

$ chmod 444 x
$ attrib x
A    R     C:\temp\pt\x

cygwin 1.7 would show
A          C:\temp\pt\x

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 compat/cygwin.c   | 13 +++++++++++++
 compat/cygwin.h   |  5 +++++
 git-compat-util.h |  1 +
 path.c            | 20 +++++++++++++++++---
 4 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/compat/cygwin.c b/compat/cygwin.c
index 5428858..871b41d 100644
--- a/compat/cygwin.c
+++ b/compat/cygwin.c
@@ -1,3 +1,4 @@
+#define CYGWIN_C
 #define WIN32_LEAN_AND_MEAN
 #ifdef CYGWIN_V15_WIN32API
 #include "../git-compat-util.h"
@@ -10,6 +11,18 @@
 #endif
 #include "../cache.h" /* to read configuration */
=20
+/*
+ * Return POSIX permission bits, regardless of core.ignorecygwinfstric=
ks
+ */
+int cygwin_get_st_mode_bits(const char *path, int *mode)
+{
+	struct stat st;
+	if (lstat(path, &st) < 0)
+		return -1;
+	*mode =3D st.st_mode;
+	return 0;
+}
+
 static inline void filetime_to_timespec(const FILETIME *ft, struct tim=
espec *ts)
 {
 	long long winTime =3D ((long long)ft->dwHighDateTime << 32) +
diff --git a/compat/cygwin.h b/compat/cygwin.h
index a3229f5..c04965a 100644
--- a/compat/cygwin.h
+++ b/compat/cygwin.h
@@ -4,6 +4,11 @@
 typedef int (*stat_fn_t)(const char*, struct stat*);
 extern stat_fn_t cygwin_stat_fn;
 extern stat_fn_t cygwin_lstat_fn;
+int cygwin_get_st_mode_bits(const char *path, int *mode);
=20
+#define get_st_mode_bits(p,m) cygwin_get_st_mode_bits((p),(m))
+#ifndef CYGWIN_C
+/* cygwin.c needs the original lstat() */
 #define stat(path, buf) (*cygwin_stat_fn)(path, buf)
 #define lstat(path, buf) (*cygwin_lstat_fn)(path, buf)
+#endif
diff --git a/git-compat-util.h b/git-compat-util.h
index b7eaaa9..04a67ad 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -160,6 +160,7 @@
 typedef long intptr_t;
 typedef unsigned long uintptr_t;
 #endif
+int get_st_mode_bits(const char *path, int *mode);
 #if defined(__CYGWIN__)
 #undef _XOPEN_SOURCE
 #include <grp.h>
diff --git a/path.c b/path.c
index d3d3f8b..2fdccc2 100644
--- a/path.c
+++ b/path.c
@@ -14,6 +14,22 @@
 #include "strbuf.h"
 #include "string-list.h"
=20
+#ifndef get_st_mode_bits
+/*
+ * The replacement lstat(2) we use on Cygwin is incomplete and
+ * may return wrong permission bits. Most of the time we do not care,
+ * but the callsites of this wrapper do care.
+ */
+int get_st_mode_bits(const char *path, int *mode)
+{
+	struct stat st;
+	if (lstat(path, &st) < 0)
+		return -1;
+	*mode =3D st.st_mode;
+	return 0;
+}
+#endif
+
 static char bad_path[] =3D "/bad-path/";
=20
 static char *get_pathname(void)
@@ -391,7 +407,6 @@ const char *enter_repo(const char *path, int strict=
)
=20
 int set_shared_perm(const char *path, int mode)
 {
-	struct stat st;
 	int tweak, shared, orig_mode;
=20
 	if (!shared_repository) {
@@ -400,9 +415,8 @@ int set_shared_perm(const char *path, int mode)
 		return 0;
 	}
 	if (!mode) {
-		if (lstat(path, &st) < 0)
+		if (get_st_mode_bits(path, &mode) < 0)
 			return -1;
-		mode =3D st.st_mode;
 		orig_mode =3D mode;
 	} else
 		orig_mode =3D 0;
--=20
1.8.2.341.g543621f
