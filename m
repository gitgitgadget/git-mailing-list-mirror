From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH 1/3] send-email: Don't use FQDNs without a '.'
Date: Fri,  9 Apr 2010 01:11:44 -0400
Message-ID: <1270789906-23735-2-git-send-email-brian@gernhardtsoftware.com>
References: <1270789906-23735-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 09 07:12:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O06VZ-0003on-Ix
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 07:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753963Ab0DIFLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 01:11:54 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:57020 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753321Ab0DIFLu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 01:11:50 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 429551FFC061; Fri,  9 Apr 2010 05:11:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (cpe-74-67-185-155.rochester.res.rr.com [74.67.185.155])
	by silverinsanity.com (Postfix) with ESMTPA id 8087F1FFC057;
	Fri,  9 Apr 2010 05:11:36 +0000 (UTC)
X-Mailer: git-send-email 1.7.1.rc0.243.g2ce66
In-Reply-To: <1270789906-23735-1-git-send-email-brian@gernhardtsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144398>

Although Net::Domain::domainname attempts to be very thorough, the
host's configuration can still refuse to give a FQDN.  Check to see if
what we receive contains a dot as a basic sanity check.

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---

 My OS X machine doesn't add ".local" to it's hostname for some reason.
 Since a FQDN requires at least one . between the TLD and hostname,
 we can check for it to avoid nonsense results like "My-Computer".

 git-send-email.perl |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index ce569a9..85fe374 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -870,7 +870,8 @@ sub maildomain_net
 	if (eval { require Net::Domain; 1 }) {
 		my $domain = Net::Domain::domainname();
 		$maildomain = $domain
-			unless $^O eq 'darwin' && $domain =~ /\.local$/;
+			unless $^O eq 'darwin' && $domain =~ /\.local$/
+				or $domain !~ /\./;
 	}
 
 	return $maildomain;
@@ -888,7 +889,8 @@ sub maildomain_mta
 				$smtp->quit;
 
 				$maildomain = $domain
-					unless $^O eq 'darwin' && $domain =~ /\.local$/;
+					unless $^O eq 'darwin' && $domain =~ /\.local$/
+						or $domain !~ /\./;
 
 				last if $maildomain;
 			}
-- 
1.7.1.rc0.210.ge6da
