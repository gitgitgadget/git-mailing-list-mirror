From: Luis Henriques <henrix@camandro.org>
Subject: [PATCH v2] send-email: add --[no-]xmailer option
Date: Wed, 3 Dec 2014 18:07:09 +0000
Message-ID: <20141203180709.GA11160@charon.olymp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 03 19:07:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwEKd-0007Gc-4J
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 19:07:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbaLCSHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 13:07:13 -0500
Received: from balrog.mythic-beasts.com ([93.93.130.6]:39916 "EHLO
	balrog.mythic-beasts.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045AbaLCSHM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 13:07:12 -0500
Received: from [2.81.129.121] (port=49294 helo=localhost)
	by balrog.mythic-beasts.com with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <henrix@camandro.org>)
	id 1XwEKT-0005ES-N8; Wed, 03 Dec 2014 18:07:10 +0000
Content-Disposition: inline
X-BlackCat-Spam-Score: -28
X-Mythic-Debug: Threshold =  On = 
X-Spam-Status: No, score=-2.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260674>

Add --[no-]xmailer that allows a user to disable adding the 'X-Mailer:'
header to the email being sent.

Acked-by: Eric Wong <normalperson@yhbt.net>
Signed-off-by: Luis Henriques <henrix@camandro.org>
---
 Documentation/config.txt         |  1 +
 Documentation/git-send-email.txt |  5 +++++
 git-send-email.perl              | 11 +++++++++--
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 922072596fdd..3f9898931d3b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2304,6 +2304,7 @@ sendemail.smtpserveroption::
 sendemail.smtpuser::
 sendemail.thread::
 sendemail.validate::
+sendemail.xmailer::
 	See linkgit:git-send-email[1] for description.
 
 sendemail.signedoffcc::
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index a60776eb579e..a0bd806cfed8 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -131,6 +131,11 @@ Note that no attempts whatsoever are made to validate the encoding.
 	Specify encoding of compose message. Default is the value of the
 	'sendemail.composeencoding'; if that is unspecified, UTF-8 is assumed.
 
+--xmailer::
+--no-xmailer::
+	Add (or prevent adding) the "X-Mailer:" header.  By default,
+	the header is added, but it can be turned off by setting the
+	`sendemail.xmailer` configuration variable to `false`.
 
 Sending
 ~~~~~~~
diff --git a/git-send-email.perl b/git-send-email.perl
index 9949db01e119..a6e66b9ae386 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -54,6 +54,7 @@ git send-email [options] <file | directory | rev-list options >
     --[no-]bcc              <str>  * Email Bcc:
     --subject               <str>  * Email "Subject:"
     --in-reply-to           <str>  * Email "In-Reply-To:"
+    --[no-]xmailer                 * Add "X-Mailer:" header (default).
     --[no-]annotate                * Review each patch that will be sent in an editor.
     --compose                      * Open an editor for introduction.
     --compose-encoding      <str>  * Encoding to assume for introduction.
@@ -176,6 +177,8 @@ my $force = 0;
 my $multiedit;
 my $editor;
 
+my $use_xmailer;
+
 sub do_edit {
 	if (!defined($editor)) {
 		$editor = Git::command_oneline('var', 'GIT_EDITOR');
@@ -219,7 +222,8 @@ my %config_bool_settings = (
     "signedoffcc" => [\$signed_off_by_cc, undef],      # Deprecated
     "validate" => [\$validate, 1],
     "multiedit" => [\$multiedit, undef],
-    "annotate" => [\$annotate, undef]
+    "annotate" => [\$annotate, undef],
+    "xmailer" => [\$use_xmailer, 1]
 );
 
 my %config_settings = (
@@ -318,6 +322,7 @@ my $rc = GetOptions("h" => \$help,
 		    "8bit-encoding=s" => \$auto_8bit_encoding,
 		    "compose-encoding=s" => \$compose_encoding,
 		    "force" => \$force,
+		    "xmailer!" => \$use_xmailer,
 	 );
 
 usage() if $help;
@@ -1163,8 +1168,10 @@ To: $to${ccline}
 Subject: $subject
 Date: $date
 Message-Id: $message_id
-X-Mailer: git-send-email $gitversion
 ";
+	if ($use_xmailer) {
+		$header .= "X-Mailer: git-send-email $gitversion\n";
+	}
 	if ($reply_to) {
 
 		$header .= "In-Reply-To: $reply_to\n";
