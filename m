From: Jeff King <peff@peff.net>
Subject: Re: git-cvsexportcommit fails for huge commits
Date: Wed, 12 Dec 2007 03:31:54 -0500
Message-ID: <20071212083154.GB7676@coredump.intra.peff.net>
References: <20071211200418.GA13815@mkl-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Markus Klinik <markus.klinik@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 12 09:32:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2N1B-0000wR-Ki
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 09:32:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757233AbXLLIb6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 03:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758389AbXLLIb6
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 03:31:58 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3389 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758383AbXLLIb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 03:31:57 -0500
Received: (qmail 32341 invoked by uid 111); 12 Dec 2007 08:31:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Dec 2007 03:31:55 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Dec 2007 03:31:54 -0500
Content-Disposition: inline
In-Reply-To: <20071211200418.GA13815@mkl-desktop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68012>

On Tue, Dec 11, 2007 at 09:04:18PM +0100, Markus Klinik wrote:

> git-cvsexportcommit fails for huge commits, that is commits with lots
> of files.  To be exact, the problem arises if the generated 'cvs
> status' command exceeds the maximum length for commands.
> 
> Here is the error:
> 
> Can't exec "cvs": Argument list too long at
> /home/mkl/bin/git-cvsexportcommit line 334.  Argument list too long 0
> at /home/mkl/bin/git-cvsexportcommit line 334.  cvs status [snip:
> long, long list of files]  1792 at /home/mkl/bin/git-cvsexportcommit
> line 332.

Yuck. Unfortunately, CVS doesn't offer a more scalable interface, so we
are stuck splitting the arguments across multiple invocations.

However, I think this should work. The output of "cvs status foo bar" is
the same as "cvs status foo; cvs status bar". We will make our commits
in two CVS invocations, but since CVS isn't atomic _anyway_, we
shouldn't mind losing the atomicity.

Does the patch below clear up your problem?

---
diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 92e4162..20e432b 100755
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
@@ -335,6 +335,22 @@ sub safe_pipe_capture {
     return wantarray ? @output : join('',@output);
 }
 
+sub xargs_safe_pipe_capture {
+	my $MAX_ARG_LENGTH = 1024;
+	my $cmd = shift;
+	my @output;
+	while(@_) {
+		my @args;
+		my $length = 0;
+		while(@_ && $length < $MAX_ARG_LENGTH) {
+			push @args, shift;
+			$length += length($args[$#args]);
+		}
+		push @output, safe_pipe_capture(@$cmd, @args);
+	}
+	return @output;
+}
+
 sub safe_pipe_capture_blob {
     my $output;
     if (my $pid = open my $child, '-|') {
