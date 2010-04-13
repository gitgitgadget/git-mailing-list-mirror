From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] git-send-email.perl: add maildomain_sanitize()
Date: Tue, 13 Apr 2010 14:35:26 +0300
Organization: Private
Message-ID: <87bpdnwpoh.fsf_-_@jondo.cante.net>
References: <1270789906-23735-1-git-send-email-brian@gernhardtsoftware.com>
	<1270789906-23735-2-git-send-email-brian@gernhardtsoftware.com>
	<7v1vep427o.fsf@alter.siamese.dyndns.org>
	<87ljcrwxni.fsf_-_@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 13 13:35:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1ePD-0006ac-SS
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 13:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389Ab0DMLfk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 07:35:40 -0400
Received: from lo.gmane.org ([80.91.229.12]:44681 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751361Ab0DMLfj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Apr 2010 07:35:39 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1O1eP1-0006VH-0Z
	for git@vger.kernel.org; Tue, 13 Apr 2010 13:35:35 +0200
Received: from a91-155-187-216.elisa-laajakaista.fi ([91.155.187.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Apr 2010 13:35:35 +0200
Received: from jari.aalto by a91-155-187-216.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Apr 2010 13:35:35 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-216.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:eqfPXaFpQHbQ7ySXcbsOe/vhtAo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144814>

Move duplicate maildomain checks to a single subroutine.
Require that a FQDN contains at least one period.

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 git-send-email.perl |   21 +++++++++++++++++----
 1 files changed, 17 insertions(+), 4 deletions(-)

      Here is improved version 2 (use "tab" for indentation).
 
      -- Jari
 
      >Re: [PATCH 1/3] send-email: Don't use FQDNs without a '.'
      >Junio C Hamano <gitster@pobox.com> writes:
      >> Brian Gernhardt <brian@gernhardtsoftware.com> writes:
      >
      >>  		$maildomain = $domain
      >> -			unless $^O eq 'darwin' && $domain =~ /\.local$/;
      >> +			unless $^O eq 'darwin' && $domain =~ /\.local$/
      >> +				or $domain !~ /\./;
      >
      > [Junio] It would become *much* easier to read if we stop using the statement
      > modifier, and write it in a more straightforward way:
      >
      > 	unless (($^O eq 'darwin' && $domain =~ /\.local$/)
      >         	|| $domain !~ /\./) {
      >                 $maildomain = $domain;
      > 	}
      >
      > as the condition seems to have grown large enough to exceed "by the way
      > don't do this under this narrow condition", which is what statement
      > modifiers are designed to be used.  Also mixing && and or that have
      > different precedence taxes readers' brainpower unnecessarily.
      >
      > I also think that this particular exception logic should probably be in a
      > separate helper function that is called from the two places.
      >
      > Jari, you are the last person who touched code around this area.  What do
      > you think?

diff --git a/git-send-email.perl b/git-send-email.perl
index ce569a9..0e8f18c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -863,14 +863,28 @@ sub sanitize_address
 # This maildomain*() code is based on ideas in Perl library Test::Reporter
 # /usr/share/perl5/Test/Reporter/Mail/Util.pm ==> sub _maildomain ()
 
+sub maildomain_sanitize
+{
+	local $_ = shift;
+
+	#  On Mac, the the domain name is not necessarily in FQDN format
+	#  Require a period in the string
+
+	if ( $^O eq 'darwin'  and  /\.local$/ ) {
+		# Nope, pass this one.
+	}
+	elsif ( /\./ ) {
+		$_;
+	}
+}
+
 sub maildomain_net
 {
 	my $maildomain;
 
 	if (eval { require Net::Domain; 1 }) {
 		my $domain = Net::Domain::domainname();
-		$maildomain = $domain
-			unless $^O eq 'darwin' && $domain =~ /\.local$/;
+		$maildomain = maildomain_sanitize($domain);
 	}
 
 	return $maildomain;
@@ -887,8 +901,7 @@ sub maildomain_mta
 				my $domain = $smtp->domain;
 				$smtp->quit;
 
-				$maildomain = $domain
-					unless $^O eq 'darwin' && $domain =~ /\.local$/;
+				$maildomain = maildomain_sanitize($domain);
 
 				last if $maildomain;
 			}
-- 
1.7.0
