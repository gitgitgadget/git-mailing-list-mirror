From: Lars Wendler <polynomial-c@gentoo.org>
Subject: [PATCH] git-send-email.perl: Fixed sending of many/huge changes/patches
Date: Wed, 30 Sep 2015 09:26:09 +0200
Message-ID: <1443597969-3962-1-git-send-email-polynomial-c@gentoo.org>
Cc: juston.h.li@gmail.com, Stefan Agner <stefan@agner.ch>,
	Lars Wendler <polynomial-c@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 30 09:26:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhBmV-0004WI-V8
	for gcvg-git-2@plane.gmane.org; Wed, 30 Sep 2015 09:26:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754560AbbI3H0X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2015 03:26:23 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:34780 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754279AbbI3H0V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2015 03:26:21 -0400
Received: from shanghai.paradoxon.rec (p4FDA99AE.dip0.t-ipconnect.de [79.218.153.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: polynomial-c@gentoo.org)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 6EAC2340EF5;
	Wed, 30 Sep 2015 07:26:19 +0000 (UTC)
X-Mailer: git-send-email 2.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278840>

From: Stefan Agner <stefan@agner.ch>

Sometimes sending huge patches/commits fail with

[Net::SMTP::SSL] Connection closed at /usr/lib/git-core/git-send-email
line 1320.

Running the command with --smtp-debug=1 yields to

Net::SMTP::SSL: Net::Cmd::datasend(): unexpected EOF on command channel:
at /usr/lib/git-core/git-send-email line 1320.
[Net::SMTP::SSL] Connection closed at /usr/lib/git-core/git-send-email
line 1320.

Stefan described it in his mail like this:

It seems to me that there is a size limit, after cutting down the patch
to ~16K, sending started to work. I cut it twice, once by removing lines
from the head and once from the bottom, in both cases at the size of
around 16K I could send the patch.

See also original report:
http://permalink.gmane.org/gmane.comp.version-control.git/274569

Reported-by: Juston Li <juston.h.li@gmail.com>
Tested-by: Markos Chandras <hwoarang@gentoo.org>
Signed-off-by: Lars Wendler <polynomial-c@gentoo.org>
---
 git-send-email.perl | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index e3ff44b..e907e0ea 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1365,7 +1365,11 @@ Message-Id: $message_id
 		$smtp->mail( $raw_from ) or die $smtp->message;
 		$smtp->to( @recipients ) or die $smtp->message;
 		$smtp->data or die $smtp->message;
-		$smtp->datasend("$header\n$message") or die $smtp->message;
+		$smtp->datasend("$header\n") or die $smtp->message;
+		my @lines = split /^/, $message;
+		foreach my $line (@lines) {
+			$smtp->datasend("$line") or die $smtp->message;
+		}
 		$smtp->dataend() or die $smtp->message;
 		$smtp->code =~ /250|200/ or die "Failed to send $subject\n".$smtp->message;
 	}
-- 
2.6.0
