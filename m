From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v3 7/7] t7006-pager: if stdout is not a terminal, make a
 new one
Date: Sat, 20 Feb 2010 02:50:25 -0600
Message-ID: <20100220085025.GA26788@progeny.tock>
References: <20100219072331.GG29916@progeny.tock>
 <20100219080819.GA13691@coredump.intra.peff.net>
 <20100219081947.GA12975@progeny.tock>
 <20100219083440.GC13691@coredump.intra.peff.net>
 <28d--OB9y5MtIy1nJel2Km6d5sqJ3yX6fVUhecDU5ehJUYJmZlE0-A@cipher.nrlssc.navy.mil>
 <setkR9a6yaRMOU11ekUmlY6ty8nNSPCcidBKotdDxpQsZLCxc54hKw@cipher.nrlssc.navy.mil>
 <20100220003950.GA18550@progeny.tock>
 <ee63ef31002191942h7fbbb6bt627cd36ea343e606@mail.gmail.com>
 <20100220052504.GA24697@progeny.tock>
 <7vaav42ya1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <drafnel@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org,
	Sebastian Celis <sebastian@sebastiancelis.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 09:50:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nil2U-0003CY-FF
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 09:50:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753568Ab0BTIuK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 03:50:10 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:58370 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719Ab0BTIuI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 03:50:08 -0500
Received: by yxe38 with SMTP id 38so866222yxe.4
        for <git@vger.kernel.org>; Sat, 20 Feb 2010 00:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=xZ4RETkEPWK7zrPGB0RJjDIh9F1SlIipaRmcQXq6wUM=;
        b=JnpMMBTAGL6KshVut+LyOuy3inFOR9TbKUdenKs8JXxAij7HigpEMvIF0yyPkuVUAR
         T+qb4nnQIVjYEhPc+rUV+xKRUDHk7jduVK9scjc4UDGCPvE9letGK58YVFyR/cAontDn
         2uivH6a+dPzMna0owixR1QzNKjsK0HuZHM2lM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=gMzzxu2zMLb72pot3HL5qT7G8bvBLZRODl2t7Mp3LHKPO2E+w2qd2F+5/6XPlnzmxg
         NabeEs3jfS941IcGv6+thpFYNrol7DHhGwdq0ddzE3wTAX+NHjF+Im3x8+jA05Jwk49Y
         8CdLeMPymLmbl1sj0VwUfeg3XRmTjX4lpdt2k=
Received: by 10.151.24.18 with SMTP id b18mr1027285ybj.168.1266655806950;
        Sat, 20 Feb 2010 00:50:06 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 9sm478626yxf.41.2010.02.20.00.50.05
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Feb 2010 00:50:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vaav42ya1.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140519>

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

The new test-terminal.perl helper uses IO::Pty from Expect.pm to create
a terminal and executes the program specified by its arguments with
that terminal as stdout.  If the IO::Pty module is missing or not
working on a system, the test script will maintain its old behavior
(skipping most of its tests unless GIT_TEST_OPTS includes --verbose).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

> > On non-Unixlike and pre-SVR4 systems, this functionality should be
> > disabled by passing NO_GRANTPT=YesPlease to the makefile.  I do not
> > know whether Cygwin or HP-UX implements the required functions
> > appropriately, so to be safe this patch includes that option for them.
> >
> > On platforms where test-terminal does not work, the test script will
> > maintain its old behavior (skipping most of its tests unless
> > GIT_TEST_OPTS includes --verbose).
> 
> If we are truly serious about doing this, it might be worthwhile to check
> how expect (http://expect.nist.gov) does this portably.

I was not interested in making this work perfectly on ancient systems,
because that would involve providing variants for old-style BSD ptys,
STREAMS-based ptys, and the modern simpler ptys.  Looking at the expect
source, it seems there are even more variants to worry about than I had
thought.

On the other hand, I do think it would be better to make this work (or
not work) without makefile changes on all platforms.  So how about this?
It lets the IO::Pty library used to implement Expect.pm do the dirty
work for us.

The main downsides are that this means less coverage (not everyone has
IO::Pty installed) and it is much slower than the C version.

 .gitignore                 |    1 +
 t/t7006-pager.sh           |   33 ++++++++++++++------
 t/t7006/test-terminal.perl |   70 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+), 10 deletions(-)
 create mode 100755 t/t7006/test-terminal.perl

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
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 2e9cb9d..da0f962 100644
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -5,18 +5,31 @@ test_description='Test automatic use of a pager.'
 . ./test-lib.sh
 
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
 
 unset GIT_PAGER GIT_PAGER_IN_USE
