From: Jeff King <peff@peff.net>
Subject: Re: git-cvsexportcommit fails for huge commits
Date: Fri, 14 Dec 2007 04:15:47 -0500
Message-ID: <20071214091546.GA20907@coredump.intra.peff.net>
References: <20071211200418.GA13815@mkl-desktop> <20071212083154.GB7676@coredump.intra.peff.net> <7vir348e0l.fsf@gitster.siamese.dyndns.org> <20071212092512.GB20799@coredump.intra.peff.net> <7vzlwevu2k.fsf@gitster.siamese.dyndns.org> <20071214044554.GB10169@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Markus Klinik <markus.klinik@gmx.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 10:16:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J36eU-0001hB-GR
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 10:16:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759658AbXLNJPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 04:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759587AbXLNJPv
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 04:15:51 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1854 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758750AbXLNJPu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 04:15:50 -0500
Received: (qmail 21933 invoked by uid 111); 14 Dec 2007 09:15:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 14 Dec 2007 04:15:48 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Dec 2007 04:15:47 -0500
Content-Disposition: inline
In-Reply-To: <20071214044554.GB10169@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68271>

On Thu, Dec 13, 2007 at 11:45:54PM -0500, Jeff King wrote:

> So it seems that we could probably go with something more like 64K, and
> then only truly pathological cases should trigger the behavior.

So here is a cleaned up patch. It bumps the maximum size to 64kB, adds
scalar support (nobody uses it, but it makes sense for the interface to
match that of safe_pipe_capture -- I am even tempted to just replace
safe_pipe_capture entirely and convert the few other callers), and
cleans up the unused safe_pipe_capture_blob.

-- >8 --
cvsexportcommit: fix massive commits

Because we feed the changed filenames to CVS on the command
line, it was possible for massive commits to overflow the
system exec limits. Instead, we now do an xargs-like split
of the arguments.

This means that we lose some of the atomicity of calling CVS
in one shot. Since CVS commits are not atomic, but the CVS
protocol is, the possible effects of this are not clear;
however, since CVS doesn't provide a different interface,
this is our only option for large commits (short of writing
a CVS client library).

The argument size limit is arbitrarily set to 64kB. This
should be high enough to trigger only in rare cases where it
is necessary, so normal-sized commits are not affected by
the atomicity change.
---
I think the atomicity might matter if you are using cvsexportcommit to
talk to a CVS server backed by something besides CVS, like
git-cvsserver. Which of course would be useless, but who is to say
that other such systems don't exist with CVS as an SCM lingua franca?

 git-cvsexportcommit.perl |   37 +++++++++++++++++++++++--------------
 1 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 92e4162..d2e50c3 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -195,11 +195,11 @@ foreach my $f (@files) {
 my %cvsstat;
 if (@canstatusfiles) {
     if ($opt_u) {
-      my @updated = safe_pipe_capture(@cvs, 'update', @canstatusfiles);
+      my @updated = xargs_safe_pipe_capture([@cvs, 'update'], @canstatusfiles);
       print @updated;
     }
     my @cvsoutput;
-    @cvsoutput= safe_pipe_capture(@cvs, 'status', @canstatusfiles);
+    @cvsoutput = xargs_safe_pipe_capture([@cvs, 'status'], @canstatusfiles);
     my $matchcount = 0;
     foreach my $l (@cvsoutput) {
         chomp $l;
@@ -295,7 +295,7 @@ if ($dirtypatch) {
 
 if ($opt_c) {
     print "Autocommit\n  $cmd\n";
-    print safe_pipe_capture(@cvs, 'commit', '-F', '.msg', @files);
+    print xargs_safe_pipe_capture([@cvs, 'commit', '-F', '.msg'], @files);
     if ($?) {
 	die "Exiting: The commit did not succeed";
     }
@@ -335,15 +335,24 @@ sub safe_pipe_capture {
     return wantarray ? @output : join('',@output);
 }
 
-sub safe_pipe_capture_blob {
-    my $output;
-    if (my $pid = open my $child, '-|') {
-        local $/;
-	undef $/;
-	$output = (<$child>);
-	close $child or die join(' ',@_).": $! $?";
-    } else {
-	exec(@_) or die "$! $?"; # exec() can fail the executable can't be found
-    }
-    return $output;
+sub xargs_safe_pipe_capture {
+	my $MAX_ARG_LENGTH = 65536;
+	my $cmd = shift;
+	my @output;
+	my $output;
+	while(@_) {
+		my @args;
+		my $length = 0;
+		while(@_ && $length < $MAX_ARG_LENGTH) {
+			push @args, shift;
+			$length += length($args[$#args]);
+		}
+		if (wantarray) {
+			push @output, safe_pipe_capture(@$cmd, @args);
+		}
+		else {
+			$output .= safe_pipe_capture(@$cmd, @args);
+		}
+	}
+	return wantarray ? @output : $output;
 }
-- 
1.5.4.rc0.1088.g8a30-dirty
