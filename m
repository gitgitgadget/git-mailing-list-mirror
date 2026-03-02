Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E14199FBA
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 03:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772421685; cv=none; b=IOfrVhIbMuGgvb5HRg3iPYccWppi2oSKeER+UD96N9yTRA7ah0Z0MAfS5bUDY6F6rfhYrnrnCs25F55SgVJXevElQmoZXVeyMLOHGmK9OI6p+1PLYxKH3S/Q6gmy9EJiWzCWY7TwBbRxStSzayej4p4GadA9XpK4nnbSrumD3b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772421685; c=relaxed/simple;
	bh=dsh5NpPkebd7L/Ve5saypA9YzY6XBYwSlaO7I1VaO+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HbYZrlRsE9mFAxo7FUI2q5bE1zHseLWrsitSjUcNmMm15E/V5S89ijF3I4dOCVQp8Z4AaiDsUC1nyqoHDq0jT745ZxtQlMZCFN7SxuAEqdk1l8q7CGKtcx0pcCnZRPQZW2zOykmUMJscDqbSwFqffCd9Pwt1qrw1L88HgHWkTEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=a9GR7E6k; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="a9GR7E6k"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 571D01CBC3;
	Mon,  2 Mar 2026 03:21:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me 571D01CBC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1772421676; bh=dsh5NpPkebd7L/Ve5saypA9YzY6XBYwSlaO7I1VaO+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a9GR7E6kx5IQGKw6HjPTsuUv8br3+BW2TaUrEHSLdmtzqCNWt8X4feRUvCguJXmY4
	 mhTLbEDyqINbsNg4/XC7opY8XHB7JHVyJr/ZNVorAtk27AzuC/l6Jvm0/3VvZI0ovZ
	 MEaP/8Nlj4mq5sRDFXGIhXqwaub7DM9Q3c6w4U3c=
Received: from maya.d.snart.me ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id TNW0LCcCpWl8sAAA8KYfjw:T2
	(envelope-from <dxdt@dev.snart.me>); Mon, 02 Mar 2026 03:21:16 +0000
From: David Timber <dxdt@dev.snart.me>
To: git@vger.kernel.org
Cc: David Timber <dxdt@dev.snart.me>
Subject: [PATCH v2 1/1] send-email: add client certificate options
Date: Mon,  2 Mar 2026 12:16:41 +0900
Message-ID: <20260302032048.260209-2-dxdt@dev.snart.me>
X-Mailer: git-send-email 2.53.0.1.ga224b40d3f.dirty
In-Reply-To: <20260302032048.260209-1-dxdt@dev.snart.me>
References: <xmqqo6lb4fuy.fsf@gitster.g>
 <20260302032048.260209-1-dxdt@dev.snart.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For SMTP servers that do "mutual certificate verification", the mail
client is required to present its own TLS certificate as well. This
patch adds --smtp-ssl-client-cert and --smtp-ssl-client-key for such
servers.

The problem of which private key for the certificate is chosen arises
when there are private keys in both the certificate and private key
file. According to the documentation of IO::Socket::SSL(link supplied),
the behaviour(the private key chosen) depends on the format of the
certificate. In a nutshell,

	- PKCS12: the key in the cert always takes the precedence
	- PEM: if the key file is not given, it will "try" to read one
	  from the cert PEM file

Many users may find this discrepancy unintuitive.

In terms of client certificate, git-send-email is implemented in a way
that what's possible with perl's SSL library is exposed to the user as
much as possible. In this instance, the user may choose to use a PEM
file that contains both certificate and private key should be
at their discretion despite the implications.

Link: https://metacpan.org/pod/IO::Socket::SSL#SSL_cert_file-%7C-SSL_cert-%7C-SSL_key_file-%7C-SSL_key
Link: https://lore.kernel.org/all/319bf98c-52df-4bf9-b157-e4bc2bf087d6@dev.snart.me/

