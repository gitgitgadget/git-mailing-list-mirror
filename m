From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC3.5.1 05/12] send-email: Improve readability and error-handling in send_message's sendmail code
Date: Sun, 19 Apr 2009 08:49:35 -0500
Message-ID: <1240148975-3082-1-git-send-email-mfwitten@gmail.com>
References: <7vskk5s15t.fsf@gitster.siamese.dyndns.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 19 15:52:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvXR9-0002KI-Eb
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 15:51:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757855AbZDSNuC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2009 09:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757034AbZDSNuA
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 09:50:00 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:61210 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754429AbZDSNuA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2009 09:50:00 -0400
Received: by yx-out-2324.google.com with SMTP id 3so536130yxj.1
        for <git@vger.kernel.org>; Sun, 19 Apr 2009 06:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=I+OWU4JH4tNi8j/PZxfvV6lfCY2TUeRKEI1HKCJUKi4=;
        b=m3flNuaMKw2zgw7kgEJ1Q1gLEHjKznWCSMrI7kXUkP2/logSeWUTimkO21AM8eJGhN
         zMOZu5zpZKY1nbIE/d89hTek2XY3uIKUFKTzsYjflPHvNnPsH4x8mh6BqB8P5UmT09J9
         Jau7xfcx1KTC9JvESzRMjwK+hAR6jJxKTtkAg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=T99DCRdXNY/NQKhPHRWXDN6Msln1zwkocQ9nW3qxcm2dggrZxcgnJzJx6auKwKQZU0
         uNqpOrTWwYQ3WSfN3kuF6A3yeMnKORGp7Ck5DHgAkGBTcaxnvmKXUSzcLpmSgJUUS/jB
         dZjTXdc8EGOnUDRTdqQa296b90Gy8hHeLRMs8=
Received: by 10.100.208.8 with SMTP id f8mr6268123ang.42.1240148998417;
        Sun, 19 Apr 2009 06:49:58 -0700 (PDT)
Received: from localhost.localdomain (97-116-111-23.mpls.qwest.net [97.116.111.23])
        by mx.google.com with ESMTPS id 5sm3926690ywd.20.2009.04.19.06.49.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Apr 2009 06:49:58 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.479.g2aec
In-Reply-To: <7vskk5s15t.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116894>

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 git-send-email.perl |   21 ++++++++++++++-------
 1 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 559e17b..3a140cd 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -967,15 +967,22 @@ X-Mailer: git-send-email $gitversion
 	}
 
 	if ($dry_run) {
+
 		# We don't want to send the email.
+
 	} elsif ($smtp_server_is_a_command) {
-		my $pid = open my $sm, '|-';
-		defined $pid or die $!;
-		if (!$pid) {
-			exec($smtp_server, @sendmail_parameters) or die $!;
-		}
-		print $sm "$header\n$message";
-		close $sm or die $?;
+
+		defined (my $pid = open my $pipe, '|-')
+			or die "Could not fork to run '$smtp_server': $!\n";
+
+		$pid or exec($smtp_server, @sendmail_parameters)
+			or die "Could not run '$smtp_server': $!\n";
+
+		local $SIG{PIPE} = 'IGNORE';
+
+		print $pipe "$header\n$message";
+		close $pipe or die "'$smtp_server' exited with status $?: $!\n";
+
 	} else {
 
 		if (!defined $smtp_server) {
-- 
1.6.2.2.479.g2aec
