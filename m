From: Luis Henriques <henrix@camandro.org>
Subject: [RFC][PATCH] send-email: add --[no-]xmailer option
Date: Mon, 24 Mar 2014 21:38:27 +0000
Message-ID: <20140324213814.GA1267@achilles.my.domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 24 23:03:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSCy6-0006ru-PP
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 23:03:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbaCXWDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 18:03:39 -0400
Received: from balrog.mythic-beasts.com ([93.93.130.6]:40508 "EHLO
	balrog.mythic-beasts.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790AbaCXWDi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 18:03:38 -0400
X-Greylist: delayed 1502 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Mar 2014 18:03:38 EDT
Received: from [2.80.169.38] (port=59841 helo=localhost)
	by balrog.mythic-beasts.com with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80)
	(envelope-from <henrix@camandro.org>)
	id 1WSCZm-0005vO-F2
	for git@vger.kernel.org; Mon, 24 Mar 2014 21:38:35 +0000
Content-Disposition: inline
X-BlackCat-Spam-Score: -28
X-Mythic-Debug: Threshold =  On = 
X-Spam-Status: No, score=-2.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244887>

Add --[no-]xmailer that allows a user to disable adding the 'X-Mailer:'
header to the email being sent.

Signed-off-by: Luis Henriques <henrix@camandro.org>
---
 Documentation/config.txt         |  1 +
 Documentation/git-send-email.txt |  3 +++
 git-send-email.perl              | 12 ++++++++++--
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 73c8973..c33d5a1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2222,6 +2222,7 @@ sendemail.smtpserveroption::
 sendemail.smtpuser::
 sendemail.thread::
 sendemail.validate::
+sendemail.xmailer::
 	See linkgit:git-send-email[1] for description.
 
 sendemail.signedoffcc::
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index f0e57a5..fab6264 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -131,6 +131,9 @@ Note that no attempts whatsoever are made to validate the encoding.
 	Specify encoding of compose message. Default is the value of the
 	'sendemail.composeencoding'; if that is unspecified, UTF-8 is assumed.
 
+--xmailer::
+	Prevent adding the "X-Mailer:" header.  Default value is
+	'sendemail.xmailer'.
 
 Sending
 ~~~~~~~
diff --git a/git-send-email.perl b/git-send-email.perl
index fdb0029..8789124 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -54,6 +54,7 @@ git send-email [options] <file | directory | rev-list options >
     --[no-]bcc              <str>  * Email Bcc:
     --subject               <str>  * Email "Subject:"
     --in-reply-to           <str>  * Email "In-Reply-To:"
+    --[no-]xmailer                 * Don't add "X-Mailer:" header.  Default on.
     --[no-]annotate                * Review each patch that will be sent in an editor.
     --compose                      * Open an editor for introduction.
     --compose-encoding      <str>  * Encoding to assume for introduction.
@@ -174,6 +175,9 @@ my $force = 0;
 my $multiedit;
 my $editor;
 
+# Usage of X-Mailer email header
+my $xmailer;
+
 sub do_edit {
 	if (!defined($editor)) {
 		$editor = Git::command_oneline('var', 'GIT_EDITOR');
@@ -214,7 +218,8 @@ my %config_bool_settings = (
     "signedoffcc" => [\$signed_off_by_cc, undef],      # Deprecated
     "validate" => [\$validate, 1],
     "multiedit" => [\$multiedit, undef],
-    "annotate" => [\$annotate, undef]
+    "annotate" => [\$annotate, undef],
+    "xmailer" => [\$xmailer, 1]
 );
 
 my %config_settings = (
@@ -311,6 +316,7 @@ my $rc = GetOptions("h" => \$help,
 		    "8bit-encoding=s" => \$auto_8bit_encoding,
 		    "compose-encoding=s" => \$compose_encoding,
 		    "force" => \$force,
+		    "xmailer!" => \$xmailer,
 	 );
 
 usage() if $help;
@@ -1144,8 +1150,10 @@ To: $to${ccline}
 Subject: $subject
 Date: $date
 Message-Id: $message_id
-X-Mailer: git-send-email $gitversion
 ";
+	if ($xmailer) {
+		$header .= "X-Mailer: git-send-email $gitversion\n";
+	}
 	if ($reply_to) {
 
 		$header .= "In-Reply-To: $reply_to\n";
-- 
1.9.1
