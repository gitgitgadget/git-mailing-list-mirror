From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFH] git-difftool fails to export GIT_DIFF_TOOL when running t7800 with valgrind over ssh
Date: Sun, 13 Jun 2010 12:51:10 +0200
Message-ID: <201006131251.11229.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>, <valgrind-users@lists.sourceforge.net>
X-From: git-owner@vger.kernel.org Sun Jun 13 12:51:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONkn0-0002D9-2d
	for gcvg-git-2@lo.gmane.org; Sun, 13 Jun 2010 12:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753712Ab0FMKvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jun 2010 06:51:37 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:55478 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753663Ab0FMKvf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jun 2010 06:51:35 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sun, 13 Jun
 2010 12:51:35 +0200
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sun, 13 Jun
 2010 12:51:11 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.3; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149044>

Hi all,

I'm also posting to the valgrind folks in case any of you have some
idea what's going on.  (Please Cc, I'm not subscribed there.)  I'm
still not sure who to blame, but at this point, any sort of input
would be *great*.  I put some extra comments for non-gitters in
footnotes.

This bug has been puzzling me for about a day now, and if you judged
from the subject that I'm crazy... well, I think so too.

I can reliably reproduce it on two machines:

  openSUSE 11.2, x86_64, 2.6.31.12-0.2-desktop, GCC 4.5.0, valgrind 3.5.0
  RHEL Server 5.4, x86_64, 2.6.18-164.el5, GCC 4.1.2, valgrind 3.5.0

While writing this I also upgraded the first one (my laptop where I do
all my development) to valgrind 3.6.0SVN, r11171.  I have also used
GCC 4.4.1 instead, which is what originally shipped with openSUSE
11.2; no luck either.

Reproducing it *requires* that I'm logged in over SSH.  I still have
no idea what huge difference this makes, and any pointers would be
appreciated.  'ssh localhost' will do just fine.

For instant failure, try running[*] t7800 with valgrind, e.g.

  cd t/
  ./t7800-difftool.sh --valgrind -i

Tests 3 and 4 reliably fail for me.  I focused on test 3 for now, it
just reads

	diff=$(git difftool --no-prompt --tool=bad-tool branch)
	test "$?" = 1 &&
	test "$diff" = ""

