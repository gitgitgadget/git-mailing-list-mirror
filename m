From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] Color support for "git-add -i"
Date: Wed,  5 Dec 2007 18:05:05 -0800
Message-ID: <1196906706-11170-3-git-send-email-gitster@pobox.com>
References: <475697BC.2090701@viscovery.net>
 <1196906706-11170-1-git-send-email-gitster@pobox.com>
 <1196906706-11170-2-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 06 03:23:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J06OT-00012B-C5
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 03:23:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756369AbXLFCWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 21:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755478AbXLFCWm
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 21:22:42 -0500
Received: from fed1rmmtai113.cox.net ([68.230.241.47]:48794 "EHLO
	fed1rmmtai113.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756403AbXLFCWj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 21:22:39 -0500
X-Greylist: delayed 1048 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Dec 2007 21:22:36 EST
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20071206020514.CBED21007.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>
          for <git@vger.kernel.org>; Wed, 5 Dec 2007 21:05:14 -0500
Received: from localhost ([68.225.240.77])
	by fed1rmimpo02.cox.net with bizsmtp
	id ME5D1Y00D1gtr5g0000000; Wed, 05 Dec 2007 21:05:13 -0500
X-Mailer: git-send-email 1.5.3.7-2132-gbd1cf
In-Reply-To: <1196906706-11170-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67222>

This is mostly lifted from earlier series by Dan Zwell, but updated to
use "git config --get-color" and "git config --get-colorbool" to make it
simpler and more consistent with commands written in C.

A new configuration color.interactive variable is like color.diff and
color.status, and controls if "git-add -i" uses color.

A set of configuration variables, color.interactive.<slot>, are used to
define what color is used for the prompt, header, and help text.

For perl scripts, Git.pm provides $repo->get_color() method, which takes
the slot name and the default color, and returns the terminal escape
sequence to color the output text.  $repo->get_colorbool() method can be
used to check if color is set to be used for a given operation.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt  |   12 +++++
 git-add--interactive.perl |  119 +++++++++++++++++++++++++++++++++++++--------
 perl/Git.pm               |   35 +++++++++++++
 3 files changed, 146 insertions(+), 20 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0e45ec5..736fcd7 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -391,6 +391,18 @@ color.diff.<slot>::
 	whitespace).  The values of these variables may be specified as
 	in color.branch.<slot>.
 
+color.interactive::
+	When set to `always`, always use colors in `git add --interactive`.
+	When false (or `never`), never.  When set to `true` or `auto`, use
+	colors only when the output is to the terminal. Defaults to false.
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
index 335c2c6..1019a72 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1,6 +1,55 @@
 #!/usr/bin/perl -w
 
 use strict;
