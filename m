Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B7EF9EA
	for <git@vger.kernel.org>; Sun, 25 Feb 2024 10:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708857302; cv=none; b=WGRamJKBFjdZf6KTHJ0L9RefbTyUgS4ZVagIcWlqTcPlayo4wGzELITqn44gFNscd45RSQBZORQeSzZ11Ku2nRLv0WE5zuNkLjVGfUawkXzOBMHFe4585feg+x2q/jzMsciJyKn8JUtjbywIpW7glBs4ull3rVzZLaV9qdpWMC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708857302; c=relaxed/simple;
	bh=7FA7/wR+SwrgkOIOCIbP5nH+Y8vnqrq2V4HHf0Z2oAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MU1VSADRRndUm/wZd8BdSgNdxCrZKOLwM2vxdnSmRQzUQUpAGYcQBspmaNDsqErD1g6tpDxgmBSpmWlO16rdsKFvd1ROULDcytEJof2SpyCWw9VaX2RfVx3St3Ynhsus3VOdab4qZy9ZY7I05o7xMhgrnwL7JsIU//SMshtFuhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swagemakers.org; spf=pass smtp.mailfrom=swagemakers.org; dkim=pass (1024-bit key) header.d=swagemakers.org header.i=@swagemakers.org header.b=ZVJUqrg+; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swagemakers.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swagemakers.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swagemakers.org header.i=@swagemakers.org header.b="ZVJUqrg+"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swagemakers.org;
	s=key1; t=1708857293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Hm3A9Zn+ee2Cy3gKki935CSCR5JZ+Wy3CrMNwJ77U0k=;
	b=ZVJUqrg+C4c9wdvG97rZaflKrp4vt1W1WMSh2opKmZdFqD2RS/+QZYIYE9SDc+vcSzg53Q
	+Czlh7BGLBTwd40hOlVgkbea0Zt/v8vJ1BCOqc95pETkTx+Q0MNqoMoJg1cQQBAecUyxQ4
	8Kp0oCcLFapVNlnXxuFoCwJDNSIlOBM=
From: Julian Swagemakers <julian@swagemakers.org>
To: git@vger.kernel.org
Cc: Julian Swagemakers <julian@swagemakers.org>
Subject: [PATCH] send-email: implement SMTP bearer authentication
Date: Sun, 25 Feb 2024 11:34:13 +0100
Message-ID: <20240225103413.9845-1-julian@swagemakers.org>
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

```
[credential]
	helper = cache --timeout 7200	# two hours
	helper = oauth
[sendemail]
    smtpEncryption = tls
    smtpServer = smtp.gmail.com
    smtpUser = example@gmail.com
    smtpServerPort = 587
    smtpauth = OAUTHBEARER
```

As well as Office 365 accounts:

```
[credential]
	helper = cache --timeout 7200	# two hours
	helper = oauth
[sendemail]
    smtpEncryption = tls
    smtpServer = smtp.office365.com
    smtpUser = example@example.com
    smtpServerPort = 587
    smtpauth = XOAUTH2
```

[0] https://github.com/hickford/git-credential-oauth
[1] https://github.com/hickford/git-credential-oauth/issues/48

Signed-off-by: Julian Swagemakers <julian@swagemakers.org>
---
 git-send-email.perl | 65 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 821b2b3a13..72d378f6fd 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1359,6 +1359,63 @@ sub smtp_host_string {
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
+		# As described in RFC7628 TLS is required and will be will
+		# be enforced at this point.
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
 
@@ -1392,8 +1449,12 @@ sub smtp_auth_maybe {
 		'password' => $smtp_authpass
 	}, sub {
 		my $cred = shift;
-
-		if ($smtp_auth) {
+		if ($smtp_auth eq "OAUTHBEARER" or $smtp_auth eq "XOAUTH2") {
+			# Since Authen:SASL does not support XOAUTH2 nor OAUTHBEARER we will
+			# manuall authenticate for tese types. The password field should
+			# contain the auth token at this point.
+			return smtp_bearer_auth($cred->{'username'}, $cred->{'password'});
+		} elsif ($smtp_auth) {
 			my $sasl = Authen::SASL->new(
 				mechanism => $smtp_auth,
 				callback => {
-- 
2.43.2

