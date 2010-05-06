From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC] Hacky version of a glob() driven config include
Date: Thu,  6 May 2010 21:14:00 +0000
Message-ID: <1273180440-8641-1-git-send-email-avarab@gmail.com>
References: <u2i51dd1af81004060115t5f837840z5adcf83622fa8882@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eli Barzilay <eli@barzilay.org>, Heiko Voigt <hvoigt@hvoigt.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 06 23:14:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OA8P9-0000Cr-UU
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 23:14:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705Ab0EFVOQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 May 2010 17:14:16 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:51753 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078Ab0EFVOO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 17:14:14 -0400
Received: by fg-out-1718.google.com with SMTP id d23so529118fga.1
        for <git@vger.kernel.org>; Thu, 06 May 2010 14:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=xR84Yb8wI97yT+ZMydH5iN5ppmpZE4ItACUrtduVBFo=;
        b=Y+2SxGanUexY8CmX4OIfFBK1I5zcuow2faahWUuKlj8ZdsCEdZUsqlFGws8BF8GvSf
         TjnW4h6wfhUF1dEcrAWq96cooZE1dL+vFq0x+uBtgrYE8MSrFlZ7AM1dXQYuq7QN0CIH
         UXdIZIu897J1Kxl8wjKwONph/FlDh9F44abxo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=j0S+ZNArcSemoW0aigpjO1VdxM3gnYh5Rx2ryx+hofP2U5kwWzV5Ajw8Lp5yBq29mc
         N1nR0gSwdTOsD9kwSwFHr00E1ephCPHe5BbuI3q83vSEnUlCIQOtskMR/IaT4YZfrwwL
         RgfxlamPeUYjikoQp5VgpCCv+Wz3QgTLQfmeg=
Received: by 10.87.20.36 with SMTP id x36mr2468338fgi.14.1273180452528;
        Thu, 06 May 2010 14:14:12 -0700 (PDT)
Received: from aoeu (dslb-094-216-115-024.pools.arcor-ip.net [94.216.115.24])
        by mx.google.com with ESMTPS id 4sm3936465fgg.27.2010.05.06.14.14.10
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 06 May 2010 14:14:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.dirty
In-Reply-To: <u2i51dd1af81004060115t5f837840z5adcf83622fa8882@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146499>

This is not ready for inclusion in anything. Commiting for RFC on
whether this way of doing it is sane in theory.

Known bugs:

  * Breaks the model of being able to *set* config values. That
    doesn't work for the included files. Maybe not a bug.

  * Errors in the git_config_from_file() call in glob_include_config()
    aren't passed upwards.

  * It relies on the GNU GLOB_TILDE extension with no
    alternative. That can be done by calling getenv("HOME") and
    s/~/$home/.

  * The whole bit with saving/restoring global state for config
    inclusion is evil, but then again so is the global state.

  * We don't check for recursion. But Git gives up eventually after
    after spewing a *lot* of duplicate entry errors. Not sure how to
    do this sanely w/symlinks.

Not-signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail=
=2Ecom>
---

> On Sun, Apr 4, 2010 at 07:50, Eli Barzilay <eli@barzilay.org> wrote:
> > Isn't it better to have a way to include files instead?
>
> Probably yes. Programs like Apache HTTPD, rsyslog and others just use
> ${foo}conf.d by convention by supporting config inclusion.

Here's an evil implementation of this. I know the code is horrid &
buggy (see above). But is the general idea sane. I thought it would be
better to submit this for comments before I went further with it.

 config.c               |   55 ++++++++++++++++++++++++++++++++++++++++=
+++++++-
 t/t1300-repo-config.sh |   43 +++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+), 1 deletions(-)

diff --git a/config.c b/config.c
index 6963fbe..e7581b4 100644
--- a/config.c
+++ b/config.c
@@ -7,6 +7,7 @@
  */
 #include "cache.h"
 #include "exec_cmd.h"
+#include <glob.h>
=20
 #define MAXNAME (256)
=20
@@ -111,6 +112,52 @@ static inline int iskeychar(int c)
 	return isalnum(c) || c =3D=3D '-';
 }
=20
+static void glob_include_config(config_fn_t fn, void *data, char *patt=
ern)
+{
+	glob_t globber;
+	int glob_ret;
+	int conf_ret;
+	size_t i =3D 0;
+	char *cfile =3D NULL;
+	FILE *saved_config_file;
+	char *saved_config_file_name;
+	int saved_config_linenr;
+	int saved_config_file_eof;
+#ifdef GLOB_TILDE
+	int glob_flags =3D GLOB_TILDE;
+#else
+	/* XXX: Non-GNU support for ~ expansion */
+	int glob_flags =3D 0;
+#endif
+
+	glob_ret =3D glob(pattern, glob_flags, NULL, &globber);
+
+	if (glob_ret =3D=3D GLOB_NOSPACE || glob_ret =3D=3D GLOB_ABORTED) {
+		globfree(&globber);
+		die("Unable to include config with pattern %s", pattern);
+	}
+
+	for (i =3D 0; i < globber.gl_pathc; i++) {
+		cfile =3D globber.gl_pathv[i];
+
+		/* Save away global state for including another file */
+		saved_config_file =3D config_file;
+		saved_config_file_name =3D config_file_name;
+		saved_config_linenr =3D config_linenr;
+		saved_config_file_eof =3D config_file_eof;
+
+		conf_ret =3D git_config_from_file(fn, cfile, data);
+
+		/* Restore it again */
+		config_file =3D saved_config_file;
+		config_file_name =3D saved_config_file_name;
+		config_linenr =3D saved_config_linenr;
+		config_file_eof =3D saved_config_file_eof;
+	}
+
+	globfree(&globber);
+}
+
 static int get_value(config_fn_t fn, void *data, char *name, unsigned =
int len)
 {
 	int c;
@@ -139,7 +186,13 @@ static int get_value(config_fn_t fn, void *data, c=
har *name, unsigned int len)
 		if (!value)
 			return -1;
 	}
-	return fn(name, value, data);
+
+	if (!strcmp(name, "voodoo.include")) {
+		glob_include_config(fn, data, value);
+		return 0;
+	} else {
+		return fn(name, value, data);
+	}
 }
=20
 static int get_extended_base_var(char *name, int baselen, int c)
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index f11f98c..4df6658 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -824,4 +824,47 @@ test_expect_success 'check split_cmdline return' "
 	test_must_fail git merge master
 	"
=20
+cat > .git/config << EOF
+[some]
+	variable =3D blah
+[voodoo]
+	include =3D .git/more_config_*
+EOF
+
+cat > .git/more_config_1 << EOF
+[another]
+	variable =3D blah blah
+EOF
+
+cat > .git/more_config_2 << EOF
+[evenmore]
+	variable =3D blah bluh=20
+EOF
+
+test_expect_success 'The voodoo include variable is hidden from us' \
+    'test_must_fail git config --get voodoo.include'
+test_expect_success 'get some included variable' \
+    'git config --get some.variable'
+test_expect_success 'get another included variable' \
+    'git config --get another.variable'
+test_expect_success 'get evenmore included variable' \
+    'git config --get evenmore.variable'
+
+rm .git/more_config*
+
+cat > .git/config << EOF
+[voodoo]
+	include =3D .git/more_config_*
+EOF
+
+cat > .git/more_config_1 << EOF
+[foo]
+    bar =3D zar
+[voodoo]
+	include =3D .git/more_config_*
+EOF
+
+test_expect_success 'circular config inclusion' \
+    'test_must_fail git config --get foo.bar'
+
 test_done
--=20
1.7.1.dirty
