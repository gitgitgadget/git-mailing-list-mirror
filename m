From: Tom Tobin <korpios@korpios.com>
Subject: [PATCH] Add color to git-add--interactive diffs
Date: Sun, 14 Oct 2007 03:23:56 -0500
Message-ID: <1192350236.7226.6.camel@athena>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 14 10:24:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Igyll-0002m2-25
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 10:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752464AbXJNIYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 04:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751641AbXJNIYF
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 04:24:05 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:40973 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbXJNIYB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 04:24:01 -0400
Received: by py-out-1112.google.com with SMTP id u77so2399685pyb
        for <git@vger.kernel.org>; Sun, 14 Oct 2007 01:24:00 -0700 (PDT)
Received: by 10.35.99.5 with SMTP id b5mr6072869pym.1192350239881;
        Sun, 14 Oct 2007 01:23:59 -0700 (PDT)
Received: from ?192.168.1.197? ( [24.124.68.243])
        by mx.google.com with ESMTPS id n63sm5838234pyh.2007.10.14.01.23.57
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Oct 2007 01:23:57 -0700 (PDT)
X-Mailer: Evolution 2.12.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60803>

Seeing the recent discussion and code regarding adding color to
git-add--interactive, I thought I'd throw in my recent attempt at
colorizing the diffs.  (This doesn't handle anything else, such as the
prompts.)

After banging my head against parsing colorized output of git-add-files,
I gave up and implemented internal colorization keying off of the
color.diff configuration.

Hopefully this can be of some use towards fully colorizing
git-add--interactive; I'll admit up front that Perl isn't my primary
language, so I apologize in advance for whatever stupidities I've
introduced.  ;)

Signed-off-by: Tom Tobin <korpios@korpios.com>
---
 git-add--interactive.perl |  111
++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 109 insertions(+), 2 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index be68814..eeb38e6 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1,5 +1,6 @@
 #!/usr/bin/perl -w
 
+use List::Util qw(first);
 use strict;
 
 sub run_cmd_pipe {
@@ -22,6 +23,112 @@ if (!defined $GIT_DIR) {
 }
 chomp($GIT_DIR);
 
+my ($use_color) = 0;
+my (%term_color_codes) = (
+	"normal", "", "black", "0", "red", "1",
+	"green", "2", "yellow", "3", "blue", "4",
+	"magenta", "5", "cyan", "6", "white", "7"
+);
+my (%term_attr_codes) = (
+	"bold", "1", "dim", "2", "ul", "4", "blink", "5", "reverse", "7"
+);
+my %colorconfig = (
+	'color.diff' => 'never',
+	'color.diff.plain' => '',
+	'color.diff.meta' => 'bold',
+	'color.diff.frag' => 'cyan',
+	'color.diff.old' => 'red',
+	'color.diff.new' => 'green',
+	'color.diff.commit' => 'yellow',
+	'color.diff.whitespace' => 'normal red'
+	);
+for (split("\n", `git-config --get-regexp '^color\.diff'`)) {
+	my ($var, $val) = $_ =~ /^([^\s]+)\s(.*)$/;
+	$colorconfig{$var} = $val;
+}
+if (first { $_ eq $colorconfig{'color.diff'} } ("true", "always",
"auto")) {
+	$use_color = 1;
+}
+
+sub parse_color {
+	my ($fg, $bg, $attr, $lookup);
+	my ($fg_code, $bg_code, $attr_code, $output_code) = ("", "", "", "");
+	my (@color) = @_;
+	my (@colorvals) = defined($color[0]) ? split(" ", $color[0]) : ();
+
+	for (@colorvals) {
+		$lookup = $term_color_codes{$_};
+		if (defined($lookup)) {
+			if (!defined($fg)) {
+				$fg = 1;
+				$fg_code = "3$lookup";
+			} elsif (!defined($bg)) {
+				$bg = 1;
+				$bg_code = "4$lookup";
+			} else {
+				die("Color slots only take up to two colors!");
+			}
+			next;
+		}
+		$lookup = $term_attr_codes{$_};
+		if (defined($lookup)) {
+			if (!defined($attr)) {
+				$attr = 1;
+				$attr_code = $lookup;
+			} else {
+				die("Color slots only take a single attribute!");
+			}
+		} else {
+			die("Unrecognized value for color slot!");
+		}
+	}
+	for ($fg_code, $bg_code, $attr_code) {
+		if ($_ eq "") {
+			next;
+		}
+		if ($output_code ne "") {
+			$output_code = $output_code . ";";
+		}
+		$output_code = $output_code . $_;
+	}
+	if (length($output_code)) {
+		return "\e[${output_code}m";
+	} else {
+		return "";
+	}
+}
+
+sub colorize_head_line {
+	my $line = shift @_;
+	if ($use_color) {
+		# git doesn't colorize these by default, soooo
+		# if ($line =~ /^\+/) {
+		#	 return parse_color($colorconfig{'color.diff.new'}) . "$line\e[m";
+		# }
+		# if ($line =~ /^-/) {
+		#	 return parse_color($colorconfig{'color.diff.old'}) . "$line\e[m";
+		# }
+		return parse_color($colorconfig{'color.diff.meta'}) . "$line\e[m";
+	}
+	return $line;
+}
+
+sub colorize_hunk_line {
+	my $line = shift @_;
+	if ($use_color) {
+		if ($line =~ /^\+/) {
+			return parse_color($colorconfig{'color.diff.new'}) . "$line\e[m";
+		}
+		if ($line =~ /^-/) {
+			return parse_color($colorconfig{'color.diff.old'}) . "$line\e[m";
+		}
+		if ($line =~ /^@@ /) {
+			return parse_color($colorconfig{'color.diff.frag'}) . "$line\e[m";
+		}
+	}
+	return $line;
+}
+
 sub refresh {
 	my $fh;
 	open $fh, 'git update-index --refresh |'
@@ -573,7 +680,7 @@ sub patch_update_cmd {
 	my $path = $it->{VALUE};
 	my ($head, @hunk) = parse_diff($path);
 	for (@{$head->{TEXT}}) {
-		print;
+		print colorize_head_line($_);
 	}
 	$num = scalar @hunk;
 	$ix = 0;
@@ -617,7 +724,7 @@ sub patch_update_cmd {
 			$other .= '/s';
 		}
 		for (@{$hunk[$ix]{TEXT}}) {
-			print;
+			print colorize_hunk_line($_);
 		}
 		print "Stage this hunk [y/n/a/d$other/?]? ";
 		my $line = <STDIN>;
-- 
1.5.3.4
