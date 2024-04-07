Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCD0199BC
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 10:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712486944; cv=none; b=ElgXbCST0Py2qEoIm6H5qOw8EdDCXU8F/Mi6ncclAp9poDQzEyw24Q1DICSIsPsRSjdRwdFnrXA4uCMsh3pSLfSh7J+CPhFAbV66kqJB6jkHBR5iFM6GhGy2EEv6/0SUkZbAEJ1mhH/fdbTonJIHJ/ZMVyOf8deUmEePYB292YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712486944; c=relaxed/simple;
	bh=KSgRlSAp20SSuLJh1tJKJsopIYU1+m0ov7xxchZRC3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V+nJzpl7N2iatfUIEFpwZWnoT/5IrDOqv5xZNeBH3eWzDMMQsw2gKStTYFNpjsR0M92waZUUiXiWTVh+fRG+ISPBg662skkpojAuz1FBhp6gqE9barQ18x021uv6X5BUz1kQw4eloEExU8/GUTc9YqSBMJxx6xOsx4Yptk41zsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=CrJmfzcA; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="CrJmfzcA"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712486940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rFLMWYB7AIdX0a0xMZFkLZq+IehkVuP9MGj54xc/a1M=;
	b=CrJmfzcApD04jUHoQEyMBdU4xlgh5XB+MeD2gCWgAliucUC7Kry6j9hchMlY/8HjarAUJw
	cd1U/nLKwcJEd07iiPGGw0+n0wIwDWxZ9qJGcOq3e51j4opyv/nuVpDZ6JIPWnZn1TO5gc
	7KkC+zS+XsBezBx+N3nNNepGsV+u4uIArxxrcY77V77FHC7bZdHJRzo1lU3vps441J56Nw
	TSTVvk1UedxI6Q3eyDCGLKM2ypI+GZ7tMavAxAgt/YOJuaSL1ZWLWy3aw8tEe3ndEDE6iU
	dF07dqtC4OFONMbtSKCEdi4408hdXkJ/wCu3LdqFRC3fwJHk1w2kNEyersCG4g==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	code@khaugsbakk.name
Subject: [PATCH v5 3/3] send-email: separate the confirmation prompts from the messages
Date: Sun,  7 Apr 2024 12:48:52 +0200
Message-Id: <7b99e5c7c0b0c8d3d7eaaae169e650ebe81964a1.1712486910.git.dsimic@manjaro.org>
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

Emit additional vertical whitespace after the "Send this email [y/n/...]?"
confirmation prompts, more specifically after each confirmed email is sent,
but before the subsequent messages are emitted, to make the produced output
more readable.  The subsequent produced messages were bunched together with
the confirmation prompts, as visible in the sample output excerpt below,
which made discerning the outputs unnecessarily harder.

    ...
    Send this email? ([y]es|[n]o|[e]dit|[q]uit|[a]ll): y
    OK. Log says:
    ...

The introduced changes don't emit additional vertical whitespace after the
confirmation prompt if the user selects to skip sending the email they were
asked about, or if the user selects to quit the procedure entirely.  This
follows the Git's general approach of not wasting the vertical screen space
whenever reasonably possible.

The associated test, t9001, requires no updates to cover these changes.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 git-send-email.perl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index 4127fbe6b936..a09bc7fd6b96 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1510,6 +1510,7 @@ sub gen_header {
 sub send_message {
 	my ($recipients_ref, $to, $date, $gitversion, $cc, $ccline, $header) = gen_header();
 	my @recipients = @$recipients_ref;
+	my $prompt_separator = 0;
 
 	my @sendmail_parameters = ('-i', @recipients);
 	my $raw_from = $sender;
@@ -1556,6 +1557,7 @@ sub send_message {
 			$confirm = 'never';
 			$needs_separator = 1;
 		}
+		$prompt_separator = 1;
 	} else {
 		$needs_separator = 1;
 	}
@@ -1665,6 +1667,7 @@ sub send_message {
 		$smtp->dataend() or die $smtp->message;
 		$smtp->code =~ /250|200/ or die sprintf(__("Failed to send %s\n"), $subject).$smtp->message;
 	}
+	print "\n" if ($prompt_separator);
 	if ($quiet) {
 		printf($dry_run ? __("Dry-Sent %s\n") : __("Sent %s\n"), $subject);
 	} else {
