From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC3.5 04/12] send-email: Verification for --smtp-server and --smpt-server-port
Date: Sat, 18 Apr 2009 12:02:00 -0500
Message-ID: <1240074128-16132-5-git-send-email-mfwitten@gmail.com>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-2-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-3-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-4-git-send-email-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 18 19:06:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvDzV-0006bs-1m
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 19:06:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755983AbZDRREc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 13:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755826AbZDRREc
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 13:04:32 -0400
Received: from mail-qy0-f126.google.com ([209.85.221.126]:34618 "EHLO
	mail-qy0-f126.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753358AbZDRREb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 13:04:31 -0400
Received: by mail-qy0-f126.google.com with SMTP id 32so633150qyk.33
        for <git@vger.kernel.org>; Sat, 18 Apr 2009 10:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=qdrHiP34TAxOBXQixe/XiaPq6HtCinKZYlSfo+uMtxo=;
        b=SA+XeKlylQ7e4l2U3tPLHCW3m3JhFRnUXsYBs5YI8KC4Svv+Rx7Z5X/Hnl2RYpM18F
         0zr+58RVUne6nF37zN9gFonM8i7RMg4cJyVIEzImaiA/baOFYGvvdJhDuGvocnRJBOnp
         zcfkircubbAJpMU69OkPzdmgzLxbtXKDyK+dg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bwlzEECx6/J2hEr0CWmNYWRhgKfmO1SvywAhJrKefQ0dAduCEPiuCh6+D8nRMLk8gb
         AFTbws5OT78TdKkl+DmbWxFxbwnxu616uUlYCIVCt47R+JjxT4HuK3LoXjibfd40N1fi
         Vew1UHIoARBTJuQIJK1YyL8iDFqd68B+EEokA=
Received: by 10.220.85.199 with SMTP id p7mr4241311vcl.104.1240074270530;
        Sat, 18 Apr 2009 10:04:30 -0700 (PDT)
Received: from localhost.localdomain (97-116-125-103.mpls.qwest.net [97.116.125.103])
        by mx.google.com with ESMTPS id 6sm1776586ywn.52.2009.04.18.10.04.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 18 Apr 2009 10:04:30 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.479.g2aec
In-Reply-To: <1240074128-16132-4-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116847>

The server URI is verified according to RFCs (including IPv6 support).

The $smtp_server and $smtp_server_port setup code has been moved
higher in the file, so that send-email fails fast if they are bad.

Now, the 'host:port' server URI form is handled regardless of the
documentation deficiencies of Net::SMTP{,::SSL}.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/git-send-email.txt |   50 ++++++++++++-----
 git-send-email.perl              |  115 +++++++++++++++++++++++++++++++------
 2 files changed, 131 insertions(+), 34 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index ae01632..92985ee 100644
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
-	`localhost` otherwise. Also, a built-in default is used if
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
+otherwise. Also, a built-in default is used if `<server>` or
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
index 5e669c7..e2c7954 100755
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
+	$smtp_server = 'localhost'; # 127.0.0.1 is not compatible with IPv6
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
-	$smtp_server = 'localhost'; # 127.0.0.1 is not compatible with IPv6
-		unless $smtp_server_is_a_command;
-}
-
 if ($compose && $compose > 0) {
 	@files = ($compose_filename . ".final", @files);
 }
-- 
1.6.2.2.479.g2aec
