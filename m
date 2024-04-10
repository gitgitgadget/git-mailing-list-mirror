Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8071731758
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 07:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712732502; cv=none; b=c2mh3u+ow1fb6/G43nOJA43ZbjtVUj3T6rUZBnO74qaXBKxVXUJbjvJmCb3MC51jVtMqtitUw6xpurDq6zCFwnhf3zvFsuD/nfwio4lRSClIxkjO1o2nMQJlD4PIsjC8cZSx3aRwO+3cbEnE70Q9Sp8OkG9kqLtWu2dl0WB69Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712732502; c=relaxed/simple;
	bh=qXUjBXLDvugjatAUKRdZwTo6/FoyuTp5a+8I6tMfSm4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r/JhE7M4gYqUjKMa5mKFlT7Z/Lms9oyT3mVejy7fnFv/0EmxQA+6B5G5X/6reJ2tzF/jUbO1iDhT42FxWMpTqIZNG1MRPEMGGJsuK4eR50bhA8YRpZmPi7V+Pyg4hjHY7FhuLs3vksv2vjsmTbIQw3IVgRbLLpilSRA+iiTFZE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Vg1GbnJu; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Vg1GbnJu"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712732496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=09ETyj8UKSKwfBJ6vHndMqO1kKw2LevyF+LK9/hp+ls=;
	b=Vg1GbnJu+6+B170VOqI0VQRrqqpnLYmXaASMQgVRK1rpEJO2vS8pHXUy7pPxw7noxvQ7KM
	DYHmmvg+BEMWlPi0USG8sXJLwpmBM+YCjw5hdaLCAJgkNEepOkSLGuCNwsRrmI2ivsxkoy
	rP0WczXB4heRXpWFk5nTPIxyBJBhhSpN4Tj7PP+OEsl1HCAfgN0YaHGCof2yAMTdkIDPSM
	4hulaD9saGZhJQyz3f+ipxaySZ7m8vzXhln7LwfT7wKAoZGsGMhxORZDPilXAGcmiXGmWN
	2DQdGPOYSwyiepDIIspxxryZy+gvqHB4R09Vi05aEe60Lw0+rr/99SLpSQ9MUw==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	code@khaugsbakk.name
Subject: [PATCH v6 0/2] send-email: make produced outputs more readable
Date: Wed, 10 Apr 2024 09:01:28 +0200
Message-Id: <cover.1712732383.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

 * send-email: make produced outputs more readable by separating
   the result statuses and prompts from the other messages

This series makes the outputs of "git send-mail" more readable, by
adding vertical whitespace to make discerning the messages produced
for each patch easy.  More specifically, these patches ensure that
single newlines exists before the displayed result statues and after
the displayed confirmation prompts.

Making the outputs of "git send-mail" more readable is quite important,
because the Git users rather regularly complain about the workflows that
require project patches to be sent to various mailing lists.  Making the
produced outputs more readable can only help there.

Changes in v6:
    - Squashed the 3/3 patch into 2/2, because the simplified logic
      no longer requires separate treatment for the prompts
    - Moved the emitting of additional newlines into the send_message()
      function, and simplified the whole logic;  the key is to notice
      that the separation of message blocks comes from the emitted SMTP
      traces, except when using the "--quiet" option, so emitting the
      additional newlines as part of the emitting of the SMTP traces
      makes everything much more simple
    - Ensured that the newline is emitted before the SMTP trace even
      if "sendemail.confirm" is set to "auto" or "never"
    - Ensured that the newline is emitted before the brief outputs
      when using the "--quit" option, regardless of "sendemail.confirm"
      being set to "auto", "always" or "never"
    - Improved the naming of a variable, as suggested by Junio [2]
    - Improved the patch descriptions, as suggested by Junio, [1][2]
      and updated to match the new nature of the patches
    - Updated the test t9001 to learn about the additional newlines

