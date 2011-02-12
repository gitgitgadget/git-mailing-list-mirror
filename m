From: Jeff King <peff@peff.net>
Subject: Re: t7006 sometimes hangs in cronjobs on OS X
Date: Sat, 12 Feb 2011 00:12:39 -0500
Message-ID: <20110212051239.GA31606@sigill.intra.peff.net>
References: <201102091538.46594.trast@student.ethz.ch>
 <20110209190900.GA8314@sigill.intra.peff.net>
 <201102092016.55078.trast@student.ethz.ch>
 <201102092122.19178.trast@student.ethz.ch>
 <20110209205056.GA2083@sigill.intra.peff.net>
 <20110212020321.GA24629@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 12 06:12:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Po7mo-0005ro-0E
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 06:12:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231Ab1BLFMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Feb 2011 00:12:35 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:55712 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751097Ab1BLFMe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Feb 2011 00:12:34 -0500
Received: (qmail 30710 invoked by uid 111); 12 Feb 2011 05:12:33 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 12 Feb 2011 05:12:33 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 12 Feb 2011 00:12:39 -0500
Content-Disposition: inline
In-Reply-To: <20110212020321.GA24629@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166593>

On Fri, Feb 11, 2011 at 08:03:21PM -0600, Jonathan Nieder wrote:

> Nice, I can reproduce this (kernel = Darwin 10.5.0, using Apple's perl
> 5.10.0).  With
> 
> 	while ./test-terminal.perl echo hi >out.$i 2>&1
> 	do
> 		i=$(($i + 1))
> 		echo $i
> 	done

Cool, more narrowing it down is nice. I'm not surprised it's a
test-terminal problem, not a git problem, but it's nice to see
confirmation.

> I get:
> 
> 	$ cat out.28 
> 	child: pumping stdout
> 	child: pumping stderr
> 	hi
> 	child: done pumping stdout

Hmm. So here, the stderr process hangs...

> Instrumenting Copy.pm, I can see that we are stuck in sysread.
> 
> 	31984: child: pumping stdout
> 	31984: enter copy loop.
> 	31984: time to read 4096...
> 	31986: child: pumping stderr
> 	31984: read returns with 4
> 	31984: about to write "hi
> 	"
> 	31984: pump 4 - 0, result = 4
> 	31984: time to read 4096...
> 	31986: enter copy loop.
> 	31986: time to read 4096...
> 	31986: read returns with 0
> 	31986: about to write ""
> 	31986: done!
> 	31986: successful return.
> 	31986: copy returns with 1 errno=
> 	31986: child: done pumping stderr

...but here, the stdout process hangs. Weird.

So I'm not even sure our perl is bad. It's just that for some reason the
pty allocated by IO::Pty doesn't give us EOF sometimes. Hmm. Two curious
things I notice:

  1. In your Copy.pm log above, it says read gives it 4 characters. But
     "hi\n" has only 3. CRLF or some other hidden character?

  2. In test-terminal.perl, start_child clones the $out and $err handles
     (which are the IO::Pty slaves). Then it closes $out, but not $err.
     Why not? It shouldn't matter, since the child process ends up
     dying, which should close all descriptors. And if that were the
     problem, I would expect it to always hang on stderr, but your
     examples show the hang on both descriptors.

     Also, should the child be closing the pty masters? Again, it
     shouldn't make a difference, both because the masters should be
     waiting for the slaves to close to get EOF, and because the child
     process dying should close all descriptors.

     But the first could be explained by some differing bsd pty
     semantics that Linux doesn't have. But for the second, I dunno.

I would first try this patch:

diff --git a/t/test-terminal.perl b/t/test-terminal.perl
index ee01eb9..bfec680 100755
--- a/t/test-terminal.perl
+++ b/t/test-terminal.perl
@@ -15,6 +15,7 @@ sub start_child {
 		open STDOUT, ">&", $out;
 		open STDERR, ">&", $err;
 		close $out;
+		close $err;
 		exec(@$argv) or die "cannot exec '$argv->[0]': $!"
 	}
 	return $pid;

and then try this more drastic one:

diff --git a/t/test-terminal.perl b/t/test-terminal.perl
index ee01eb9..cce7de0 100755
--- a/t/test-terminal.perl
+++ b/t/test-terminal.perl
@@ -12,9 +12,12 @@ sub start_child {
 	if (not defined $pid) {
 		die "fork failed: $!"
 	} elsif ($pid == 0) {
-		open STDOUT, ">&", $out;
-		open STDERR, ">&", $err;
+		open STDOUT, ">&", $out->slave;
+		open STDERR, ">&", $err->slave;
+		close $out->slave;
 		close $out;
+		close $err->slave;
+		close $err;
 		exec(@$argv) or die "cannot exec '$argv->[0]': $!"
 	}
 	return $pid;
@@ -69,7 +72,7 @@ if ($#ARGV < 1) {
 }
 my $master_out = new IO::Pty;
 my $master_err = new IO::Pty;
-my $pid = start_child(\@ARGV, $master_out->slave, $master_err->slave);
+my $pid = start_child(\@ARGV, $master_out, $master_err);
 close $master_out->slave;
 close $master_err->slave;
 copy_stdio($master_out, $master_err);

Also, I don't know what kind of support you have for stuff like lsof,
but in theory we should be able to get a hung process, find the open
descriptor for the pty using lsof, match that descriptor with the other
end of the pty, and then see which processes have that pty still open.

> Redirecting stderr by using 'xsendfile("elsewhere", $err);' avoids
> trouble.

That seems doubly weird, since you are changing the _output_, not the
input. But the input is what is causing the hang.

> Sometimes output includes some streams of null bytes, which makes me
> suspect something awry in the kernel.

Yuck.

-Peff
