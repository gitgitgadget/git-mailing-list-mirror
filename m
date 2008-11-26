From: Trent Piepho <tpiepho@freescale.com>
Subject: [PATCH] send-email: Fix Pine address book parsing
Date: Tue, 25 Nov 2008 18:55:00 -0800
Message-ID: <1227668100-5563-1-git-send-email-tpiepho@freescale.com>
Cc: Trent Piepho <tpiepho@freescale.com>, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 26 03:56:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5AaB-00024f-AQ
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 03:56:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbYKZCzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 21:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752322AbYKZCzf
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 21:55:35 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:40216 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668AbYKZCze (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2008 21:55:34 -0500
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id mAQ2tK2h000890;
	Tue, 25 Nov 2008 19:55:28 -0700 (MST)
Received: from localhost.localdomain (vpn-10-213-160-8.am.freescale.net [10.213.160.8])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id mAQ2tJXZ016709;
	Tue, 25 Nov 2008 20:55:19 -0600 (CST)
X-Mailer: git-send-email 1.5.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101700>

See:  http://www.washington.edu/pine/tech-notes/low-level.html

Entries with a fcc or comment field after the address weren't parsed
correctly.

Continuation lines, identified by leading spaces, were also not handled.

Distribution lists which had ( ) around a list of addresses did not have
the parenthesis removed.

Signed-off-by: Trent Piepho <tpiepho@freescale.com>
---
 git-send-email.perl |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 94ca5c8..007e2c6 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -345,10 +345,13 @@ my %parse_alias = (
 			# spaces delimit multiple addresses
 			$aliases{$1} = [ split(/\s+/, $2) ];
 		}}},
-	pine => sub { my $fh = shift; while (<$fh>) {
-		if (/^(\S+)\t.*\t(.*)$/) {
+	pine => sub { my $fh = shift; my $f='\t[^\t]*';
+	        for (my $x = ''; defined($x); $x = $_) {
+			chomp $x;
+		        $x .= $1 while(defined($_ = <$fh>) && /^ +(.*)$/);
+			$x =~ /^(\S+)$f\t\(?([^\t]+?)\)?(:?$f){0,2}$/ or next;
 			$aliases{$1} = [ split(/\s*,\s*/, $2) ];
-		}}},
+		}},
 	gnus => sub { my $fh = shift; while (<$fh>) {
 		if (/\(define-mail-alias\s+"(\S+?)"\s+"(\S+?)"\)/) {
 			$aliases{$1} = [ $2 ];
-- 
1.5.4.1
