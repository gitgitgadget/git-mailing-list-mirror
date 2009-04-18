From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC3.5 05/12] send-email: Improve redability and error-handling in send_message's sendmail code
Date: Sat, 18 Apr 2009 12:02:01 -0500
Message-ID: <1240074128-16132-6-git-send-email-mfwitten@gmail.com>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-2-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-3-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-4-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-5-git-send-email-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 18 19:06:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvDzz-0006pu-Ii
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 19:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756689AbZDRRFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 13:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756047AbZDRRFE
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 13:05:04 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:20171 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755826AbZDRRFD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 13:05:03 -0400
Received: by qw-out-2122.google.com with SMTP id 5so485786qwd.37
        for <git@vger.kernel.org>; Sat, 18 Apr 2009 10:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=J3SXk+G4dCee0jgZxE6plnRlEgLsBU14pkHWbrnEjAY=;
        b=ICRbXR1+7dwqmy6WqiF50ebKv79HNRvZR+8MqO1/TR0cSd3OIXRLg0jZ5Hcr2Qx4hV
         ASrimYvZQzmxXxKNY/286002utE40zNc46t/yW8Eiug5e2nWh44JhVC2fQR60Iitv7if
         faP0MqrRp1wL2QAn0hLGywV4lRJw4pbYr5bfo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nGkkcdU6TQfGI4iub92t+qa3/7TpFMU4SS0NXw6ZLAEt4pd0uEzqVdBv2KcSVax2jl
         NgG6qoqumgdDW57gWL9NmVmYl2772QojUg/AtCO5j/Sckos3CeEon1kUIojsERSYf5Nn
         gtCsELPswLmu7ILm+s6lnJdwaZEuIBHipdVkA=
Received: by 10.220.45.205 with SMTP id g13mr4222112vcf.64.1240074301924;
        Sat, 18 Apr 2009 10:05:01 -0700 (PDT)
Received: from localhost.localdomain (97-116-125-103.mpls.qwest.net [97.116.125.103])
        by mx.google.com with ESMTPS id 6sm1776586ywn.52.2009.04.18.10.05.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 18 Apr 2009 10:05:01 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.479.g2aec
In-Reply-To: <1240074128-16132-5-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116848>

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 git-send-email.perl |   21 ++++++++++++++-------
 1 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index e2c7954..2727c77 100755
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
+		(my $pid = open my $pipe, '|-')
+			// die "Could not fork to run '$smtp_server': $!\n";
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
