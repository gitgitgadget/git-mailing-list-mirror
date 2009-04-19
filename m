From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC3.5.1 04/12] send-email: Verification for --smtp-server and --smpt-server-port
Date: Sun, 19 Apr 2009 09:19:45 -0500
Message-ID: <1240150785-3999-1-git-send-email-mfwitten@gmail.com>
References: <1240074128-16132-5-git-send-email-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 19 16:22:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvXty-0002AY-Nh
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 16:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760569AbZDSOUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2009 10:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760353AbZDSOUI
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 10:20:08 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:62406 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758111AbZDSOUG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2009 10:20:06 -0400
Received: by yx-out-2324.google.com with SMTP id 3so540223yxj.1
        for <git@vger.kernel.org>; Sun, 19 Apr 2009 07:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=xbXpLZOPETSrGj04RNraKF/datsGPW3IC9Z/H7VgH/s=;
        b=TWpimF31X7P2P23Vwgc4EMXJXE82Nur7vGri7kruiePM1xS3hSOxKF8Z+1cYSs2Qdv
         7bhWxK42Ts88bFh64UxrPH1cHbM9lJCd5XW93VTN6xTmrhLgy+hV1yFmYjS6hRO5S9tT
         mfeIgmT3pjS+T3l2HFYGmfv6H8zz0sgbSY+nU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=b5jUYQ4usCJQnkYOYOMv5VUd+zFkRIBr63ZqiG+aXa7pWVKu5vP4iH3hQnPV3TjvWY
         JE6CpxXM2iTxaZvKv78Es0IxK1l9SsZSC16wrToVJY3SAx6Sp2+ttnSji4QgEtFk48d+
         lcVt6RH/67Mm9IhYow/MzB9v3F7Slo9yH7h6U=
Received: by 10.100.47.10 with SMTP id u10mr5935322anu.122.1240150804968;
        Sun, 19 Apr 2009 07:20:04 -0700 (PDT)
Received: from localhost.localdomain (97-116-111-23.mpls.qwest.net [97.116.111.23])
        by mx.google.com with ESMTPS id 9sm3794247yws.25.2009.04.19.07.20.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Apr 2009 07:20:04 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.479.g2aec
In-Reply-To: <1240074128-16132-5-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116900>

The server URI is verified according to RFCs (including IPv6 support).

The $smtp_server and $smtp_server_port setup code has been moved
higher in the file, so that send-email fails fast if they are bad.

Now, the 'host:port' server URI form is handled regardless of the
documentation deficiencies of Net::SMTP{,::SSL}.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---

		NOTE: This changed due to the change in:
		[PATCH RFC3.5.1 03/12] send-email: Interpret...
		Basically, only "a built-in" was changed to
		"the built-in".

		Is it ever useful to submit patches for patches
		rather than sending the whole patch gain? Or would
		that be even more trouble?

 Documentation/git-send-email.txt |   50 ++++++++++++-----
 git-send-email.perl              |  115 +++++++++++++++++++++++++++++++------
 2 files changed, 131 insertions(+), 34 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 0937dd0..f306e88 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -125,23 +125,43 @@ specified (with '--smtp-pass' or 'sendemail.smtppass'), then the
 user is prompted for a password while the input is masked for privacy.
 
 --smtp-server=<server>::
