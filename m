From: Jeff King <peff@peff.net>
Subject: Re: feature request: git add--interactive --patch on regex-matched
 hunks only
Date: Mon, 25 Jul 2011 15:55:55 -0600
Message-ID: <20110725215553.GA23145@sigill.intra.peff.net>
References: <CACsJy8B1B25DZ1yrzHq69vwgzQyM2ouTXCHb8oPRpb_cAX+JZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 25 23:56:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlT89-0003KZ-Tz
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 23:56:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507Ab1GYV4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 17:56:00 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56969
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751290Ab1GYVz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 17:55:59 -0400
Received: (qmail 14116 invoked by uid 107); 25 Jul 2011 21:56:28 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Jul 2011 17:56:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Jul 2011 15:55:55 -0600
Content-Disposition: inline
In-Reply-To: <CACsJy8B1B25DZ1yrzHq69vwgzQyM2ouTXCHb8oPRpb_cAX+JZQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177823>

On Sun, Jul 24, 2011 at 12:11:29PM +0700, Nguyen Thai Ngoc Duy wrote:

> Can we have "git add--interactive --patch --match=regex" where only
> (splitted if possible) hunks that match regex are shown?

The patch below does this, but there are a lot of unanswered questions.
Such as:

  1. What does it mean to be "shown"? My patch auto-marks non-matching
     hunks as "do not stage". That means you can still switch back to
     them in the hunk list and enable them if you want. Another option
     would be to omit them entirely, and pretend that those hunks don't
     exist.

  2. What should we do with non-text changes, like mode changes are
     full-file deletion?

  3. What should be shown for a file with no matching hunks? Probably
     nothing (i.e., as if it had been limited away by pathname)? My
     patch shows the header, but that is easy to fix.

I think those depend on the intended use case. For me, it seems useful
to do something like:

  $ hack hack hack
  [oops, I need to refactor foo() and its callers first]
  $ refactor refactor refactor
  $ git add -p --match=foo
  $ git commit -m 'refactor foo'
  [resume initial hacking]

However, I'm not sure I would trust my regex to actually get all of the
changes needed for the refactoring (e.g., there might be nearby hunks
related to the refactoring that are not specifically in the same hunk as
the word "foo"). So I tend to just "git add -p" and flip through the
changes manually.

> I've been reviewing a .po file and adding translations that I approve,
> leaving the rest to be determined later. The problem with .po files is
> that a lot of comment lines are changes because some translations are
> moved in source code. I don't care about those comment changes and
> would like to completely ignore them (even destroy them with git
> checkout -p).

You can already skip around in the hunk list using "/regex". Might that
be enough for you? I think you're stuck typing "/yoursearch" over and
over, though. It would be nice if doing just "/" would search again for
the previous regex.

Anyway, here's the patch. It's just the perl bits. You'd need to write
the scaffolding to add an option to "git add", "git checkout", etc.

---
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 2ee0908..07896d4 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -86,6 +86,7 @@ sub colored {
 # command line options
 my $patch_mode;
 my $patch_mode_revision;
+my $patch_match;
 
 sub apply_patch;
 sub apply_patch_for_checkout_commit;
@@ -1277,6 +1278,17 @@ sub display_hunks {
 	return $i;
 }
 
+sub want_hunk {
+	my ($re, $hunk) = @_;
+
+	return 1 if $hunk->{TYPE} ne 'hunk';
+
+	foreach my $line (@{$hunk->{TEXT}}) {
+		return 1 if $line =~ $re;
+	}
+	return 0;
+}
+
 sub patch_update_file {
 	my $quit = 0;
 	my ($ix, $num);
@@ -1301,6 +1313,20 @@ sub patch_update_file {
 	$num = scalar @hunk;
 	$ix = 0;
 
+	if ($patch_match) {
+		# mark non-matching text hunks as "do not want"
+		foreach my $hunk (@hunk) {
+			if (!want_hunk($patch_match, $hunk)) {
+				$hunk->{USE} = 0;
+			}
+		}
+		# and then advance us to the first undecided hunk
+		while ($ix < $num) {
+			last unless defined $hunk[$ix]{USE};
+			$ix++;
+		}
+	}
+
 	while (1) {
 		my ($prev, $next, $other, $undecided, $i);
 		$other = '';
@@ -1606,6 +1632,10 @@ sub process_args {
 		} else {
 			$patch_mode = 'stage';
 			$arg = shift @ARGV or die "missing --";
+			if ($arg =~ /--match=(.*)/) {
+				$patch_match = qr/$1/;
+				$arg = shift @ARGV or die "missing --";
+			}
 		}
 		die "invalid argument $arg, expecting --"
 		    unless $arg eq "--";
