From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] send-email: add 'specify-author' option
Date: Sun,  6 Feb 2011 16:44:05 +0200
Message-ID: <1297003445-23652-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 06 15:44:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm5qk-00016V-Af
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 15:44:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748Ab1BFOoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 09:44:20 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61693 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677Ab1BFOoU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 09:44:20 -0500
Received: by fxm20 with SMTP id 20so4033116fxm.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 06:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=4dGZOoppVl58xipk0kjXRfeWRM4A8jQMTXCUGBwWW34=;
        b=oNblvhAZUnuSiL/zGqOug5fEQFStgWVt7eMLAtIbz1Tbr/FNzeuXR2swieChTOXoTI
         4gYHGw1rtgsoRzQpiUlCdF/aIRaqNb/r+cV+1pHWy4S9kQQaea0z2cFofj2g1F3k8iMi
         hty7r11BULFN7f/CptGTBlQdDvenic94nPfq0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=iOvBAO/OBzn7AraQoJHzQDW+L6S9zkWUfASxJOddE9uDYv8y5B1vf8eyFYB2aO9lsf
         i3xcM6DYZRBKR5Jo90y/xDmgiqwBeoV0i4egJXxEX8ZbzovaYEICMq8vO8aRiYAU3uoE
         Vr4NSseIL45/LG4aBra/rXPZlXiyOQXexXdzY=
Received: by 10.223.98.198 with SMTP id r6mr73762fan.42.1297003458757;
        Sun, 06 Feb 2011 06:44:18 -0800 (PST)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id o17sm856343fal.25.2011.02.06.06.44.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Feb 2011 06:44:18 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1.gf4271.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166148>

From: Felipe Contreras <felipe.contreras@gmail.com>

Always specify the author of the commit in the body of the message, even
if the committer is the author.

This is useful if the 'From' header is mangled by some mail server.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-send-email.txt |    4 ++++
 git-send-email.perl              |    7 ++++++-
 t/t9001-send-email.sh            |   12 ++++++++++++
 3 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 7ec9dab..5895835 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -125,6 +125,10 @@ The --to option must be repeated for each user you want on the to list.
 +
 Note that no attempts whatsoever are made to validate the encoding.
 
+--specify-author::
+	Always specify the author of the commit in the body of the message,
+	even if the committer is the author. This is useful if the 'From'
+	header is mangled by some mail server.
 
 Sending
 ~~~~~~~
diff --git a/git-send-email.perl b/git-send-email.perl
index 76565de..30f27ff 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -57,6 +57,8 @@ git send-email [options] <file | directory | rev-list options >
     --annotate                     * Review each patch that will be sent in an editor.
     --compose                      * Open an editor for introduction.
     --8bit-encoding         <str>  * Encoding to assume 8bit mails if undeclared
+    --specify-author               * Always specify the author of the commit in
+			             the body of the message.
 
   Sending:
     --envelope-sender       <str>  * Email envelope sender.
@@ -198,6 +200,7 @@ my ($identity, $aliasfiletype, @alias_files, $smtp_domain);
 my ($validate, $confirm);
 my (@suppress_cc);
 my ($auto_8bit_encoding);
+my ($specify_author);
 
 my ($debug_net_smtp) = 0;		# Net::SMTP, see send_message()
 
@@ -210,6 +213,7 @@ my %config_bool_settings = (
     "signedoffbycc" => [\$signed_off_by_cc, undef],
     "signedoffcc" => [\$signed_off_by_cc, undef],      # Deprecated
     "validate" => [\$validate, 1],
+    "specifyauthor" => [\$specify_author, undef],
 );
 
 my %config_settings = (
@@ -311,6 +315,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "format-patch!" => \$format_patch,
 		    "8bit-encoding=s" => \$auto_8bit_encoding,
 		    "force" => \$force,
+		    "specify-author!" => \$specify_author,
 	 );
 
 unless ($rc) {
@@ -1285,7 +1290,7 @@ foreach my $t (@files) {
 		$subject = quote_rfc2047($subject, $auto_8bit_encoding);
 	}
 
-	if (defined $author and $author ne $sender) {
+	if (defined $author and ($author ne $sender or $specify_author)) {
 		$message = "From: $author\n\n$message";
 		if (defined $author_encoding) {
 			if ($has_content_type) {
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 579ddb7..66d2541 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -280,6 +280,18 @@ test_expect_success $PREREQ 'Author From: not in message body' '
 	! grep "From: A <author@example.com>" msgbody1
 '
 
+test_expect_success $PREREQ 'Author From: in message body (forced)' '
+	clean_fake_sendmail &&
+	git send-email \
+		--from="A <author@example.com>" \
+		--to=nobody@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		--specify-author \
+		$patches &&
+	sed "1,/^\$/d" < msgtxt1 > msgbody1 &&
+	grep "From: A <author@example.com>" msgbody1
+'
+
 test_expect_success $PREREQ 'allow long lines with --no-validate' '
 	git send-email \
 		--from="Example <nobody@example.com>" \
-- 
1.7.4.1.gf4271.dirty
