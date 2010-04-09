From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH v2 1/3] send-email: Don't use FQDNs without a '.'
Date: Fri,  9 Apr 2010 11:42:26 -0400
Message-ID: <1270827746-29229-1-git-send-email-brian@gernhardtsoftware.com>
References: <1270827245-28958-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 09 17:42:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0GLp-0004Qf-Pj
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 17:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754503Ab0DIPm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 11:42:29 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:35127 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753839Ab0DIPm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 11:42:28 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 2DB841FFC058; Fri,  9 Apr 2010 15:42:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from Hermes.local.net (unknown [64.134.102.129])
	by silverinsanity.com (Postfix) with ESMTPA id 7DBA11FFC056;
	Fri,  9 Apr 2010 15:42:23 +0000 (UTC)
X-Mailer: git-send-email 1.7.1.rc0.243.g2ce66
In-Reply-To: <1270827245-28958-1-git-send-email-brian@gernhardtsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144446>

Although Net::Domain::domainname attempts to be very thorough, the
host's configuration can still refuse to give a FQDN.  Check to see if
what we receive contains a dot as a basic sanity check.

Since the same condition is used twice and getting complex, let's move
it to a new function.

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---
 git-send-email.perl |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index ce569a9..f491d44 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -863,14 +863,19 @@ sub sanitize_address
 # This maildomain*() code is based on ideas in Perl library Test::Reporter
 # /usr/share/perl5/Test/Reporter/Mail/Util.pm ==> sub _maildomain ()
 
+sub valid_fqdn
+{
+	my $domain = $_[0];
+	return !($^O eq 'darwin' && $domain =~ /\.local$/) && $domain =~ /\./;
+}
+
 sub maildomain_net
 {
 	my $maildomain;
 
 	if (eval { require Net::Domain; 1 }) {
 		my $domain = Net::Domain::domainname();
-		$maildomain = $domain
-			unless $^O eq 'darwin' && $domain =~ /\.local$/;
+		$maildomain = $domain if valid_fqdn( $domain );
 	}
 
 	return $maildomain;
@@ -887,8 +892,7 @@ sub maildomain_mta
 				my $domain = $smtp->domain;
 				$smtp->quit;
 
-				$maildomain = $domain
-					unless $^O eq 'darwin' && $domain =~ /\.local$/;
+				$maildomain = $domain if valid_fqdn( $domain );
 
 				last if $maildomain;
 			}
-- 
1.7.1.rc0.243.g2ce66
