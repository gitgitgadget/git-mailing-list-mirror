From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Color support for "git-add -i"
Date: Wed, 05 Dec 2007 02:59:04 -0800
Message-ID: <7vbq95tnk7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Wincent Colaiuta <win@wincent.com>,
	git@vger.kernel.org
To: Dan Zwell <dzwell@zwell.net>
X-From: git-owner@vger.kernel.org Wed Dec 05 11:59:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzryY-0008K1-SV
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 11:59:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbXLEK7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 05:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbXLEK7O
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 05:59:14 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:35213 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbXLEK7M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 05:59:12 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 39DAD2F0;
	Wed,  5 Dec 2007 05:59:34 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 012339A189;
	Wed,  5 Dec 2007 05:59:28 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67139>

This is mostly lifted from earlier series by Dan Zwell, but updated to
use "git config --get-color" to make it simpler and more consistent with
commands written in C.

A new configuration color.interactive variable is like color.diff and
color.status, and controls if "git-add -i" uses color.

A set of configuration variables, color.interactive.<slot>, are used to
define what color is used for the prompt, header, and help text.

For perl scripts, Git.pm provides $repo->get_color() method, which takes
the slot name and the default color, and returns the terminal escape
sequence to color the output text.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I'd like to have the colored "add -i" by 1.5.4-rc0 so I updated the
   series myself.  Ack, improvements, fixes?

 Documentation/config.txt  |   13 +++++
 git-add--interactive.perl |  121 +++++++++++++++++++++++++++++++++++++-------
 perl/Git.pm               |   20 +++++++
 3 files changed, 134 insertions(+), 20 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 72a33e9..c94f252 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -391,6 +391,19 @@ color.diff.<slot>::
 	whitespace).  The values of these variables may be specified as
 	in color.branch.<slot>.
 
+color.interactive::
+	When true (or `always`), always use colors in `git add
+	--interactive`.  When false (or `never`), never.  When set to
+	`auto`, use colors only when the output is to the
+	terminal. Defaults to false.
+
+color.interactive.<slot>::
+	Use customized color for `git add --interactive`
+	output. `<slot>` may be `prompt`, `header`, or `help`, for
+	three distinct types of normal output from interactive
+	programs.  The values of these variables may be specified as
+	in color.branch.<slot>.
+
 color.pager::
 	A boolean to enable/disable colored output when the pager is in
 	use (default is true).
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 335c2c6..3bcccfb 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1,6 +1,57 @@
 #!/usr/bin/perl -w
 
 use strict;
+use Git;
+
+# Prompt colors:
+my ($use_color, $prompt_color, $header_color, $help_color, $normal_color);
+# Diff colors:
+my ($diff_use_color, $new_color, $old_color, $fraginfo_color,
+    $metainfo_color, $whitespace_color);
+my $color_config = qx(git config --get color.interactive);
+if ($color_config=~/true|always/ || -t STDOUT && $color_config=~/auto/) {
+	if (!$@) {
+		$use_color = 1;
+		# Set interactive colors:
+
+		# Grab the 3 main colors in git color string format, with sane
+		# (visible) defaults:
+		my $repo = Git->repository();
+		$prompt_color = $repo->get_color("color.interactive.prompt", "bold blue");
+		$header_color = $repo->get_color("color.interactive.header", "bold");
+		$help_color = $repo->get_color("color.interactive.help", "red bold");
+		$normal_color = $repo->get_color("", "reset");
+
+		# Do we also set diff colors?
+		my $diff_colors = Git::config($repo, "color.diff");
+		if ($diff_colors =~ /true/ ||
+		    (-t STDOUT && $diff_colors =~ /auto/)) {
+			$diff_use_color = 1;
+			$new_color = $repo->get_color("color.diff.new", "green");
+			$old_color = $repo->get_color("color.diff.old", "red");
+			$fraginfo_color = $repo->get_color("color.diff.frag", "cyan");
+			$metainfo_color = $repo->get_color("color.diff.meta", "bold");
+			$whitespace_color = $repo->get_color("color.diff.whitespace", "normal red");
+		}
+	}
+}
+
+sub colored {
+	my $color = shift;
+	my $string = join("", @_);
+
+	if ($use_color) {
+		# Put a color code at the beginning of each line, a reset at the end
+		# color after newlines that are not at the end of the string
+		$string =~ s/(\n+)(.)/$1$color$2/g;
+		# reset before newlines
+		$string =~ s/(\n+)/$normal_color$1/g;
+		# codes at beginning and end (if necessary):
+		$string =~ s/^/$color/;
+		$string =~ s/$/$normal_color/ unless $string =~ /\n$/;
+	}
+	return $string;
+}
 
 # command line options
 my $patch_mode;
