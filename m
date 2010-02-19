From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 7/7] t7006-pager: if stdout is not a terminal, make a
 new one
Date: Fri, 19 Feb 2010 01:23:31 -0600
Message-ID: <20100219072331.GG29916@progeny.tock>
References: <20100219065010.GA22258@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sebastian Celis <sebastian@sebastiancelis.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 19 08:23:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiNCy-0001QY-Jn
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 08:23:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754615Ab0BSHXX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Feb 2010 02:23:23 -0500
Received: from mail-yw0-f197.google.com ([209.85.211.197]:45947 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754597Ab0BSHXV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 02:23:21 -0500
Received: by ywh35 with SMTP id 35so1816273ywh.4
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 23:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=kfRtTq9NyzImyQalf0iPj70nYop79YbN+qfSgS9hZtI=;
        b=tsXau3yHZn9VIt2zlIoAKf13+fkrKMnX/35kKHMk1gN3YsCI6QygfewYBibRf+KArj
         3i1u2u1c9CB/a1ia+3ImxZwigjHuoHCyz3FgnfnUSd6QNv9Xh+IyOzvfrl36W8RGB1iW
         ORnqzfhHrqvjgbnGn+t29tqtVsgsjujCbvuKA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=vDAG879AUSH9KV/59Lom4TP9/c472DQocvx7pjjqKh9lp6yitePSlzCCv/r1g0jsnl
         aTdAE465VelUUePyOdgqIM6GDqrQ5bgrQ2diVEsdD4wtvAwid7gOZriGEUH65QPEUrNp
         eHy7PvxvPWU17A7yUEpC8DDPXqAAfMcMTDuFg=
Received: by 10.101.36.17 with SMTP id o17mr1285805anj.204.1266564200976;
        Thu, 18 Feb 2010 23:23:20 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 7sm4039192yxd.44.2010.02.18.23.23.19
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 18 Feb 2010 23:23:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100219065010.GA22258@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140425>

Test t7006-pager skips most of its tests except when running with
--verbose, for lack of a terminal to use.  Thus many of the tests
would not get much coverage, since whole testsuite runs with --verbose
are rare.  Redirecting output to /dev/tty would be problematic because
(1) there really could be no controlling terminal and (2) test
breakage might manifest itself by the producing extraneous output.
Luckily, there is a way around this: Unix98-style pseudo-terminals
allow us to create a fake terminal on the fly and capture its output.

Do so.  The new test-terminal command to accomplish this uses
posix_openpt (from SuSv3) to create a terminal because that is good
enough on Linux.  I would like some feedback on what platforms are
missing that function and thus what alternate interfaces are worth
supporting.  The perl IO::Tty module could take care of this for us,
but I do not think it is worth the extra dependency.

The test-terminal facility can be disabled by passing
NO_POSIX_OPENPT=3DYesPlease to the makefile, in which case the test
will revert to its old behavior (skipping most tests unless
GIT_TEST_OPTS includes --verbose).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Requiring users to add NO_POSIX_OPENPT themselves doesn=E2=80=99t seem =
so
great.  I did it that way just so I could send something and get
some feedback; a more suitable version would need a way to detect
missing openpt on the fly, for example by noticing the compilation
failure and continuing anyway.

 .gitignore       |    1 +
 Makefile         |    6 +++++
 t/t7006-pager.sh |   28 +++++++++++++++--------
 test-terminal.c  |   62 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 4 files changed, 87 insertions(+), 10 deletions(-)
 create mode 100644 test-terminal.c

diff --git a/.gitignore b/.gitignore
index 8df8f88..6b405ba 100644
--- a/.gitignore
+++ b/.gitignore
@@ -169,6 +169,7 @@
 /test-run-command
 /test-sha1
 /test-sigchain
+/test-terminal
 /common-cmds.h
 *.tar.gz
 *.dsc
diff --git a/Makefile b/Makefile
index 7bf2fca..9c900a7 100644
--- a/Makefile
+++ b/Makefile
@@ -45,6 +45,8 @@ all::
 #
 # Define NO_MEMMEM if you don't have memmem.
 #
+# Define NO_POSIX_OPENPT if you don't have posix_openpt (for tests).
+#
 # Define NO_STRLCPY if you don't have strlcpy.
 #
 # Define NO_STRTOUMAX if you don't have strtoumax in the C library.
@@ -1727,6 +1729,10 @@ TEST_PROGRAMS_NEED_X +=3D test-sha1
 TEST_PROGRAMS_NEED_X +=3D test-sigchain
 TEST_PROGRAMS_NEED_X +=3D test-index-version
=20
+ifndef NO_POSIX_OPENPT
+TEST_PROGRAMS_NEED_X +=3D test-terminal
+endif
+
 TEST_PROGRAMS =3D $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
=20
 test_bindir_programs :=3D $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAM=
S_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 2e9cb9d..21788e3 100644
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -5,18 +5,26 @@ test_description=3D'Test automatic use of a pager.'
 . ./test-lib.sh
=20
 rm -f stdout_is_tty
-test_expect_success 'is stdout a terminal?' '
+test_expect_success 'set up terminal for tests' '
 	if test -t 1
 	then
 		: > stdout_is_tty
+	elif test-terminal sh -c "test -t 1"
+	then
+		: > test_terminal_works
 	fi
 '
=20
 if test -e stdout_is_tty
 then
+	test_terminal() { "$@"; }
+	test_set_prereq TTY
+elif test -e test_terminal_works
+then
+	test_terminal() { test-terminal "$@"; }
 	test_set_prereq TTY
 else
-	say stdout is not a terminal, so skipping some tests.
+	say no usable terminal, so skipping some tests
 fi
=20
 unset GIT_PAGER GIT_PAGER_IN_USE
@@ -30,13 +38,13 @@ test_expect_success 'setup' '
=20
 rm -f paginated.out
 test_expect_success TTY 'some commands use a pager' '
-	git log &&
+	test_terminal git log &&
 	test -e paginated.out
 '
=20
 rm -f paginated.out
 test_expect_success TTY 'some commands do not use a pager' '
-	git rev-list HEAD &&
+	test_terminal git rev-list HEAD &&
 	! test -e paginated.out
 '
=20
@@ -54,7 +62,7 @@ test_expect_success 'no pager when stdout is a regula=
r file' '
=20
 rm -f paginated.out
 test_expect_success TTY 'git --paginate rev-list uses a pager' '
-	git --paginate rev-list HEAD  &&
+	test_terminal git --paginate rev-list HEAD &&
 	test -e paginated.out
 '
=20
@@ -66,7 +74,7 @@ test_expect_success 'no pager even with --paginate wh=
en stdout is a pipe' '
=20
 rm -f paginated.out
 test_expect_success TTY 'no pager with --no-pager' '
-	git --no-pager log &&
+	test_terminal git --no-pager log &&
 	! test -e paginated.out
 '
=20
@@ -127,7 +135,7 @@ test_expect_success SIMPLEPAGER 'default pager is u=
sed by default' '
 	: > default_pager_used
 	EOF
 	chmod +x $less &&
-	PATH=3D.:$PATH git log &&
+	PATH=3D.:$PATH test_terminal git log &&
 	test -e default_pager_used
 '
=20
@@ -137,7 +145,7 @@ rm -f PAGER_used
 test_expect_success TTY 'PAGER overrides default pager' '
 	PAGER=3D": > PAGER_used" &&
 	export PAGER &&
-	git log &&
+	test_terminal git log &&
 	test -e PAGER_used
 '
=20
@@ -147,7 +155,7 @@ test_expect_success TTY 'core.pager overrides PAGER=
' '
 	PAGER=3D: &&
 	export PAGER &&
 	git config core.pager ": > core.pager_used" &&
-	git log &&
+	test_terminal git log &&
 	test -e core.pager_used
 '
=20
@@ -156,7 +164,7 @@ test_expect_success TTY 'GIT_PAGER overrides core.p=
ager' '
 	git config core.pager : &&
 	GIT_PAGER=3D": > GIT_PAGER_used" &&
 	export GIT_PAGER &&
-	git log &&
+	test_terminal git log &&
 	test -e GIT_PAGER_used
 '
=20
diff --git a/test-terminal.c b/test-terminal.c
new file mode 100644
index 0000000..f4d6a71
--- /dev/null
+++ b/test-terminal.c
@@ -0,0 +1,62 @@
+#include "cache.h"
+#include "run-command.h"
+
+static void newtty(int *master, int *slave)
+{
+	int fd;
+	const char *term;
+
+	fd =3D posix_openpt(O_RDWR|O_NOCTTY);
+	if (fd =3D=3D -1 || grantpt(fd) || unlockpt(fd) || !(term =3D ptsname=
(fd)))
+		die_errno("Could not allocate a new pseudo-terminal");
+	*master =3D fd;
+	*slave =3D open(term, O_RDWR|O_NOCTTY);
+	if (*slave =3D=3D -1)
+		die_errno("Could not open pseudo-terminal: %s", term);
+}
+
+static void setup_child(struct child_process *chld,
+			const char **args, int out)
+{
+	memset(chld, 0, sizeof(*chld));
+	chld->argv =3D args;
+	chld->out =3D out;
+}
+
+static void xsendfile(int out_fd, int in_fd)
+{
+	char buf[BUFSIZ];
+
+	/* Note: the real sendfile() cannot read from a terminal. */
+	for (;;) {
+		ssize_t n =3D xread(in_fd, buf, sizeof(buf));
+
+		/*
+		 * It is unspecified by POSIX whether reads
+		 * from a disconnected terminal will return
+		 * EIO (as in AIX 4.x, IRIX, and Linux) or
+		 * end-of-file.  Either is fine.
+		 */
+		if (n =3D=3D 0 || (n =3D=3D -1 && errno =3D=3D EIO))
+			break;
+		if (n =3D=3D -1)
+			die_errno("cannot read from child");
+		write_or_die(out_fd, buf, n);
+	}
+}
+
+int main(int argc, const char **argv)
+{
+	int masterfd, slavefd;
+	struct child_process chld;
+
+	if (argc < 2 || (argc =3D=3D 2 && !strcmp(argv[1], "-h")))
+		usage("test-terminal program args");
+
+	newtty(&masterfd, &slavefd);
+	setup_child(&chld, argv + 1, slavefd);
+	if (start_command(&chld))
+		return error("failed to execute child");
+	xsendfile(1, masterfd);
+	return finish_command(&chld);
+}
--=20
1.7.0
