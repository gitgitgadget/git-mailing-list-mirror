From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] send-email: introduce sendemail.smtpsslcertpath
Date: Fri, 05 Jul 2013 10:20:11 -0700
Message-ID: <7vobag7wl0.fsf@alter.siamese.dyndns.org>
References: <1373025947-26495-1-git-send-email-artagnon@gmail.com>
	<1373025947-26495-3-git-send-email-artagnon@gmail.com>
	<20130705124536.GU862789@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Fri Jul 05 19:20:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uv9gD-0004aD-OL
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 19:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757401Ab3GERUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 13:20:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60965 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751579Ab3GERUO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 13:20:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 377602E630;
	Fri,  5 Jul 2013 17:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uNDEJx9+riumyDmzowtJhMmrEek=; b=EDw8kY
	+IGNhpKkSVW5ESs3zbNApGr2kfCoymXHiTYhFOrY7qEL7kfYqu5TmiLjjhuGPgef
	MZfantG+3fPQzBXzwuk6dYf0dFSJKOwx109wUUtlVIrXsUJoCUm8Oi0lvbzbfq7E
	lyNMJyW4VttLiuffFgLHzEPzCDX9FdW4f6l6M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AI2LhLs6pXiSnXXKZ8ok7sAXHAVa2eCV
	5UTgTBd/5h0pETl4KngZjWgxWLdlGYVGXF9PFH2XURPQXZA+rVHEtTbQaq1jAbtY
	mMIAI+4lSsg9fKSCcIbKJDswIf8mPTu91s0XUU2N0sAyE7meF06IMd8z0oqgCMgl
	LWMzGQ/K1n4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B7E42E62E;
	Fri,  5 Jul 2013 17:20:13 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8064E2E62C;
	Fri,  5 Jul 2013 17:20:12 +0000 (UTC)
In-Reply-To: <20130705124536.GU862789@vauxhall.crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 5 Jul 2013 12:45:37 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 269F881E-E597-11E2-B464-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229669>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> You've covered the STARTTLS case, but not the SSL one right above it.
> Someone using smtps on port 465 will still see the warning.  You can
> pass SSL_verify_mode to Net::SMTP::SSL->new just like you pass it to
> start_SSL.

OK, will a fix-up look like this on top of 1/2 and 2/2?

 git-send-email.perl | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 52028ba..3b80340 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1093,6 +1093,25 @@ sub smtp_auth_maybe {
 	return $auth;
 }
 
+# Helper to come up with SSL/TLS certification validation params
+# and warn when doing no verification
+sub ssl_verify_params {
+	use IO::Socket::SSL qw(SSL_VERIFY_PEER SSL_VERIFY_NONE);
+
+	if (!defined $smtp_ssl_cert_path) {
+		$smtp_ssl_cert_path = "/etc/ssl/certs";
+	}
+
+	if (-d $smtp_ssl_cert_path) {
+		return (SSL_verify_mode => SSL_VERIFY_PEER,
+			SSL_ca_path => $smtp_ssl_cert_path);
+	} else {
+		print STDERR "warning: Using SSL_VERIFY_NONE.  " .
+		    "See sendemail.smtpsslcertpath.\n";
+		return (SSL_verify_mode => SSL_VERIFY_NONE);
+	}
+}
+
 # Returns 1 if the message was sent, and 0 otherwise.
 # In actuality, the whole program dies when there
 # is an error sending a message.
@@ -1195,12 +1214,11 @@ sub send_message {
 		if ($smtp_encryption eq 'ssl') {
 			$smtp_server_port ||= 465; # ssmtp
 			require Net::SMTP::SSL;
-			use IO::Socket::SSL qw(SSL_VERIFY_NONE);
 			$smtp_domain ||= maildomain();
 			$smtp ||= Net::SMTP::SSL->new($smtp_server,
 						      Hello => $smtp_domain,
 						      Port => $smtp_server_port,
-						      SSL_verify_mode => SSL_VERIFY_NONE);
+						      ssl_verify_params());
 		}
 		else {
 			require Net::SMTP;
@@ -1210,23 +1228,12 @@ sub send_message {
 						 Debug => $debug_net_smtp);
 			if ($smtp_encryption eq 'tls' && $smtp) {
 				require Net::SMTP::SSL;
-				use IO::Socket::SSL qw(SSL_VERIFY_PEER SSL_VERIFY_NONE);
 				$smtp->command('STARTTLS');
 				$smtp->response();
 				if ($smtp->code == 220) {
-					# Attempt to use a ca-certificate by default
-					$smtp_ssl_cert_path ||= "/etc/ssl/certs";
-					if (-d $smtp_ssl_cert_path) {
-						$smtp = Net::SMTP::SSL->start_SSL($smtp,
-										  SSL_verify_mode => SSL_VERIFY_PEER,
-										  SSL_ca_path => $smtp_ssl_cert_path)
-							or die "STARTTLS failed! ".$smtp->message;
-					} else {
-						print STDERR "warning: Using SSL_VERIFY_NONE.  See sendemail.smtpsslcertpath.\n";
-						$smtp = Net::SMTP::SSL->start_SSL($smtp,
-										  SSL_verify_mode => SSL_VERIFY_NONE)
-							or die "STARTTLS failed! ".$smtp->message;
-					}
+					$smtp = Net::SMTP::SSL->start_SSL($smtp,
+									  ssl_verify_params())
+					    or die "STARTTLS failed! ".$smtp->message;
 					$smtp_encryption = '';
 					# Send EHLO again to receive fresh
 					# supported commands