@@ -246,10 +297,20 @@ sub is_valid_prefix {
 sub highlight_prefix {
 	my $prefix = shift;
 	my $remainder = shift;
-	return $remainder unless defined $prefix;
-	return is_valid_prefix($prefix) ?
-	    "[$prefix]$remainder" :
-	    "$prefix$remainder";
+
+	if (!defined $prefix) {
+		return $remainder;
+	}
+
+	if (!is_valid_prefix($prefix)) {
+		return "$prefix$remainder";
+	}
+
+	if (!$use_color) {
+		return "[$prefix]$remainder";
+	}
+
+	return "$prompt_color$prefix$normal_color$remainder";
 }
 
 sub list_and_choose {
@@ -266,7 +327,7 @@ sub list_and_choose {
 			if (!$opts->{LIST_FLAT}) {
 				print "     ";
 			}
-			print "$opts->{HEADER}\n";
+			print colored $header_color, "$opts->{HEADER}\n";
 		}
 		for ($i = 0; $i < @stuff; $i++) {
 			my $chosen = $chosen[$i] ? '*' : ' ';
@@ -304,7 +365,7 @@ sub list_and_choose {
 
 		return if ($opts->{LIST_ONLY});
 
-		print $opts->{PROMPT};
+		print colored $prompt_color, $opts->{PROMPT};
 		if ($opts->{SINGLETON}) {
 			print "> ";
 		}
@@ -371,7 +432,7 @@ sub list_and_choose {
 }
 
 sub singleton_prompt_help_cmd {
-	print <<\EOF ;
+	print colored $help_color, <<\EOF ;
 Prompt help:
 1          - select a numbered item
 foo        - select item based on unique prefix
@@ -380,7 +441,7 @@ EOF
 }
 
 sub prompt_help_cmd {
-	print <<\EOF ;
+	print colored $help_color, <<\EOF ;
 Prompt help:
 1          - select a single item
 3-5        - select a range of items
@@ -477,6 +538,31 @@ sub parse_diff {
 	return @hunk;
 }
 
+sub colored_diff_hunk {
+	my ($text) = @_;
+	# return the text, so that it can be passed to print()
+	my @ret;
+	for (@$text) {
+		if (!$diff_use_color) {
+			push @ret, $_;
+			next;
+		}
+
+		if (/^\+/) {
+			push @ret, colored($new_color, $_);
+		} elsif (/^\-/) {
+			push @ret, colored($old_color, $_);
+		} elsif (/^\@/) {
+			push @ret, colored($fraginfo_color, $_);
+		} elsif (/^ /) {
+			push @ret, colored($normal_color, $_);
+		} else {
+			push @ret, colored($metainfo_color, $_);
+		}
+	}
+	return @ret;
+}
+
 sub hunk_splittable {
 	my ($text) = @_;
 
@@ -671,7 +757,7 @@ sub coalesce_overlapping_hunks {
 }
 
 sub help_patch_cmd {
-	print <<\EOF ;
+	print colored $help_color, <<\EOF ;
 y - stage this hunk
 n - do not stage this hunk
 a - stage this and all the remaining hunks in the file
@@ -710,9 +796,7 @@ sub patch_update_file {
 	my ($ix, $num);
 	my $path = shift;
 	my ($head, @hunk) = parse_diff($path);
-	for (@{$head->{TEXT}}) {
-		print;
-	}
+	print colored_diff_hunk($head->{TEXT});
 	$num = scalar @hunk;
 	$ix = 0;
 
@@ -754,10 +838,8 @@ sub patch_update_file {
 		if (hunk_splittable($hunk[$ix]{TEXT})) {
 			$other .= '/s';
 		}
-		for (@{$hunk[$ix]{TEXT}}) {
-			print;
-		}
-		print "Stage this hunk [y/n/a/d$other/?]? ";
+		print colored_diff_hunk($hunk[$ix]{TEXT});
+		print colored $prompt_color, "Stage this hunk [y/n/a/d$other/?]? ";
 		my $line = <STDIN>;
 		if ($line) {
 			if ($line =~ /^y/i) {
@@ -811,7 +893,7 @@ sub patch_update_file {
 			elsif ($other =~ /s/ && $line =~ /^s/) {
 				my @split = split_hunk($hunk[$ix]{TEXT});
 				if (1 < @split) {
-					print "Split into ",
+					print colored $header_color, "Split into ",
 					scalar(@split), " hunks.\n";
 				}
 				splice(@hunk, $ix, 1,
@@ -894,8 +976,7 @@ sub diff_cmd {
 				     HEADER => $status_head, },
 				   @mods);
 	return if (!@them);
-	system(qw(git diff-index -p --cached HEAD --),
-	       map { $_->{VALUE} } @them);
+	system(qw(git diff -p --cached HEAD --), map { $_->{VALUE} } @them);
 }
 
 sub quit_cmd {
@@ -904,7 +985,7 @@ sub quit_cmd {
 }
 
 sub help_cmd {
-	print <<\EOF ;
+	print colored $help_color, <<\EOF ;
 status        - show paths with changes
 update        - add working tree state to the staged set of changes
 revert        - revert staged set of changes back to the HEAD version
diff --git a/perl/Git.pm b/perl/Git.pm
index 7468460..0f7156e 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -581,6 +581,26 @@ sub config_int {
 	};
 }
 
+=item get_color ( SLOT, COLOR )
+
+Finds color for SLOT from the configuration, while defaulting to COLOR,
+and returns the ANSI color escape sequence:
+
+	print $repo->get_color("color.interactive.prompt", "underline blue white");
+	print "some text";
+	print $repo->get_color("", "normal");
+
+=cut
+
+sub get_color {
+	my ($self, $slot, $default) = @_;
+	my $color = $self->command_oneline('config', '--get-color', $slot, $default);
+	if (!defined $color) {
+		$color = "";
+	}
+	return $color;
+}
+
 =item ident ( TYPE | IDENTSTR )
 
 =item ident_person ( TYPE | IDENTSTR | IDENTARRAY )
-- 
1.5.3.7-2134-g53f9
