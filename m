From: Joe Perches <joe@perches.com>
Subject: [PATCH v2] git-send-email.perl: fold multiple entry "Cc:" and
 multiple single line "RCPT TO:"s
Date: Thu, 08 Oct 2009 10:03:26 -0700
Message-ID: <1255021406.2056.122.camel@Joe-Laptop.home>
References: <1254759898.1799.449.camel@Joe-Laptop.home>
	 <7vd44yo4uz.fsf@alter.siamese.dyndns.org>
	 <1254979690.2056.103.camel@Joe-Laptop.home>
	 <7vy6nlhmw7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 19:05:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvwQP-0002bc-QL
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 19:05:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758960AbZJHREF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 13:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758950AbZJHREF
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 13:04:05 -0400
Received: from mail.perches.com ([173.55.12.10]:2003 "EHLO mail.perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758951AbZJHREE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 13:04:04 -0400
Received: from [192.168.1.152] (new-host.home [192.168.1.152])
	by mail.perches.com (Postfix) with ESMTP id 6FFDF24368;
	Thu,  8 Oct 2009 10:03:17 -0700 (PDT)
In-Reply-To: <7vy6nlhmw7.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.28.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129702>

Some MTAs reject Cc: lines longer than 78 chars.
Avoid this by using the same join as "To:" ",\n\t"
so each subsequent Cc entry is on a new line.

RCPT TO: should have a single entry per line.
see: http://www.ietf.org/rfc/rfc2821.txt

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/git-send-email.perl b/git-send-email.perl
index dd821f7..ce81425 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -835,7 +835,7 @@ sub send_message
 	    $gitversion = Git::version();
 	}
 
-	my $cc = join(", ", unique_email_list(@cc));
+	my $cc = join(",\n\t", unique_email_list(@cc));
 	my $ccline = "";
 	if ($cc ne '') {
 		$ccline = "\nCc: $cc";
@@ -976,7 +976,9 @@ X-Mailer: git-send-email $gitversion
 		if ($smtp_server !~ m#^/#) {
 			print "Server: $smtp_server\n";
 			print "MAIL FROM:<$raw_from>\n";
-			print "RCPT TO:".join(',',(map { "<$_>" } @recipients))."\n";
+			foreach my $entry (@recipients) {
+			    print "RCPT TO:<$entry>\n";
+			}
 		} else {
 			print "Sendmail: $smtp_server ".join(' ',@sendmail_parameters)."\n";
 		}