Signed-off-by: David Timber <dxdt@dev.snart.me>
---
 Documentation/config/sendemail.adoc | 16 ++++++++++
 Documentation/git-send-email.adoc   | 19 ++++++++++++
 git-send-email.perl                 | 47 ++++++++++++++++++++++-------
 3 files changed, 71 insertions(+), 11 deletions(-)

diff --git a/Documentation/config/sendemail.adoc b/Documentation/config/sendemail.adoc
index 90164c734d..6560ecc5ab 100644
--- a/Documentation/config/sendemail.adoc
+++ b/Documentation/config/sendemail.adoc
@@ -12,6 +12,22 @@ sendemail.smtpSSLCertPath::
 	Path to ca-certificates (either a directory or a single file).
 	Set it to an empty string to disable certificate verification.
 
+sendemail.smtpSSLClientCert::
+	Path to the client certificate file to present if requested by the
+	server. This is required when the server is set up to verify client
+	certificates. If the corresponding private key is not included in the
+	file, it must be supplied using `sendemail.smtpSSLClientKey` or the
+	`--smtp-ssl-client-key` option.
+
+sendemail.smtpSSLClientKey::
+	Path to the client private key file that corresponds to the client
+	certificate. To avoid misconfiguration, this configuration must be used
+	in conjunction with `sendemail.smtpSSLClientKey` or the
+	`--smtp-ssl-client-cert` option. If the client key is included in the
+	client certificate, the choice of private key depends on the format of
+	the certificate. Visit https://metacpan.org/pod/IO::Socket::SSL for more
+	details.
+
 sendemail.<identity>.*::
 	Identity-specific versions of the `sendemail.*` parameters
 	found below, taking precedence over those when this
diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
index ebe8853e9f..ed9a0d3053 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -290,6 +290,25 @@ must be used for each option.
 	variable, if set, or the backing SSL library's compiled-in default
 	otherwise (which should be the best choice on most platforms).
 
+--smtp-ssl-client-cert <path>::
+	Path to the client certificate file to present if requested by the
+	server. This option is required when the server is set up to verify
+	client certificates. If the corresponding private key is not included in
+	the file, it must be supplied using the `sendemail.smtpSSLClientKey`
+	configuration variable or the `--smtp-ssl-client-key` option. Defaults
+	to the value of the `sendemail.smtpSSLClientCert` configuration
+	variable, if set.
+
+--smtp-ssl-client-key <path>::
+	Path to the client private key file that corresponds to the client
+	certificate. To avoid misconfiguration, this option must be used in
+	conjunction with the `sendemail.smtpSSLClientKey` configuration variable
+	or the `--smtp-ssl-client-cert` option. If the client key is included in
+	the client certificate, the choice of private key depends on the format
+	of the certificate. Visit https://metacpan.org/pod/IO::Socket::SSL for
+	more details. Defaults to the value of the `sendemail.smtpSSLClientKey`
+	configuration variable, if set.
+
 --smtp-user=<user>::
 	Username for SMTP-AUTH. Default is the value of `sendemail.smtpUser`;
 	if a username is not specified (with `--smtp-user` or `sendemail.smtpUser`),
