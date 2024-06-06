Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C16113AD06
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 08:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717662160; cv=none; b=C+EhXvLEX0txMZchCtblSK/Bh8/92goDT/x/IuMAcdBXHSgjuR97K1oprcL14MRBhiNef/rvJ/fyvQzcO9NzJJ3EibHwtCBTSDflKtFSswW5vGUS3xar0+OSD7Rrhk2k0WtvEQURCvQXHm+vdYXAaxwZClN/S2VafoCTTIA+EqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717662160; c=relaxed/simple;
	bh=LAjlTxeJa1/MRXfllYq1GOTIbZsXGlYmOcfTDH7iZzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOdVnOzz8MwdtNldu+t7JN2STEKP6au+6BjJjzpOSLPCp0L9cZCeBn+nKIeJzq1lD19y/i3cl/zIshyw3R7Fh5owyOo6hBXrVvrHAIA00YvSB+XUbiuH1JFSQ6JnyuVo7rqE6eWzZioUN20+XRR5MHYcgWIXX2J1aIdm41oGzaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11215 invoked by uid 109); 6 Jun 2024 08:22:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 06 Jun 2024 08:22:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6662 invoked by uid 111); 6 Jun 2024 08:22:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 06 Jun 2024 04:22:35 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 6 Jun 2024 04:22:37 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: [PATCH 2/2] test-terminal: drop stdin handling
Message-ID: <20240606082237.GB1167215@coredump.intra.peff.net>
References: <20240606081724.GA1166769@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240606081724.GA1166769@coredump.intra.peff.net>

Since 18d8c26930 (test_terminal: redirect child process' stdin to a pty,
2015-08-04), we set up a pty and copy stdin to the child program. But
this ends up being racy; once we send all of the bytes and close the
descriptor, the child program will no longer see a terminal! isatty()
will return 0, and trying to read may return EIO, even if we didn't yet
get all of the bytes.

This was mentioned even in the commit message of 18d8c26930, but we
hacked around it by just sending an infinite input from /dev/zero (in
the intended case, we only cared about isatty(0), not reading actual
input).

And it came up again recently in:

  https://lore.kernel.org/git/d42a55b1-1ba9-4cfb-9c3d-98ea4d86da33@gmail.com/

where we tried to actually send bytes, but they don't always all come
through. So this interface is somewhat of an accident waiting to happen;
a caller might not even care about stdin being a tty, but will get bit
by the flaky behavior.

One solution would probably be to avoid closing test_terminal's end of
the pty altogether. But then the other side would never see EOF on its
stdin.  That may be OK for some cases, but it's another gotcha that
might cause races or deadlocks, depending on what the child expects to
read.

Let's instead just drop test_terminal's stdin feature completely. Since
the previous commit dropped the two cases from t4153 for which the
feature was originally added, there are no callers left that need it.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/test-terminal.perl | 29 +++--------------------------
 1 file changed, 3 insertions(+), 26 deletions(-)

diff --git a/t/test-terminal.perl b/t/test-terminal.perl
index 3810e9bb43..b8fd6a4f13 100755
--- a/t/test-terminal.perl
+++ b/t/test-terminal.perl
@@ -5,17 +5,15 @@
 use IO::Pty;
 use File::Copy;
 
-# Run @$argv in the background with stdio redirected to $in, $out and $err.
+# Run @$argv in the background with stdio redirected to $out and $err.
 sub start_child {
-	my ($argv, $in, $out, $err) = @_;
+	my ($argv, $out, $err) = @_;
 	my $pid = fork;
 	if (not defined $pid) {
 		die "fork failed: $!"
 	} elsif ($pid == 0) {
-		open STDIN, "<&", $in;
 		open STDOUT, ">&", $out;
 		open STDERR, ">&", $err;
-		close $in;
 		close $out;
 		exec(@$argv) or die "cannot exec '$argv->[0]': $!"
 	}
@@ -51,17 +49,6 @@ sub xsendfile {
 	copy($in, $out, 4096) or $!{EIO} or die "cannot copy from child: $!";
 }
 
-sub copy_stdin {
-	my ($in) = @_;
-	my $pid = fork;
-	if (!$pid) {
-		xsendfile($in, \*STDIN);
-		exit 0;
-	}
-	close($in);
-	return $pid;
-}
-
 sub copy_stdio {
 	my ($out, $err) = @_;
 	my $pid = fork;
@@ -81,25 +68,15 @@ sub copy_stdio {
 	die "usage: test-terminal program args";
 }
 $ENV{TERM} = 'vt100';
-my $parent_in = new IO::Pty;
 my $parent_out = new IO::Pty;
 my $parent_err = new IO::Pty;
-$parent_in->set_raw();
 $parent_out->set_raw();
 $parent_err->set_raw();
-$parent_in->slave->set_raw();
 $parent_out->slave->set_raw();
 $parent_err->slave->set_raw();
-my $pid = start_child(\@ARGV, $parent_in->slave, $parent_out->slave, $parent_err->slave);
-close $parent_in->slave;
+my $pid = start_child(\@ARGV, $parent_out->slave, $parent_err->slave);
 close $parent_out->slave;
 close $parent_err->slave;
-my $in_pid = copy_stdin($parent_in);
 copy_stdio($parent_out, $parent_err);
 my $ret = finish_child($pid);
-# If the child process terminates before our copy_stdin() process is able to
-# write all of its data to $parent_in, the copy_stdin() process could stall.
-# Send SIGTERM to it to ensure it terminates.
-kill 'TERM', $in_pid;
-finish_child($in_pid);
 exit($ret);
-- 
2.45.2.817.g6f0d0f2a6c
