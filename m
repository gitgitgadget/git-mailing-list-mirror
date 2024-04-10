Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6166B13C831
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 07:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712732503; cv=none; b=MROFoGdcBmj3x6ksfCITqTmFTqiZvlDgHv4noD1SlAQ8DvP0oStmHDwnvuZWY8kkcLD3c+F9zzE2EzkGSAAXxsMqOAAjgnTwVObAw3PmHwiOo3aRbMEpp6teuhSmeW33n/78LAMlJzeqKhtIB70Yi9/l0ri4Pk7Fyiicwr2BFuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712732503; c=relaxed/simple;
	bh=zJjNBD8yO7H6fx7hQeduhNd+us7Gq86ZXav55mdXKrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i9+4fKt3s9gZwmNL8VoMsVeD8GUP/O63LYFkaFZP4CnQaoXG2fUrRG9G05Sh3KBt5uFS4QbYLw+jz2A31dgm2p9zjBSgmqXRGcw7LFGc6sK31X4zI4D5ZaBPfbrvVJlisoryaGcYDkA22We7AXggzeUwUvj51FVwMFulofOl8OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=C6BXUk2I; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="C6BXUk2I"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712732498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IsqtWABjuy+alL0agvfTxYCfdnS5EtlQHnt5cia9dfo=;
	b=C6BXUk2Ii1fe8rqr+PV0LEyIPLnqfetarU1AFTd36E7rMXEoUdUtWEzN4zomTpu8RmMHB7
	u2pMKtNclX419AHYB7JHUFNMNZdNqOGLvv6Cm3MWAgXL6WM4JJAsEBMkjEZccAq1ZleOXy
	dmkrSQFd4IZO/JtP+8Y3vsP6GYHbj5FrOsF/+9TLKy3g1baeLwhCyw0+sFto9HOspUq8Yp
	gmC9cN2WFfzej9rK1PMDMSyyERIWfeaPE8uj/TzooSsxHEvOHkDxk4uu9osxkRwMPoS3ps
	m2C8Vn3T+V4CBUu+XDKHPs040gtNkefj3gE3x8fu7T/pJILmlsJUXLv47O38oA==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	code@khaugsbakk.name
Subject: [PATCH v6 2/2] send-email: make it easy to discern the messages for each patch
Date: Wed, 10 Apr 2024 09:01:30 +0200
Message-Id: <c78b043b5a6cf0de712d36e6e000804bd6e1316d.1712732383.git.dsimic@manjaro.org>
In-Reply-To: <cover.1712732383.git.dsimic@manjaro.org>
References: <cover.1712732383.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

When sending one or multiple patches at once, the displayed result statuses
for each patch and the "Send this email [y/n/a/...]?" confirmation prompts
become bunched together with the messages produced for the subsequent patch,
or with the produced SMTP trace, respectively.

This makes reading the outputs unnecessarily harder, as visible in a couple
of excerpts from a sample output below:

    ...
    MIME-Version: 1.0
    Content-Transfer-Encoding: 8bit

    Result: 250
    OK. Log says:
    Server: smtp.example.com
    MAIL FROM:<test@example.com>
    ...

    ...
    MIME-Version: 1.0
    Content-Transfer-Encoding: 8bit

    Send this email? ([y]es|[n]o|[e]dit|[q]uit|[a]ll): y
    OK. Log says:
    Server: smtp.example.com
    MAIL FROM:<test@example.com>
    ...

As visible in the excerpts above, bunching the "Result: <status-code>" lines
or the "Send this email [y/n/a/...]?" confirmation prompts together with the
other messages makes the outputs a bit unreadable, which actually becomes
worse as the number of patches sent at once increases.

To make the produced outputs more readable, ensure that vertical whitespace
(more precisely, single newlines) exist before the displayed result statuses
and after the confirmation prompts, as visible in the two updated excerpts
from a sample output below:

    ...
    MIME-Version: 1.0
    Content-Transfer-Encoding: 8bit

    Result: 250

    OK. Log says:
    Server: smtp.example.com
    MAIL FROM:<test@example.com>
    ...

    ...
    MIME-Version: 1.0
    Content-Transfer-Encoding: 8bit

    Send this email? ([y]es|[n]o|[e]dit|[q]uit|[a]ll): y

    OK. Log says:
    Server: smtp.example.com
    MAIL FROM:<test@example.com>
    ...

While there, remove a couple of spotted stray newlines in the source code
and convert one indentation from spaces to tabs, for consistency.