Changes in v5:
    - Split into a three-patch series, because changes introduced in
      some versions of this patch made the original assumptions about
      squashing the changes together no longer apply [3]
    - Updated and extended the patch descriptions, to hopefully describe
      the changes performed in each patch a bit better

Changes in v4:
    - Dropped the changes to the styling of the produced prompts, as
      reasonably requested by Junio, [4] because it extended the scope
      of the patch with no good reason, and may also create issues on
      some platforms, whose Perl packages may actually not support the
      "->ornaments()" feature of Term::ReadLine
    - Updated the patch description and the "what's cooking" summary
      to cover the changes

Changes in v3:
    - Removed a redundant comment, as suggested by Junio [5]
    - Did the right thing and made the vertical separators emitted as
      message separators, instead of having them emitted as message
      terminators, as suggested by Junio [5]
    - Additional vertical whitespace is now also emitted after the
      prompt for sending emails, to "de-bunch" it from the subsequent
      messages and make discerning the messages easier
    - The above-mentioned prompt no longer uses underlined text, to make
      it significantly easier on the eyes
    - Fixed one indentation by spaces to use tabs and removed one stray
      newline in the source code, as spotted
    - Updated and extended the patch description to cover the changes
    - Updated the "what's cooking" summary to cover the changes
    - Cleaned up the older notes a bit

Changes in v2:
    - Improved the way additional newline separators are introduced to
      the source code, as suggested by Junio, [6], to help a bit with
      the translation efforts
    - Improved the patch subject and description a bit, to provide some
      additional information, as suggested by Junio [6]
    - Added a Helped-by tag

Notes for v1:
    - This is a resubmission of the patch I submitted about a week and
      a half ago; [7]  the patch subject in the original submission was
      selected in a bit unfortunate way, which this submission corrects,
      and also improves the patch description a bit
    - There are no changes to the patch itself, vs. the original patch

Link to v1: https://lore.kernel.org/git/62553db377c28458883b66bcdc0c58cc0f32d15b.1712250366.git.dsimic@manjaro.org/T/#u
Link to v2: https://lore.kernel.org/git/0e087ed992def0746f3d437253248904c2126464.1712262791.git.dsimic@manjaro.org/T/#u
Link to v3: https://lore.kernel.org/git/e3212c0a4ad331685c68c13afcdbced20982ab32.1712364420.git.dsimic@manjaro.org/T/#u
Link to v4: https://lore.kernel.org/git/8a9f4927aab96f2f62e2467e59fb6150d7e931fc.1712367983.git.dsimic@manjaro.org/T/#u
Link to v5: https://lore.kernel.org/git/cover.1712486910.git.dsimic@manjaro.org/T/#u

[1] https://lore.kernel.org/git/xmqq7ch7a7gt.fsf@gitster.g/
[2] https://lore.kernel.org/git/xmqq1q7fa6u7.fsf@gitster.g/
[3] https://lore.kernel.org/git/713c28cfc9dff2d01159105ddd2fd0f5@manjaro.org/
[4] https://lore.kernel.org/git/xmqq8r1rs39g.fsf@gitster.g/
[5] https://lore.kernel.org/git/xmqqzfu8yc40.fsf@gitster.g/
[6] https://lore.kernel.org/git/xmqqy19tylrm.fsf@gitster.g/
[7] https://lore.kernel.org/git/6ee28707b9eb8bd8fdfc8756c351455c6bc3bb62.1711447365.git.dsimic@manjaro.org/

Dragan Simic (2):
  send-email: move newline characters out of a few translatable strings
  send-email: make it easy to discern the messages for each patch

 git-send-email.perl   | 19 ++++++++++++-------
 t/t9001-send-email.sh | 10 ++++++++++
 2 files changed, 22 insertions(+), 7 deletions(-)

