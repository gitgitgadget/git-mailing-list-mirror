From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH] perl: redirect stderr to /dev/null instead of closing
Date: Thu, 4 Apr 2013 00:26:06 +0200
Message-ID: <f3d238a4c6cfbc6d68f2c4fa285aefa93acf4b7d.1365027616.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Wong <normalperson@yhbt.net>,
	Marcin Owsiany <marcin@owsiany.pl>, Petr Baudis <pasky@suse.cz>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 04 00:26:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNW8d-0007NN-F0
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 00:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759269Ab3DCW0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 18:26:11 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:49573 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758711Ab3DCW0K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 18:26:10 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 4 Apr
 2013 00:25:59 +0200
Received: from hexa.v.cablecom.net (46.126.8.85) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 4 Apr
 2013 00:26:06 +0200
X-Mailer: git-send-email 1.8.2.551.g91a1e48
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219976>

On my system, t9100.1 triggers the following warning:

  ==352== Syscall param write(buf) points to uninitialised byte(s)
  ==352==    at 0x57119C0: __write_nocancel (in /lib64/libc-2.17.so)
  ==352==    by 0x56AC1D2: _IO_file_write@@GLIBC_2.2.5 (in /lib64/libc-2.17.so)
  ==352==    by 0x56AC0B1: new_do_write (in /lib64/libc-2.17.so)
  ==352==    by 0x56AD3B4: _IO_do_write@@GLIBC_2.2.5 (in /lib64/libc-2.17.so)
  ==352==    by 0x56AD6FE: _IO_file_overflow@@GLIBC_2.2.5 (in /lib64/libc-2.17.so)
  ==352==    by 0x56AE3D8: _IO_default_xsputn (in /lib64/libc-2.17.so)
  ==352==    by 0x56ACAA2: _IO_file_xsputn@@GLIBC_2.2.5 (in /lib64/libc-2.17.so)
  ==352==    by 0x5682133: buffered_vfprintf (in /lib64/libc-2.17.so)
  ==352==    by 0x567CE9D: vfprintf (in /lib64/libc-2.17.so)
  ==352==    by 0x5687096: fprintf (in /lib64/libc-2.17.so)
  ==352==    by 0x4E7AC5: vreportf (usage.c:15)
  ==352==    by 0x4E7B14: die_builtin (usage.c:38)

The actual complaint appears to be a bug in the underlying
implementation.  What's interesting here is that it is apparently
_triggered_ by closing stderr, which results in (from strace)

  write(2, "fatal: Needed a single revision\n", 32) = -1 EBADF (Bad file descriptor)
  write(2, "\0", 1) = -1 EBADF (Bad file descriptor)

Closing stderr is a bad idea anyway: there is a very real chance that
we print fatal error messages to some other file that just happens to
be opened on the now-free FD 2.  So let's not do that.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---


The commit message is intentionally overdramatic on the chance of
printing stuff to bad places.  The code is actually from way back in
2006 (!).

The t9100 problem bisects to e3bd4dd (git-svn: don't create master if
another head exists, 2012-06-24), but that's just changing some
verify_ref(), which asks to close stderr on the git-rev-parse process.


I can easily reproduce the underlying issue with a small test: running

  #include <stdio.h>

  int main ()
  {
      	  fprintf(stderr, "%s%s\n", "fatal: ", "needed a single revision");
      	  return 0;
  }

with

  valgrind --log-fd=3 ./die_test 3>&2 2>&-

results in pretty much the same warnings.  I fail to see a reason
other than a glibc bug why

  fprintf(stderr, "%s%s\n", ...);

should attempt to write "\0" -- all its inputs are C strings.  But
maybe I'm missing something?



 perl/Git.pm | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/perl/Git.pm b/perl/Git.pm
index 96cac39..3b79a36 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1495,6 +1495,9 @@ sub _command_common_pipe {
 			if ($opts{STDERR}) {
 				open (STDERR, '>&', $opts{STDERR})
 					or die "dup failed: $!";
+			} elsif (defined $opts{STDERR}) {
+				open (STDERR, '>', '/dev/null')
+					or die "opening /dev/null failed: $!";
 			}
 			_cmd_exec($self, $cmd, @args);
 		}
-- 
1.8.2.551.g91a1e48