-	If set, specifies the outgoing SMTP server to use (e.g.
-	`smtp.example.com` or a raw IP address).  Alternatively it can
-	specify a full pathname of a sendmail-like program instead;
-	the program must support the `-i` option.  Default value can
-	be specified by the 'sendemail.smtpserver' configuration
-	variable; the built-in default is `/usr/sbin/sendmail` or
-	`/usr/lib/sendmail` if such a program is available, or
-	`localhost` otherwise. Also, the built-in default is used if
-	`<host>` or 'sendemail.smtpserver' is the empty string (for
-	example, if '--smtp-server ""' is specified on the command line).
+	Specifies the outgoing SMTP server to use. The server may be
+	given as a domain name (e.g. `smtp.example.com:587`), raw IP
+	address (e.g. `192.168.0.1`), or absolute path to a command
+	(e.g. `/usr/sbin/sendmail`).
++
+Usually a server is specified with its URI form:
++
+	host[:port]
++
+The optional port, which identifies a particular service at the
+given host, is normally provided as a non-negative integer that
+is representable in 16-bits; however, it is possible to use any
+string composed of some combination of alphanumeric characters, the
+underscore, the hyphen, and punctuation (special) characters, so
+that symbolic service names can be employed (as defined by, say,
+`/etc/services` on Unix systems).
++
+Alternatively the server can be specified as an absolute path to
+a sendmail-like program; in particular, the program must support
+`sendmail's` `-i` option.
++
+Default value can be specified by the 'sendemail.smtpserver'
+configuration variable; the built-in default is `/usr/sbin/sendmail`
+or `/usr/lib/sendmail` if such a program is available, or `localhost`
+otherwise. Also, the built-in default is used if `<server>` or
+'sendemail.smtpserver' is the empty string (for example, if
+'--smtp-server ""' is specified on the command line).
 
 --smtp-server-port=<port>::
-	Specifies a port different from the default port (SMTP
-	servers typically listen to smtp port 25 and ssmtp port
-	465); symbolic service names (e.g. "submission" instead of 587)
-	are also accepted. The port can also be set with the
-	'sendemail.smtpserverport' configuration variable.
+	Specifies a port different from the default port (SMTP servers
+	typically listen to port 25, 587, or even non-standard 465); symbolic
+	service names (e.g. "submission" instead of 587) are also accepted,
+	provided the underlying system handles mappings in something like
+	`/etc/services`; such service names may only be composed of some
+	combination of alphanumeric characters, the underscore, the hyphen,
+	and punctuation (special) characters. The port can also be set with
+	the 'sendemail.smtpserverport' configuration variable.
 
 --smtp-ssl::
 	Legacy alias for '--smtp-encryption ssl'.
diff --git a/git-send-email.perl b/git-send-email.perl
index be6d171..559e17b 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -61,7 +61,7 @@ git send-email [options] <file | directory | rev-list options >
 
   Sending:
     --envelope-sender   <address>  * Email envelope sender.
-    --smtp-server        <server>  * Outgoing SMTP server. <host | command>
+    --smtp-server        <server>  * Outgoing SMTP server: <host[:port] | cmd>.
     --smtp-server-port     <port>  * Outgoing SMTP server port; symbolic too.
     --smtp-user        <username>  * Username for SMTP-AUTH.
     --smtp-pass       [<password>] * Password for SMTP-AUTH; not necessary.
