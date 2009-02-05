From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v4 3/4] add -p: prompt for single characters
Date: Thu,  5 Feb 2009 09:28:26 +0100
Message-ID: <1233822507-9612-1-git-send-email-trast@student.ethz.ch>
References: <7v63jqorza.fsf@gitster.siamese.dyndns.org>
Cc: Jeff King <peff@peff.net>, Suraj Kurapati <sunaku@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 09:30:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUzdP-0007tF-0t
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 09:30:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757573AbZBEI3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 03:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758247AbZBEI3F
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 03:29:05 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:10466 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754813AbZBEI3E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 03:29:04 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 5 Feb 2009 09:29:02 +0100
Received: from localhost.localdomain ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 5 Feb 2009 09:29:01 +0100
X-Mailer: git-send-email 1.6.1.2.573.g45906
In-Reply-To: <7v63jqorza.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 05 Feb 2009 08:29:01.0981 (UTC) FILETIME=[CC8CF4D0:01C9876B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108535>

Use Term::ReadKey, if available and enabled with interactive.singlekey,
to let the user answer add -p's prompts by pressing a single key.  We're
not doing the same in the main 'add -i' interface because file selection
etc. may expect several characters.

Two commands take an argument: 'g' can easily cope since it'll just
offer a choice of chunks.  '/' now (unconditionally, even without
readkey) offers a chance to enter a regex if none was given.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Junio C Hamano wrote:
> And readkey would be a bad name.  You are doing singlekey, and use of
> readkey *is* an implementation detail, no?

Well, ok, here's another reroll. :-)

Again not preceded by 1&2.


 Documentation/config.txt  |    7 +++++++
 git-add--interactive.perl |   45 +++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7fbf64d..3c65b81 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1013,6 +1013,13 @@ instaweb.port::
 	The port number to bind the gitweb httpd to. See
 	linkgit:git-instaweb[1].
 
+interactive.singlekey::
+	In interactive programs, allow the user to provide one-letter
+	input with a single key (i.e., without hitting enter).
+	Currently this is used only by the `\--patch` mode of
+	linkgit:git-add[1].  Note that this setting is silently
+	ignored if portable keystroke input is not available.
+
 log.date::
 	Set default date-time mode for the log command. Setting log.date
 	value is similar to using 'git-log'\'s --date option. The value is one of the
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 3bf0cda..1813f9e 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -33,6 +33,14 @@ my ($diff_new_color) =
 
 my $normal_color = $repo->get_color("", "reset");
 
+my $use_readkey = 0;
+if ($repo->config_bool("interactive.singlekey")) {
+	eval {
+		use Term::ReadKey;
+		$use_readkey = 1;
+	};
+}
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
@@ -893,7 +922,7 @@ sub patch_update_file {
 			print @{$mode->{DISPLAY}};
 			print colored $prompt_color,
 				"Stage mode change [y/n/a/d/?]? ";
-			my $line = <STDIN>;
+			my $line = prompt_single_character;
 			if ($line =~ /^y/i) {
 				$mode->{USE} = 1;
 				last;
@@ -966,7 +995,7 @@ sub patch_update_file {
 			print;
 		}
 		print colored $prompt_color, "Stage this hunk [y,n,a,d,/$other,?]? ";
-		my $line = <STDIN>;
+		my $line = prompt_single_character;
 		if ($line) {
 			if ($line =~ /^y/i) {
 				$hunk[$ix]{USE} = 1;
@@ -1018,9 +1047,17 @@ sub patch_update_file {
 				next;
 			}
 			elsif ($line =~ m|^/(.*)|) {
+				my $regex = $1;
+				if ($1 eq "") {
+					print colored $prompt_color, "search for regex? ";
+					$regex = <STDIN>;
+					if (defined $regex) {
+						chomp $regex;
+					}
+				}
 				my $search_string;
 				eval {
-					$search_string = qr{$1}m;
+					$search_string = qr{$regex}m;
 				};
 				if ($@) {
 					my ($err,$exp) = ($@, $1);
-- 
1.6.1.2.574.g928b8
