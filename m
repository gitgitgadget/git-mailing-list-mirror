From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH] Add parsing of elm aliases to git-send-email
Date: Wed, 22 Apr 2009 09:41:29 -0400
Message-ID: <1240407689-19500-1-git-send-email-wfp5p@virginia.edu>
Cc: gitster@pobox.com, Bill Pemberton <wfp5p@virginia.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 22 15:53:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwcsj-0000kn-PD
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 15:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752874AbZDVNvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 09:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752647AbZDVNvX
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 09:51:23 -0400
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:60802 "EHLO
	viridian.itc.Virginia.EDU" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327AbZDVNvW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 09:51:22 -0400
X-Greylist: delayed 581 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Apr 2009 09:51:22 EDT
Received: by viridian.itc.Virginia.EDU (Postfix, from userid 1249)
	id 8E2415703B; Wed, 22 Apr 2009 09:41:39 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117198>

elm stores a text file version of the aliases that is
<alias> = <comment> = <email address>

This adds the parsing of this file to git-send-email

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
---

I'm probably the only one that still uses elm, but hey, it's an easy 
parser to add.

 Documentation/git-send-email.txt |    2 +-
 git-send-email.perl              |    8 ++++++++
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 0b1f183..794224b 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -262,7 +262,7 @@ sendemail.aliasesfile::
 
 sendemail.aliasfiletype::
 	Format of the file(s) specified in sendemail.aliasesfile. Must be
-	one of 'mutt', 'mailrc', 'pine', or 'gnus'.
+	one of 'mutt', 'mailrc', 'pine', 'elm', or 'gnus'.
 
 sendemail.multiedit::
 	If true (default), a single editor instance will be spawned to edit
diff --git a/git-send-email.perl b/git-send-email.perl
index 172b53c..c08d40c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -418,6 +418,14 @@ my %parse_alias = (
 			$x =~ /^(\S+)$f\t\(?([^\t]+?)\)?(:?$f){0,2}$/ or next;
 			$aliases{$1} = [ split_addrs($2) ];
 		}},
+        elm => sub  { my $fh = shift;
+	              while (<$fh>) {
+			  if (/^(\S+)\s+=\s+[^=]+=\s(\S+)/) {
+			      my ($alias, $addr) = ($1, $2);
+			       $aliases{$alias} = [ split_addrs($addr) ];
+			  }
+		      } },
+
 	gnus => sub { my $fh = shift; while (<$fh>) {
 		if (/\(define-mail-alias\s+"(\S+?)"\s+"(\S+?)"\)/) {
 			$aliases{$1} = [ $2 ];
-- 
1.6.0.6
