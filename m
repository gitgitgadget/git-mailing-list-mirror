From: Jeff King <peff@peff.net>
Subject: [PATCHv2 8/8] send-email: do not prompt for explicit repo ident
Date: Wed, 14 Nov 2012 16:36:40 -0800
Message-ID: <20121115003640.GH17819@sigill.intra.peff.net>
References: <20121115003029.GA17550@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 15 01:36:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYnRy-0004vX-6v
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 01:36:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933261Ab2KOAgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 19:36:44 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48859 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933222Ab2KOAgn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 19:36:43 -0500
Received: (qmail 9373 invoked by uid 107); 15 Nov 2012 00:37:32 -0000
Received: from 204-16-157-26-static.ipnetworksinc.net (HELO sigill.intra.peff.net) (204.16.157.26)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Nov 2012 19:37:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Nov 2012 16:36:40 -0800
Content-Disposition: inline
In-Reply-To: <20121115003029.GA17550@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209774>

If git-send-email is configured with sendemail.from, we will
not prompt the user for the "From" address of the emails.
If it is not configured, we prompt the user, but provide the
repo author or committer as a default.  Even though we
probably have a sensible value for the default, the prompt
is a safety check in case git generated an incorrect
implicit ident string.

Now that Git.pm will tell us whether the ident is implicit or
explicit, we can stop prompting in the explicit case, saving
most users from having to see the prompt at all.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-send-email.perl   | 22 +++++++++++++---------
 t/t9001-send-email.sh | 36 ++++++++++++++++++++++++++++++++++--
 2 files changed, 47 insertions(+), 11 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 5a7c29d..0c49b32 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -436,9 +436,8 @@ if (0) {
 	}
 }
 
-my ($repoauthor, $repocommitter);
-($repoauthor) = Git::ident_person(@repo, 'author');
-($repocommitter) = Git::ident_person(@repo, 'committer');
+my ($repoauthor, $author_explicit) = Git::ident_person(@repo, 'author');
+my ($repocommitter, $committer_explicit) = Git::ident_person(@repo, 'committer');
 
 # Verify the user input
 
@@ -755,12 +754,17 @@ if (!$force) {
 
 my $prompting = 0;
 if (!defined $sender) {
-	$sender = $repoauthor || $repocommitter || '';
-	$sender = ask("Who should the emails appear to be from? [$sender] ",
-	              default => $sender,
-		      valid_re => qr/\@.*\./, confirm_only => 1);
-	print "Emails will be sent from: ", $sender, "\n";
-	$prompting++;
+	($sender, my $explicit) =
+		defined $repoauthor ? ($repoauthor, $author_explicit) :
+		defined $repocommitter ? ($repocommitter, $committer_explicit) :
+		('', 0);
+	if (!$explicit) {
+		$sender = ask("Who should the emails appear to be from? [$sender] ",
+			      default => $sender,
+			      valid_re => qr/\@.*\./, confirm_only => 1);
+		print "Emails will be sent from: ", $sender, "\n";
+		$prompting++;
+	}
 }
 
 if (!@initial_to && !defined $to_cmd) {
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 6c6af7d..0fe0b8e 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -191,15 +191,47 @@ test_expect_success $PREREQ 'Show all headers' '
 
 test_expect_success $PREREQ 'Prompting works' '
 	clean_fake_sendmail &&
-	(echo "Example <from@example.com>"
-	 echo "to@example.com"
+	(echo "to@example.com"
 	 echo ""
 	) | GIT_SEND_EMAIL_NOTTY=1 git send-email \
 		--smtp-server="$(pwd)/fake.sendmail" \
 		$patches \
 		2>errors &&
+		grep "^From: A U Thor <author@example.com>\$" msgtxt1 &&
+		grep "^To: to@example.com\$" msgtxt1
+'
+
+test_expect_success $PREREQ,AUTOIDENT 'implicit ident prompts for sender' '
+	clean_fake_sendmail &&
+	(echo "Example <from@example.com>" &&
+	 echo "to@example.com" &&
+	 echo ""
+	) |
+	(sane_unset GIT_AUTHOR_NAME &&
+	 sane_unset GIT_AUTHOR_EMAIL &&
+	 sane_unset GIT_COMMITTER_NAME &&
+	 sane_unset GIT_COMMITTER_EMAIL &&
+	 GIT_SEND_EMAIL_NOTTY=1 git send-email \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		$patches \
+		2>errors &&
 		grep "^From: Example <from@example.com>\$" msgtxt1 &&
 		grep "^To: to@example.com\$" msgtxt1
+	)
+'
+
+test_expect_success $PREREQ,!AUTOIDENT 'broken implicit ident aborts send-email' '
+	clean_fake_sendmail &&
+	(sane_unset GIT_AUTHOR_NAME &&
+	 sane_unset GIT_AUTHOR_EMAIL &&
+	 sane_unset GIT_COMMITTER_NAME &&
+	 sane_unset GIT_COMMITTER_EMAIL &&
+	 GIT_SEND_EMAIL_NOTTY=1 && export GIT_SEND_EMAIL_NOTTY &&
+	 test_must_fail git send-email \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		$patches </dev/null 2>errors.out &&
+		test_i18ngrep "tell me who you are" errors.out
+	)
 '
 
 test_expect_success $PREREQ 'tocmd works' '
-- 
1.8.0.207.gdf2154c
