Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436A826ED35
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 07:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771573994; cv=none; b=IR/hZKws8rTtcukVtXiG+h6CmGaGSG4Ll7olpSTU0iUpY+tVcH0AbPA851hbVrPp6XMsIr8OkWE2iSM/w92SaxyuF5R0lyBOhUqpi8bkWK+cZgjDi4HpEKBT5/5s7z8B+qtF3WBAVUuEDH/Rrq10q1aqmXdLpgzvbXqgberWIYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771573994; c=relaxed/simple;
	bh=TDYt74ASRscDH88M8+2RSXAZUU8gxgRZ0MwFCVox9D4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IkRwuXL13QamL9/+U+zv9i1wxi+2dD/CR0fdoU5unoLJKI9jkMk1SAN/leXtW2RCVk6LtwJ5qTEGG9PxGOjIri/AvvoOgE1g6hhCOkAnhcoeQH7sb2vjeAEViHRvorDmm5AHMG/pL1CzOVhej8sNX79KIaNKqw4s06E/dav+NU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=TpdbZw4d; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="TpdbZw4d"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 50BB11D49A;
	Fri, 20 Feb 2026 07:53:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me 50BB11D49A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1771573991; bh=TDYt74ASRscDH88M8+2RSXAZUU8gxgRZ0MwFCVox9D4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TpdbZw4dHuz0uR9v6FfdowijZ7Yq56aHcDwkLpYVJm7JjZZxZJ9NNLlOqlTy9ZZKI
	 YgPYwVjSUAjGbAn3VQvhbsgPcmIIAeQWPKrRKa6FxM6eR+eVrksEIgdeeHkOgTz3lm
	 oDAaGk5h+TU7ko4BFceVPZUvUhFsm/unvGohpaxk=
Received: from maya.d.snart.me ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id Lqj/AOcSmGnSngIA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Fri, 20 Feb 2026 07:53:11 +0000
From: David Timber <dxdt@dev.snart.me>
To: git@vger.kernel.org
Cc: David Timber <dxdt@dev.snart.me>
Subject: [PATCH] send-mail: add client certificate options
Date: Fri, 20 Feb 2026 16:52:53 +0900
Message-ID: <20260220075304.536514-1-dxdt@dev.snart.me>
X-Mailer: git-send-email 2.53.0.1.g242c94b05d.dirty
In-Reply-To: <20260219-kavaliersdelikt-ansatz-9bdd1aa77326@brauner>
References: <20260219-kavaliersdelikt-ansatz-9bdd1aa77326@brauner>
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

Signed-off-by: David Timber <dxdt@dev.snart.me>
---
 Documentation/git-send-email.adoc | 13 +++++++++
 git-send-email.perl               | 48 ++++++++++++++++++++++++-------
 2 files changed, 50 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
index ebe8853e9f..9c782a4d9a 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -290,6 +290,19 @@ must be used for each option.
 	variable, if set, or the backing SSL library's compiled-in default
 	otherwise (which should be the best choice on most platforms).
 
+--smtp-ssl-client-cert <path>::
+	Path to a client certificate file to present to the SMTP server. This option
+	can be used when the server verifies the certificate from the client. The
+	format could be in either PKCS12 or PEM. In the latter case, the private key
+	can be specified using `--smtp-ssl-client-key` option. More more
+	detail, see
+	https://metacpan.org/pod/IO::Socket::SSL#SSL_cert_file-|-SSL_cert-|-SSL_key_file-|-SSL_key
+
+--smtp-ssl-client-key <path>::
+	Optional path to the private key file. If this is not given and a PKCS12
+	certificate file is used, the private key from the PKCS12 certificate will
+	be used(see `--smtp-ssl-client-cert`).
+
 --smtp-user=<user>::
 	Username for SMTP-AUTH. Default is the value of `sendemail.smtpUser`;
 	if a username is not specified (with `--smtp-user` or `sendemail.smtpUser`),
diff --git a/git-send-email.perl b/git-send-email.perl
index cd4b316ddc..49601a91d8 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -66,6 +66,9 @@ sub usage {
     --smtp-ssl-cert-path    <str>  * Path to ca-certificates (either directory or file).
                                      Pass an empty string to disable certificate
                                      verification.
+    --smtp-ssl-client-cert  <str>  * Path to client certificate file to present to SMTP server
+    --smtp-ssl-client-key   <str>  * Path to the private key file for the client certificate
+                                     (optional if a PKCS12 client certificate is used)
     --smtp-domain           <str>  * The domain name sent to HELO/EHLO handshake
     --smtp-auth             <str>  * Space-separated list of allowed AUTH mechanisms, or
                                      "none" to disable authentication.
@@ -279,6 +282,7 @@ sub do_edit {
 my ($to_cmd, $cc_cmd, $header_cmd);
 my ($smtp_server, $smtp_server_port, @smtp_server_options);
 my ($smtp_authuser, $smtp_encryption, $smtp_ssl_cert_path);
+my ($smtp_ssl_client_cert, $smtp_ssl_client_key);
 my ($batch_size, $relogin_delay);
 my ($identity, $aliasfiletype, @alias_files, $smtp_domain, $smtp_auth);
 my ($imap_sent_folder);
@@ -350,6 +354,8 @@ sub do_edit {
 my %config_path_settings = (
     "aliasesfile" => \@alias_files,
     "smtpsslcertpath" => \$smtp_ssl_cert_path,
+    "smtpsslclientcert" => \$smtp_ssl_client_cert,
+    "smtpsslclientkey" => \$smtp_ssl_client_key,
     "mailmap.file" => \$mailmap_file,
     "mailmap.blob" => \$mailmap_blob,
 );
@@ -531,6 +537,8 @@ sub config_regexp {
 		    "smtp-ssl" => sub { $smtp_encryption = 'ssl' },
 		    "smtp-encryption=s" => \$smtp_encryption,
 		    "smtp-ssl-cert-path=s" => \$smtp_ssl_cert_path,
+		    "smtp-ssl-client-cert=s" => \$smtp_ssl_client_cert,
+		    "smtp-ssl-client-key=s" => \$smtp_ssl_client_key,
 		    "smtp-debug:i" => \$debug_net_smtp,
 		    "smtp-domain:s" => \$smtp_domain,
 		    "smtp-auth=s" => \$smtp_auth,
@@ -1520,6 +1528,8 @@ sub handle_smtp_error {
 }
 
 sub ssl_verify_params {
+	my %ret = ();
+
 	eval {
 		require IO::Socket::SSL;
 		IO::Socket::SSL->import(qw/SSL_VERIFY_PEER SSL_VERIFY_NONE/);
@@ -1531,20 +1541,36 @@ sub ssl_verify_params {
 
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
+		# The cert could be in PKCS12 format, which can store both cert and key
+		$ret{SSL_cert_file} = $smtp_ssl_client_cert;
+		$ret{SSL_use_cert} = 1;
 	}
+	if (defined $smtp_ssl_client_key) {
+		if (!defined $smtp_ssl_client_cert) {
+			# doesn't make sense to use a client key only
+			die sprintf(__("Only client key \"%s\" specified"), $smtp_ssl_client_key);
+		}
+		$ret{SSL_key_file} = $smtp_ssl_client_key;
+	}
+
+	return %ret;
 }
 
 sub file_name_is_absolute {
-- 
2.53.0

