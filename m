From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 2/2] send-email: introduce sendemail.smtpsslcertpath
Date: Sat, 6 Jul 2013 12:46:00 +0100
Message-ID: <20130706114600.GP9161@serenity.lan>
References: <1373025947-26495-1-git-send-email-artagnon@gmail.com>
 <1373025947-26495-3-git-send-email-artagnon@gmail.com>
 <20130705124536.GU862789@vauxhall.crustytoothpaste.net>
 <7vobag7wl0.fsf@alter.siamese.dyndns.org>
 <20130705174730.GM9161@serenity.lan>
 <7vehbc7tcc.fsf@alter.siamese.dyndns.org>
 <20130705184333.GN9161@serenity.lan>
 <7v1u7c6w7z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 06 13:46:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvQwR-00082R-GE
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jul 2013 13:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752958Ab3GFLqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jul 2013 07:46:11 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:53955 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752943Ab3GFLqK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jul 2013 07:46:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 5B46C198008;
	Sat,  6 Jul 2013 12:46:09 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -10.999
X-Spam-Level: 
X-Spam-Status: No, score=-10.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0tXuwSu3rFbf; Sat,  6 Jul 2013 12:46:08 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 9FFFB6064B7;
	Sat,  6 Jul 2013 12:46:02 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7v1u7c6w7z.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229699>

On Fri, Jul 05, 2013 at 11:25:36PM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > I'd rather have '$smtp_ssl_cert_path ne ""' in the first if condition
> > (instead of the '-d $smtp_ssl_cert_path') ...
> 
> I agree.  The signal for "no certs" should be an explicit "nonsense"
> value like an empty string, not just a string that does not name an
> expected filesystem object.  Otherwise people can misspell paths and
> disable the validation by accident.
> 
> > Perhaps a complete solution could allow CA files as well.
> 
> Yes, that would be a good idea.  Care to roll into a "fixup!" patch
> against [2/2]?

Here's a patch that should do that.  However, when testing this I
couldn't get the "SSL_verify_mode" warning to disappear and
git-send-email kept connecting to my untrusted server - this was using
the SSL code path not the TLS upgrade one.

I think this is caused by the SSL_verify_mode argument not getting all
the way down to the configure_SSL function in IO::Socket::SSL but I
can't see what the code in git-send-email is doing wrong.  Can any Perl
experts point out what's going wrong?

Also, I tried Brian's "IO::Socket::SSL->import(qw(SSL_VERIFY_PEER
SSL_VERIFY_NONE));" but that produced a warning message about the uses
of SSL_VERIFY_PEER and SSL_VERIFY_NONE following that statement, so I
ended up qualifying each use in the code below.

-- >8 --
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 605f263..b56c215 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -198,6 +198,10 @@ must be used for each option.
 --smtp-ssl::
 	Legacy alias for '--smtp-encryption ssl'.
 
+--smtp-ssl-verify::
+--no-smtp-ssl-verify::
+	Enable SSL certificate verification.  Defaults to on.
+
 --smtp-ssl-cert-path::
 	Path to ca-certificates.  Defaults to `/etc/ssl/certs`, or
 	'sendemail.smtpsslcertpath'.
diff --git a/git-send-email.perl b/git-send-email.perl
index 3b80340..cbe85aa 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -69,8 +69,10 @@ git send-email [options] <file | directory | rev-list options >
     --smtp-pass             <str>  * Password for SMTP-AUTH; not necessary.
     --smtp-encryption       <str>  * tls or ssl; anything else disables.
     --smtp-ssl                     * Deprecated. Use '--smtp-encryption ssl'.
+    --[no-]smtp-ssl-verify         * Enable SSL certificate verification.
+                                     Default on.
     --smtp-ssl-cert-path    <str>  * Path to ca-certificates.  Defaults to
-                                     /etc/ssl/certs.
+                                     a platform-specific value.
     --smtp-domain           <str>  * The domain name sent to HELO/EHLO handshake
     --smtp-debug            <0|1>  * Disable, enable Net::SMTP debug.
 
@@ -197,7 +199,7 @@ my ($thread, $chain_reply_to, $suppress_from, $signed_off_by_cc);
 my ($to_cmd, $cc_cmd);
 my ($smtp_server, $smtp_server_port, @smtp_server_options);
 my ($smtp_authuser, $smtp_encryption);
