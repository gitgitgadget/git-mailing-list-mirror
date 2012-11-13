From: Jeff King <peff@peff.net>
Subject: [PATCH 6/6] send-email: do not prompt for explicit repo ident
Date: Tue, 13 Nov 2012 11:53:27 -0500
Message-ID: <20121113165327.GF12626@sigill.intra.peff.net>
References: <20121113164845.GD20361@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 17:53:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYJkG-0007qu-HB
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 17:53:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144Ab2KMQxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 11:53:38 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47566 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755384Ab2KMQxc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 11:53:32 -0500
Received: (qmail 26598 invoked by uid 107); 13 Nov 2012 16:54:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Nov 2012 11:54:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Nov 2012 11:53:27 -0500
Content-Disposition: inline
In-Reply-To: <20121113164845.GD20361@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209638>

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

The test scripts need to be adjusted to not expect a prompt
for the sender, since they always have the author explicitly
defined in the environment. Unfortunately, we cannot
reliably test that prompting still happens in the implicit
case, as send-email will produce inconsistent results
depending on the machine config (if we cannot find a FQDN,
"git var" will barf, causing us to exit early; if we can,
send-email will continue but prompt).

Signed-off-by: Jeff King <peff@peff.net>
---
 git-send-email.perl   | 22 +++++++++++++---------
 t/t9001-send-email.sh |  5 ++---
 2 files changed, 15 insertions(+), 12 deletions(-)

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
index 6c6af7d..c5d66cf 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -191,14 +191,13 @@ test_expect_success $PREREQ 'Show all headers' '
 
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
-		grep "^From: Example <from@example.com>\$" msgtxt1 &&
+		grep "^From: A U Thor <author@example.com>\$" msgtxt1 &&
 		grep "^To: to@example.com\$" msgtxt1
 '
 
-- 
1.8.0.207.gdf2154c
