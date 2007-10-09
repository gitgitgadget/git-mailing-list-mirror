From: Jean-Luc Herren <jlh@gmx.ch>
Subject: [PATCH 1/2] git add -i: Fix parsing of abbreviated hunk headers
Date: Tue, 09 Oct 2007 21:29:26 +0200
Message-ID: <470BD696.1010305@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 09 21:35:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfKr2-0007De-0J
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 21:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744AbXJITel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 15:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752040AbXJITek
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 15:34:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:53285 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750807AbXJITek (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 15:34:40 -0400
Received: (qmail invoked by alias); 09 Oct 2007 19:34:38 -0000
Received: from 217-8.79-83.cust.bluewin.ch (EHLO [192.168.123.202]) [83.79.8.217]
  by mail.gmx.net (mp038) with SMTP; 09 Oct 2007 21:34:38 +0200
X-Authenticated: #14737133
X-Provags-ID: V01U2FsdGVkX191lP8xhQR19HPaIbXcIk0knB6UlEtimAw0XsjF6w
	OvIfhYZ++Rm0wt
User-Agent: Thunderbird 2.0.0.6 (X11/20070805)
X-Enigmail-Version: 0.95.3
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60429>

The unified diff format allows one-line ranges to be abbreviated
by omiting the size.  The hunk header "@@ -10,1 +10,1 @@" can be
expressed as "@@ -10 +10 @@", but this wasn't properly parsed in
all cases.

Such abbreviated hunk headers are generated when a one-line change
(add, remove or modify) appears without context; for example
because the file is a one-liner itself or because GIT_DIFF_OPTS
was set to '-u0'.  If the user then runs 'git add -i' and enters
the 'patch' command for that file, perl complains about undefined
variables.

Signed-off-by: Jean-Luc Herren <jlh@gmx.ch>
---
 git-add--interactive.perl |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index be68814..15b3f5b 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -360,7 +360,9 @@ sub hunk_splittable {
 sub parse_hunk_header {
 	my ($line) = @_;
 	my ($o_ofs, $o_cnt, $n_ofs, $n_cnt) =
-	    $line =~ /^@@ -(\d+)(?:,(\d+)) \+(\d+)(?:,(\d+)) @@/;
+	    $line =~ /^@@ -(\d+)(?:,(\d+))? \+(\d+)(?:,(\d+))? @@/;
+	$o_cnt = 1 unless defined $o_cnt;
+	$n_cnt = 1 unless defined $n_cnt;
 	return ($o_ofs, $o_cnt, $n_ofs, $n_cnt);
 }
 
@@ -705,9 +707,6 @@ sub patch_update_cmd {
 		    parse_hunk_header($text->[0]);
 
 		if (!$_->{USE}) {
-			if (!defined $o_cnt) { $o_cnt = 1; }
-			if (!defined $n_cnt) { $n_cnt = 1; }
-
 			# We would have added ($n_cnt - $o_cnt) lines
 			# to the postimage if we were to use this hunk,
 			# but we didn't.  So the line number that the next
@@ -719,10 +718,10 @@ sub patch_update_cmd {
 			if ($n_lofs) {
 				$n_ofs += $n_lofs;
 				$text->[0] = ("@@ -$o_ofs" .
-					      ((defined $o_cnt)
+					      (($o_cnt != 1)
 					       ? ",$o_cnt" : '') .
 					      " +$n_ofs" .
-					      ((defined $n_cnt)
+					      (($n_cnt != 1)
 					       ? ",$n_cnt" : '') .
 					      " @@\n");
 			}
-- 
1.5.3.4
