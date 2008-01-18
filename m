From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] send-email: detect invocation errors earlier
Date: Fri, 18 Jan 2008 09:19:36 -0500
Message-ID: <20080118141935.GA19783@coredump.intra.peff.net>
References: <20080118141638.GA14928@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Adam Piatyszek <ediap@users.sourceforge.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 15:20:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFs4l-0001Po-G9
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 15:20:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758100AbYAROTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 09:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758104AbYAROTi
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 09:19:38 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1442 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757683AbYAROTi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 09:19:38 -0500
Received: (qmail 18464 invoked by uid 111); 18 Jan 2008 14:19:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 18 Jan 2008 09:19:37 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Jan 2008 09:19:36 -0500
Content-Disposition: inline
In-Reply-To: <20080118141638.GA14928@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71019>

We never even look at the command line arguments until after
we have prompted the user for some information. So running
"git send-email" without arguments would prompt for "from"
and "to" headers, only to then die with "No patch files
specified." Instead, let's try to do as much error checking
as possible before getting user input.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-send-email.perl |   55 +++++++++++++++++++++++++--------------------------
 1 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index e47994a..7a86977 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -314,6 +314,33 @@ if (@alias_files and $aliasfiletype and defined $parse_alias{$aliasfiletype}) {
 
 ($sender) = expand_aliases($sender) if defined $sender;
 
+# Now that all the defaults are set, process the rest of the command line
+# arguments and collect up the files that need to be processed.
+for my $f (@ARGV) {
+	if (-d $f) {
+		opendir(DH,$f)
+			or die "Failed to opendir $f: $!";
+
+		push @files, grep { -f $_ } map { +$f . "/" . $_ }
+				sort readdir(DH);
+
+	} elsif (-f $f) {
+		push @files, $f;
+
+	} else {
+		print STDERR "Skipping $f - not found.\n";
+	}
+}
+
+if (@files) {
+	unless ($quiet) {
+		print $_,"\n" for (@files);
+	}
+} else {
+	print STDERR "\nNo patch files specified!\n\n";
+	usage();
+}
+
 my $prompting = 0;
 if (!defined $sender) {
 	$sender = $repoauthor || $repocommitter;
@@ -427,34 +454,6 @@ EOT
 	@files = ($compose_filename . ".final");
 }
 
-
-# Now that all the defaults are set, process the rest of the command line
-# arguments and collect up the files that need to be processed.
-for my $f (@ARGV) {
-	if (-d $f) {
-		opendir(DH,$f)
-			or die "Failed to opendir $f: $!";
-
-		push @files, grep { -f $_ } map { +$f . "/" . $_ }
-				sort readdir(DH);
-
-	} elsif (-f $f) {
-		push @files, $f;
-
-	} else {
-		print STDERR "Skipping $f - not found.\n";
-	}
-}
-
-if (@files) {
-	unless ($quiet) {
-		print $_,"\n" for (@files);
-	}
-} else {
-	print STDERR "\nNo patch files specified!\n\n";
-	usage();
-}
-
 # Variables we set as part of the loop over files
 our ($message_id, %mail, $subject, $reply_to, $references, $message);
 
-- 
1.5.4.rc3.1128.g1826-dirty
