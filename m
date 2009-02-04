From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 4/4] add -p: print errors in separate color
Date: Wed,  4 Feb 2009 21:08:49 +0100
Message-ID: <1233778129-6861-2-git-send-email-trast@student.ethz.ch>
References: <1233778129-6861-1-git-send-email-trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>,
	Suraj Kurapati <sunaku@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 04 21:10:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUo57-0007q1-RA
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 21:10:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758010AbZBDUJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 15:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757128AbZBDUJT
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 15:09:19 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:50933 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756720AbZBDUJR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 15:09:17 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 4 Feb 2009 21:09:14 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 4 Feb 2009 21:09:14 +0100
X-Mailer: git-send-email 1.6.1.2.554.g6515b
In-Reply-To: <1233778129-6861-1-git-send-email-trast@student.ethz.ch>
In-Reply-To: <200902042042.13787.trast@student.ethz.ch>
References: <200902042042.13787.trast@student.ethz.ch>
X-OriginalArrivalTime: 04 Feb 2009 20:09:14.0856 (UTC) FILETIME=[73C32E80:01C98704]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108419>

Print interaction error messages in color.interactive.error, which
defaults to the value of color.interactive.help.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/config.txt  |    4 ++--
 git-add--interactive.perl |   30 ++++++++++++++++++++----------
 2 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 403edb8..51f684f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -569,8 +569,8 @@ color.interactive::
 
 color.interactive.<slot>::
 	Use customized color for 'git-add --interactive'
-	output. `<slot>` may be `prompt`, `header`, or `help`, for
-	three distinct types of normal output from interactive
+	output. `<slot>` may be `prompt`, `header`, `help` or `error`, for
+	four distinct types of normal output from interactive
 	programs.  The values of these variables may be specified as
 	in color.branch.<slot>.
 
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 3aa21db..e06a445 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -12,6 +12,12 @@ my ($prompt_color, $header_color, $help_color) =
 		$repo->get_color('color.interactive.header', 'bold'),
 		$repo->get_color('color.interactive.help', 'red bold'),
 	) : ();
+my $error_color = ();
+if ($menu_use_color) {
+	my $help_color_spec = $repo->config('color.interactive.help');
+	$error_color = $repo->get_color('color.interactive.error',
+					$help_color_spec);
+}
 
 my $diff_use_color = $repo->get_colorbool('color.diff');
 my ($fraginfo_color) =
@@ -333,6 +339,10 @@ sub highlight_prefix {
 	return "$prompt_color$prefix$normal_color$remainder";
 }
 
+sub error_msg {
+	print STDERR colored $error_color, @_;
+}
+
 sub list_and_choose {
 	my ($opts, @stuff) = @_;
 	my (@chosen, @return);
@@ -428,12 +438,12 @@ sub list_and_choose {
 			else {
 				$bottom = $top = find_unique($choice, @stuff);
 				if (!defined $bottom) {
-					print "Huh ($choice)?\n";
+					error_msg "Huh ($choice)?\n";
 					next TOPLOOP;
 				}
 			}
 			if ($opts->{SINGLETON} && $bottom != $top) {
-				print "Huh ($choice)?\n";
+				error_msg "Huh ($choice)?\n";
 				next TOPLOOP;
 			}
 			for ($i = $bottom-1; $i <= $top-1; $i++) {
@@ -1029,11 +1039,11 @@ sub patch_update_file {
 					chomp $response;
 				}
 				if ($response !~ /^\s*\d+\s*$/) {
-					print STDERR "Invalid number: '$response'\n";
+					error_msg "Invalid number: '$response'\n";
 				} elsif (0 < $response && $response <= $num) {
 					$ix = $response - 1;
 				} else {
-					print STDERR "Sorry, only $num hunks available.\n";
+					error_msg "Sorry, only $num hunks available.\n";
 				}
 				next;
 			}
@@ -1062,7 +1072,7 @@ sub patch_update_file {
 				if ($@) {
 					my ($err,$exp) = ($@, $1);
 					$err =~ s/ at .*git-add--interactive line \d+, <STDIN> line \d+.*$//;
-					print STDERR "Malformed search regexp $exp: $err\n";
+					error_msg "Malformed search regexp $exp: $err\n";
 					next;
 				}
 				my $iy = $ix;
@@ -1072,7 +1082,7 @@ sub patch_update_file {
 					$iy++;
 					$iy = 0 if ($iy >= $num);
 					if ($ix == $iy) {
-						print STDERR "No hunk matches the given pattern\n";
+						error_msg "No hunk matches the given pattern\n";
 						last;
 					}
 				}
@@ -1084,7 +1094,7 @@ sub patch_update_file {
 					$ix--;
 				}
 				else {
-					print STDERR "No previous hunk\n";
+					error_msg "No previous hunk\n";
 				}
 				next;
 			}
@@ -1093,7 +1103,7 @@ sub patch_update_file {
 					$ix++;
 				}
 				else {
-					print STDERR "No next hunk\n";
+					error_msg "No next hunk\n";
 				}
 				next;
 			}
@@ -1106,13 +1116,13 @@ sub patch_update_file {
 					}
 				}
 				else {
-					print STDERR "No previous hunk\n";
+					error_msg "No previous hunk\n";
 				}
 				next;
 			}
 			elsif ($line =~ /^j/) {
 				if ($other !~ /j/) {
-					print STDERR "No next hunk\n";
+					error_msg "No next hunk\n";
 					next;
 				}
 			}
-- 
1.6.1.2.554.g6515b
