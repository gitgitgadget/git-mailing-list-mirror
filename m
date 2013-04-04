From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH v2 1/2] perl: redirect stderr to /dev/null instead of closing
Date: Thu, 4 Apr 2013 22:41:41 +0200
Message-ID: <801ebb2a75d7cddfeee70eb86e8854c78d22eb3e.1365107899.git.trast@inf.ethz.ch>
References: <20130404011653.GA28492@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Wong <normalperson@yhbt.net>,
	Marcin Owsiany <marcin@owsiany.pl>, Petr Baudis <pasky@ucw.cz>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 04 22:42:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNqz9-0005dx-WA
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 22:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760519Ab3DDUlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 16:41:47 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:16485 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760169Ab3DDUlq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 16:41:46 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 4 Apr
 2013 22:41:39 +0200
Received: from hexa.v.cablecom.net (46.126.8.85) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 4 Apr
 2013 22:41:42 +0200
X-Mailer: git-send-email 1.8.2.607.g19d29d3
In-Reply-To: <20130404011653.GA28492@dcvr.yhbt.net>
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220097>

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

As pointed out by Eric Wong (thanks), the initial close needs to go:
die() would again write nowhere if we close STDERR beforehand.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---

> Perhaps we should also do the following:
>
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -1489,9 +1489,6 @@ sub _command_common_pipe {
>  		if (not defined $pid) {
>  			throw Error::Simple("open failed: $!");
>  		} elsif ($pid == 0) {
> -			if (defined $opts{STDERR}) {
> -				close STDERR;
> -			}
>  			if ($opts{STDERR}) {
>  				open (STDERR, '>&', $opts{STDERR})
>					or die "dup failed: $!";

Indeed.  Thanks for pointing that out.

 perl/Git.pm | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 96cac39..2cec8cf 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1489,12 +1489,12 @@ sub _command_common_pipe {
 		if (not defined $pid) {
 			throw Error::Simple("open failed: $!");
 		} elsif ($pid == 0) {
-			if (defined $opts{STDERR}) {
-				close STDERR;
-			}
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
1.8.2.607.g19d29d3
