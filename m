From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] git-add--interactive: manual hunk editing mode
Date: Tue, 10 Jun 2008 07:05:53 -0400
Message-ID: <20080610110553.GA13655@sigill.intra.peff.net>
References: <200805232221.45406.trast@student.ethz.ch> <200806091931.51221.johan@herland.net> <20080609201734.GA15662@sigill.intra.peff.net> <200806092319.23906.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Jun 10 13:07:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K61h3-0001Go-5f
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 13:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755193AbYFJLF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 07:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751715AbYFJLF5
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 07:05:57 -0400
Received: from peff.net ([208.65.91.99]:4590 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750821AbYFJLF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 07:05:56 -0400
Received: (qmail 31409 invoked by uid 111); 10 Jun 2008 11:05:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 10 Jun 2008 07:05:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jun 2008 07:05:53 -0400
Content-Disposition: inline
In-Reply-To: <200806092319.23906.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84495>

On Mon, Jun 09, 2008 at 11:19:23PM +0200, Johan Herland wrote:

> On Monday 09 June 2008, Jeff King wrote:
> > But honestly, I don't really see a use case that isn't covered by
> > "manually edit the diff and apply the hunk". And the rationale in your
> > "side note" indicates that you think the same way.

Below is a simple patch to build interactive edit support on top of
Dscho's "git apply --recount" patch. Rather than create new hunks, the
action is just "edit and apply": if the apply is successful, the hunk is
removed from further consideration. This is just for playing with, and
not for commit:

  - it's not very well tested :)

  - I think the recount stuff may have flaws; I didn't follow the thread
    too closely, but Junio seemed to have a lot of comments (I am
    working under the assumption that Dscho will get that part right,
    and we can just build on top of it)

  - I tried one or two simple tests where I edited and applied an early
    hunk, and then resumed the loop for later hunks. Everything seemed
    to work, but I am not convinced that it isn't possible to make the
    rest of the hunk selection loop useless by applying early and
    invalidating all of the other hunks. That might be a flaw with this
    approach. A more sane interface might be to simply jump from the
    hunk selection loop into manually editing _all_ hunks and then
    applying, ending the hunk selection loop.

This should be applied on top of "allow git-apply to ignore the hunk
headers" (v3) which can be found on the list.  Obviously significant
portions of the patch below are based on Thomas' version.

-- >8 --
git-add--interactive: manual hunk editing mode

Adds a new option 'e' to the 'add -p' command loop that lets you
edit the current hunk in your favourite editor, applying the
result.
---
 git-add--interactive.perl |   81 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 81 insertions(+), 0 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 903953e..62b5aed 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -2,6 +2,7 @@
 
 use strict;
 use Git;
+use File::Temp;
 
 my $repo = Git->repository();
 
@@ -770,6 +771,76 @@ sub coalesce_overlapping_hunks {
 	return @out;
 }
 
+sub edit_hunk_manually {
+	my ($oldtext) = @_;
+
+	my $t = File::Temp->new(
+		TEMPLATE => $repo->repo_path . "/git-hunk-edit.XXXXXX",
+		SUFFIX => '.diff'
+	);
+	print $t "# Manual hunk edit mode -- see bottom for a quick guide\n";
+	print $t @$oldtext;
+	print $t <<EOF;
+# ---
+# To remove '-' lines, make them ' ' lines (context).
+# To remove '+' lines, delete them.
+# Empty lines and lines starting with # will be removed.
+#
+# Lines starting with @ start a new hunk. Line counts will be adjusted
+# according to contents. If the line numbers are missing altogether,
+# they will be inferred from the previous hunk.
+#
+# You can change the hunk to your heart's content, but it will be
+# refused if the end result (the entire patch including your edited
+# hunk) does not apply cleanly.
+EOF
+	close $t;
+
+	my $editor = $ENV{GIT_EDITOR} || $repo->config("core.editor")
+		|| $ENV{VISUAL} || $ENV{EDITOR} || "vi";
+	system('sh', '-c', $editor.' "$@"', $editor, $t);
+
+	open my $fh, '<', $t
+		or die "failed to open hunk edit file for reading: " . $!;
+	my @newtext = grep { !/^#/ } <$fh>;
+	close $fh;
+
+	# Reinsert the first hunk header if the user accidentally deleted it
+	if ($newtext[0] !~ /^@/) {
+		unshift @newtext, $oldtext->[0];
+	}
+	return \@newtext;
+}
+
+sub apply_diff {
+	open(my $fh, '|-', qw(git apply --cached --recount));
+	print $fh map { @$_ } @_;
+	return close $fh;
+}
+
+sub prompt_yesno {
+	my ($prompt) = @_;
+	while (1) {
+		print colored $prompt_color, $prompt;
+		my $line = <STDIN>;
+		return 0 if $line =~ /^n/i;
+		return 1 if $line =~ /^y/i;
+	}
+}
+
+sub edit_hunk_loop {
+	my ($head, $text) = @_;
+
+	while (1) {
+		$text = edit_hunk_manually($text);
+		apply_diff($head, $text) and return 1;
+		prompt_yesno(
+			'Your edited hunk does not apply. Edit again '
+			. '(saying "no" discards!) [y/n]? '
+		) or return 0;
+	}
+}
+
 sub help_patch_cmd {
 	print colored $help_color, <<\EOF ;
 y - stage this hunk
@@ -781,6 +852,7 @@ J - leave this hunk undecided, see next hunk
 k - leave this hunk undecided, see previous undecided hunk
 K - leave this hunk undecided, see previous hunk
 s - split the current hunk into smaller hunks
+e - manually edit the current hunk
 ? - print help
 EOF
 }
@@ -885,6 +957,7 @@ sub patch_update_file {
 		if (hunk_splittable($hunk[$ix]{TEXT})) {
 			$other .= '/s';
 		}
+		$other .= '/e';
 		for (@{$hunk[$ix]{DISPLAY}}) {
 			print;
 		}
@@ -949,6 +1022,14 @@ sub patch_update_file {
 				$num = scalar @hunk;
 				next;
 			}
+			elsif ($line =~ /^e/) {
+				if (edit_hunk_loop($head->{TEXT},
+						   $hunk[$ix]{TEXT})) {
+					splice @hunk, $ix, 1;
+					$num = @hunk;
+				}
+				next;
+			}
 			else {
 				help_patch_cmd($other);
 				next;
-- 
1.5.6.rc2.26.gda075.dirty
