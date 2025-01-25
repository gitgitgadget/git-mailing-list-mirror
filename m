Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970733FBA5
	for <git@vger.kernel.org>; Sat, 25 Jan 2025 19:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737831734; cv=none; b=IijU+cZwJsU8taEJPouSL05boV9ljv1HObzRJBv7w/GfjYCSz8dQ70l0ZwBUMleE6W2P/M6TXLJwvfITl8LC0u9OBvvP2V1zX6YEyE7NO9IABtZOlJv/S0p/KDdi5MATV6ZFvWgyuF8n8wSmNJH6GIWyhWAY+WnK1f6NkHFaD2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737831734; c=relaxed/simple;
	bh=SRJftxT/lY+d27vXS9SzV2RsWMaLyZWgdnbZMT5ISXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=quZCOKZfYen0QbSRCFTY8Izp3sSNPxZngbn9Lc9RsR0Uv8F0cwmWWRaRimLtf9wGE4Fkieq2AibcLicCNJMaWsYDHPFvS79Nkcz6BN6CfGr/8bAxKz5eVJcHhplwU0NaLH6F085ALgGPVif/YhA6jSpPsal8NAQ/zZo9usdGalM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swagemakers.org; spf=pass smtp.mailfrom=swagemakers.org; dkim=pass (1024-bit key) header.d=swagemakers.org header.i=@swagemakers.org header.b=CT+ZZJea; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swagemakers.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swagemakers.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swagemakers.org header.i=@swagemakers.org header.b="CT+ZZJea"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swagemakers.org;
	s=key1; t=1737831726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qn1QoNp/ENkUIDPhrFvRhtSdaXJZtMQtUTpDYvCSzUk=;
	b=CT+ZZJeafQWT2sOxoRVxViWAc7yle6Qfz+G0sutUJdwZxkoILGgNwTxGiBxT7iJZPajVP/
	i6KzCD7hz8J2QHiewrnuDWkBW8DJaKWllNWefQJ08K72KvVj+IQVF3wmCvdCNJU3io/byX
	E0yE3/CNypBhunUyTYYwY0tMBzznvFE=
From: Julian Swagemakers <julian@swagemakers.org>
To: git@vger.kernel.org
Cc: mirth.hickford@gmail.com,
	julian@swagemakers.org,
	sandals@crustytoothpaste.net,
	wiagn233@outlook.com
Subject: [PATCH v2] send-email: implement SMTP bearer authentication
Date: Sat, 25 Jan 2025 20:01:31 +0100
Message-ID: <20250125190131.48717-1-julian@swagemakers.org>
In-Reply-To: <20240225103413.9845-1-julian@swagemakers.org>
References: <20240225103413.9845-1-julian@swagemakers.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Manually send SMTP AUTH command for auth type OAUTHBEARER and XOAUTH2.
This is necessary since they are currently not supported by the Perls
Authen::SASL module.

The bearer token needs to be passed in as the password. This can be done
with git-credential-oauth[0] after minor modifications[1]. Which will
allow using git send-email with Gmail and oauth2 authentication:

    [credential]
        helper = cache --timeout 7200    # two hours
        helper = oauth
    [sendemail]
        smtpEncryption = tls
        smtpServer = smtp.gmail.com
        smtpUser = example@gmail.com
        smtpServerPort = 587
        smtpauth = OAUTHBEARER

As well as Office 365 accounts:

    [credential]
        helper = cache --timeout 7200   # two hours
        helper = oauth
    [sendemail]
        smtpEncryption = tls
        smtpServer = smtp.office365.com
        smtpUser = example@example.com
        smtpServerPort = 587
        smtpauth = XOAUTH2

[0] https://github.com/hickford/git-credential-oauth
[1] https://github.com/hickford/git-credential-oauth/issues/48

Tested-by: M Hickford <mirth.hickford@gmail.com>
Signed-off-by: Julian Swagemakers <julian@swagemakers.org>
---
 Documentation/git-send-email.txt |  5 ++-
 git-send-email.perl              | 65 +++++++++++++++++++++++++++++++-
 2 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index bc3ef45acb..b1972d99bf 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -213,7 +213,10 @@ SMTP server and if it is supported by the utilized SASL library, the mechanism
 is used for authentication. If neither 'sendemail.smtpAuth' nor `--smtp-auth`
 is specified, all mechanisms supported by the SASL library can be used. The
 special value 'none' maybe specified to completely disable authentication
