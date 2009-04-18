From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC3.5 02/12] send-email: No longer repeatedly test if $smtp_server is a command
Date: Sat, 18 Apr 2009 12:01:58 -0500
Message-ID: <1240074128-16132-3-git-send-email-mfwitten@gmail.com>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-2-git-send-email-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 18 19:05:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvDzF-0006Oc-TE
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 19:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754498AbZDRRDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 13:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753358AbZDRRDa
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 13:03:30 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:26077 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826AbZDRRD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 13:03:29 -0400
Received: by qw-out-2122.google.com with SMTP id 5so485416qwd.37
        for <git@vger.kernel.org>; Sat, 18 Apr 2009 10:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=dasLQp8WqDQ0/qNLbyUyHh9K2baGUNSJQQJnOm1/ScQ=;
        b=EWiK+yxZz/X/6ju4RL02qRa4DG3pg/LDd+Z4l+Ft2voUwNPBJuDlz3105fDwu+KTcO
         +VfYSvXqqLY1lSGaRqn6lM9TENsigjHwgEB1FS8GLJsAI7OJ2+8En6jlszoFRA3d9UHL
         yBSVtLDys9N+UQaAFwT9nN3L5gn84yqTwjR0s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=g8DjEOzBMXWVuvjoAc5ALk2MCW83Ar7P53+2vaQ4+aUaSDBzZgMecsmluAL068Y7ZW
         iHzHUgHzIPlSkb5OTjLT7CQOWtQym9hzYlgMcYH2BrCH9TFkT4a84asvH14ZW3F7uNSl
         F9bLp6o9qp4ba9s60How+dyK4KFLe6oCZuCEs=
Received: by 10.220.74.71 with SMTP id t7mr4226678vcj.97.1240074208612;
        Sat, 18 Apr 2009 10:03:28 -0700 (PDT)
Received: from localhost.localdomain (97-116-125-103.mpls.qwest.net [97.116.125.103])
        by mx.google.com with ESMTPS id 6sm1776586ywn.52.2009.04.18.10.03.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 18 Apr 2009 10:03:28 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.479.g2aec
In-Reply-To: <1240074128-16132-2-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116844>

This is a minor change, but it's cleaner, and it sets up the
$smtp_server initialization code for future improvements.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 git-send-email.perl |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index e43342e..1a20b2c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -186,7 +186,8 @@ sub do_edit {
 
 # Variables with corresponding config settings
 my ($thread, $chain_reply_to, $suppress_from, $signed_off_by_cc, $cc_cmd);
-my ($smtp_server, $smtp_server_port, $smtp_authuser, $smtp_encryption);
+my ($smtp_server, $smtp_server_is_a_command);
+my ($smtp_server_port, $smtp_authuser, $smtp_encryption);
 my ($identity, $aliasfiletype, @alias_files, @smtp_host_parts);
 my ($validate, $confirm);
 my (@suppress_cc);
@@ -674,14 +675,22 @@ if (defined $initial_reply_to) {
 	$initial_reply_to = "<$initial_reply_to>" if $initial_reply_to ne '';
 }
 
-if (!defined $smtp_server) {
+if (defined $smtp_server) {
+
+	$smtp_server_is_a_command = ($smtp_server =~ m{^/});
+
+} else { # use a default:
+
 	foreach (qw( /usr/sbin/sendmail /usr/lib/sendmail )) {
 		if (-x $_) {
 			$smtp_server = $_;
+			$smtp_server_is_a_command = 1;
 			last;
 		}
 	}
-	$smtp_server ||= 'localhost'; # could be 127.0.0.1, too... *shrug*
+
+	$smtp_server = 'localhost'; # 127.0.0.1 is not compatible with IPv6
+		unless $smtp_server_is_a_command;
 }
 
 if ($compose && $compose > 0) {
@@ -882,7 +891,7 @@ X-Mailer: git-send-email $gitversion
 
 	if ($dry_run) {
 		# We don't want to send the email.
-	} elsif ($smtp_server =~ m#^/#) {
+	} elsif ($smtp_server_is_a_command) {
 		my $pid = open my $sm, '|-';
 		defined $pid or die $!;
 		if (!$pid) {
@@ -958,7 +967,7 @@ X-Mailer: git-send-email $gitversion
 		printf (($dry_run ? "Dry-" : "")."Sent %s\n", $subject);
 	} else {
 		print (($dry_run ? "Dry-" : "")."OK. Log says:\n");
-		if ($smtp_server !~ m#^/#) {
+		unless ($smtp_server_is_a_command) {
 			print "Server: $smtp_server\n";
 			print "MAIL FROM:<$raw_from>\n";
 			print "RCPT TO:".join(',',(map { "<$_>" } @recipients))."\n";
-- 
1.6.2.2.479.g2aec