Update the associated test, t9001, by including additional newlines into
the expected outputs of separate tests affected by these changes.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 git-send-email.perl   |  8 +++++---
 t/t9001-send-email.sh | 10 ++++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index f0be4b4560f7..1d6712a44e95 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1361,7 +1361,6 @@ sub smtp_host_string {
 
 # Returns 1 if authentication succeeded or was not necessary
 # (smtp_user was not specified), and 0 otherwise.
-
 sub smtp_auth_maybe {
 	if (!defined $smtp_authuser || $auth || (defined $smtp_auth && $smtp_auth eq "none")) {
 		return 1;
@@ -1510,6 +1509,7 @@ sub gen_header {
 sub send_message {
 	my ($recipients_ref, $to, $date, $gitversion, $cc, $ccline, $header) = gen_header();
 	my @recipients = @$recipients_ref;
+	my $confirm_shown = 0;
 
 	my @sendmail_parameters = ('-i', @recipients);
 	my $raw_from = $sender;
@@ -1555,6 +1555,7 @@ sub send_message {
 		} elsif (/^a/i) {
 			$confirm = 'never';
 		}
+		$confirm_shown = 1;
 	}
 
 	unshift (@sendmail_parameters, @smtp_server_options);
@@ -1576,7 +1577,6 @@ sub send_message {
 		print $sm "$header\n$message";
 		close $sm or die $!;
 	} else {
-
 		if (!defined $smtp_server) {
 			die __("The required SMTP server is not properly defined.")
 		}
@@ -1664,9 +1664,11 @@ sub send_message {
 		$smtp->code =~ /250|200/ or die sprintf(__("Failed to send %s\n"), $subject).$smtp->message;
 	}
 	if ($quiet) {
+		print "\n" if ($confirm_shown);
 		printf($dry_run ? __("Dry-Sent %s") : __("Sent %s"), $subject);
 		print "\n";
 	} else {
+		print "\n";
 		print($dry_run ? __("Dry-OK. Log says:") : __("OK. Log says:"));
 		print "\n";
 		if (!defined $sendmail_cmd && !file_name_is_absolute($smtp_server)) {
@@ -1923,7 +1925,7 @@ sub pre_process_file {
 sub process_file {
 	my ($t) = @_;
 
-        pre_process_file($t, $quiet);
+	pre_process_file($t, $quiet);
 
 	my $message_was_sent = send_message();
 	if ($message_was_sent == -1) {
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 5a771000c9ca..a5cb198a5c5f 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -208,6 +208,7 @@ cat >expected-show-all-headers <<\EOF
 (mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
 (mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
 (mbox) Adding cc: two@example.com from line 'Cc: One <one@example.com>, two@example.com'
+
 Dry-OK. Log says:
 Server: relay.example.com
 MAIL FROM:<from@example.com>
@@ -821,6 +822,7 @@ cat >expected-suppress-sob <<\EOF
 (mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
 (mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
 (mbox) Adding cc: two@example.com from line 'Cc: One <one@example.com>, two@example.com'
+
 Dry-OK. Log says:
 Server: relay.example.com
 MAIL FROM:<from@example.com>
@@ -869,6 +871,7 @@ cat >expected-suppress-sob <<\EOF
 (mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
 (mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
 (mbox) Adding cc: two@example.com from line 'Cc: One <one@example.com>, two@example.com'
+
 Dry-OK. Log says:
 Server: relay.example.com
 MAIL FROM:<from@example.com>
@@ -904,6 +907,7 @@ cat >expected-suppress-cccmd <<\EOF
 (mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
 (mbox) Adding cc: two@example.com from line 'Cc: One <one@example.com>, two@example.com'
 (body) Adding cc: C O Mitter <committer@example.com> from line 'Signed-off-by: C O Mitter <committer@example.com>'
+
 Dry-OK. Log says:
 Server: relay.example.com
 MAIL FROM:<from@example.com>
@@ -940,6 +944,7 @@ test_expect_success $PREREQ 'sendemail.cccmd' '
 test_expect_success $PREREQ 'setup expect' '
 cat >expected-suppress-all <<\EOF
 0001-Second.patch
+
 Dry-OK. Log says:
 Server: relay.example.com
 MAIL FROM:<from@example.com>
@@ -968,6 +973,7 @@ cat >expected-suppress-body <<\EOF
 (mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
 (mbox) Adding cc: two@example.com from line 'Cc: One <one@example.com>, two@example.com'
 (cc-cmd) Adding cc: cc-cmd@example.com from: './cccmd'
+
 Dry-OK. Log says:
 Server: relay.example.com
 MAIL FROM:<from@example.com>
@@ -1003,6 +1009,7 @@ cat >expected-suppress-body-cccmd <<\EOF
 (mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
 (mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
 (mbox) Adding cc: two@example.com from line 'Cc: One <one@example.com>, two@example.com'
+
 Dry-OK. Log says:
 Server: relay.example.com
 MAIL FROM:<from@example.com>
@@ -1036,6 +1043,7 @@ cat >expected-suppress-sob <<\EOF
 (mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
 (mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
 (mbox) Adding cc: two@example.com from line 'Cc: One <one@example.com>, two@example.com'
+
 Dry-OK. Log says:
 Server: relay.example.com
 MAIL FROM:<from@example.com>
@@ -1071,6 +1079,7 @@ cat >expected-suppress-bodycc <<\EOF
 (mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
 (mbox) Adding cc: two@example.com from line 'Cc: One <one@example.com>, two@example.com'
 (body) Adding cc: C O Mitter <committer@example.com> from line 'Signed-off-by: C O Mitter <committer@example.com>'
+
 Dry-OK. Log says:
 Server: relay.example.com
 MAIL FROM:<from@example.com>
@@ -1105,6 +1114,7 @@ cat >expected-suppress-cc <<\EOF
 0001-Second.patch
 (mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
 (body) Adding cc: C O Mitter <committer@example.com> from line 'Signed-off-by: C O Mitter <committer@example.com>'
+
 Dry-OK. Log says:
 Server: relay.example.com
 MAIL FROM:<from@example.com>
