From: Jeff King <peff@peff.net>
Subject: [PATCH] add--interactive: allow custom diff highlighting programs
Date: Sat, 27 Feb 2016 00:37:06 -0500
Message-ID: <20160227053706.GA21117@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 06:37:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZXZC-0001VX-Sv
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 06:37:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbcB0FhK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 00:37:10 -0500
Received: from cloud.peff.net ([50.56.180.127]:50572 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750964AbcB0FhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 00:37:09 -0500
Received: (qmail 26643 invoked by uid 102); 27 Feb 2016 05:37:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 27 Feb 2016 00:37:09 -0500
Received: (qmail 10804 invoked by uid 107); 27 Feb 2016 05:37:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 27 Feb 2016 00:37:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 27 Feb 2016 00:37:06 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287659>

The patch hunk selector of add--interactive knows how ask
git for colorized diffs, and correlate them with the
uncolored diffs we apply. But there's not any way for
somebody who uses a diff-filter tool like contrib's
diff-highlight to see their normal highlighting.

This patch lets users define an arbitrary shell command to
pipe the colorized diff through. The exact output shouldn't
matter (since we just show the result to humans) as long as
it is line-compatible with the original diff (so that
hunk-splitting can split the colorized version, too).

I left two minor issues with the new system that I don't
think are worth fixing right now, but could be done later:

  1. We only filter colorized diffs. Theoretically a user
     could want to filter a non-colorized diff, but I find
     it unlikely in practice. Users who are doing things
     like diff-highlighting are likely to want color, too.

  2. add--interactive will re-colorize a diff which has been
     hand-edited, but it won't have run through the filter.
     Fixing this is conceptually easy (just pipe the diff
     through the filter), but practically hard to do without
     using tempfiles (it would need to feed data to and read
     the result from the filter without deadlocking; this
     raises portability questions with respect to Windows).

I've punted on both issues for now, and if somebody really
cares later, they can do a patch on top.

Signed-off-by: Jeff King <peff@peff.net>
---
This is a little hack I whipped up after the diff-so-fancy people asked
me about it in:

  https://github.com/so-fancy/diff-so-fancy/issues/35

It's something I've wanted for a while with diff-highlight. I made sure
it works (the final hunk of this patch was added via highlighted "add
-p". Woohoo!), but other than that it hasn't been exposed to a lot of
corner cases.

I'm actually not sure whether it will work well with diff-so-fancy or
not; they change the diff header around a bit, and there's not a
complete 1:1 correspondence in the lines. _But_ I think it might work OK
in practice, because their diff header remains 4 lines long, and the
hunks themselves have 1:1 line correspondence.

 Documentation/config.txt  |  8 ++++++++
 git-add--interactive.perl | 12 ++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2cd6bdd..f5834ec 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1886,6 +1886,14 @@ interactive.singleKey::
 	setting is silently ignored if portable keystroke input
 	is not available; requires the Perl module Term::ReadKey.
 
+interactive.diffFilter::
+	When an interactive command (such as `git add --patch`) shows
+	a colorized diff, git will pipe the diff through the shell
+	command defined by this configuration variable. The command may
+	mark up the diff further for human consumption, provided that it
+	retains a one-to-one correspondence with the lines in the
+	original diff. Defaults to disabled (no filtering).
+
 log.abbrevCommit::
 	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
 	linkgit:git-whatchanged[1] assume `--abbrev-commit`. You may
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 77876d4..822f857 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -45,6 +45,7 @@ my ($diff_new_color) =
 my $normal_color = $repo->get_color("", "reset");
 
 my $diff_algorithm = $repo->config('diff.algorithm');
+my $diff_filter = $repo->config('interactive.difffilter');
 
 my $use_readkey = 0;
 my $use_termcap = 0;
@@ -754,7 +755,14 @@ sub parse_diff {
 	my @diff = run_cmd_pipe("git", @diff_cmd, "--", $path);
 	my @colored = ();
 	if ($diff_use_color) {
-		@colored = run_cmd_pipe("git", @diff_cmd, qw(--color --), $path);
+		my @display_cmd = ("git", @diff_cmd, qw(--color --), $path);
+		if (defined $diff_filter) {
+			# quotemeta is overkill, but sufficient for shell-quoting
+			my $diff = join(' ', map { quotemeta } @display_cmd);
+			@display_cmd = ("$diff | $diff_filter");
+		}
+
+		@colored = run_cmd_pipe(@display_cmd);
 	}
 	my (@hunk) = { TEXT => [], DISPLAY => [], TYPE => 'header' };
 
@@ -765,7 +773,7 @@ sub parse_diff {
 		}
 		push @{$hunk[-1]{TEXT}}, $diff[$i];
 		push @{$hunk[-1]{DISPLAY}},
-			($diff_use_color ? $colored[$i] : $diff[$i]);
+			(@colored ? $colored[$i] : $diff[$i]);
 	}
 	return @hunk;
 }
-- 
2.7.2.767.g705917e
