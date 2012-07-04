From: Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v2 1/3] gitweb: Cleanup git_print_log()
Date: Wed,  4 Jul 2012 11:47:24 +0900
Message-ID: <1341370046-19913-1-git-send-email-namhyung@kernel.org>
Cc: git@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 04:52:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmFhE-0004Xj-1c
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jul 2012 04:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757502Ab2GDCv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 22:51:58 -0400
Received: from LGEMRELSE7Q.lge.com ([156.147.1.151]:47898 "EHLO
	LGEMRELSE7Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757494Ab2GDCvd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 22:51:33 -0400
X-AuditID: 9c930197-b7b49ae0000027b8-41-4ff3afb3e6df
Received: from sejong.aot.lge.com ( [10.177.220.181])
	by LGEMRELSE7Q.lge.com (Symantec Brightmail Gateway) with SMTP id 7E.7D.10168.3BFA3FF4; Wed,  4 Jul 2012 11:51:31 +0900 (KST)
X-Mailer: git-send-email 1.7.10.4
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200981>

If $signoff set to 1, the $line would be handled in
the if statement for the both cases. So the outer of
the conditional always sees the $signoff always set
to 0 and no need to check it. Thus we can finally get
rid of it.

Also rename $empty to more clear $skip_blank_line as
suggested by Junio.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 gitweb/gitweb.perl |   21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 55e0e9e..82c5da7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4484,30 +4484,23 @@ sub git_print_log {
 	}
 
 	# print log
-	my $signoff = 0;
-	my $empty = 0;
+	my $skip_blank_line = 0;
 	foreach my $line (@$log) {
 		if ($line =~ m/^ *(signed[ \-]off[ \-]by[ :]|acked[ \-]by[ :]|cc[ :])/i) {
-			$signoff = 1;
-			$empty = 0;
 			if (! $opts{'-remove_signoff'}) {
 				print "<span class=\"signoff\">" . esc_html($line) . "</span><br/>\n";
-				next;
-			} else {
-				# remove signoff lines
-				next;
+				$skip_blank_line = 1;
 			}
-		} else {
-			$signoff = 0;
+			next;
 		}
 
 		# print only one empty line
 		# do not print empty line after signoff
 		if ($line eq "") {
-			next if ($empty || $signoff);
-			$empty = 1;
+			next if ($skip_blank_line);
+			$skip_blank_line = 1;
 		} else {
-			$empty = 0;
+			$skip_blank_line = 0;
 		}
 
 		print format_log_line_html($line) . "<br/>\n";
@@ -4515,7 +4508,7 @@ sub git_print_log {
 
 	if ($opts{'-final_empty_line'}) {
 		# end with single empty line
-		print "<br/>\n" unless $empty;
+		print "<br/>\n" unless $skip_blank_line;
 	}
 }
 
-- 
1.7.10.4
