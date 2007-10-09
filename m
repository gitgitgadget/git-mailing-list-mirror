From: Jean-Luc Herren <jlh@gmx.ch>
Subject: [PATCH 2/2] git add -i: Remove unused variables
Date: Tue, 09 Oct 2007 21:34:17 +0200
Message-ID: <470BD7B9.4080206@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 09 21:35:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfKr2-0007De-MR
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 21:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851AbXJITen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 15:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752773AbXJITem
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 15:34:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:50399 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751851AbXJITek (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 15:34:40 -0400
Received: (qmail invoked by alias); 09 Oct 2007 19:34:39 -0000
Received: from 217-8.79-83.cust.bluewin.ch (EHLO [192.168.123.202]) [83.79.8.217]
  by mail.gmx.net (mp035) with SMTP; 09 Oct 2007 21:34:39 +0200
X-Authenticated: #14737133
X-Provags-ID: V01U2FsdGVkX1/yIGpOOsHydGY+Tr6rZnq5dzpFtEtnqOI1kNhcb0
	jztEsPiD3lKWzg
User-Agent: Thunderbird 2.0.0.6 (X11/20070805)
X-Enigmail-Version: 0.95.3
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60430>


Signed-off-by: Jean-Luc Herren <jlh@gmx.ch>
---

Maybe it's a matter of opinion which of the following is better.
The later makes it clearer that some return values are being
thrown away, but some people might consider it noise.  I chose the
first one for now.

my ($a, $b) = function(...)
my ($a, $b, undef, undef) = function(...)

 git-add--interactive.perl |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 15b3f5b..ac598f8 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -374,9 +374,8 @@ sub split_hunk {
 	# it can be split, but we would need to take care of
 	# overlaps later.
 
-	my ($o_ofs, $o_cnt, $n_ofs, $n_cnt) = parse_hunk_header($text->[0]);
+	my ($o_ofs, undef, $n_ofs) = parse_hunk_header($text->[0]);
 	my $hunk_start = 1;
-	my $next_hunk_start;
 
       OUTER:
 	while (1) {
@@ -443,8 +442,8 @@ sub split_hunk {
 	for my $hunk (@split) {
 		$o_ofs = $hunk->{OLD};
 		$n_ofs = $hunk->{NEW};
-		$o_cnt = $hunk->{OCNT};
-		$n_cnt = $hunk->{NCNT};
+		my $o_cnt = $hunk->{OCNT};
+		my $n_cnt = $hunk->{NCNT};
 
 		my $head = ("@@ -$o_ofs" .
 			    (($o_cnt != 1) ? ",$o_cnt" : '') .
@@ -459,7 +458,7 @@ sub split_hunk {
 sub find_last_o_ctx {
 	my ($it) = @_;
 	my $text = $it->{TEXT};
-	my ($o_ofs, $o_cnt, $n_ofs, $n_cnt) = parse_hunk_header($text->[0]);
+	my ($o_ofs, $o_cnt) = parse_hunk_header($text->[0]);
 	my $i = @{$text};
 	my $last_o_ctx = $o_ofs + $o_cnt;
 	while (0 < --$i) {
@@ -531,8 +530,7 @@ sub coalesce_overlapping_hunks {
 
 	for (grep { $_->{USE} } @in) {
 		my $text = $_->{TEXT};
-		my ($o_ofs, $o_cnt, $n_ofs, $n_cnt) =
-		    parse_hunk_header($text->[0]);
+		my ($o_ofs) = parse_hunk_header($text->[0]);
 		if (defined $last_o_ctx &&
 		    $o_ofs <= $last_o_ctx) {
 			merge_hunk($out[-1], $_);
@@ -699,7 +697,7 @@ sub patch_update_cmd {
 
 	@hunk = coalesce_overlapping_hunks(@hunk);
 
-	my ($o_lofs, $n_lofs) = (0, 0);
+	my $n_lofs = 0;
 	my @result = ();
 	for (@hunk) {
 		my $text = $_->{TEXT};
@@ -806,8 +804,6 @@ sub main_loop {
 	}
 }
 
-my @z;
-
 refresh();
 status_cmd();
 main_loop();
-- 
1.5.3.4
