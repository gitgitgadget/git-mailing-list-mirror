From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 7/7] t7006-pager: if stdout is not a terminal, make a
 new one
Date: Fri, 19 Feb 2010 23:25:18 -0600
Message-ID: <20100220052504.GA24697@progeny.tock>
References: <20100219065010.GA22258@progeny.tock>
 <20100219072331.GG29916@progeny.tock>
 <20100219080819.GA13691@coredump.intra.peff.net>
 <20100219081947.GA12975@progeny.tock>
 <20100219083440.GC13691@coredump.intra.peff.net>
 <28d--OB9y5MtIy1nJel2Km6d5sqJ3yX6fVUhecDU5ehJUYJmZlE0-A@cipher.nrlssc.navy.mil>
 <setkR9a6yaRMOU11ekUmlY6ty8nNSPCcidBKotdDxpQsZLCxc54hKw@cipher.nrlssc.navy.mil>
 <20100220003950.GA18550@progeny.tock>
 <ee63ef31002191942h7fbbb6bt627cd36ea343e606@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Sebastian Celis <sebastian@sebastiancelis.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 06:33:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nihxq-0000Rt-8j
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 06:33:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140Ab0BTFdI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Feb 2010 00:33:08 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:41162 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794Ab0BTFdE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 00:33:04 -0500
Received: by yxe38 with SMTP id 38so796740yxe.4
        for <git@vger.kernel.org>; Fri, 19 Feb 2010 21:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=6lDx2xjiErr8ENlkXNyzSLrotom1OEhxqmjre24hYSw=;
        b=t+qyZgL5BWOrhCeeGRtc6fwcOIAAzTwgfQBYKi1DN3wkXpMPFrKdtL1Yf0HJfoboig
         eiW5DOziOOK3C/ONgXc2d7s6ZRAVCZ9FkAPszsMP3eMy2eX3LufWeBfgxYk2OAAKW4tf
         M2lcpU2aCZUnZ4bO2txOV7YwmqouFwloCE9Bc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=WCQ14Xv3cZAl8uyanXaRqhkkg+R5bfyAzCLKgdbULastirrqeU5vZ6BUdZDBfWX2z1
         ZAP1L69XPZrAjMMQRQGDh3clNLhvunefZ6Xc95RYM+7b5X1Bc7RZJv5NA3l3E98a0FqU
         8IJePiFgrx4wZmmuKPmCWsRi+3QPeUK0nGJrg=
Received: by 10.151.89.35 with SMTP id r35mr3276828ybl.183.1266643502123;
        Fri, 19 Feb 2010 21:25:02 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 8sm413130yxb.43.2010.02.19.21.25.00
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Feb 2010 21:25:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <ee63ef31002191942h7fbbb6bt627cd36ea343e606@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140515>

Testing pagination requires (fake or real) access to a terminal so we
can see whether the pagination automatically kicks in, which makes it
hard to get good coverage when running tests without --verbose.  There
are a number of ways to work around that:

 - Replace all isatty calls with calls to a custom xisatty wrapper
   that usually checks for a terminal but can be overridden for tests.
   This would be workable, but it would require implementing xisatty
   separately in three languages (C, shell, and perl) and making sure
   that any code that is to be tested always uses the wrapper.

 - Redirect stdout to /dev/tty.  This would be problematic because
   there might be no terminal available, and even if a terminal is
   available, it might not be appropriate to spew output to it.

 - Create a new pseudo-terminal on the fly and capture its output.

This patch implements the third approach.

The new test-terminal command opens /dev/ptmx to create a terminal and
executes the program specified by its arguments with that terminal as
stdout.  All platforms I know of with SuSv3 posix_openpt implement it
as open("/dev/ptmx", ...), so this should be just as portable.

Pre-SuSv3 systems may not have the proper support, but that is okay.
If SVR4 STREAMS are supported, all the functions used by test-terminal
will be available and succeed, though the result will not satisfy
isatty() unless the appropriate ioctl()s are used.  The test suite
checks for this and will not use test-terminal in that case.

On non-Unixlike and pre-SVR4 systems, this functionality should be
disabled by passing NO_GRANTPT=3DYesPlease to the makefile.  I do not
know whether Cygwin or HP-UX implements the required functions
appropriately, so to be safe this patch includes that option for them.

On platforms where test-terminal does not work, the test script will
maintain its old behavior (skipping most of its tests unless
GIT_TEST_OPTS includes --verbose).