@@ -328,6 +328,101 @@ foreach my $setting (values %config_bool_settings) {
 # 'default' encryption is none -- this only prevents a warning
 $smtp_encryption = '' unless (defined $smtp_encryption);
 
+# Define a function that verifies a server URI and returns
+# its host and port parts:
+
+sub parse_server_URI($) {
+
+	# These regular experssions were derived from:
+	#   * RFC 2373 (Appendix B) : IP Version 6 Addressing Architecture
+	#   * RFC 2732 (Section  3) : Format for Literal IPv6 Addresses in URL's
+	#   * RFC 2396 (Sec. 3.2.2) : Uniform Resource Identifiers (URI): Generic Syntax
+	# Also, ports are allowed to be symbolic, so that /etc/services mappings
+	# can be used.
+
+	# Define a port (RFC 2396 and extension):
+
+	my $port = qr/[\w[:punct:]]+/;
+
+	# Define an IPv4 address (RFC 2373):
+
+	my $dig3        = qr/\d{1,3}/;
+	my $IPv4address = qr/$dig3(?:\.$dig3){3}/;
+
+	# Define an IPv6 address (RFC 2373):
+
+	my $hex4        = qr/[[:xdigit:]]{1,4}/;
+	my $hexseq      = qr/$hex4(?::$hex4)*/;  		# RFC 2373 is really that loose.
+	my $hexpart     = qr/$hexseq|$hexseq?::$hexseq?/;
+	my $IPv6address = qr/$hexpart(?::$IPv4address)?/;
+
+	# Define an IPv6 literal (RFC 2732):
+
+	my $IPv6reference = qr/\[$IPv6address\]/;
+
+	# Define a server URI (RFC 2396 and RFC 2732):
+
+	my $toplabel    = qr/[[:alpha:]](?:(?:[[:alnum:]]|-)*[[:alpha:]])?/;
+	my $domainlabel = qr/[[:alnum:]](?:(?:[[:alnum:]]|-)*[[:alnum:]])?/;
+	my $hostname    = qr/(?:$domainlabel\.)*$toplabel\.?/;
+	my $host        = qr/$hostname|$IPv4address|$IPv6reference/;
+	my $hostport    = qr/^($host)(?::($port))?$/;
+
+	# Phew! Now parse
+
+	return shift =~ $hostport;
+}
+
+# Figure out how to contact the SMTP server.
+# After this code, $smtp_server_port is either
+# valid or undef:
+
+if (defined $smtp_server && $smtp_server ne '') {
+
+	if ($smtp_server_is_a_command = ($smtp_server =~ m{^/})) {
+
+		die "--smtp-server: The SMTP server command does not exist: $smtp_server\n"
+			unless -x $smtp_server;
+
+		print STDERR "--smtp-server: Using command '$smtp_server'; ignoring --smtp-server-port='$smtp_server_port'\n"
+			if defined $smtp_server_port;
+
+	} else {
+
+		($smtp_server, my $port) = parse_server_URI $smtp_server
+			or die "--smtp-server: Not a valid server URI: '$smtp_server'\n";
+
+		if (defined $smtp_server_port) {
+
+			$smtp_server_port =~ /[\w[:punct:]]+/ or die "--smtp-server-port: Invalid port: '$smtp_server_port'\n";
+
+			print STDERR "--smtp-server-port: Using port '$smtp_server_port'; ignoring --smtp-server's port '$port'\n"
+				if defined $port;
+
+		} else {
+
+			$smtp_server_port = $port;
+		}
+	}
+
+} else { # use a default:
+
+	foreach (qw( /usr/sbin/sendmail /usr/lib/sendmail )) {
+		if (-x $_) {
+			$smtp_server = $_;
+			$smtp_server_is_a_command = 1;
+
+			print STDERR "--smtp-server: Using command '$smtp_server'; ignoring --smtp-server-port='$smtp_server_port'\n"
+				if defined $smtp_server_port;
+
+			last;
+		}
+	}
+
+	$smtp_server = 'localhost' # 127.0.0.1 is not compatible with IPv6
+		unless $smtp_server_is_a_command;
+}
+
 # Set CC suppressions
 my(%suppress_cc);
 if (@suppress_cc) {
@@ -675,24 +770,6 @@ if (defined $initial_reply_to) {
 	$initial_reply_to = "<$initial_reply_to>" if $initial_reply_to ne '';
 }
 
-if (defined $smtp_server && $smtp_server ne '') {
-
-	$smtp_server_is_a_command = ($smtp_server =~ m{^/});
-
-} else { # use a default:
-
-	foreach (qw( /usr/sbin/sendmail /usr/lib/sendmail )) {
-		if (-x $_) {
-			$smtp_server = $_;
-			$smtp_server_is_a_command = 1;
-			last;
-		}
-	}
-
-	$smtp_server = 'localhost' # 127.0.0.1 is not compatible with IPv6
-		unless $smtp_server_is_a_command;
-}
-
 if ($compose && $compose > 0) {
 	@files = ($compose_filename . ".final", @files);
 }
-- 
1.6.2.2.479.g2aec
