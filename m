From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v4 4/4] add -p: print errors in separate color
Date: Thu,  5 Feb 2009 09:28:27 +0100
Message-ID: <1233822507-9612-2-git-send-email-trast@student.ethz.ch>
References: <1233822507-9612-1-git-send-email-trast@student.ethz.ch>
Cc: Jeff King <peff@peff.net>, Suraj Kurapati <sunaku@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 09:30:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUzdP-0007tF-OK
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 09:30:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757228AbZBEI3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 03:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758247AbZBEI3I
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 03:29:08 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:10466 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758143AbZBEI3F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 03:29:05 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 5 Feb 2009 09:29:02 +0100
Received: from localhost.localdomain ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 5 Feb 2009 09:29:02 +0100
X-Mailer: git-send-email 1.6.1.2.573.g45906
In-Reply-To: <1233822507-9612-1-git-send-email-trast@student.ethz.ch>
In-Reply-To: <7v63jqorza.fsf@gitster.siamese.dyndns.org>
References: <7v63jqorza.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 05 Feb 2009 08:29:02.0028 (UTC) FILETIME=[CC9420C0:01C9876B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108534>

Print interaction error messages in color.interactive.error, which
defaults to the value of color.interactive.help.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Same patch as v3.

 Documentation/config.txt  |    4 ++--
 git-add--interactive.perl |   30 ++++++++++++++++++++----------
 2 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3c65b81..1dd18c9 100644
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
index 1813f9e..be8ca8e 100755
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
1.6.1.2.574.g928b8