I have tried reproducing the valgrind environment; running with
--valgrind once will set up some of the necessary glue[2], and I can
then do (assuming I'm in t/)

  export GIT_VALGRIND=$(pwd)/valgrind
  export GIT_EXEC_PATH=$GIT_VALGRIND/bin
  export PATH=$GIT_VALGRIND/bin:$PATH

Then you can manually run the offending command with

  git difftool --no-prompt --tool=bad-tool branch

This now gives me

  ==9204== valgrind: failed to move logfile fd into safe range, using stderr
  [...more of those...]
  ==9276== valgrind: failed to move logfile fd into safe range, using stderr
  branch

which at least verifies that something is wrong.  Through way too much
fiddling, I came up with the patch at the end of the email.  After
applying it, you'll have to install the env-helper:

  gcc -o $GIT_EXEC_PATH/env-helper env-helper.c

After that, running

  GIT_TRACE=1 git difftool --no-prompt --tool=bad-tool branch

dumps the environment in three places.  I won't paste the full output,
but here's the rub:

1. Immediately after git-difftool has set up the variables.  You can
   see that $GIT_DIFF_TOOL is set to bad-tool, as it should.

2. Immediately before execv_shell_cmd() called by git-diff runs execvp
   to run the $GIT_EXTERNAL_DIFF command.  The differences to (1) as
   per diffing a sorted dump are:

     +GIT_DIR=.git

     -LD_PRELOAD=
     +LD_PRELOAD=/home/thomas/.local/lib/valgrind/vgpreload_core-amd64-linux.so:/home/thomas/.local/lib/valgrind/vgpreload_memcheck-amd64-linux.so:

     -PATH=/home/thomas/dev/git/t/valgrind/bin:/home/thomas/g/t/valgrind/bin:/home/thomas/g/t/valgrind/../..:/home/thomas/g/t/valgrind/bin:/home/thomas/.local/bin:/home/thomas/.local/bin:/usr/lib64/mpi/gcc/openmpi/bin:/usr/local/bin:/usr/bin:/bin:/usr/bin/X11:/usr/X11R6/bin:/usr/games:/opt/kde3/bin:/usr/lib/mit/bin:/usr/lib/mit/sbin:/usr/sbin:/sbin:/usr/games:/usr/sbin:/sbin:/usr/games
     +PATH=/home/thomas/g/t/valgrind/bin:/home/thomas/g/t/valgrind/../..:/home/thomas/dev/git/t/valgrind/bin:/home/thomas/g/t/valgrind/bin:/home/thomas/g/t/valgrind/../..:/home/thomas/g/t/valgrind/bin:/home/thomas/.local/bin:/home/thomas/.local/bin:/usr/lib64/mpi/gcc/openmpi/bin:/usr/local/bin:/usr/bin:/bin:/usr/bin/X11:/usr/X11R6/bin:/usr/games:/opt/kde3/bin:/usr/lib/mit/bin:/usr/lib/mit/sbin:/usr/sbin:/sbin:/usr/games:/usr/sbin:/sbin:/usr/games

   (This is already with valgrind-3.6.0SVN installed for testing, but
   the result with 3.5.0 is basically the same.)

3. Immediately after that execvp(), inside the env-helper (which is a
   bogus diff tool serving only for debugging).  The differences to
   (2) are

     +

     -GIT_DIFF_TOOL=bad-tool

     -LD_PRELOAD=/home/thomas/.local/lib/valgrind/vgpreload_core-amd64-linux.so:/home/thomas/.local/lib/valgrind/vgpreload_memcheck-amd64-linux.so:
     +LD_PRELOAD=


At (3), $GIT_DIFF_TOOL is gone!  Its "I'm doubting my sanity" friends
$GIT_DIFF_TOO[KM] aren't though.  Also, that is *not* a stray +, there
really is an empty entry in the environment!  In the output of
env-helper, it looks like:

  0x7fffc45381fb GIT_DIFF_TOOM=bad-tool
  0x7fffc4538212 LD_PRELOAD=
  0x7fffc453821e 
  0x7fffc453821f MORE=-sl
  0x7fffc4538228 GIT_DIFF_TOOK=bad-tool

Eh?  Is this even allowed?  Probably not, right?

BTW, the empty LD_PRELOAD before step (1) is already valgrind's; I do
not have it set in the shell.

That's about as far as I got.  There's a bug report that seems to run
into a similar problem at

  http://bugs.kde.org/show_bug.cgi?id=215914

but it ends up being blamed on the shell.  AFAICS there is no shell
involved in our case between (2) and (3) since git only uses one if
the command has characters that "require a shell".

Any pointers would be welcome...



[1] You'll first need git sources, try
      git clone git://git.kernel.org/pub/scm/git/git.git
      cd git
      make
    though if you actually want to install it, you should first read
    the top of the Makefile and at least set 'prefix'.

[2] The --valgrind support sets up trampolines that execute git
    commands written in C under valgrind in t/valgrind/bin/.  


--- 8< ---
diff --git i/git-difftool.perl w/git-difftool.perl
index adc42de..ddf0330 100755
--- i/git-difftool.perl
+++ w/git-difftool.perl
@@ -34,7 +34,7 @@ sub setup_environment
 {
 	$ENV{PATH} = "$DIR:$ENV{PATH}";
 	$ENV{GIT_PAGER} = '';
-	$ENV{GIT_EXTERNAL_DIFF} = 'git-difftool--helper';
+	$ENV{GIT_EXTERNAL_DIFF} = 'env-helper';
 }
 
 sub exe
@@ -107,10 +107,16 @@ sub generate_command
 
 setup_environment();
 
+my @cmd = generate_command();
+$ENV{GIT_DIFF_TOOM} = $ENV{GIT_DIFF_TOOK} = $ENV{GIT_DIFF_TOOL};
+foreach my $k (keys %ENV) {
+	print STDERR "$k=$ENV{$k}\n"
+}
+
 # ActiveState Perl for Win32 does not implement POSIX semantics of
 # exec* system call. It just spawns the given executable and finishes
 # the starting program, exiting with code 0.
 # system will at least catch the errors returned by git diff,
 # allowing the caller of git difftool better handling of failures.
-my $rc = system(generate_command());
+my $rc = system(@cmd);
 exit($rc | ($rc >> 8));
diff --git i/run-command.c w/run-command.c
index 2a1041e..5cb0475 100644
--- i/run-command.c
+++ w/run-command.c
@@ -54,6 +54,11 @@ static const char **prepare_shell_cmd(const char **argv)
 static int execv_shell_cmd(const char **argv)
 {
 	const char **nargv = prepare_shell_cmd(argv);
+	if (1) {
+		char **p;
+		for (p = environ; *p; p++)
+			fprintf(stderr, "%p %s\n", *p, *p);
+	}
 	trace_argv_printf(nargv, "trace: exec:");
 	execvp(nargv[0], (char **)nargv);
 	free(nargv);
diff --git i/t/env-helper.c w/t/env-helper.c
index e69de29..3fe6053 100644
--- i/t/env-helper.c
+++ w/t/env-helper.c
@@ -0,0 +1,8 @@
+#include <stdio.h>
+
+int main (int argc, char *argv[], char **environ)
+{
+	char **p;
+	for (p = environ; *p; p++)
+		fprintf(stderr, "%p %s\n", *p, *p);
+}
diff --git i/t/valgrind/valgrind.sh w/t/valgrind/valgrind.sh
index 582b4dc..d5b9874 100755
--- i/t/valgrind/valgrind.sh
+++ w/t/valgrind/valgrind.sh
@@ -16,7 +16,5 @@ exec valgrind -q --error-exitcode=126 \
 	--suppressions="$GIT_VALGRIND/default.supp" \
 	--gen-suppressions=all \
 	$TRACK_ORIGINS \
-	--log-fd=4 \
-	--input-fd=4 \
 	$GIT_VALGRIND_OPTIONS \
 	"$GIT_VALGRIND"/../../"$base" "$@"

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
