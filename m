From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH v3 2/4] send-email: Don't use FQDNs without a '.'
Date: Sat, 10 Apr 2010 10:53:54 -0400
Message-ID: <1270911236-32476-3-git-send-email-brian@gernhardtsoftware.com>
References: <1270911236-32476-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 10 16:54:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0c4c-0006Uv-9h
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 16:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897Ab0DJOyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 10:54:08 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:52326 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751777Ab0DJOyG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 10:54:06 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 64EAE1FFC083; Sat, 10 Apr 2010 14:54:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from Hermes.local.net (unknown [64.134.103.20])
	by silverinsanity.com (Postfix) with ESMTPA id 1F42C1FFC058;
	Sat, 10 Apr 2010 14:53:59 +0000 (UTC)
X-Mailer: git-send-email 1.7.1.rc0.251.g42f41
In-Reply-To: <1270911236-32476-1-git-send-email-brian@gernhardtsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144552>

Although Net::Domain::domainname attempts to be very thorough, the
host's configuration can still refuse to give a FQDN.  Check to see if
what we receive contains a dot as a basic sanity check.

Since the same condition is used twice and getting complex, let's move
it to a new function.

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---
 git-send-email.perl |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 26fe624..1e9bec1 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -861,13 +861,17 @@ sub sanitize_address {
 # This maildomain*() code is based on ideas in Perl library Test::Reporter
 # /usr/share/perl5/Test/Reporter/Mail/Util.pm ==> sub _maildomain ()
 
+sub valid_fqdn {
+	my $domain = shift;
+	return !($^O eq 'darwin' && $domain =~ /\.local$/) && $domain =~ /\./;
+}
+
 sub maildomain_net {
 	my $maildomain;
 
 	if (eval { require Net::Domain; 1 }) {
 		my $domain = Net::Domain::domainname();
-		$maildomain = $domain
-			unless $^O eq 'darwin' && $domain =~ /\.local$/;
+		$maildomain = $domain if valid_fqdn($domain);
 	}
 
 	return $maildomain;
@@ -883,8 +887,7 @@ sub maildomain_mta {
 				my $domain = $smtp->domain;
 				$smtp->quit;
 
-				$maildomain = $domain
-					unless $^O eq 'darwin' && $domain =~ /\.local$/;
+				$maildomain = $domain if valid_fqdn($domain);
 
 				last if $maildomain;
 			}
-- 
1.7.1.rc0.251.g42f41
