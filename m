Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CAD28E6
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 01:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712368116; cv=none; b=jFES4YSERcXXTq1MEd8BfA0dPxHNvzTdEj15qxrXxAaVfoDoPJF/v7Up515M3eDvkbdJG8Tr85MVAUjGDvsgCjrd903CA2yPcfSnAyJuZszLK8euAzowIH8pRX9Ut9r2YfURsed6rliyU4Xtepe13nf525EVVa80j09oSm/oyho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712368116; c=relaxed/simple;
	bh=OP2VE2dXmT5B3oEY3b1vDW7DvKIisajIgmW2cwWh6G8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hwez07reSVEd94yEmQPRBcEP7vv/0TcofUcCvlQ7OWgMJLpkQlCAMfFFi6207dedUEi61MnhlIOsig58FeXaEk2fHo2FIilWHCPHDXhs1u81oulR3ogoropKczOQrPK73hEAPqIQwTxP6PylbsTjNZC3YJb7CK1UlYvAKFC+DnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=EawP584p; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="EawP584p"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712368112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uk146EG2tawEOTh1lRxjdeV+0qMnsVyZHomF9BsinSU=;
	b=EawP584pH2nwcYFZAkgg/heABLGwDepWOhFZ/1keWYeiapTp4hejBFAyP5WWYKe0aRnUnJ
	PWj9jVAJCkVaovT7ylOpWmr74mNka+NI4zzgjFlnEinaW7bwFjpJgENiNqP/MUftd3CdQu
	NE5uZIwUkphC5fMbgLCbYGBUkov1MiLaCf2xC23QubU7bDGMcPTtRv+3StOelMuvujpA72
	l8aPhX+ZOOQWPfFIFbKxx1OYrdcKQ2sHtfWljEf+pPMfjlrhTfgfuJSI0WKj/3KB7WzEOo
	cv2fhO6ELQ+S8Y0Fm3fjDH6dvT+o/YIMnlJHIjfRDOm/POvDBKGbwsrA8iYkDQ==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	code@khaugsbakk.name
Subject: [PATCH v4] send-email: make it easy to discern the messages for each patch
Date: Sat,  6 Apr 2024 03:48:28 +0200
Message-Id: <8a9f4927aab96f2f62e2467e59fb6150d7e931fc.1712367983.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

When sending multiple patches at once, without confirming the sending of each
patch separately, the displayed result statuses of sending each patch become
bunched together with the messages produced for the subsequent patch.  This
unnecessarily makes discerning each of the result statuses a bit difficult,
as visible in the sample output excerpt below:

    ...
    MIME-Version: 1.0
    Content-Transfer-Encoding: 8bit

    Result: 250
    OK. Log says:
    ...

As visible above, bunching the "Result: <status-code>" lines together with
the messages produced for the subsequent patch makes the output unreadable.
Thus, let's add a newline after each displayed result status, except after
the last one, to make the outputs more readable, as visible in the sample
output excerpt below, produced after the addition of vertical whitespace:

    ...
    MIME-Version: 1.0
    Content-Transfer-Encoding: 8bit

    Result: 250

    OK. Log says:
    ...

These changes don't emit additional vertical whitespace after the result
status produced for the last processed patch, i.e. the vertical whitespace
is treated as a separator.  This follows the Git's general approach of not
wasting the vertical screen space whenever possible.

The way the additional vertical separation between the messages produced for
each patch is introduced to the source code also moves the already existing
newline characters out of the couple of translatable strings, which should
help a bit with the translation efforts.

Following the approach of making the produced output more readable, also
emit additional vertical whitespace after the "Send this email [y/n/...]?"
prompt.  The subsequent produced messages were also bunched together with
this prompt, as visible in the excerpt right below, which also contributed
to making the discerning of the produced outputs unnecessarily hard.

    ...
    Send this email? ([y]es|[n]o|[e]dit|[q]uit|[a]ll): y
    OK. Log says:
    ...

While there, remove a couple of spotted stray newlines in the source code
and convert one indentation from spaces to tabs, for consistency.

The associated test, t9001, requires no updates to cover these changes.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---

