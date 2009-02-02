From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 3/4] add -p: optionally prompt for single characters
Date: Mon,  2 Feb 2009 22:46:30 +0100
Message-ID: <1233611191-18590-4-git-send-email-trast@student.ethz.ch>
References: <1233611191-18590-1-git-send-email-trast@student.ethz.ch>
 <1233611191-18590-2-git-send-email-trast@student.ethz.ch>
 <1233611191-18590-3-git-send-email-trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>, Jeff King <peff@peff.net>,
	Suraj Kurapati <sunaku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 02 22:49:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LU6fO-0001pu-Um
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 22:49:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758948AbZBBVq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 16:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753564AbZBBVqz
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 16:46:55 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:9370 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756084AbZBBVqv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 16:46:51 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 2 Feb 2009 22:46:44 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 2 Feb 2009 22:46:44 +0100
X-Mailer: git-send-email 1.6.1.2.513.g04677
In-Reply-To: <1233611191-18590-3-git-send-email-trast@student.ethz.ch>
In-Reply-To: <7vljspjk8n.fsf@gitster.siamese.dyndns.org>
References: <7vljspjk8n.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 02 Feb 2009 21:46:44.0924 (UTC) FILETIME=[BDD937C0:01C9857F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108127>

Use Term::ReadKey, if available and enabled with interactive.readkey,
to let the user answer add -p's prompts by pressing a single key.
We're not doing the same in the main 'add -i' interface because file
selection etc. may expect several characters.

Two commands take an argument: 'g' can easily cope since it'll just
offer a choice of chunks.  '/' now (unconditionally, even without
readkey) offers a chance to enter a regex if none was given.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/config.txt  |    6 ++++++
 git-add--interactive.perl |   45 +++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7fbf64d..cee64db 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1013,6 +1013,12 @@ instaweb.port::
 	The port number to bind the gitweb httpd to. See
 	linkgit:git-instaweb[1].
 
+interactive.readkey::
+	Attempt to use Term::ReadKey facilities to allow typing
+	one-letter input with a single key.  Currently only used by
+	the `\--patch` mode of linkgit:git-add[1].  Silently disabled
+	if Term::ReadKey is not available.
+
 log.date::
 	Set default date-time mode for the log command. Setting log.date
 	value is similar to using 'git-log'\'s --date option. The value is one of the
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 3bf0cda..3aa21db 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -33,6 +33,14 @@ my ($diff_new_color) =
 
 my $normal_color = $repo->get_color("", "reset");
 
+my $use_readkey = 0;
+if ($repo->config_bool("interactive.readkey")) {
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
1.6.1.2.513.g04677
