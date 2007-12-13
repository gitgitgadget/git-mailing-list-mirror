From: Andy Whitcroft <apw@shadowen.org>
Subject: git-svn: expand handling of From: and Signed-off-by:
Date: Thu, 13 Dec 2007 06:58:15 +0000
Message-ID: <20071213065815.GH30608@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 13 07:58:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2i1n-0006Lp-61
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 07:58:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762633AbXLMG5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 01:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762472AbXLMG5x
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 01:57:53 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:4170 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762633AbXLMG5w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 01:57:52 -0500
Received: from localhost ([127.0.0.1] helo=pinky)
	by hellhawk.shadowen.org with esmtp (Exim 4.63)
	(envelope-from <apw@shadowen.org>)
	id 1J2i10-0001ck-VB; Thu, 13 Dec 2007 06:57:51 +0000
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68124>

The current parsing for From: and Signed-off-by: lines handles fully
specified names:

	From: Full Name <email@address>

Expand this to include the raw email addresses and straight "names":

	From: email@address       -> email <email@address>
	From: Full Name           -> Full Name <unknown>

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 git-svn.perl |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)
diff --git a/git-svn.perl b/git-svn.perl
index 54d7844..058f8e9 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2363,11 +2363,20 @@ sub make_log_entry {
 
 	my ($commit_name, $commit_email) = ($name, $email);
 	if ($_use_log_author) {
-		if ($log_entry{log} =~ /From:\s+(.*?)\s+<(.*)>\s*\n/) {
-			($name, $email) = ($1, $2);
-		} elsif ($log_entry{log} =~
-		                      /Signed-off-by:\s+(.*?)\s+<(.*)>\s*\n/) {
+		my $name_field;
+		if ($log_entry{log} =~ /From:\s+(.*\S)\s*\n/i) {
+			$name_field = $1;
+		} elsif ($log_entry{log} =~ /Signed-off-by:\s+(.*\S)\s*\n/i) {
+			$name_field = $1;
+		}
+		if (!defined $name_field) {
+			#
+		} elsif ($name_field =~ /(.*?)\s+<(.*)>/) {
 			($name, $email) = ($1, $2);
+        	} elsif ($name_field =~ /(.*)@/) {
+			($name, $email) = ($1, $name_field);
+		} else {
+			($name, $email) = ($name_field, 'unknown');
 		}
 	}
 	if (defined $headrev && $self->use_svm_props) {
