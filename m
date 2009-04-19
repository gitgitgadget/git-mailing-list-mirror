From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC3.5.1 08/12] send-email: Simplify --compose subject sanitation
Date: Sun, 19 Apr 2009 11:43:41 -0500
Message-ID: <1240159421-5643-1-git-send-email-mfwitten@gmail.com>
References: <b4087cc50904190753v6f5862c0sebe2dcc56c5269dc@mail.gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 19 18:45:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lva9D-0003Go-2g
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 18:45:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755865AbZDSQoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2009 12:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753874AbZDSQoE
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 12:44:04 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:21438 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbZDSQoC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2009 12:44:02 -0400
Received: by qw-out-2122.google.com with SMTP id 5so664678qwd.37
        for <git@vger.kernel.org>; Sun, 19 Apr 2009 09:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references:references;
        bh=xzUwoWRW9pYs2d1WBf4Pvtw71czmZUOt5lXOJ49vNRU=;
        b=i+bNzDgFDadyTTpp2pns2Wb08eTdIQUbjZl3jpDLL1dwbCArzX9eDGDKkir9aD3pFl
         Bm2oG928zbHs6ZvvuDclBzE1UHzxyTI7ECLEbBLGvNho0LSObQFfaXooL8zetwlTZ26f
         Dd4hCPJCVRiCySfmU87HgNflqS/cHul2QXAbk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=n0t9MiEdglQ8zGg9af9Mnt8D/S+z1SuorLlw36Uiprs/RqpV7ouUVkDNWDLkOySxkG
         FI6U+P1Pp8n4S7Z2dVirUUxeHLfEMvKGJgTkEHiVNxWkeM0mPq2nijInKZjsIgzQOsWW
         1VQY75AnPdWD4wjiox5fJ6eAEeYAlx8R3bRyc=
Received: by 10.220.74.71 with SMTP id t7mr4733929vcj.97.1240159441021;
        Sun, 19 Apr 2009 09:44:01 -0700 (PDT)
Received: from localhost.localdomain (97-116-111-23.mpls.qwest.net [97.116.111.23])
        by mx.google.com with ESMTPS id 9sm4294767ywf.6.2009.04.19.09.43.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Apr 2009 09:44:00 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.479.g2aec
In-Reply-To: <b4087cc50904190753v6f5862c0sebe2dcc56c5269dc@mail.gmail.com>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com> <1240074128-16132-5-git-send-email-mfwitten@gmail.com> <1240074128-16132-6-git-send-email-mfwitten@gmail.com> <1240074128-16132-7-git-send-email-mfwitten@gmail.com> <1240074128-16132-8-git-send-email-mfwitten@gmail.com> <1240074128-16132-9-git-send-email-mfwitten@gmail.com> <76718490904181854o380fe118y9f3a52c926bd1f6d@mail.gmail.com> <b4087cc50904181937q38ef45fm7409e020ecf40792@mail.gmail.com> <76718490904190713l3d6b5abcmf54544512de87413@mail.gmail.com> <b4087cc50904190739u54a9a9d7p6f011ab2b47c1d05@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116906>

We might as well use the global variables while they exist; there's
no reason to print the result to a file and then read it back in.

Also, the entire file is already read and checked for:

	/[^[:ascii:]]/

by:

	my $need_8bit_cte = file_has_nonascii($compose_filename);

so we might as well use $need_8bit_cte until something less egregiously
inefficient is implemented.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 git-send-email.perl |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 3894a93..1f815d7 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -675,13 +675,8 @@ EOT
 		} elsif (/^MIME-Version:/i) {
 			$need_8bit_cte = 0;
 		} elsif (/^Subject:\s*(.+)\s*$/i) {
-			$initial_subject = $1;
-			my $subject = $initial_subject;
-			$_ = "Subject: " .
-				($subject =~ /[^[:ascii:]]/ ?
-				 quote_rfc2047($subject) :
-				 $subject) .
-				"\n";
+			$initial_subject = $need_8bit_cte ? quote_rfc2047($1) : $1;
+			next;
 		} elsif (/^In-Reply-To:\s*(.+)\s*$/i) {
 			$initial_reply_to = $1;
 			next;
-- 
1.6.2.2.479.g2aec