Thanks to Brandon Casey <drafnel@gmail.com> and Jeff King
<peff@peff.net> for porting help.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Brandon Casey wrote:
> On Fri, Feb 19, 2010 at 6:39 PM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:

>> Thanks for trying it out. =C2=A0That=E2=80=99s an excellent outcome:=
 it means that
>> test-terminal compiled without trouble with no makefile magic. =C2=A0=
It
>> does seem strange to me that there was no error message. =C2=A0Is
>> sh -c "test -t 1" false for an ordinary terminal?
>
> No, it is true.  I also substituted /usr/xpg4/bin/sh and got the same=
 result.

Ah, okay.  I read up a little more, and it seems that old STREAMS-based
implementations of pseudo-terminals require

	ioctl(*slave, I_PUSH, "ptem");
	ioctl(*slave, I_PUSH, "ldterm");
	ioctl(*slave, I_PUSH, "pckt");

where I_PUSH is ('S' << 8) | 2.  I am terrified of ioctl number conflic=
ts
and do not want to try that, so it is nice to see that this fails so
gracefully.

Thanks again.  Here=E2=80=99s a revised patch.

 .gitignore       |    1 +
 Makefile         |   11 +++++++++
 t/t7006-pager.sh |   28 +++++++++++++++--------
 test-terminal.c  |   62 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 4 files changed, 92 insertions(+), 10 deletions(-)
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
index 7bf2fca..0df3795 100644
--- a/Makefile
+++ b/Makefile
@@ -55,6 +55,9 @@ all::
 #
 # Define NO_UNSETENV if you don't have unsetenv in the C library.
 #
+# Define NO_GRANTPT if you don't have grantpt, unlockpt, and ptsname
+# (for tests).
+#
 # Define NO_MKDTEMP if you don't have mkdtemp in the C library.
 #
 # Define NO_MKSTEMPS if you don't have mkstemps in the C library.
@@ -803,6 +806,7 @@ ifeq ($(uname_O),Cygwin)
 	NO_TRUSTABLE_FILEMODE =3D UnfortunatelyYes
 	OLD_ICONV =3D UnfortunatelyYes
 	NO_ST_BLOCKS_IN_STRUCT_STAT =3D YesPlease
+	NO_GRANTPT =3D YesPlease
 	# There are conflicting reports about this.
 	# On some boxes NO_MMAP is needed, and not so elsewhere.
 	# Try commenting this out if you suspect MMAP is more efficient
@@ -910,6 +914,7 @@ ifeq ($(uname_S),HP-UX)
 	NO_UNSETENV =3D YesPlease
 	NO_HSTRERROR =3D YesPlease
 	NO_SYS_SELECT_H =3D YesPlease
+	NO_GRANTPT =3D YesPlease
 	SNPRINTF_RETURNS_BOGUS =3D YesPlease
 endif
 ifeq ($(uname_S),Windows)
@@ -937,6 +942,7 @@ ifeq ($(uname_S),Windows)
 	NO_PERL_MAKEMAKER =3D YesPlease
 	RUNTIME_PREFIX =3D YesPlease
 	NO_POSIX_ONLY_PROGRAMS =3D YesPlease
+	NO_GRANTPT =3D YesPlease
 	NO_ST_BLOCKS_IN_STRUCT_STAT =3D YesPlease
 	NO_NSEC =3D YesPlease
 	USE_WIN32_MMAP =3D YesPlease
@@ -989,6 +995,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_PERL_MAKEMAKER =3D YesPlease
 	RUNTIME_PREFIX =3D YesPlease
 	NO_POSIX_ONLY_PROGRAMS =3D YesPlease
+	NO_GRANTPT =3D YesPlease
 	NO_ST_BLOCKS_IN_STRUCT_STAT =3D YesPlease
 	NO_NSEC =3D YesPlease
 	USE_WIN32_MMAP =3D YesPlease
@@ -1727,6 +1734,10 @@ TEST_PROGRAMS_NEED_X +=3D test-sha1
 TEST_PROGRAMS_NEED_X +=3D test-sigchain
 TEST_PROGRAMS_NEED_X +=3D test-index-version
=20
+ifndef NO_GRANTPT
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
index 0000000..6408a7d
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
+	fd =3D open("/dev/ptmx", O_RDWR|O_NOCTTY);
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
