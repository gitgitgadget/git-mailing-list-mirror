From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH RESEND] send-email: add 'specify-author' option
Date: Fri,  6 Apr 2012 15:21:13 +0300
Message-ID: <1333714876-21895-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	"Thomas Rast" <trast@student.ethz.ch>,
	"Pierre Habouzit" <madcoder@debian.org>,
	"Michael Witten" <mfwitten@MIT.EDU>,
	"Pascal Obry" <pascal@obry.net>,
	"Jay Soffian" <jaysoffian@gmail.com>,
	"David Brown" <git@davidb.org>, "Adam Roben" <aroben@apple.com>,
	"Nanako Shiraishi" <nanako3@lavabit.com>,
	"Matthew Wilcox" <matthew@wil.cx>,
	"Robin H. Johnson" <robbat2@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 06 14:21:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SG8Ab-0005e5-4k
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 14:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754594Ab2DFMVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 08:21:33 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:48206 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115Ab2DFMVc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 08:21:32 -0400
Received: by lbbgg6 with SMTP id gg6so643779lbb.19
        for <git@vger.kernel.org>; Fri, 06 Apr 2012 05:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Tn3YJYtJ/n1E/pecoFF4wIp5Age3QQDYmb6edC1/8gc=;
        b=fQqVQC/mxAysFB/URcmS774YndR1FjeYmPieh5H03XFsapa1EtoLaE9IgSEqkuVXSz
         Ny8cLlwLjFoaQA1nByncnCqJIguDxZbrXqZmLhqk6lcdBMb8fXXgfd4VZDtSINNiFNiE
         fVvgHkIiUmwIcQPmO5T6/upDJ3sjdPjYFueRZEggZ8/MxzK1M9XUybHF1H8XlXpmk8yt
         Oij8DxgB8DrJt1amKgSAWMrluqYiNy+FOPeq+3D50SSc8ul+vKWzvHMG0sJ9mX8t82NM
         CfNHlT7/u8Znny7yOzmXZ7rIvBT1W0pGwpCaokYM1Znam7k11MAtbCZMtsJaSK/cN/cw
         p9wg==
Received: by 10.152.145.169 with SMTP id sv9mr8350580lab.12.1333714890569;
        Fri, 06 Apr 2012 05:21:30 -0700 (PDT)
Received: from localhost (80-186-93-53.elisa-mobile.fi. [80.186.93.53])
        by mx.google.com with ESMTPS id hv2sm8800776lbb.9.2012.04.06.05.21.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 06 Apr 2012 05:21:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194868>

Some mail servers (Microsoft Exchange) mangle the 'From' header, so
while applying the patches, the author has to be fixed manually.

This option allows to always specify the author of the commit in the
body of the message, even if the committer is the author.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-send-email.txt |    4 ++++
 git-send-email.perl              |    9 +++++++--
 t/t9001-send-email.sh            |   12 ++++++++++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 3241170..9bd1379 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -126,6 +126,10 @@ The --to option must be repeated for each user you want on the to list.
 +
 Note that no attempts whatsoever are made to validate the encoding.
 
+--specify-author::
+	Always specify the author of the commit in the body of the message,
+	even if the committer is the author. This is useful if the 'From'
+	header is mangled by some mail server.
 
 Sending
 ~~~~~~~
diff --git a/git-send-email.perl b/git-send-email.perl
index ef30c55..f18ad16 100755
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
 
@@ -210,7 +213,8 @@ my %config_bool_settings = (
     "signedoffbycc" => [\$signed_off_by_cc, undef],
     "signedoffcc" => [\$signed_off_by_cc, undef],      # Deprecated
     "validate" => [\$validate, 1],
-    "multiedit" => [\$multiedit, undef]
+    "multiedit" => [\$multiedit, undef],
+    "specifyauthor" => [\$specify_author, undef],
 );
 
 my %config_settings = (
@@ -316,6 +320,7 @@ my $rc = GetOptions("h" => \$help,
 		    "format-patch!" => \$format_patch,
 		    "8bit-encoding=s" => \$auto_8bit_encoding,
 		    "force" => \$force,
+		    "specify-author!" => \$specify_author,
 	 );
 
 usage() if $help;
@@ -1310,7 +1315,7 @@ foreach my $t (@files) {
 		$subject = quote_rfc2047($subject, $auto_8bit_encoding);
 	}
 
-	if (defined $author and $author ne $sender) {
+	if (defined $author and ($author ne $sender or $specify_author)) {
 		$message = "From: $author\n\n$message";
 		if (defined $author_encoding) {
 			if ($has_content_type) {
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 8c12c65..1dab17e 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -281,6 +281,18 @@ test_expect_success $PREREQ 'Author From: not in message body' '
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
1.7.9.6
