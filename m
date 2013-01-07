From: Nickolai Zeldovich <nickolai@csail.mit.edu>
Subject: [PATCH] git-send-email: treat field names as case-independent
Date: Sun,  6 Jan 2013 20:34:58 -0500
Message-ID: <1357522498-8086-1-git-send-email-nickolai@csail.mit.edu>
Cc: Nickolai Zeldovich <nickolai@csail.mit.edu>, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 07 03:04:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ts24l-0006tR-M1
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 03:04:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378Ab3AGCEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 21:04:12 -0500
Received: from outgoing.csail.mit.edu ([128.30.2.149]:44638 "EHLO
	outgoing.csail.mit.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269Ab3AGCEK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 21:04:10 -0500
X-Greylist: delayed 1740 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 Jan 2013 21:04:10 EST
Received: from c-71-232-26-90.hsd1.ma.comcast.net ([71.232.26.90] helo=sahara)
	by outgoing.csail.mit.edu with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <nickolai@csail.mit.edu>)
	id 1Ts1cG-0004u9-Uw; Sun, 06 Jan 2013 20:35:05 -0500
Received: from nickolai by sahara with local (Exim 4.80)
	(envelope-from <nickolai@csail.mit.edu>)
	id 1Ts1cq-00027G-Jb; Sun, 06 Jan 2013 20:35:40 -0500
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212866>

Field names like To:, Cc:, etc should be treated as case-independent;
use a case-insensitive regexp to match them as such.  Previously,
git-send-email would send email messages with a lowercase "cc:" line in
the body without actually sending a copy of the message to that address.

Signed-off-by: Nickolai Zeldovich <nickolai@csail.mit.edu>
---
 git-send-email.perl |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 94c7f76..be809e5 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1285,10 +1285,10 @@ foreach my $t (@files) {
 		}
 
 		if (defined $input_format && $input_format eq 'mbox') {
-			if (/^Subject:\s+(.*)$/) {
+			if (/^Subject:\s+(.*)$/i) {
 				$subject = $1;
 			}
-			elsif (/^From:\s+(.*)$/) {
+			elsif (/^From:\s+(.*)$/i) {
 				($author, $author_encoding) = unquote_rfc2047($1);
 				next if $suppress_cc{'author'};
 				next if $suppress_cc{'self'} and $author eq $sender;
@@ -1296,14 +1296,14 @@ foreach my $t (@files) {
 					$1, $_) unless $quiet;
 				push @cc, $1;
 			}
-			elsif (/^To:\s+(.*)$/) {
+			elsif (/^To:\s+(.*)$/i) {
 				foreach my $addr (parse_address_line($1)) {
 					printf("(mbox) Adding to: %s from line '%s'\n",
 						$addr, $_) unless $quiet;
 					push @to, $addr;
 				}
 			}
-			elsif (/^Cc:\s+(.*)$/) {
+			elsif (/^Cc:\s+(.*)$/i) {
 				foreach my $addr (parse_address_line($1)) {
 					if (unquote_rfc2047($addr) eq $sender) {
 						next if ($suppress_cc{'self'});
@@ -1325,7 +1325,7 @@ foreach my $t (@files) {
 			elsif (/^Message-Id: (.*)/i) {
 				$message_id = $1;
 			}
-			elsif (!/^Date:\s/ && /^[-A-Za-z]+:\s+\S/) {
+			elsif (!/^Date:\s/i && /^[-A-Za-z]+:\s+\S/) {
 				push @xh, $_;
 			}
 
-- 
1.7.10.4