Notes:
     * send-email: make produced outputs more readable by separating
       the result statuses and the prompts from the subsequent outputs
    
    Changes in v4:
        - Dropped the changes to the styling of the produced prompts, as
          reasonably requested by Junio, [1] because it extended the scope
          of the patch with no good reason, and may also create issues on
          some platforms, whose Perl packages may actually not support the
          "->ornaments()" feature of Term::ReadLine
        - Updated the patch description and the "what's cooking" summary
          to cover the changes
    
    Changes in v3:
        - Removed a redundant comment, as suggested by Junio [2]
        - Did the right thing and made the vertical separators emitted as
          message separators, instead of having them emitted as message
          terminators, as suggested by Junio [2]
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
          the source code, as suggested by Junio, [3], to help a bit with
          the translation efforts
        - Improved the patch subject and description a bit, to provide some
          additional information, as suggested by Junio [3]
        - Added a Helped-by tag
    
    Notes for v1:
        - This is a resubmission of the patch I submitted about a week and
          a half ago; [4]  the patch subject in the original submission was
          selected in a bit unfortunate way, which this submission corrects,
          and also improves the patch description a bit
        - There are no changes to the patch itself, vs. the original patch
    
    Link to v1: https://lore.kernel.org/git/62553db377c28458883b66bcdc0c58cc0f32d15b.1712250366.git.dsimic@manjaro.org/T/#u
    Link to v2: https://lore.kernel.org/git/0e087ed992def0746f3d437253248904c2126464.1712262791.git.dsimic@manjaro.org/T/#u
    Link to v3: https://lore.kernel.org/git/e3212c0a4ad331685c68c13afcdbced20982ab32.1712364420.git.dsimic@manjaro.org/T/#u
    
    [1] https://lore.kernel.org/git/xmqq8r1rs39g.fsf@gitster.g/
    [2] https://lore.kernel.org/git/xmqqzfu8yc40.fsf@gitster.g/
    [3] https://lore.kernel.org/git/xmqqy19tylrm.fsf@gitster.g/
    [4] https://lore.kernel.org/git/6ee28707b9eb8bd8fdfc8756c351455c6bc3bb62.1711447365.git.dsimic@manjaro.org/

