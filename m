From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v4 7/7] t7006-pager: if stdout is not a terminal, make a
 new one
Date: Sat, 20 Feb 2010 20:09:22 -0600
Message-ID: <20100221020922.GB7651@progeny.tock>
References: <20100219065010.GA22258@progeny.tock>
 <20100219071857.GF29916@progeny.tock>
 <7v8wanq0c3.fsf@alter.siamese.dyndns.org>
 <20100221020317.GA7651@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Sebastian Celis <sebastian@sebastiancelis.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 21 04:04:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nj1Fm-0001I3-0Q
	for gcvg-git-2@lo.gmane.org; Sun, 21 Feb 2010 03:09:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756180Ab0BUCI4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Feb 2010 21:08:56 -0500
Received: from mail-yx0-f193.google.com ([209.85.210.193]:33654 "EHLO
	mail-yx0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756017Ab0BUCI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 21:08:56 -0500
Received: by yxe31 with SMTP id 31so72435yxe.21
        for <git@vger.kernel.org>; Sat, 20 Feb 2010 18:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=M/ti6Jrh10rZrUKSjwbYnhwNA3WAI0MtzCDICHJqArE=;
        b=fN/+D7K9gWVV1wEmlByu0fsfOaS0zAzMQuE3gY50pNS9ksjDvlixS4MEeEl1X5SIYy
         LFaanhbMLKoNZtE+BkIKbnTJ30htk7N6qft0EaRfmXJpUoYslCf/81g+venEbsS7QNz8
         xVZqNT3KYXPQbk5Lc4IoVJuue6Lp/udYCDtug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=VjEiy8X/1J1Sej58NGCtLI18qiEPNcMT5W7bnorJS3axpD6IwKg478Ex8YxXmFN1ei
         Fz8lmcDFqN6yzAVRd7vlDQ07RhXM0FXdfp4c5xDlKutKW5QD9Vdnzw6D+EmXnvhNzqV4
         2qva2YYMSBi2aeyN6OX9OnbgXohBPyuvkAb6s=
Received: by 10.150.164.13 with SMTP id m13mr573763ybe.21.1266718134967;
        Sat, 20 Feb 2010 18:08:54 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 5sm914523yxg.64.2010.02.20.18.08.53
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Feb 2010 18:08:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100221020317.GA7651@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140579>

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

The new test-terminal.perl helper uses IPC::Open3 and IO::Pty from
Expect.pm to create a terminal and execute the program specified by
its arguments with that terminal as stdout.  If either module is
missing or not working on a system, the test script will maintain its
old behavior (skipping most of its tests unless GIT_TEST_OPTS includes
--verbose).

It also uses File::Copy, which has been part of core Perl since
version 5.002 (1996).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Here=E2=80=99s test-terminal on top of that.  As long as this using IO:=
:Pty
from CPAN, there=E2=80=99s not much reason not to use the often-used
IPC::Open3 to simplify this.

The nice thing about using a script for this is that it fails
gracefully and doesn=E2=80=99t affect the makefile.

Thanks for bearing with me.

 t/t7006-pager.sh           |   35 ++++++++++++++++++++++++-----------
 t/t7006/test-terminal.perl |   28 ++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 11 deletions(-)
 create mode 100755 t/t7006/test-terminal.perl

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 4f52ea5..da0f962 100644
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -5,18 +5,31 @@ test_description=3D'Test automatic use of a pager.'
 . ./test-lib.sh
=20
 rm -f stdout_is_tty
-test_expect_success 'is stdout a terminal?' '
+test_expect_success 'set up terminal for tests' '
 	if test -t 1
 	then
 		: > stdout_is_tty
+	elif
+		test_have_prereq PERL &&
+		"$PERL_PATH" "$TEST_DIRECTORY"/t7006/test-terminal.perl \
+			sh -c "test -t 1"
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
+	test_terminal() {
+		"$PERL_PATH" "$TEST_DIRECTORY"/t7006/test-terminal.perl "$@"
+	}
 	test_set_prereq TTY
 else
-	say stdout is not a terminal, so skipping some tests.
+	say no usable terminal, so skipping some tests
 fi
=20
 unset GIT_PAGER GIT_PAGER_IN_USE
@@ -30,13 +43,13 @@ test_expect_success 'setup' '
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
@@ -54,7 +67,7 @@ test_expect_success 'no pager when stdout is a regula=
r file' '
=20
 rm -f paginated.out
 test_expect_success TTY 'git --paginate rev-list uses a pager' '
-	git --paginate rev-list HEAD  &&
+	test_terminal git --paginate rev-list HEAD &&
 	test -e paginated.out
 '
=20
@@ -66,7 +79,7 @@ test_expect_success 'no pager even with --paginate wh=
en stdout is a pipe' '
=20
 rm -f paginated.out
 test_expect_success TTY 'no pager with --no-pager' '
-	git --no-pager log &&
+	test_terminal git --no-pager log &&
 	! test -e paginated.out
 '
=20
@@ -95,7 +108,7 @@ test_expect_success 'no color when stdout is a regul=
ar file' '
 rm -f paginated.out
 git config color.ui auto
 test_expect_success TTY 'color when writing to a pager' '
-	TERM=3Dvt100 git log &&
+	TERM=3Dvt100 test_terminal git log &&
 	colorful paginated.out
 '
=20
@@ -127,7 +140,7 @@ test_expect_success SIMPLEPAGER 'default pager is u=
sed by default' '
 	: > default_pager_used
 	EOF
 	chmod +x $less &&
-	PATH=3D.:$PATH git log &&
+	PATH=3D.:$PATH test_terminal git log &&
 	test -e default_pager_used
 '
=20
@@ -137,7 +150,7 @@ rm -f PAGER_used
 test_expect_success TTY 'PAGER overrides default pager' '
 	PAGER=3D": > PAGER_used" &&
 	export PAGER &&
-	git log &&
+	test_terminal git log &&
 	test -e PAGER_used
 '
=20
@@ -147,7 +160,7 @@ test_expect_success TTY 'core.pager overrides PAGER=
' '
 	PAGER=3D: &&
 	export PAGER &&
 	git config core.pager ": > core.pager_used" &&
-	git log &&
+	test_terminal git log &&
 	test -e core.pager_used
 '
=20
@@ -156,7 +169,7 @@ test_expect_success TTY 'GIT_PAGER overrides core.p=
ager' '
 	git config core.pager : &&
 	GIT_PAGER=3D": > GIT_PAGER_used" &&
 	export GIT_PAGER &&
-	git log &&
+	test_terminal git log &&
 	test -e GIT_PAGER_used
 '
=20
diff --git a/t/t7006/test-terminal.perl b/t/t7006/test-terminal.perl
new file mode 100755
index 0000000..fc3fbb4
--- /dev/null
+++ b/t/t7006/test-terminal.perl
@@ -0,0 +1,28 @@
+#!/usr/bin/perl
+use strict;
+use warnings;
+use IO::Pty;
+use File::Copy;
+use IPC::Open3;
+
+# Wait for $_[0] to finish.
+sub finish_child {
+	# Simplified from wait_or_whine() in run-command.c.
+	waitpid($_[0], 0) =3D=3D $_[0] or die "waitpid failed: $!";
+	if ($? & 127) {
+		my $code =3D $? & 127;
+		warn "died of signal $code";
+		return $code - 128;
+	}
+	return $? >> 8;
+}
+
+@ARGV >=3D 1 or die "usage: test-terminal program args";
+my $master =3D new IO::Pty;
+my $slave =3D $master->slave;
+my $pid =3D open3(\*STDIN, '>&' . fileno($slave), \*STDERR, @ARGV);
+close $slave;
+# Reads from a disconnected terminal may return EIO or end-of-file.
+# Either is fine.
+copy($master, \*STDOUT, 4096) or $!{EIO} or die "cannot copy from chil=
d: $!";
+exit(finish_child($pid));
--=20
1.7.0
