From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] send-email: improve SSL certificate verification
Date: Tue, 16 Jul 2013 00:15:06 +0000
Message-ID: <20130716001506.GG11097@vauxhall.crustytoothpaste.net>
References: <1373025947-26495-1-git-send-email-artagnon@gmail.com>
 <1373025947-26495-2-git-send-email-artagnon@gmail.com>
 <51D82970.5070108@web.de>
 <20130706143256.GX862789@vauxhall.crustytoothpaste.net>
 <51D83C7E.8000902@web.de>
 <CALkWK0kAfZLqyCO+e+0PH0-MmjMYX1nJmit5Qb5L3Qf6nyhC9Q@mail.gmail.com>
 <20130714170316.GE11097@vauxhall.crustytoothpaste.net>
 <51E3677D.6040903@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Jul 16 02:15:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UysvI-0008PH-2Y
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 02:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755367Ab3GPAPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 20:15:14 -0400
Received: from qmta01.emeryville.ca.mail.comcast.net ([76.96.30.16]:32926 "EHLO
	qmta01.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755247Ab3GPAPN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Jul 2013 20:15:13 -0400
Received: from omta13.emeryville.ca.mail.comcast.net ([76.96.30.52])
	by qmta01.emeryville.ca.mail.comcast.net with comcast
	id 0ntx1m00717UAYkA1oFCFe; Tue, 16 Jul 2013 00:15:12 +0000
Received: from castro.crustytoothpaste.net ([173.11.243.49])
	by omta13.emeryville.ca.mail.comcast.net with comcast
	id 0oFA1m00h14fh3h8ZoFByR; Tue, 16 Jul 2013 00:15:12 +0000
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 37F1D28074;
	Tue, 16 Jul 2013 00:15:10 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <51E3677D.6040903@web.de>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.10-rc7-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1373933712;
	bh=pcfXP0Dh9Qd1NK6Sr3ncEq9+zQ0DgxX/PI/DFPjLI6I=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=SOOOhlA37XL1e73dBeKUQt2sjJtOLTKD8v07GFuAt77yLiBChElw7bDq2i6qjkg9Z
	 EUxDnJk5AWr2s/adJtD+BpMLLwkVFZN2DNMul6FinJSAWkaOAumIAwTVG9C+XCMSzs
	 Fg7nJFw9+C5m0qIMH25uglh1KViZukydI5CR51I3KOZJkIgE31fMIRa3LzbIqJ8rtQ
	 w+x1+2hVG3MR+iXIzOt3hqDCKRgSgFFdpA6Zs1tUmmpjw86PBbG/AOVKKMIAyE0JOI
	 lDvW39p4QovkKXX4/cKGQqw/mqHSEnbBU+C9lM+t7fg6lYUVQDuyDRCZpGlgdt2dhd
	 scnPzcw+JMZYg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230533>

The SSL and TLS code for SMTP is non-trivial, so refactor it into a separate
function for ease of use.  Handle both files and directories as sources for CA
certificates.  Also add handling for older version of IO::Socket::SSL that do
not support the SSL_VERIFY_PEER and SSL_VERIFY_NONE constants; in this case,
print a warning and inform the user of this fact.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---

This is completely untested.  I used perl -c, but that's it.

 git-send-email.perl | 50 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 095b6fb..11fb2d0 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1083,6 +1083,37 @@ sub smtp_auth_maybe {
 	return $auth;
 }
 
+sub ssl_verify_params {
+	require IO::Socket::SSL;
+	eval {
+		IO::Socket::SSL->import(qw/SSL_VERIFY_PEER SSL_VERIFY_NONE/);
+	};
+	if ($@) {
+		print STDERR "Not using SSL_VERIFY_PEER due to out-of-date IO::Socket::SSL.\n";
+		return;
+	}
+
+	if (!defined $smtp_ssl_cert_path) {
+		$smtp_ssl_cert_path ||= "/etc/ssl/certs";
+	}
+
+	if (!$smtp_ssl_cert_path) {
+		return (SSL_verify_mode => SSL_VERIFY_NONE());
+	}
+	elsif (-d $smtp_ssl_cert_path) {
+		return (SSL_verify_mode => SSL_VERIFY_PEER(),
+			SSL_ca_path => $smtp_ssl_cert_path);
+	}
+	elsif (-f $smtp_ssl_cert_path) {
+		return (SSL_verify_mode => SSL_VERIFY_PEER(),
+			SSL_ca_file => $smtp_ssl_cert_path);
+	}
+	else {
+		print STDERR "Not using SSL_VERIFY_PEER because the CA path does not exist.\n";
+		return (SSL_verify_mode => SSL_VERIFY_NONE());
+	}
+}
+
 # Returns 1 if the message was sent, and 0 otherwise.
 # In actuality, the whole program dies when there
 # is an error sending a message.
@@ -1187,7 +1218,8 @@ X-Mailer: git-send-email $gitversion
 			$smtp_domain ||= maildomain();
 			$smtp ||= Net::SMTP::SSL->new($smtp_server,
 						      Hello => $smtp_domain,
-						      Port => $smtp_server_port);
+						      Port => $smtp_server_port,
+							  ssl_verify_params());
 		}
 		else {
 			require Net::SMTP;
@@ -1203,19 +1235,9 @@ X-Mailer: git-send-email $gitversion
 				$smtp->command('STARTTLS');
 				$smtp->response();
 				if ($smtp->code == 220) {
-					# Attempt to use a ca-certificate by default
-					$smtp_ssl_cert_path |= "/etc/ssl/certs";
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
+						or die "STARTTLS failed! ".$smtp->message;
 					$smtp_encryption = '';
 					# Send EHLO again to receive fresh
 					# supported commands
-- 
1.8.3.2.923.g2a18ff8.dirty


-- 
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187
