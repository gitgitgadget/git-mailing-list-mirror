From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: t7800-difftool.sh failure on pu
Date: Thu, 29 Mar 2012 19:12:20 +0100
Message-ID: <4F74A604.3040402@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: tim.henigan@gmail.com
X-From: git-owner@vger.kernel.org Thu Mar 29 20:14:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDJrE-0002Jw-6W
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 20:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933671Ab2C2SN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 14:13:58 -0400
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:56016 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933464Ab2C2SN4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Mar 2012 14:13:56 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1SDJr8-0005YL-j3; Thu, 29 Mar 2012 18:13:55 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194284>

Hi Tim,

With the current pu branch, I have t7800.3 (difftool ignores bad --tool values)
failing on Linux (I haven't tried cygwin or mingw yet). The failure is caused
by the test for the value of the exit code; for me the exit code is 9 not 1.

I have investigated, briefly, and found *two* alternatives for a fix. ;-)

The first option is to (effectively) revert commit 0440ed72 ("difftool: replace
system call with Git::command_noisy", 22-03-2012), like so:

-- >8 --
diff --git a/git-difftool.perl b/git-difftool.perl
index e1754ff..49613b1 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -237,5 +237,7 @@ if (defined($dirdiff)) {
 
 	$ENV{GIT_PAGER} = '';
 	$ENV{GIT_EXTERNAL_DIFF} = 'git-difftool--helper';
-	git_cmd_try { Git::command_noisy(('diff', @ARGV)) } 'exit code %d';
+	my @command = ('git', 'diff', @ARGV);
+	my $rc = system(@command);
+	exit($rc | ($rc >> 8));
 }
-- 8< --

The second option is a bit of a mystery, since I don't see why it is necessary
or why it works! :-P

First take a look at the following:

$ perl -e 'print $!+0, " $!\n";'
0 
$ echo $?
0

$ perl -e 'use Carp qw(croak); print $!+0, " $!\n";'
9 Bad file descriptor
$ echo $?
0

$ perl -e 'use Carp qw(croak); print $!+0, " $!\n"; croak oops;'
9 Bad file descriptor
oops at -e line 1
$ echo $?
9

$ perl -e 'use Carp qw(croak); print $!+0, " $!\n"; $!=0; croak oops;'
9 Bad file descriptor
oops at -e line 1
$ echo $?
255

$ perl -e 'use Carp qw(croak); print $!+0, " $!\n"; $!=0;  $?=1<<8; croak oops;'
9 Bad file descriptor
oops at -e line 1
$ echo $?
1

$ 

So, it seems that a stray non-zero errno (Bad file descriptor) is finding it's
way to the perl exit value via the die call from within croak(). In particular,
the call to croak within git_cmd_try() from Git.pm.

However, I don't see why this is happening, since just before the call to croak
the perl vars $! (errno) and $? (exit status) are set to the *correct* values.
Namely, $! is zero and $? is 256 (1<<8). As you can see from the above, that
*should* result in the correct exit code. However, unlike above, git-difftool.perl
returns 9.

Since 'croak' exits via a 'die' call, in desperation, I tried the following
patch - and it works! Just don't ask me why. :-D

-- 8< --
diff --git a/perl/Git.pm b/perl/Git.pm
index 1c96a20..264a45f 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1258,7 +1258,7 @@ sub git_cmd_try(&$) {
 		# We can't croak here since Error.pm would mangle
 		# that to Error::Simple.
 	};
-	$err and croak $err;
+	$err and die $err;
 	return $array ? @result : $result[0];
 }
 
-- >8 --

HTH

ATB,
Ramsay Jones