-independently of `--smtp-user`
+independently of `--smtp-user`. Specifying `OAUTHBEARER` or `XOAUTH2` will
+bypass SASL negotiation and force bearer authentication. In this case the
+bearer token must be provided with `--smtp-pass` or using a credential helper
+and `--smtp-encryption=tls` must be set.
 
 --smtp-pass[=<password>]::
 	Password for SMTP-AUTH. The argument is optional: If no
diff --git a/git-send-email.perl b/git-send-email.perl
index 798d59b84f..a78159971b 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1398,6 +1398,63 @@ sub smtp_host_string {
 	}
 }
 
+sub generate_oauthbearer_string {
+	# This will generate the oauthbearer string used for authentication.
+	#
+	# "n,a=" {User} ",^Ahost=" {Host} "^Aport=" {Port} "^Aauth=Bearer " {Access Token} "^A^A
+	#
+	# The first part `n,a=" {User} ",` is the gs2 header described in RFC5801.
+	# * gs2-cb-flag `n` -> client does not support CB
+	# * gs2-authzid `a=" {User} "`
+	#
+	# The second part are key value pairs containing host, port and auth as
+	# described in RFC7628.
+	#
+	# https://datatracker.ietf.org/doc/html/rfc5801
+	# https://datatracker.ietf.org/doc/html/rfc7628
+	my $username = shift;
+	my $token = shift;
+	return "n,a=$username,\001port=$smtp_server_port\001auth=Bearer $token\001\001";
+}
+
+sub generate_xoauth2_string {
+	# "user=" {User} "^Aauth=Bearer " {Access Token} "^A^A"
+	# https://developers.google.com/gmail/imap/xoauth2-protocol#initial_client_response
+	my $username = shift;
+	my $token = shift;
+	return "user=$username\001auth=Bearer $token\001\001";
+}
+
+sub smtp_bearer_auth {
+	my $username = shift;
+	my $token = shift;
+	my $auth_string;
+	if ($smtp_encryption ne "tls") {
+		# As described in RFC7628 TLS is required and will be enforced
+		# at this point.
+		#
+		# https://datatracker.ietf.org/doc/html/rfc7628#section-3
+		die __("For $smtp_auth TLS is required.")
+	}
+	if ($smtp_auth eq "OAUTHBEARER") {
+		$auth_string = generate_oauthbearer_string($username, $token);
+	} elsif ($smtp_auth eq "XOAUTH2") {
+		$auth_string = generate_xoauth2_string($username, $token);
+	}
+	my $encoded_auth_string = MIME::Base64::encode($auth_string, "");
+	$smtp->command("AUTH $smtp_auth $encoded_auth_string\r\n");
+	use Net::Cmd qw(CMD_OK);
+	if ($smtp->response() == CMD_OK){
+		return 1;
+	} else {
+		# Send dummy request on authentication failure according to rfc7628.
+		# https://datatracker.ietf.org/doc/html/rfc7628#section-3.2.3
+		$smtp->command(MIME::Base64::encode("\001"));
+		$smtp->response();
+		return 0;
+	}
+}
+
 # Returns 1 if authentication succeeded or was not necessary
 # (smtp_user was not specified), and 0 otherwise.
 