diff --git a/git-send-email.perl b/git-send-email.perl
index cd4b316ddc..324fa0056c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -66,6 +66,8 @@ sub usage {
     --smtp-ssl-cert-path    <str>  * Path to ca-certificates (either directory or file).
                                      Pass an empty string to disable certificate
                                      verification.
+    --smtp-ssl-client-cert  <str>  * Path to the client certificate file
+    --smtp-ssl-client-key   <str>  * Path to the private key file for the client certificate
     --smtp-domain           <str>  * The domain name sent to HELO/EHLO handshake
     --smtp-auth             <str>  * Space-separated list of allowed AUTH mechanisms, or
                                      "none" to disable authentication.
@@ -279,6 +281,7 @@ sub do_edit {
 my ($to_cmd, $cc_cmd, $header_cmd);
 my ($smtp_server, $smtp_server_port, @smtp_server_options);
 my ($smtp_authuser, $smtp_encryption, $smtp_ssl_cert_path);
+my ($smtp_ssl_client_cert, $smtp_ssl_client_key);
 my ($batch_size, $relogin_delay);
 my ($identity, $aliasfiletype, @alias_files, $smtp_domain, $smtp_auth);
 my ($imap_sent_folder);
@@ -350,6 +353,8 @@ sub do_edit {
 my %config_path_settings = (
     "aliasesfile" => \@alias_files,
     "smtpsslcertpath" => \$smtp_ssl_cert_path,
+    "smtpsslclientcert" => \$smtp_ssl_client_cert,
+    "smtpsslclientkey" => \$smtp_ssl_client_key,
     "mailmap.file" => \$mailmap_file,
     "mailmap.blob" => \$mailmap_blob,
 );
@@ -531,6 +536,8 @@ sub config_regexp {
 		    "smtp-ssl" => sub { $smtp_encryption = 'ssl' },
 		    "smtp-encryption=s" => \$smtp_encryption,
 		    "smtp-ssl-cert-path=s" => \$smtp_ssl_cert_path,
+		    "smtp-ssl-client-cert=s" => \$smtp_ssl_client_cert,
+		    "smtp-ssl-client-key=s" => \$smtp_ssl_client_key,
 		    "smtp-debug:i" => \$debug_net_smtp,
 		    "smtp-domain:s" => \$smtp_domain,
 		    "smtp-auth=s" => \$smtp_auth,
@@ -1520,6 +1527,8 @@ sub handle_smtp_error {
 }
 
 sub ssl_verify_params {
+	my %ret = ();
+
 	eval {
 		require IO::Socket::SSL;
 		IO::Socket::SSL->import(qw/SSL_VERIFY_PEER SSL_VERIFY_NONE/);
@@ -1531,20 +1540,36 @@ sub ssl_verify_params {
 
 	if (!defined $smtp_ssl_cert_path) {
 		# use the OpenSSL defaults
-		return (SSL_verify_mode => SSL_VERIFY_PEER());
+		$ret{SSL_verify_mode} = SSL_VERIFY_PEER();
+	}
+	else {
+		if ($smtp_ssl_cert_path eq "") {
+			$ret{SSL_verify_mode} = SSL_VERIFY_NONE();
+		} elsif (-d $smtp_ssl_cert_path) {
+			$ret{SSL_verify_mode} = SSL_VERIFY_PEER();
+			$ret{SSL_ca_path} = $smtp_ssl_cert_path;
+		} elsif (-f $smtp_ssl_cert_path) {
+			$ret{SSL_verify_mode} = SSL_VERIFY_PEER();
+			$ret{SSL_ca_file} = $smtp_ssl_cert_path;
+		} else {
+			die sprintf(__("CA path \"%s\" does not exist"), $smtp_ssl_cert_path);
+		}
 	}
 
-	if ($smtp_ssl_cert_path eq "") {
-		return (SSL_verify_mode => SSL_VERIFY_NONE());
-	} elsif (-d $smtp_ssl_cert_path) {
-		return (SSL_verify_mode => SSL_VERIFY_PEER(),
-			SSL_ca_path => $smtp_ssl_cert_path);
-	} elsif (-f $smtp_ssl_cert_path) {
-		return (SSL_verify_mode => SSL_VERIFY_PEER(),
-			SSL_ca_file => $smtp_ssl_cert_path);
-	} else {
-		die sprintf(__("CA path \"%s\" does not exist"), $smtp_ssl_cert_path);
+	if (defined $smtp_ssl_client_cert) {
+		$ret{SSL_cert_file} = $smtp_ssl_client_cert;
 	}
+	if (defined $smtp_ssl_client_key) {
+		if (!defined $smtp_ssl_client_cert) {
+			# Accept the client key only when a certificate is given.
+			# We die here because this case is a user error.
+			die sprintf(__("Only client key \"%s\" specified"),
+				    $smtp_ssl_client_key);
+		}
+		$ret{SSL_key_file} = $smtp_ssl_client_key;
+	}
+
+	return %ret;
 }
 
 sub file_name_is_absolute {
-- 
2.53.0.1.ga224b40d3f.dirty