-my ($smtp_ssl_cert_path);
+my ($smtp_ssl_verify, $smtp_ssl_cert_path);
 my ($identity, $aliasfiletype, @alias_files, $smtp_domain);
 my ($validate, $confirm);
 my (@suppress_cc);
@@ -214,6 +216,7 @@ my %config_bool_settings = (
     "suppressfrom" => [\$suppress_from, undef],
     "signedoffbycc" => [\$signed_off_by_cc, undef],
     "signedoffcc" => [\$signed_off_by_cc, undef],      # Deprecated
+    "smtpsslverify" => [\$smtp_ssl_verify, 1],
     "validate" => [\$validate, 1],
     "multiedit" => [\$multiedit, undef],
     "annotate" => [\$annotate, undef]
@@ -306,6 +309,8 @@ my $rc = GetOptions("h" => \$help,
 		    "smtp-pass:s" => \$smtp_authpass,
 		    "smtp-ssl" => sub { $smtp_encryption = 'ssl' },
 		    "smtp-encryption=s" => \$smtp_encryption,
+		    "smtp-ssl-cert-path=s" => \$smtp_ssl_cert_path,
+		    "smtp-ssl-verify!" => \$smtp_ssl_verify,
 		    "smtp-debug:i" => \$debug_net_smtp,
 		    "smtp-domain:s" => \$smtp_domain,
 		    "identity=s" => \$identity,
@@ -1096,19 +1101,18 @@ sub smtp_auth_maybe {
 # Helper to come up with SSL/TLS certification validation params
 # and warn when doing no verification
 sub ssl_verify_params {
-	use IO::Socket::SSL qw(SSL_VERIFY_PEER SSL_VERIFY_NONE);
-
-	if (!defined $smtp_ssl_cert_path) {
-		$smtp_ssl_cert_path = "/etc/ssl/certs";
+	if ($smtp_ssl_verify == 0) {
+		return (SSL_verify_mode => IO::Socket::SSL->SSL_VERIFY_NONE);
 	}
 
-	if (-d $smtp_ssl_cert_path) {
-		return (SSL_verify_mode => SSL_VERIFY_PEER,
-			SSL_ca_path => $smtp_ssl_cert_path);
+	if (! defined $smtp_ssl_cert_path) {
+		return (SSL_verify_mode => IO::Socket::SSL->SSL_VERIFY_PEER);
+	} elsif (-f $smtp_ssl_cert_path) {
+		return (SSL_verify_mode => IO::Socket::SSL->SSL_VERIFY_PEER,
+			SSL_ca_file => $smtp_ssl_cert_path);
 	} else {
-		print STDERR "warning: Using SSL_VERIFY_NONE.  " .
-		    "See sendemail.smtpsslcertpath.\n";
-		return (SSL_verify_mode => SSL_VERIFY_NONE);
+		return (SSL_verify_mode => IO::Socket::SSL->SSL_VERIFY_PEER,
+			SSL_ca_path => $smtp_ssl_cert_path);
 	}
 }
 
-- 8< --

> > 	if (defined $smtp_ssl_cert_path) {
> > 		if ($smtp_ssl_cert_path eq "") {
> > 			return (SSL_verify_mode => SSL_VERIFY_NONE);
> > 		} elsif (-f $smtp_ssl_cert_path) {
> > 			return (SSL_verify_mode => SSL_VERIFY_PEER,
> > 				SSL_ca_file => $smtp_ssl_cert_path);
> > 		} else {
> > 			return (SSL_verify_mode => SSL_VERIFY_PEER,
> > 				SSL_ca_path => $smtp_ssl_cert_path);
> > 		}
> > 	} else {
> > 		return (SSL_verify_mode => SSL_VERIFY_PEER);
> > 	}
> 
> Two things that worry me a bit are:
> 
>  (1) At the end user UI level, it may look nice to accept some form
>      of --no-option-name to say "I have been using SSL against my
>      server with handrolled cert, and I want to keep using the
>      verify-none option"; "--ssl-cert-path=" looks somewhat ugly.
>      The same goes for [sendemail] ssl_cert_path = "" config.
> 
>  (2) How loudly does the new code barf when no configuration is done
>      (i.e. we just pass SSL_VERIFY_PEER and let the system default
>      CA path to take effect) and the server cert does not validate?
>      The warning that triggered this thread, if we had the
>      configuration mechanism we have been designing together, would
>      have been a good reminder for the user to use it, but would we
>      give a similar (less noisy is fine, as long as it is clear)
>      diagnostic message?
