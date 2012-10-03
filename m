From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: [PATCH 1/2] git-send-email: introduce compose-encoding
Date: Thu,  4 Oct 2012 00:05:30 +0200
Message-ID: <1349301931-11912-1-git-send-email-krzysiek@podlesie.net>
Cc: Krzysztof Mazur <krzysiek@podlesie.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 00:03:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtKs-0001DP-PL
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:52:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756021Ab2JCWOs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 18:14:48 -0400
Received: from shrek-modem2.podlesie.net ([83.13.132.46]:38131 "EHLO
	shrek.podlesie.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754416Ab2JCWOr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 18:14:47 -0400
Received: from geronimo.kostuchna.emnet (localhost [127.0.0.1])
	by shrek.podlesie.net (Postfix) with ESMTP id 53AB198;
	Thu,  4 Oct 2012 00:07:05 +0200 (CEST)
X-Mailer: git-send-email 1.7.12.2.2.g1c3c581
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206957>

The introduction email (--compose option) have encoding hardcoded to
UTF-8, but invoked editor may not use UTF-8 encoding.
The encoding used by patches can be changed by the "8bit-encoding"
option, but this option does not have effect on introduction email
and equivalent for introduction email is missing.

Added compose-encoding command line option and sendemail.composeencoding
configuration option specify encoding of introduction email.

Signed-off-by: Krzysztof Mazur <krzysiek@podlesie.net>
---
 Documentation/git-send-email.txt | 5 +++++
 git-send-email.perl              | 9 ++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 3241170..9f09e92 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -126,6 +126,11 @@ The --to option must be repeated for each user you want on the to list.
 +
 Note that no attempts whatsoever are made to validate the encoding.
 
+--compose-encoding=<encoding>::
+	Specify encoding of compose message. Default is the value of the
+	'sendemail.composeencoding'; if that is unspecified, UTF-8 is assumed.
++
+
 
 Sending
 ~~~~~~~
diff --git a/git-send-email.perl b/git-send-email.perl
index aea66a0..107e814 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -56,6 +56,7 @@ git send-email [options] <file | directory | rev-list options >
     --in-reply-to           <str>  * Email "In-Reply-To:"
     --annotate                     * Review each patch that will be sent in an editor.
     --compose                      * Open an editor for introduction.
+    --compose-encoding      <str>  * Encoding to assume for introduction.
     --8bit-encoding         <str>  * Encoding to assume 8bit mails if undeclared
 
   Sending:
@@ -198,6 +199,7 @@ my ($identity, $aliasfiletype, @alias_files, $smtp_domain);
 my ($validate, $confirm);
 my (@suppress_cc);
 my ($auto_8bit_encoding);
+my ($compose_encoding);
 
 my ($debug_net_smtp) = 0;		# Net::SMTP, see send_message()
 
@@ -231,6 +233,7 @@ my %config_settings = (
     "confirm"   => \$confirm,
     "from" => \$sender,
     "assume8bitencoding" => \$auto_8bit_encoding,
+    "composeencoding" => \$compose_encoding,
 );
 
 my %config_path_settings = (
@@ -315,6 +318,7 @@ my $rc = GetOptions("h" => \$help,
 		    "validate!" => \$validate,
 		    "format-patch!" => \$format_patch,
 		    "8bit-encoding=s" => \$auto_8bit_encoding,
+		    "compose-encoding=s" => \$compose_encoding,
 		    "force" => \$force,
 	 );
 
@@ -638,10 +642,13 @@ EOT
 			$summary_empty = 0 unless (/^\n$/);
 		} elsif (/^\n$/) {
 			$in_body = 1;
+			if (!defined $compose_encoding) {
+				$compose_encoding = "UTF-8";
+			}
 			if ($need_8bit_cte) {
 				print $c2 "MIME-Version: 1.0\n",
 					 "Content-Type: text/plain; ",
-					   "charset=UTF-8\n",
+					   "charset=$compose_encoding\n",
 					 "Content-Transfer-Encoding: 8bit\n";
 			}
 		} elsif (/^MIME-Version:/i) {
-- 
1.7.12.2.2.g1c3c581
