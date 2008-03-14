From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH 4/4] send-email: Don't require to be called in a repository
Date: Fri, 14 Mar 2008 18:29:30 +0100
Message-ID: <1205515770-3424-5-git-send-email-frank@lichtenheld.de>
References: <1205515770-3424-1-git-send-email-frank@lichtenheld.de>
 <1205515770-3424-2-git-send-email-frank@lichtenheld.de>
 <1205515770-3424-3-git-send-email-frank@lichtenheld.de>
 <1205515770-3424-4-git-send-email-frank@lichtenheld.de>
Cc: Git Mailing List <git@vger.kernel.org>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 14 18:30:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaDjV-00033R-Af
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 18:30:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753747AbYCNR3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 13:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754067AbYCNR3j
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 13:29:39 -0400
Received: from aiolos.lenk.info ([85.214.124.154]:55114 "EHLO aiolos.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753747AbYCNR3e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 13:29:34 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1JaDiu-0003YR-94; Fri, 14 Mar 2008 18:29:40 +0100
Received: from host-82-135-33-74.customer.m-online.net ([82.135.33.74] helo=dirac.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1JaDii-000847-Sq; Fri, 14 Mar 2008 18:29:28 +0100
Received: from djpig by dirac.djpig.de with local (Exim 4.69)
	(envelope-from <frank@lichtenheld.de>)
	id 1JaDil-00013L-9f; Fri, 14 Mar 2008 18:29:31 +0100
X-Mailer: git-send-email 1.5.4.4.555.g697b7.dirty
In-Reply-To: <1205515770-3424-4-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77260>

We might not have some configuration variables available, but if the
user doesn't care about that, neither should we. Still use the
repository if it is available, though.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 git-send-email.perl |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index be4a20d..9e568bf 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -168,7 +168,8 @@ my $envelope_sender;
 # Example reply to:
 #$initial_reply_to = ''; #<20050203173208.GA23964@foobar.com>';
 
-my $repo = Git->repository();
+my $repo = eval { Git->repository() };
+my @repo = $repo ? ($repo) : ();
 my $term = eval {
 	$ENV{"GIT_SEND_EMAIL_NOTTY"}
 		? new Term::ReadLine 'git-send-email', \*STDIN, \*STDOUT
@@ -271,25 +272,25 @@ sub read_config {
 
 	foreach my $setting (keys %config_bool_settings) {
 		my $target = $config_bool_settings{$setting}->[0];
-		$$target = $repo->config_bool("$prefix.$setting") unless (defined $$target);
+		$$target = Git::config_bool(@repo, "$prefix.$setting") unless (defined $$target);
 	}
 
 	foreach my $setting (keys %config_settings) {
 		my $target = $config_settings{$setting};
 		if (ref($target) eq "ARRAY") {
 			unless (@$target) {
-				my @values = $repo->config("$prefix.$setting");
+				my @values = Git::config(@repo, "$prefix.$setting");
 				@$target = @values if (@values && defined $values[0]);
 			}
 		}
 		else {
-			$$target = $repo->config("$prefix.$setting") unless (defined $$target);
+			$$target = Git::config(@repo, "$prefix.$setting") unless (defined $$target);
 		}
 	}
 }
 
 # read configuration from [sendemail "$identity"], fall back on [sendemail]
-$identity = $repo->config("sendemail.identity") unless (defined $identity);
+$identity = Git::config(@repo, "sendemail.identity") unless (defined $identity);
 read_config("sendemail.$identity") if (defined $identity);
 read_config("sendemail");
 
@@ -327,8 +328,9 @@ if (0) {
 	}
 }
 
-my ($repoauthor) = $repo->ident_person('author');
-my ($repocommitter) = $repo->ident_person('committer');
+my ($repoauthor, $repocommitter);
+($repoauthor) = Git::ident_person(@repo, 'author');
+($repocommitter) = Git::ident_person(@repo, 'committer');
 
 # Verify the user input
 
@@ -415,7 +417,7 @@ if (@files) {
 
 my $prompting = 0;
 if (!defined $sender) {
-	$sender = $repoauthor || $repocommitter;
+	$sender = $repoauthor || $repocommitter || '';
 
 	while (1) {
 		$_ = $term->readline("Who should the emails appear to be from? [$sender] ");
@@ -509,7 +511,7 @@ GIT: for the patch you are writing.
 EOT
 	close(C);
 
-	my $editor = $ENV{GIT_EDITOR} || $repo->config("core.editor") || $ENV{VISUAL} || $ENV{EDITOR} || "vi";
+	my $editor = $ENV{GIT_EDITOR} || Git::config(@repo, "core.editor") || $ENV{VISUAL} || $ENV{EDITOR} || "vi";
 	system('sh', '-c', '$0 $@', $editor, $compose_filename);
 
 	open(C2,">",$compose_filename . ".final")
-- 
1.5.4.4