Range-diff against v5:
1:  d2d456edcb5b ! 1:  29ea3a9b07bf send-email: move newline character out of a translatable string
    @@ Metadata
     Author: Dragan Simic <dsimic@manjaro.org>
     
      ## Commit message ##
    -    send-email: move newline character out of a translatable string
    +    send-email: move newline characters out of a few translatable strings
     
    -    Move the already existing newline character out of a translatable string,
    -    to help a bit with the translation efforts.
    +    Move the already existing newline characters out of a few translatable
    +    strings, to help a bit with the translation efforts.
     
         Signed-off-by: Dragan Simic <dsimic@manjaro.org>
     
      ## git-send-email.perl ##
    +@@ git-send-email.perl: sub send_message {
    + 		$smtp->code =~ /250|200/ or die sprintf(__("Failed to send %s\n"), $subject).$smtp->message;
    + 	}
    + 	if ($quiet) {
    +-		printf($dry_run ? __("Dry-Sent %s\n") : __("Sent %s\n"), $subject);
    ++		printf($dry_run ? __("Dry-Sent %s") : __("Sent %s"), $subject);
    ++		print "\n";
    + 	} else {
    +-		print($dry_run ? __("Dry-OK. Log says:\n") : __("OK. Log says:\n"));
    ++		print($dry_run ? __("Dry-OK. Log says:") : __("OK. Log says:"));
    ++		print "\n";
    + 		if (!defined $sendmail_cmd && !file_name_is_absolute($smtp_server)) {
    + 			print "Server: $smtp_server\n";
    + 			print "MAIL FROM:<$raw_from>\n";
     @@ git-send-email.perl: sub send_message {
      		print $header, "\n";
      		if ($smtp) {
2:  7f8738308901 ! 2:  c78b043b5a6c send-email: make it easy to discern the messages for each patch
    @@ Metadata
      ## Commit message ##
         send-email: make it easy to discern the messages for each patch
     
    -    When sending multiple patches at once, without prompting the user to confirm
    -    the sending of each patch separately, the displayed result statuses for each
    -    patch become bunched together with the messages produced for the subsequent
    -    patch.  This unnecessarily makes discerning each of the result statuses a bit
    -    difficult, as visible in the sample output excerpt below:
    +    When sending one or multiple patches at once, the displayed result statuses
    +    for each patch and the "Send this email [y/n/a/...]?" confirmation prompts
    +    become bunched together with the messages produced for the subsequent patch,
    +    or with the produced SMTP trace, respectively.
    +
    +    This makes reading the outputs unnecessarily harder, as visible in a couple
    +    of excerpts from a sample output below:
     
             ...
             MIME-Version: 1.0
             Content-Transfer-Encoding: 8bit
     
             Result: 250
             OK. Log says:
    +        Server: smtp.example.com
    +        MAIL FROM:<test@example.com>
             ...
     
    -    As visible in the excerpt above, bunching the "Result: <status-code>" lines
    -    together with the messages produced for the subsequent patch makes the output
    -    unreadable, which actually becomes worse as the number of patches sent at
    -    once increases.  To make the produced outputs more readable, add vertical
    -    whitespace (more precisely, a newline) between the displayed result statuses
    -    and the subsequent messages, as visible in the sample output excerpt below,
    -    produced after the addition of vertical whitespace:
    +        ...
    +        MIME-Version: 1.0
    +        Content-Transfer-Encoding: 8bit
    +
    +        Send this email? ([y]es|[n]o|[e]dit|[q]uit|[a]ll): y
    +        OK. Log says:
    +        Server: smtp.example.com
    +        MAIL FROM:<test@example.com>
    +        ...
    +
    +    As visible in the excerpts above, bunching the "Result: <status-code>" lines
    +    or the "Send this email [y/n/a/...]?" confirmation prompts together with the
    +    other messages makes the outputs a bit unreadable, which actually becomes
    +    worse as the number of patches sent at once increases.
    +
    +    To make the produced outputs more readable, ensure that vertical whitespace
    +    (more precisely, single newlines) exist before the displayed result statuses
    +    and after the confirmation prompts, as visible in the two updated excerpts
    +    from a sample output below:
     
             ...
             MIME-Version: 1.0
             Content-Transfer-Encoding: 8bit
     
             Result: 250
     
             OK. Log says:
    +        Server: smtp.example.com
    +        MAIL FROM:<test@example.com>
    +        ...
    +
             ...
    +        MIME-Version: 1.0
    +        Content-Transfer-Encoding: 8bit
    +
    +        Send this email? ([y]es|[n]o|[e]dit|[q]uit|[a]ll): y
     
    -    These changes don't emit additional vertical whitespace after the result
    -    status produced for the last processed patch, i.e. the vertical whitespace
    -    is treated as a separator between the groups of produced messages, not as
    -    their terminator.  This follows the Git's general approach of not wasting
    -    the vertical screen space whenever reasonably possible.
    +        OK. Log says:
    +        Server: smtp.example.com
    +        MAIL FROM:<test@example.com>
    +        ...
     
         While there, remove a couple of spotted stray newlines in the source code
         and convert one indentation from spaces to tabs, for consistency.
     
    -    The associated test, t9001, requires no updates to cover these changes.
    +    Update the associated test, t9001, by including additional newlines into
    +    the expected outputs of separate tests affected by these changes.
     
         Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Dragan Simic <dsimic@manjaro.org>
     
      ## git-send-email.perl ##
    -@@ git-send-email.perl: sub format_2822_time {
    - my $compose_filename;
    - my $force = 0;
    - my $dump_aliases = 0;
    -+my $needs_separator = 0;
    - 
    - # Variables to prevent short format-patch options from being captured
    - # as abbreviated send-email options
     @@ git-send-email.perl: sub smtp_host_string {
      
      # Returns 1 if authentication succeeded or was not necessary
      # (smtp_user was not specified), and 0 otherwise.
     -
      sub smtp_auth_maybe {
      	if (!defined $smtp_authuser || $auth || (defined $smtp_auth && $smtp_auth eq "none")) {
      		return 1;
    +@@ git-send-email.perl: sub gen_header {
    + sub send_message {
    + 	my ($recipients_ref, $to, $date, $gitversion, $cc, $ccline, $header) = gen_header();
    + 	my @recipients = @$recipients_ref;
    ++	my $confirm_shown = 0;
    + 
    + 	my @sendmail_parameters = ('-i', @recipients);
    + 	my $raw_from = $sender;
     @@ git-send-email.perl: sub send_message {
    - 			exit(0);
      		} elsif (/^a/i) {
      			$confirm = 'never';
    -+			$needs_separator = 1;
      		}
    -+	} else {
    -+		$needs_separator = 1;
    ++		$confirm_shown = 1;
      	}
      
      	unshift (@sendmail_parameters, @smtp_server_options);
     @@ git-send-email.perl: sub send_message {
      		print $sm "$header\n$message";
      		close $sm or die $!;
      	} else {
     -
      		if (!defined $smtp_server) {
      			die __("The required SMTP server is not properly defined.")
      		}
    +@@ git-send-email.perl: sub send_message {
    + 		$smtp->code =~ /250|200/ or die sprintf(__("Failed to send %s\n"), $subject).$smtp->message;
    + 	}
    + 	if ($quiet) {
    ++		print "\n" if ($confirm_shown);
    + 		printf($dry_run ? __("Dry-Sent %s") : __("Sent %s"), $subject);
    + 		print "\n";
    + 	} else {
    ++		print "\n";
    + 		print($dry_run ? __("Dry-OK. Log says:") : __("OK. Log says:"));
    + 		print "\n";
    + 		if (!defined $sendmail_cmd && !file_name_is_absolute($smtp_server)) {
     @@ git-send-email.perl: sub pre_process_file {
      sub process_file {
      	my ($t) = @_;
      
     -        pre_process_file($t, $quiet);
     +	pre_process_file($t, $quiet);
    -+	print "\n" if ($needs_separator);
      
      	my $message_was_sent = send_message();
      	if ($message_was_sent == -1) {
    +
    + ## t/t9001-send-email.sh ##
    +@@ t/t9001-send-email.sh: cat >expected-show-all-headers <<\EOF
    + (mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
    + (mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
    + (mbox) Adding cc: two@example.com from line 'Cc: One <one@example.com>, two@example.com'
    ++
    + Dry-OK. Log says:
    + Server: relay.example.com
    + MAIL FROM:<from@example.com>
    +@@ t/t9001-send-email.sh: cat >expected-suppress-sob <<\EOF
    + (mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
    + (mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
    + (mbox) Adding cc: two@example.com from line 'Cc: One <one@example.com>, two@example.com'
    ++
    + Dry-OK. Log says:
    + Server: relay.example.com
    + MAIL FROM:<from@example.com>
    +@@ t/t9001-send-email.sh: cat >expected-suppress-sob <<\EOF
    + (mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
    + (mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
    + (mbox) Adding cc: two@example.com from line 'Cc: One <one@example.com>, two@example.com'
    ++
    + Dry-OK. Log says:
    + Server: relay.example.com
    + MAIL FROM:<from@example.com>
    +@@ t/t9001-send-email.sh: cat >expected-suppress-cccmd <<\EOF
    + (mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
    + (mbox) Adding cc: two@example.com from line 'Cc: One <one@example.com>, two@example.com'
    + (body) Adding cc: C O Mitter <committer@example.com> from line 'Signed-off-by: C O Mitter <committer@example.com>'
    ++
    + Dry-OK. Log says:
    + Server: relay.example.com
    + MAIL FROM:<from@example.com>
    +@@ t/t9001-send-email.sh: test_expect_success $PREREQ 'sendemail.cccmd' '
    + test_expect_success $PREREQ 'setup expect' '
    + cat >expected-suppress-all <<\EOF
    + 0001-Second.patch
    ++
    + Dry-OK. Log says:
    + Server: relay.example.com
    + MAIL FROM:<from@example.com>
    +@@ t/t9001-send-email.sh: cat >expected-suppress-body <<\EOF
    + (mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
    + (mbox) Adding cc: two@example.com from line 'Cc: One <one@example.com>, two@example.com'
    + (cc-cmd) Adding cc: cc-cmd@example.com from: './cccmd'
    ++
    + Dry-OK. Log says:
    + Server: relay.example.com
    + MAIL FROM:<from@example.com>
    +@@ t/t9001-send-email.sh: cat >expected-suppress-body-cccmd <<\EOF
    + (mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
    + (mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
    + (mbox) Adding cc: two@example.com from line 'Cc: One <one@example.com>, two@example.com'
    ++
    + Dry-OK. Log says:
    + Server: relay.example.com
    + MAIL FROM:<from@example.com>
    +@@ t/t9001-send-email.sh: cat >expected-suppress-sob <<\EOF
    + (mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
    + (mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
    + (mbox) Adding cc: two@example.com from line 'Cc: One <one@example.com>, two@example.com'
    ++
    + Dry-OK. Log says:
    + Server: relay.example.com
    + MAIL FROM:<from@example.com>
    +@@ t/t9001-send-email.sh: cat >expected-suppress-bodycc <<\EOF
    + (mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
    + (mbox) Adding cc: two@example.com from line 'Cc: One <one@example.com>, two@example.com'
    + (body) Adding cc: C O Mitter <committer@example.com> from line 'Signed-off-by: C O Mitter <committer@example.com>'
    ++
    + Dry-OK. Log says:
    + Server: relay.example.com
    + MAIL FROM:<from@example.com>
    +@@ t/t9001-send-email.sh: cat >expected-suppress-cc <<\EOF
    + 0001-Second.patch
    + (mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
    + (body) Adding cc: C O Mitter <committer@example.com> from line 'Signed-off-by: C O Mitter <committer@example.com>'
    ++
    + Dry-OK. Log says:
    + Server: relay.example.com
    + MAIL FROM:<from@example.com>
3:  7b99e5c7c0b0 < -:  ------------ send-email: separate the confirmation prompts from the messages
