From: Jeff King <peff@peff.net>
Subject: Re: t7006 sometimes hangs in cronjobs on OS X
Date: Wed, 9 Feb 2011 15:50:57 -0500
Message-ID: <20110209205056.GA2083@sigill.intra.peff.net>
References: <201102091538.46594.trast@student.ethz.ch>
 <20110209190900.GA8314@sigill.intra.peff.net>
 <201102092016.55078.trast@student.ethz.ch>
 <201102092122.19178.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Feb 09 21:51:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnH0L-0005VW-0m
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 21:51:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512Ab1BIUvD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Feb 2011 15:51:03 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:33949 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750853Ab1BIUvC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 15:51:02 -0500
Received: (qmail 12613 invoked by uid 111); 9 Feb 2011 20:51:00 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 09 Feb 2011 20:51:00 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Feb 2011 15:50:57 -0500
Content-Disposition: inline
In-Reply-To: <201102092122.19178.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166440>

On Wed, Feb 09, 2011 at 09:22:19PM +0100, Thomas Rast wrote:

> Thomas Rast wrote:
> > I'll have to put off the more involved experimentation somewhat :-(
> 
> Or not.
> 
> Anyway, I managed to load the relevant parts of t7006 in an
> interactive shell, and used
> 
>   i=0
>   while test_terminal git --no-pager log >out.$i 2>&1; do
>     i=$(($i+1))
>     echo $i
>   done

Great, that is a much smaller bit to work with. I of course can't
replicate it on my Linux boxes, though. :(

> Running 'dtruss -n git' instead did hit the issue, and I have the
> output saved away, but I'm not sure what I'd be looking for.  After
> all, the git process becomes a zombie:
> 
>   47606 s006  S+     0:00.13 /usr/bin/perl /Users/trast/git/t/test-terminal.perl git --no-pager log
>   47607 s006  Z+     0:00.00 (git)
>   47608 s006  Z+     0:00.00 (perl5.10.0)

Yeah, I think the problem is going to be in the perl process, but...

> The output for pid 47607 ends in:
> 
>   47607/0x1f7fec5:  write_nocancel(0x1, "Author: A U Thor <author@example.com>\n\0", 0x26)                 = 38 0
>   47607/0x1f7fec5:  write_nocancel(0x1, "Date:   Thu Apr 7 15:13:13 2005 -0700\n\0", 0x26)                 = 38 0
>   47607/0x1f7fec5:  write_nocancel(0x1, "\n\0", 0x1)               = 1 0
>   47607/0x1f7fec5:  write_nocancel(0x1, "    initial\n\0", 0xC)            = 12 0
>   47607/0x1f7fec5:  fstat64(0x1, 0x7FFF5FBFE8A0, 0x0)              = 0 0
>   47607/0x1f7fec5:  fstat64(0x1, 0x7FFF5FBFEF60, 0x0)              = 0 0
>   47607/0x1f7fec5:  close_nocancel(0x1)            = 0 0
> 
> Which seems rather unsurprising really :-(

It doesn't close(2) also? That could be the problem. I would expect it
also to exit().

> Finally, attaching dtruss after hitting the race gives no output when
> I finally kill it.

Yeah, it is probably stuck in some syscall. You could try instrumenting
your test-terminal.perl like:

diff --git a/t/test-terminal.perl b/t/test-terminal.perl
index ee01eb9..1755017 100755
--- a/t/test-terminal.perl
+++ b/t/test-terminal.perl
@@ -55,11 +55,15 @@ sub copy_stdio {
 	defined $pid or die "fork failed: $!";
 	if (!$pid) {
 		close($out);
+		print STDERR "child: pumping stderr\n";
 		xsendfile(\*STDERR, $err);
+		print STDERR "child: done pumping stderr\n";
 		exit 0;
 	}
 	close($err);
+	print STDERR "parent: pumping stdout\n";
 	xsendfile(\*STDOUT, $out);
+	print STDERR "parent: done pumping stdout\n";
 	finish_child($pid) == 0
 		or exit 1;
 }

and see which of those messages actually gets printed on the stuck case.
My suspicion is that one of the processes is getting stuck in xsendfile.
It may be the fault of File::Copy::copy, which I have seen be flaky
before on non-regular files. We should arguably be using non-buffered
I/O here anyway, so maybe try this:

diff --git a/t/test-terminal.perl b/t/test-terminal.perl
index ee01eb9..0d33da1 100755
--- a/t/test-terminal.perl
+++ b/t/test-terminal.perl
@@ -3,7 +3,6 @@ use 5.008;
 use strict;
 use warnings;
 use IO::Pty;
-use File::Copy;
 
 # Run @$argv in the background with stdio redirected to $out and $err.
 sub start_child {
@@ -46,7 +45,13 @@ sub xsendfile {
 	# from a disconnected terminal will return
 	# EIO (as in AIX 4.x, IRIX, and Linux) or
 	# end-of-file.  Either is fine.
-	copy($in, $out, 4096) or $!{EIO} or die "cannot copy from child: $!";
+	while (1) {
+		my $r = sysread($in, my $buf, 4096);
+		last if $r == 0;
+		last if !defined $r and $!{EIO};
+		die "cannot copy from child: $!" unless defined $r;
+		syswrite($out, $buf);
+	}
 }
 
 sub copy_stdio {