@@ -30,13 +43,13 @@ test_expect_success 'setup' '
 
 rm -f paginated.out
 test_expect_success TTY 'some commands use a pager' '
-	git log &&
+	test_terminal git log &&
 	test -e paginated.out
 '
 
 rm -f paginated.out
 test_expect_success TTY 'some commands do not use a pager' '
-	git rev-list HEAD &&
+	test_terminal git rev-list HEAD &&
 	! test -e paginated.out
 '
 
@@ -54,7 +67,7 @@ test_expect_success 'no pager when stdout is a regular file' '
 
 rm -f paginated.out
 test_expect_success TTY 'git --paginate rev-list uses a pager' '
-	git --paginate rev-list HEAD  &&
+	test_terminal git --paginate rev-list HEAD &&
 	test -e paginated.out
 '
 
@@ -66,7 +79,7 @@ test_expect_success 'no pager even with --paginate when stdout is a pipe' '
 
 rm -f paginated.out
 test_expect_success TTY 'no pager with --no-pager' '
-	git --no-pager log &&
+	test_terminal git --no-pager log &&
 	! test -e paginated.out
 '
 
@@ -127,7 +140,7 @@ test_expect_success SIMPLEPAGER 'default pager is used by default' '
 	: > default_pager_used
 	EOF
 	chmod +x $less &&
-	PATH=.:$PATH git log &&
+	PATH=.:$PATH test_terminal git log &&
 	test -e default_pager_used
 '
 
@@ -137,7 +150,7 @@ rm -f PAGER_used
 test_expect_success TTY 'PAGER overrides default pager' '
 	PAGER=": > PAGER_used" &&
 	export PAGER &&
-	git log &&
+	test_terminal git log &&
 	test -e PAGER_used
 '
 
@@ -147,7 +160,7 @@ test_expect_success TTY 'core.pager overrides PAGER' '
 	PAGER=: &&
 	export PAGER &&
 	git config core.pager ": > core.pager_used" &&
-	git log &&
+	test_terminal git log &&
 	test -e core.pager_used
 '
 
@@ -156,7 +169,7 @@ test_expect_success TTY 'GIT_PAGER overrides core.pager' '
 	git config core.pager : &&
 	GIT_PAGER=": > GIT_PAGER_used" &&
 	export GIT_PAGER &&
-	git log &&
+	test_terminal git log &&
 	test -e GIT_PAGER_used
 '
 
diff --git a/t/t7006/test-terminal.perl b/t/t7006/test-terminal.perl
new file mode 100755
index 0000000..b51cfc6
--- /dev/null
+++ b/t/t7006/test-terminal.perl
@@ -0,0 +1,70 @@
+#!/usr/bin/perl
+use strict;
+use warnings;
+use IO::Pty;
+
+# Fork and execute @$argv with stdout redirected to $out.
+sub start_child {
+	my ($argv, $out) = @_;
+	my $pid = fork;
+	if (not defined $pid) {
+		die "fork failed: $!"
+	} elsif ($pid == 0) {
+		open STDOUT, ">&", $out;
+		close $out;
+		exec(@$argv) or die "cannot exec '$argv->[0]': $!"
+	}
+	return $pid;
+}
+
+# Wait for $pid to finish.
+sub finish_child {
+	# Simplified from wait_or_whine() in run-command.c.
+	my ($pid) = @_;
+
+	my $waiting = waitpid($pid, 0);
+	if ($waiting < 0) {
+		die "waitpid failed: $!";
+	} elsif ($? & 127) {
+		my $code = $? & 127;
+		warn "died of signal $code";
+		return $code - 128;
+	} else {
+		return $? >> 8;
+	}
+}
+
+sub xsendfile {
+	my ($out, $in) = @_;
+
+	my $buf;
+
+	# Note: the real sendfile() cannot read from a terminal.
+	for (;;) {
+		my $n = sysread $in, $buf, 4096;
+
+		# It is unspecified by POSIX whether reads
+		# from a disconnected terminal will return
+		# EIO (as in AIX 4.x, IRIX, and Linux) or
+		# end-of-file.  Either is fine.
+		if (!defined($n) && $!{EIO}) {
+			return;
+		} elsif (!defined($n)) {
+			die "cannot read from child: $!";
+		} elsif ($n == 0) {
+			return;
+		} else {
+			print $out $buf or die "write error: $!";
+		}
+	}
+}
+
+if ($#ARGV < 1) {
+	die "usage: test-terminal program args";
+}
+my $master = new IO::Pty;
+my $slave = $master->slave;
+my $pid = start_child(\@ARGV, $slave);
+close $slave;
+xsendfile(\*STDOUT, $master);
+exit(finish_child($pid));
-- 
1.7.0
