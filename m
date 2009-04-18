From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC3.5 07/12] send-email: Cleanup send_message 'log' code
Date: Sat, 18 Apr 2009 12:02:03 -0500
Message-ID: <1240074128-16132-8-git-send-email-mfwitten@gmail.com>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-2-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-3-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-4-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-5-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-6-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-7-git-send-email-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 18 19:07:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvE12-0007Ca-MI
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 19:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756930AbZDRRGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 13:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756129AbZDRRGH
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 13:06:07 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:33249 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754744AbZDRRGF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 13:06:05 -0400
Received: by qw-out-2122.google.com with SMTP id 5so485985qwd.37
        for <git@vger.kernel.org>; Sat, 18 Apr 2009 10:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=SqmtsLRVZzQexMG35r03MgKDW0xyMWitFoyZssy7Dkk=;
        b=W/X88FaziRe++mfAEnzbCnB4SvB4paIBwE5y4gSbhPBurY+fQXx/bZTE2jFHlil+7x
         l69XXSjluB859FuyrwvkCcQlZ+8czipraUU0eJsti/FrSM1xqNrxhTRHukADbZJcxEk5
         lE1rcMQkYattRonPc1Vr6ukl+4Brnj54DeJEM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hdrnNCwrc1hpXk9m1rnVCxatDOUVGF2Mg60mGk7vmzz9KPS2UHphtd2zM/QyQQAc6g
         gWKgm3RscIsEPcgTOVDxcDUTf86l6d1MwafNYhjvRXxEBq7PsPQb8ftQYiL4dKtiq7y1
         j0I3ol05+4/nK8xo86NX9cg8OjvPoRnDUZBLQ=
Received: by 10.220.90.140 with SMTP id i12mr4274858vcm.22.1240074363904;
        Sat, 18 Apr 2009 10:06:03 -0700 (PDT)
Received: from localhost.localdomain (97-116-125-103.mpls.qwest.net [97.116.125.103])
        by mx.google.com with ESMTPS id 6sm1776586ywn.52.2009.04.18.10.06.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 18 Apr 2009 10:06:03 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.479.g2aec
In-Reply-To: <1240074128-16132-7-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116850>

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 git-send-email.perl |   33 ++++++++++++++++-----------------
 1 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 6e2ea2c..f3e2ccd 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1054,24 +1054,23 @@ X-Mailer: git-send-email $gitversion
 
 		die "Failed to send '$subject': " . $smtp->message . "\n";
 	}
-	if ($quiet) {
-		printf (($dry_run ? "Dry-" : "")."Sent %s\n", $subject);
+
+	print "\n" unless $quiet;
+	print 'Dry-' if $dry_run;
+	print("Sent $subject\n"), return 1 if $quiet;
+	print "OK. Log says:\n";
+
+	if ($smtp_server_is_a_command) {
+		print "Sendmail: $smtp_server ".join(' ',@sendmail_parameters)."\n";
+		print "$header\n";
+		print "Result: OK\n";
 	} else {
-		print (($dry_run ? "Dry-" : "")."OK. Log says:\n");
-		unless ($smtp_server_is_a_command) {
-			print "Server: $smtp_server\n";
-			print "MAIL FROM:<$raw_from>\n";
-			print "RCPT TO:".join(',',(map { "<$_>" } @recipients))."\n";
-		} else {
-			print "Sendmail: $smtp_server ".join(' ',@sendmail_parameters)."\n";
-		}
-		print $header, "\n";
-		if ($smtp) {
-			print "Result: ", $smtp->code, ' ',
-				($smtp->message =~ /\n([^\n]+\n)$/s), "\n";
-		} else {
-			print "Result: OK\n";
-		}
+		print "Server: $smtp_server\n";
+		print "MAIL FROM:<$raw_from>\n";
+		print "RCPT TO:".join(',',(map { "<$_>" } @recipients))."\n";
+		print "$header\n";
+		print("Result: OK\n"), return 1 if $dry_run;
+		print "Result: ", $smtp->code, ' ', ($smtp->message =~ /\n([^\n]+\n)$/s), "\n";
 	}
 
 	return 1;
-- 
1.6.2.2.479.g2aec