@@ -1431,8 +1488,12 @@ sub smtp_auth_maybe {
 		'password' => $smtp_authpass
 	}, sub {
 		my $cred = shift;
-
-		if ($smtp_auth) {
+		if (defined $smtp_auth && ($smtp_auth eq "OAUTHBEARER" || $smtp_auth eq "XOAUTH2")) {
+			# Since Authen:SASL does not support XOAUTH2 nor OAUTHBEARER we will
+			# manually authenticate for these types. The password field should
+			# contain the auth token at this point.
+			return smtp_bearer_auth($cred->{'username'}, $cred->{'password'});
+		} elsif ($smtp_auth) {
 			my $sasl = Authen::SASL->new(
 				mechanism => $smtp_auth,
 				callback => {

Range-diff against v1:
1:  ab3ba94099 ! 1:  7532a1ee0a send-email: implement SMTP bearer authentication
    @@ Commit message
         with git-credential-oauth[0] after minor modifications[1]. Which will
         allow using git send-email with Gmail and oauth2 authentication:
     
    -    ```
    -    [credential]
    -            helper = cache --timeout 7200   # two hours
    +        [credential]
    +            helper = cache --timeout 7200    # two hours
                 helper = oauth
    -    [sendemail]
    -        smtpEncryption = tls
    -        smtpServer = smtp.gmail.com
    -        smtpUser = example@gmail.com
    -        smtpServerPort = 587
    -        smtpauth = OAUTHBEARER
    -    ```
    +        [sendemail]
    +            smtpEncryption = tls
    +            smtpServer = smtp.gmail.com
    +            smtpUser = example@gmail.com
    +            smtpServerPort = 587
    +            smtpauth = OAUTHBEARER
     
         As well as Office 365 accounts:
     
    -    ```
    -    [credential]
    +        [credential]
                 helper = cache --timeout 7200   # two hours
                 helper = oauth
    -    [sendemail]
    -        smtpEncryption = tls
    -        smtpServer = smtp.office365.com
    -        smtpUser = example@example.com
    -        smtpServerPort = 587
    -        smtpauth = XOAUTH2
    -    ```
    +        [sendemail]
    +            smtpEncryption = tls
    +            smtpServer = smtp.office365.com
    +            smtpUser = example@example.com
    +            smtpServerPort = 587
    +            smtpauth = XOAUTH2
     
         [0] https://github.com/hickford/git-credential-oauth
         [1] https://github.com/hickford/git-credential-oauth/issues/48
     
    +    Tested-by: M Hickford <mirth.hickford@gmail.com>
         Signed-off-by: Julian Swagemakers <julian@swagemakers.org>
     
    + ## Documentation/git-send-email.txt ##
    +@@ Documentation/git-send-email.txt: SMTP server and if it is supported by the utilized SASL library, the mechanism
    + is used for authentication. If neither 'sendemail.smtpAuth' nor `--smtp-auth`
    + is specified, all mechanisms supported by the SASL library can be used. The
    + special value 'none' maybe specified to completely disable authentication
    +-independently of `--smtp-user`
    ++independently of `--smtp-user`. Specifying `OAUTHBEARER` or `XOAUTH2` will
    ++bypass SASL negotiation and force bearer authentication. In this case the
    ++bearer token must be provided with `--smtp-pass` or using a credential helper
    ++and `--smtp-encryption=tls` must be set.
    + 
    + --smtp-pass[=<password>]::
    + 	Password for SMTP-AUTH. The argument is optional: If no
    +
      ## git-send-email.perl ##
     @@ git-send-email.perl: sub smtp_host_string {
      	}
    @@ git-send-email.perl: sub smtp_host_string {
     +	my $token = shift;
     +	my $auth_string;
     +	if ($smtp_encryption ne "tls") {
    -+		# As described in RFC7628 TLS is required and will be will
    -+		# be enforced at this point.
    ++		# As described in RFC7628 TLS is required and will be enforced
    ++		# at this point.
     +		#
     +		# https://datatracker.ietf.org/doc/html/rfc7628#section-3
     +		die __("For $smtp_auth TLS is required.")
    @@ git-send-email.perl: sub smtp_auth_maybe {
      		my $cred = shift;
     -
     -		if ($smtp_auth) {
    -+		if ($smtp_auth eq "OAUTHBEARER" or $smtp_auth eq "XOAUTH2") {
    ++		if (defined $smtp_auth && ($smtp_auth eq "OAUTHBEARER" || $smtp_auth eq "XOAUTH2")) {
     +			# Since Authen:SASL does not support XOAUTH2 nor OAUTHBEARER we will
    -+			# manuall authenticate for tese types. The password field should
    ++			# manually authenticate for these types. The password field should
     +			# contain the auth token at this point.
     +			return smtp_bearer_auth($cred->{'username'}, $cred->{'password'});
     +		} elsif ($smtp_auth) {
-- 
2.48.1

