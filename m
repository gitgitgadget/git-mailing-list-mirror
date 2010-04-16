From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH v2] git-send-email.perl: Add sub maildomain_sanitize
Date: Fri, 16 Apr 2010 18:49:23 +0300
Organization: Private
Message-ID: <87wrw7qtx8.fsf_-_@jondo.cante.net>
References: <1270789906-23735-1-git-send-email-brian@gernhardtsoftware.com>
	<1270789906-23735-2-git-send-email-brian@gernhardtsoftware.com>
	<7v1vep427o.fsf@alter.siamese.dyndns.org>
	<87ljcrwxni.fsf_-_@jondo.cante.net>
	<87bpdnwpoh.fsf_-_@jondo.cante.net>
	<m38w8og9w4.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 16 17:49:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2nnX-0003ay-5q
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 17:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758123Ab0DPPte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 11:49:34 -0400
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:58990 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757433Ab0DPPtd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 11:49:33 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id 009BE8C46E;
	Fri, 16 Apr 2010 18:49:31 +0300 (EEST)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A06037F2A35; Fri, 16 Apr 2010 18:49:30 +0300
Received: from jondo.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id CBB8F2BD4B;
	Fri, 16 Apr 2010 18:49:25 +0300 (EEST)
In-Reply-To: <m38w8og9w4.fsf@localhost.localdomain> (Jakub Narebski's message
	of "Thu, 15 Apr 2010 05:47:45 -0700 (PDT)")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145067>

Move duplicate maildomain checks to a single subroutine.
Require that a FQDN contains at least one period.

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 git-send-email.perl |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

    Jakub Narebski <jnareb@gmail.com> writes:
    >   +sub maildomain_sanitize {
    >   +	local $domain = shift;
    >   +
    >   +	#  On Mac, the the domain name is not necessarily in FQDN format
    >   +	#  Require a period in the string
    >   +
    >   +	if ($^O eq 'darwin'  &&  $domain =~ /\.local$/) {
    >   +		# Nope, pass this one.
    >   +	} elsif ($domain =~ /\./) {
    >   +		return $domain;
    >   +	}
    >   +}

    Thanks for 2nd eye. Changed these in above:

    * Starting brace placement at function start
    * Placement of else
    * Maybe: use or "return" (debatable).

    But not these. Motivation:

    * The "$_" simplifies ussage everywhere in the function. XP: less is more.
    * The "and" is more readable than "&&". The "and" is also safer
      due to its lower precedence.

    Jari

diff --git a/git-send-email.perl b/git-send-email.perl
index ce569a9..d52a8c3 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -863,14 +863,26 @@ sub sanitize_address
 # This maildomain*() code is based on ideas in Perl library Test::Reporter
 # /usr/share/perl5/Test/Reporter/Mail/Util.pm ==> sub _maildomain ()
 
+sub maildomain_sanitize {
+	local $_ = shift;
+
+	#  On Mac, the the domain name is not necessarily in FQDN format.
+	#  Require a period in the string.
+
+	if ( $^O eq 'darwin'  and  /\.local$/ ) {
+		# Nope, pass this one.
+	} elsif ( /\./ ) {
+		return $_;
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
@@ -887,8 +899,7 @@ sub maildomain_mta
 				my $domain = $smtp->domain;
 				$smtp->quit;
 
-				$maildomain = $domain
-					unless $^O eq 'darwin' && $domain =~ /\.local$/;
+				$maildomain = maildomain_sanitize($domain);
 
 				last if $maildomain;
 			}
-- 
1.7.0