+use Git;
+
+# Prompt colors:
+my ($prompt_color, $header_color, $help_color, $normal_color);
+# Diff colors:
+my ($new_color, $old_color, $fraginfo_color, $metainfo_color, $whitespace_color);
+
+my ($use_color, $diff_use_color);
+my $repo = Git->repository();
+
+$use_color = $repo->get_colorbool('color.interactive');
+
+if ($use_color) {
+	# Set interactive colors:
+
+	# Grab the 3 main colors in git color string format, with sane
+	# (visible) defaults:
+	$prompt_color = $repo->get_color("color.interactive.prompt", "bold blue");
+	$header_color = $repo->get_color("color.interactive.header", "bold");
+	$help_color = $repo->get_color("color.interactive.help", "red bold");
+	$normal_color = $repo->get_color("", "reset");
+
+	# Do we also set diff colors?
+	$diff_use_color = $repo->get_colorbool('color.diff');
+	if ($diff_use_color) {
+		$new_color = $repo->get_color("color.diff.new", "green");
+		$old_color = $repo->get_color("color.diff.old", "red");
+		$fraginfo_color = $repo->get_color("color.diff.frag", "cyan");
+		$metainfo_color = $repo->get_color("color.diff.meta", "bold");
+		$whitespace_color = $repo->get_color("color.diff.whitespace", "normal red");
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
@@ -246,10 +295,20 @@ sub is_valid_prefix {
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
@@ -266,7 +325,7 @@ sub list_and_choose {
 			if (!$opts->{LIST_FLAT}) {
 				print "     ";
 			}
-			print "$opts->{HEADER}\n";
+			print colored $header_color, "$opts->{HEADER}\n";
 		}
 		for ($i = 0; $i < @stuff; $i++) {
 			my $chosen = $chosen[$i] ? '*' : ' ';
@@ -304,7 +363,7 @@ sub list_and_choose {
 
 		return if ($opts->{LIST_ONLY});
 
-		print $opts->{PROMPT};
+		print colored $prompt_color, $opts->{PROMPT};
 		if ($opts->{SINGLETON}) {
 			print "> ";
 		}
@@ -371,7 +430,7 @@ sub list_and_choose {
 }
 
 sub singleton_prompt_help_cmd {
-	print <<\EOF ;
+	print colored $help_color, <<\EOF ;
 Prompt help:
 1          - select a numbered item
 foo        - select item based on unique prefix
@@ -380,7 +439,7 @@ EOF
 }
 
 sub prompt_help_cmd {
-	print <<\EOF ;
+	print colored $help_color, <<\EOF ;
 Prompt help:
 1          - select a single item
 3-5        - select a range of items
@@ -477,6 +536,31 @@ sub parse_diff {
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
 
@@ -671,7 +755,7 @@ sub coalesce_overlapping_hunks {
 }
 
 sub help_patch_cmd {
-	print <<\EOF ;
+	print colored $help_color, <<\EOF ;
 y - stage this hunk
 n - do not stage this hunk
 a - stage this and all the remaining hunks in the file
@@ -710,9 +794,7 @@ sub patch_update_file {
 	my ($ix, $num);
 	my $path = shift;
 	my ($head, @hunk) = parse_diff($path);
-	for (@{$head->{TEXT}}) {
-		print;
-	}
+	print colored_diff_hunk($head->{TEXT});
 	$num = scalar @hunk;
 	$ix = 0;
 
@@ -754,10 +836,8 @@ sub patch_update_file {
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
@@ -811,7 +891,7 @@ sub patch_update_file {
 			elsif ($other =~ /s/ && $line =~ /^s/) {
 				my @split = split_hunk($hunk[$ix]{TEXT});
 				if (1 < @split) {
-					print "Split into ",
+					print colored $header_color, "Split into ",
 					scalar(@split), " hunks.\n";
 				}
 				splice(@hunk, $ix, 1,
@@ -894,8 +974,7 @@ sub diff_cmd {
 				     HEADER => $status_head, },
 				   @mods);
 	return if (!@them);
-	system(qw(git diff-index -p --cached HEAD --),
-	       map { $_->{VALUE} } @them);
+	system(qw(git diff -p --cached HEAD --), map { $_->{VALUE} } @them);
 }
 
 sub quit_cmd {
@@ -904,7 +983,7 @@ sub quit_cmd {
 }
 
 sub help_cmd {
-	print <<\EOF ;
+	print colored $help_color, <<\EOF ;
 status        - show paths with changes
 update        - add working tree state to the staged set of changes
 revert        - revert staged set of changes back to the HEAD version
diff --git a/perl/Git.pm b/perl/Git.pm
index 7468460..a2812ea 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -581,6 +581,41 @@ sub config_int {
 	};
 }
 
+=item get_colorbool ( NAME )
+
+Finds if color should be used for NAMEd operation from the configuration,
+and returns boolean (true for "use color", false for "do not use color").
+
+=cut
+
+sub get_colorbool {
+	my ($self, $var) = @_;
+	my $stdout_to_tty = (-t STDOUT) ? "true" : "false";
+	my $use_color = $self->command_oneline('config', '--get-colorbool',
+					       $var, $stdout_to_tty);
+	return ($use_color eq 'true');
+}
+
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
1.5.3.7-2132-gbd1cf
