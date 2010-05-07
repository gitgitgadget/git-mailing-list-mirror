From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC v2] Hacky version of a glob() driven config include
Date: Fri,  7 May 2010 20:11:19 +0000
Message-ID: <1273263079-885-1-git-send-email-avarab@gmail.com>
References: <AANLkTimziTKL13VKIOcaS1TX1F_xvTVjH8Q398Yx36Us@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 07 22:11:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OATti-0008UX-LF
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 22:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758172Ab0EGULk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 16:11:40 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61068 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758157Ab0EGULj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 16:11:39 -0400
Received: by fxm10 with SMTP id 10so1061437fxm.19
        for <git@vger.kernel.org>; Fri, 07 May 2010 13:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=mrcfnrC/jI6hWoA6kvFa5fgoO+cZWZk0jqfsZKkIQps=;
        b=cNERU/euFiQhd3QC789iSO5phuHM8K/m6+PpVRHcaojyEd4VdcpyGADfMu7erjx3Tu
         H0pEJJMjfSQI82j6h/mvzWbIPkKmHXReFL4iIDH5BNkry/XxmpK0QQBUXExPz13giebH
         /+Mfdas1HwtwCWCC7Lu3q5DYeFgo+8+Kj3G6I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=MmEGe0ozgHp2xXjh7UdK0CuzMFv3xfboqLW0loQveWRquDQaM7S20Q6xafA0rvXzYR
         cfmZm/9B6UKtrRqD8uq5MXXOx2pQ/KjVjLYlhvBIcLdJSyCdk47eyarpkXXyct2Kg2F3
         0+1fhlpr6hWudCrcPUQZ6u6YsMUFDDMESZwZU=
Received: by 10.223.30.130 with SMTP id u2mr585258fac.70.1273263097911;
        Fri, 07 May 2010 13:11:37 -0700 (PDT)
Received: from aoeu (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id r25sm8107927fai.11.2010.05.07.13.11.35
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 07 May 2010 13:11:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.dirty
In-Reply-To: <AANLkTimziTKL13VKIOcaS1TX1F_xvTVjH8Q398Yx36Us@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146580>

Add support for a special `voodoo.include` config variable. Its
contents will be globbed, and the files it expands to included as
config files.

This enables support for keeping around a ~/.gitconfig.d/* directory,
or for distros to keep a /etc/gitconfig.d/* directory. Some use cases:

  * Keep secret portions of the Git config file separate,
    e.g. github.token. Useful if the ~/.gitconfig itself is kept in
    a public Git repository.

  * Ability to selectively include config libraries. You could include
    e.g. ~/.gitconfig.d/pretty-colors.ini or
    ~/.gitconfig.d/better-submodule-handling.ini from a remote source.

Known bugs:

  * Breaks the model of being able to *set* config values. That
    doesn't work for the included files, i.e. setting a value that
    might be considered derived from a value in an included file won't
    end up in the "right" place. Maybe not a bug.

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

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

On Fri, May 7, 2010 at 19:52, Bert Wesarg <bert.wesarg@googlemail.com> =
wrote:

> But where does the Developer's Certificate of Origin talks about
> non-legal aspects of patch submitting? E.g. correctness, quality, ...
>
> I think the part "if you want your work included in git.git" is very
> misleading in this paragraph, and I propose to remove it.

=46air enough. My reading of it was literal, i.e. `if (want_inclusion &=
&
DCO) { -s }`. Since I didn't want inclusion for the patch I didn't add =
a SOB.

Here's a version v2 of the patch with a Signed-off-by, and a better
commit message.

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
