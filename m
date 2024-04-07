Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E381862A
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 10:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712486943; cv=none; b=I0q7jc+wd/a5leYZ9fyDgo0VqJVsv8PozFR0gBvtShtYxjUucX4Rj8vTMD/ifbKyjGcdAX+oRBoeOe3mL7ekJNCIg2ddf81q9wlhgTvuITlmwTrYEQH/3CHAnaC37C3x5YY5JEV8pMiQG6Kh0tu86UZgbovc/a/hhJe+fH1XVmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712486943; c=relaxed/simple;
	bh=PHo3KT87jiyCXkcGSZD+M9TaTZ1C3dcLrQcXtvOAdcY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sY7BwnFBI2nTRVgRYOK+4c34Y0LLTf5i/mjXC55yH8fEOo18NGYFfLNh5aufaV9DcPYAUn97oGWbR5+cZp7LoSVwknHNNinAMuiRUt8AI9EJjxEZCYiVLd3A6qxwCWClULnUuP6fc1HzE3/XsSSgKdguELMSY/IZBcu5QhgISlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=XmbV4a/Q; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="XmbV4a/Q"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712486939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jwXeWqlyVJLpm1VJmdKDiQWySD31rUlcy40p+WzeHX4=;
	b=XmbV4a/QARm4xLop3HLecFDOSm2XI+UTocfzdghXVPXeCSBDhR5nA5OrPMWspoOgwxcMt8
	pQrWtakXRn6k58iNUjYTlvBR5n+OvJkaEoXrSW4gl68+bMHoMh5xmHWifs02Jc4Qq4kd4b
	yjwfU838JkkZX8mxuEWle3ocvB8ZRnVWf8MKTMcjQF0kkpgWD2sKlxF5IstsG07Y7TNNh1
	IBNlUB+4XSwIFr+ym9NsBr/HJUIw+hANBQtqDJJYkPvjJhPQi0sB7ivBlccwj1NmXYeq7l
	jsHh7CAD9OfUC4/b0jPpuZ+3MHfvDuWuUsiHExDO3BAvvuCwJg0EwEe7JT/Paw==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	code@khaugsbakk.name
Subject: [PATCH v5 2/3] send-email: make it easy to discern the messages for each patch
Date: Sun,  7 Apr 2024 12:48:51 +0200
Message-Id: <7f87383089011a98b0347d885b3b9d76cfddb91d.1712486910.git.dsimic@manjaro.org>
In-Reply-To: <cover.1712486910.git.dsimic@manjaro.org>
References: <cover.1712486910.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

When sending multiple patches at once, without prompting the user to confirm
the sending of each patch separately, the displayed result statuses for each
patch become bunched together with the messages produced for the subsequent
patch.  This unnecessarily makes discerning each of the result statuses a bit
difficult, as visible in the sample output excerpt below:

    ...
    MIME-Version: 1.0
    Content-Transfer-Encoding: 8bit

    Result: 250
    OK. Log says:
    ...

As visible in the excerpt above, bunching the "Result: <status-code>" lines
together with the messages produced for the subsequent patch makes the output
unreadable, which actually becomes worse as the number of patches sent at
once increases.  To make the produced outputs more readable, add vertical
whitespace (more precisely, a newline) between the displayed result statuses
and the subsequent messages, as visible in the sample output excerpt below,
produced after the addition of vertical whitespace:

    ...
    MIME-Version: 1.0
    Content-Transfer-Encoding: 8bit

    Result: 250

    OK. Log says:
    ...

These changes don't emit additional vertical whitespace after the result
status produced for the last processed patch, i.e. the vertical whitespace
is treated as a separator between the groups of produced messages, not as
their terminator.  This follows the Git's general approach of not wasting
the vertical screen space whenever reasonably possible.

While there, remove a couple of spotted stray newlines in the source code
and convert one indentation from spaces to tabs, for consistency.

The associated test, t9001, requires no updates to cover these changes.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 git-send-email.perl | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index a22f299ba051..4127fbe6b936 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -212,6 +212,7 @@ sub format_2822_time {
 my $compose_filename;
 my $force = 0;
 my $dump_aliases = 0;
+my $needs_separator = 0;
 
 # Variables to prevent short format-patch options from being captured
 # as abbreviated send-email options
@@ -1361,7 +1362,6 @@ sub smtp_host_string {
 
 # Returns 1 if authentication succeeded or was not necessary
 # (smtp_user was not specified), and 0 otherwise.
-
 sub smtp_auth_maybe {
 	if (!defined $smtp_authuser || $auth || (defined $smtp_auth && $smtp_auth eq "none")) {
 		return 1;
@@ -1554,7 +1554,10 @@ sub send_message {
 			exit(0);
 		} elsif (/^a/i) {
 			$confirm = 'never';
+			$needs_separator = 1;
 		}
+	} else {
+		$needs_separator = 1;
 	}
 
 	unshift (@sendmail_parameters, @smtp_server_options);
@@ -1576,7 +1579,6 @@ sub send_message {
 		print $sm "$header\n$message";
 		close $sm or die $!;
 	} else {
-
 		if (!defined $smtp_server) {
 			die __("The required SMTP server is not properly defined.")
 		}
@@ -1921,7 +1923,8 @@ sub pre_process_file {
 sub process_file {
 	my ($t) = @_;
 
-        pre_process_file($t, $quiet);
+	pre_process_file($t, $quiet);
+	print "\n" if ($needs_separator);
 
 	my $message_was_sent = send_message();
 	if ($message_was_sent == -1) {