Range-diff against v3:
1:  21168cead42a ! 1:  8a9f4927aab9 send-email: make it easy to discern the messages for each patch
    @@ Commit message
             OK. Log says:
             ...
     
    -    As the final touch, make the above-mentioned prompt emitted without using
    -    underlined text, which also applies to any other produced prompts, which made
    -    them somewhat hard on the eyes, especially because the prompt's tailing space
    -    character was also underlined.
    -
         While there, remove a couple of spotted stray newlines in the source code
         and convert one indentation from spaces to tabs, for consistency.
     
         The associated test, t9001, requires no updates to cover these changes.
     
         Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Dragan Simic <dsimic@manjaro.org>
     
     
      ## Notes ##
          * send-email: make produced outputs more readable by separating
    -       the result statuses and the prompts from the subsequent patch
    -       outputs, and by no longer using underlined text for the prompts
    +       the result statuses and the prompts from the subsequent outputs
    +
    +    Changes in v4:
    +        - Dropped the changes to the styling of the produced prompts, as
    +          reasonably requested by Junio, [1] because it extended the scope
    +          of the patch with no good reason, and may also create issues on
    +          some platforms, whose Perl packages may actually not support the
    +          "->ornaments()" feature of Term::ReadLine
    +        - Updated the patch description and the "what's cooking" summary
    +          to cover the changes
     
         Changes in v3:
    -        - Removed a redundant comment, as suggested by Junio [1]
    +        - Removed a redundant comment, as suggested by Junio [2]
             - Did the right thing and made the vertical separators emitted as
               message separators, instead of having them emitted as message
    -          terminators, as suggested by Junio [1]
    +          terminators, as suggested by Junio [2]
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
    -          the source code, as suggested by Junio, [2], to help a bit with
    +          the source code, as suggested by Junio, [3], to help a bit with
               the translation efforts
             - Improved the patch subject and description a bit, to provide some
    -          additional information, as suggested by Junio [2]
    +          additional information, as suggested by Junio [3]
             - Added a Helped-by tag
     
         Notes for v1:
             - This is a resubmission of the patch I submitted about a week and
    -          a half ago; [3]  the patch subject in the original submission was
    +          a half ago; [4]  the patch subject in the original submission was
               selected in a bit unfortunate way, which this submission corrects,
               and also improves the patch description a bit
             - There are no changes to the patch itself, vs. the original patch
     
         Link to v1: https://lore.kernel.org/git/62553db377c28458883b66bcdc0c58cc0f32d15b.1712250366.git.dsimic@manjaro.org/T/#u
         Link to v2: https://lore.kernel.org/git/0e087ed992def0746f3d437253248904c2126464.1712262791.git.dsimic@manjaro.org/T/#u
    +    Link to v3: https://lore.kernel.org/git/e3212c0a4ad331685c68c13afcdbced20982ab32.1712364420.git.dsimic@manjaro.org/T/#u
     
    -    [1] https://lore.kernel.org/git/xmqqzfu8yc40.fsf@gitster.g/
    -    [2] https://lore.kernel.org/git/xmqqy19tylrm.fsf@gitster.g/
    -    [3] https://lore.kernel.org/git/6ee28707b9eb8bd8fdfc8756c351455c6bc3bb62.1711447365.git.dsimic@manjaro.org/
    +    [1] https://lore.kernel.org/git/xmqq8r1rs39g.fsf@gitster.g/
    +    [2] https://lore.kernel.org/git/xmqqzfu8yc40.fsf@gitster.g/
    +    [3] https://lore.kernel.org/git/xmqqy19tylrm.fsf@gitster.g/
    +    [4] https://lore.kernel.org/git/6ee28707b9eb8bd8fdfc8756c351455c6bc3bb62.1711447365.git.dsimic@manjaro.org/
     
      ## git-send-email.perl ##
     @@ git-send-email.perl: sub format_2822_time {
      my $compose_filename;
      my $force = 0;
      my $dump_aliases = 0;
     +my $needs_separator = 0;
      
      # Variables to prevent short format-patch options from being captured
      # as abbreviated send-email options
    -@@ git-send-email.perl: sub get_patch_subject {
    - 			$term = $ENV{"GIT_SEND_EMAIL_NOTTY"}
    - 				? Term::ReadLine->new('git-send-email', \*STDIN, \*STDOUT)
    - 				: Term::ReadLine->new('git-send-email');
    -+			$term->ornaments(0);
    - 		}
    - 		return $term;
    - 	}
     @@ git-send-email.perl: sub smtp_host_string {
      
      # Returns 1 if authentication succeeded or was not necessary

 git-send-email.perl | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 821b2b3a135a..a09bc7fd6b96 100755
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
@@ -1510,6 +1510,7 @@ sub gen_header {
 sub send_message {
 	my ($recipients_ref, $to, $date, $gitversion, $cc, $ccline, $header) = gen_header();
 	my @recipients = @$recipients_ref;
+	my $prompt_separator = 0;
 
 	my @sendmail_parameters = ('-i', @recipients);
 	my $raw_from = $sender;
@@ -1554,7 +1555,11 @@ sub send_message {
 			exit(0);
 		} elsif (/^a/i) {
 			$confirm = 'never';
+			$needs_separator = 1;
 		}
+		$prompt_separator = 1;
+	} else {
+		$needs_separator = 1;
 	}
 
 	unshift (@sendmail_parameters, @smtp_server_options);
@@ -1576,7 +1581,6 @@ sub send_message {
 		print $sm "$header\n$message";
 		close $sm or die $!;
 	} else {
-
 		if (!defined $smtp_server) {
 			die __("The required SMTP server is not properly defined.")
 		}
@@ -1663,6 +1667,7 @@ sub send_message {
 		$smtp->dataend() or die $smtp->message;
 		$smtp->code =~ /250|200/ or die sprintf(__("Failed to send %s\n"), $subject).$smtp->message;
 	}
+	print "\n" if ($prompt_separator);
 	if ($quiet) {
 		printf($dry_run ? __("Dry-Sent %s\n") : __("Sent %s\n"), $subject);
 	} else {
@@ -1686,10 +1691,11 @@ sub send_message {
 		print $header, "\n";
 		if ($smtp) {
 			print __("Result: "), $smtp->code, ' ',
-				($smtp->message =~ /\n([^\n]+\n)$/s), "\n";
+				($smtp->message =~ /\n([^\n]+\n)$/s);
 		} else {
-			print __("Result: OK\n");
+			print __("Result: OK");
 		}
+		print "\n";
 	}
 
 	return 1;
@@ -1920,7 +1926,8 @@ sub pre_process_file {
 sub process_file {
 	my ($t) = @_;
 
-        pre_process_file($t, $quiet);
+	pre_process_file($t, $quiet);
+	print "\n" if ($needs_separator);
 
 	my $message_was_sent = send_message();
 	if ($message_was_sent == -1) {
