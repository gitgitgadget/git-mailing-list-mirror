From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH] add -p: prompt for single characters
Date: Sun,  1 Feb 2009 21:35:11 +0100
Message-ID: <1233520511-13061-1-git-send-email-trast@student.ethz.ch>
Cc: Jeff King <peff@peff.net>, "Suraj N. Kurapati" <sunaku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 01 21:37:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTj4d-0005co-Js
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 21:37:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752950AbZBAUfd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 15:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752841AbZBAUfd
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 15:35:33 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:14743 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751264AbZBAUfc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 15:35:32 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 1 Feb 2009 21:35:29 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 1 Feb 2009 21:35:29 +0100
X-Mailer: git-send-email 1.6.1.2.495.g0175e
X-OriginalArrivalTime: 01 Feb 2009 20:35:29.0963 (UTC) FILETIME=[9F5C2FB0:01C984AC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107999>

Use Term::ReadKey, if available, to let the user answer add -p's
prompts by pressing a single key.  The 'g' command is the only one
that takes an argument, but can easily cope since it'll just offer a
choice of chunks.  We're not doing the same in the main 'add -i'
interface because file selection etc. may expect several characters.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

I wrote this on the train today, but it turns out a similar idea was
already around earlier:

  http://thread.gmane.org/gmane.comp.version-control.git/100146

I can't find the v4 promised there, so I assume Suraj dropped it.

It would indeed be nice if we could apply the same to the main 'add
-i' loop, and I played with the code to do so for a while.  Most of
the mechanisms required seem to be in place; it already computes
shortest unique prefixes for the inputs given, so we could just grab
the one-character prefixes from there.

However, what to do when the user entered a letter that is known to be
part of several prefixes?  If we offer to enter the rest of the line,
e.g., 'return $key.<STDIN>', the user can't backspace away the
"existing" input if he decides to do something else instead.  Perhaps
readline could prime the input line with the letter, but I can't find
any such feature in the Term::ReadLine docs.  Implementation ideas are
obviously very welcome.


 git-add--interactive.perl |   35 ++++++++++++++++++++++++++++++++---
 1 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index ca60356..0633eca 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -33,6 +33,14 @@ my ($diff_new_color) =
 
 my $normal_color = $repo->get_color("", "reset");
 
+my $use_readkey = 0;
+my %control_keys;
+eval {
+	use Term::ReadKey;
+	$use_readkey = 1;
+	%control_keys = GetControlChars;
+};
+
 sub colored {
 	my $color = shift;
 	my $string = join("", @_);
@@ -758,11 +766,32 @@ sub diff_applies {
 	return close $fh;
 }
 
+sub _restore_terminal_and_die {
+	ReadMode 'restore';
+	print "\n";
+	exit 1;
+}
+
+sub prompt_single_character {
+	if ($use_readkey) {
+		local $SIG{TERM} = \&_restore_terminal_and_die;
+		local $SIG{INT} = \&_restore_terminal_and_die;
+		ReadMode 'cbreak';
+		my $key = ReadKey 0;
+		ReadMode 'restore';
+		print "$key" if defined $key;
+		print "\n";
+		return $key;
+	} else {
+		return <STDIN>;
+	}
+}
+
 sub prompt_yesno {
 	my ($prompt) = @_;
 	while (1) {
 		print colored $prompt_color, $prompt;
-		my $line = <STDIN>;
+		my $line = prompt_single_character;
 		return 0 if $line =~ /^n/i;
 		return 1 if $line =~ /^y/i;
 	}
@@ -892,7 +921,7 @@ sub patch_update_file {
 			print @{$mode->{DISPLAY}};
 			print colored $prompt_color,
 				"Stage mode change [y/n/a/d/?]? ";
-			my $line = <STDIN>;
+			my $line = prompt_single_character;
 			if ($line =~ /^y/i) {
 				$mode->{USE} = 1;
 				last;
@@ -965,7 +994,7 @@ sub patch_update_file {
 			print;
 		}
 		print colored $prompt_color, "Stage this hunk [y/n/a/d$other/?]? ";
-		my $line = <STDIN>;
+		my $line = prompt_single_character;
 		if ($line) {
 			if ($line =~ /^y/i) {
 				$hunk[$ix]{USE} = 1;
-- 
tg: (a34a9db..) t/add-p-readkey (depends on: origin/master)
