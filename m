Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAFE156EE
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 10:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE9410D4
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 03:13:12 -0700 (PDT)
Received: (qmail 15405 invoked by uid 109); 20 Oct 2023 10:13:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Oct 2023 10:13:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12720 invoked by uid 111); 20 Oct 2023 10:13:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Oct 2023 06:13:16 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 20 Oct 2023 06:13:10 -0400
From: Jeff King <peff@peff.net>
To: Michael Strawbridge <michael.strawbridge@amd.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 2/3] Revert "send-email: extract email-parsing code into a
 subroutine"
Message-ID: <20231020101310.GB2673716@coredump.intra.peff.net>
References: <20231020100343.GA2194322@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231020100343.GA2194322@coredump.intra.peff.net>

This reverts commit b6049542b97e7b135e0e82bf996084d461224d32.

Prior to that commit, we read the results of the user editing the
"--compose" message in a loop, picking out parts we cared about, and
streaming the result out to a ".final" file. That commit split the
reading/interpreting into two phases; we'd now read into a hash, and
then pick things out of the hash.

The goal was making the code more readable. And in some ways it did,
because the ugly regexes are confined to the reading phase. But it also
introduced several bugs, because now the two phases need to match each
other. In particular:

  - we pick out headers like "Subject: foo" with a case-insensitive
    regex, and then use the user-provided header name as the key in a
    case-sensitive hash. So if the user wrote "subject: foo", we'd no
    longer recognize it as a subject.

  - the namespace for the hash keys conflates header names with meta
    information like "body". If you put "body: foo" in your message, it
    would be misinterpreted as the actual message body (nobody is likely
    to do that in practice, but it seems like an unnecessary danger).

  - the handling for to/cc/bcc is totally broken. The behavior before
    that commit is to recognize and skip those headers, with a note to
    the user that they are not yet handled. Not great, but OK. But
    after the patch, the reading side now splits the addresses into a
    perl array-ref. But the interpreting side doesn't handle this at
    all, and blindly prints the stringified array-ref value. This leads
    to garbage like:

      (mbox) Adding to: ARRAY (0x555b4345c428) from line 'To: ARRAY(0x555b4345c428)'
      error: unable to extract a valid address from: ARRAY (0x555b4345c428)
      What to do with this address? ([q]uit|[d]rop|[e]dit):

    Probably not a huge deal, since nobody should even try to use those
    headers in the first place (since they were not implemented). But
    the new behavior is worse, and indicative of the sorts of problems
    that come from having the two layers.

The revert had a few conflicts, due to later work in this area from
15dc3b9161 (send-email: rename variable for clarity, 2018-03-04) and
d11c943c78 (send-email: support separate Reply-To address, 2018-03-04).
I've ported the changes from those commits over as part of the conflict
resolution.

The new tests show the bugs. Note the use of GIT_SEND_EMAIL_NOTTY in the
second one. Without it, the test is happy to reach outside the test
harness to the developer's actual terminal (when run with the buggy
state before this patch).

Signed-off-by: Jeff King <peff@peff.net>
---
I guess "readable" is up for debate here, but I find the inline handling
a lot easier to follow (and it's half as many lines; most of the
diffstat is the new tests).

But one thing that gives me pause is that the neither before or after
this patch do we handle continuation lines like:

  Subject: this is the beginning
    and this is more subject

And it would probably be a lot easier to add when storing the headers in
a hash (it's not impossible to do it the other way, but you basically
have to delay processing each line with a small state machine).

So another option is to just fix the individual bugs separately.

 git-send-email.perl   | 120 ++++++++++++++----------------------------
 t/t9001-send-email.sh |  35 ++++++++++++
 2 files changed, 75 insertions(+), 80 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 288ea1ae80..bbda2a931b 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -888,73 +888,59 @@ sub get_patch_subject {
 		do_edit($compose_filename);
 	}
 
+	open my $c2, ">", $compose_filename . ".final"
+		or die sprintf(__("Failed to open %s.final: %s"), $compose_filename, $!);
+
 	open $c, "<", $compose_filename
 		or die sprintf(__("Failed to open %s: %s"), $compose_filename, $!);
 
+	my $need_8bit_cte = file_has_nonascii($compose_filename);
+	my $in_body = 0;
+	my $summary_empty = 1;
 	if (!defined $compose_encoding) {
 		$compose_encoding = "UTF-8";
 	}
-
-	my %parsed_email;
-	while (my $line = <$c>) {
-		next if $line =~ m/^GIT:/;
-		parse_header_line($line, \%parsed_email);
-		if ($line =~ /^$/) {
-			$parsed_email{'body'} = filter_body($c);
+	while(<$c>) {
+		next if m/^GIT:/;
+		if ($in_body) {
+			$summary_empty = 0 unless (/^\n$/);
+		} elsif (/^\n$/) {
+			$in_body = 1;
+			if ($need_8bit_cte) {
+				print $c2 "MIME-Version: 1.0\n",
+					 "Content-Type: text/plain; ",
+					   "charset=$compose_encoding\n",
+					 "Content-Transfer-Encoding: 8bit\n";
+			}
+		} elsif (/^MIME-Version:/i) {
+			$need_8bit_cte = 0;
+		} elsif (/^Subject:\s*(.+)\s*$/i) {
+			$initial_subject = $1;
+			my $subject = $initial_subject;
+			$_ = "Subject: " .
+				quote_subject($subject, $compose_encoding) .
+				"\n";
+		} elsif (/^In-Reply-To:\s*(.+)\s*$/i) {
+			$initial_in_reply_to = $1;
+			next;
+		} elsif (/^Reply-To:\s*(.+)\s*$/i) {
+			$reply_to = $1;
+		} elsif (/^From:\s*(.+)\s*$/i) {
+			$sender = $1;
+			next;
+		} elsif (/^(?:To|Cc|Bcc):/i) {
+			print __("To/Cc/Bcc fields are not interpreted yet, they have been ignored\n");
+			next;
 		}
+		print $c2 $_;
 	}
 	close $c;
+	close $c2;
 
-	open my $c2, ">", $compose_filename . ".final"
-	or die sprintf(__("Failed to open %s.final: %s"), $compose_filename, $!);
-
-
-	if ($parsed_email{'From'}) {
-		$sender = delete($parsed_email{'From'});
-	}
-	if ($parsed_email{'In-Reply-To'}) {
-		$initial_in_reply_to = delete($parsed_email{'In-Reply-To'});
-	}
-	if ($parsed_email{'Reply-To'}) {
-		$reply_to = delete($parsed_email{'Reply-To'});
-	}
-	if ($parsed_email{'Subject'}) {
-		$initial_subject = delete($parsed_email{'Subject'});
-		print $c2 "Subject: " .
-			quote_subject($initial_subject, $compose_encoding) .
-			"\n";
-	}
-
-	if ($parsed_email{'MIME-Version'}) {
-		print $c2 "MIME-Version: $parsed_email{'MIME-Version'}\n",
-				"Content-Type: $parsed_email{'Content-Type'};\n",
-				"Content-Transfer-Encoding: $parsed_email{'Content-Transfer-Encoding'}\n";
-		delete($parsed_email{'MIME-Version'});
-		delete($parsed_email{'Content-Type'});
-		delete($parsed_email{'Content-Transfer-Encoding'});
-	} elsif (file_has_nonascii($compose_filename)) {
-		my $content_type = (delete($parsed_email{'Content-Type'}) or
-			"text/plain; charset=$compose_encoding");
-		print $c2 "MIME-Version: 1.0\n",
-			"Content-Type: $content_type\n",
-			"Content-Transfer-Encoding: 8bit\n";
-	}
-	# Preserve unknown headers
-	foreach my $key (keys %parsed_email) {
-		next if $key eq 'body';
-		print $c2 "$key: $parsed_email{$key}";
-	}
-
-	if ($parsed_email{'body'}) {
-		print $c2 "\n$parsed_email{'body'}\n";
-		delete($parsed_email{'body'});
-	} else {
+	if ($summary_empty) {
 		print __("Summary email is empty, skipping it\n");
 		$compose = -1;
 	}
-
-	close $c2;
-
 } elsif ($annotate) {
 	do_edit(@files);
 }
@@ -1009,32 +995,6 @@ sub ask {
 	return;
 }
 
-sub parse_header_line {
-	my $lines = shift;
-	my $parsed_line = shift;
-	my $addr_pat = join "|", qw(To Cc Bcc);
-
-	foreach (split(/\n/, $lines)) {
-		if (/^($addr_pat):\s*(.+)$/i) {
-		        $parsed_line->{$1} = [ parse_address_line($2) ];
-		} elsif (/^([^:]*):\s*(.+)\s*$/i) {
-		        $parsed_line->{$1} = $2;
-		}
-	}
-}
-
-sub filter_body {
-	my $c = shift;
-	my $body = "";
-	while (my $body_line = <$c>) {
-		if ($body_line !~ m/^GIT:/) {
-			$body .= $body_line;
-		}
-	}
-	return $body;
-}
-
-
 my %broken_encoding;
 
 sub file_declares_8bit_cte {
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 263db3ad17..9644ff5793 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -2505,4 +2505,39 @@ test_expect_success $PREREQ 'test forbidSendmailVariables behavior override' '
 		HEAD^
 '
 
+test_expect_success $PREREQ '--compose handles lowercase headers' '
+	write_script fake-editor <<-\EOF &&
+	sed "s/^From:.*/from: edited-from@example.com/i" "$1" >"$1.tmp" &&
+	mv "$1.tmp" "$1"
+	EOF
+	clean_fake_sendmail &&
+	git send-email \
+		--compose \
+		--from="Example <from@example.com>" \
+		--to=nobody@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		HEAD^ &&
+	grep "From: edited-from@example.com" msgtxt1
+'
+
+test_expect_success $PREREQ '--compose handles to headers' '
+	write_script fake-editor <<-\EOF &&
+	sed "s/^$/To: edited-to@example.com\n/" <"$1" >"$1.tmp" &&
+	echo this is the body >>"$1.tmp" &&
+	mv "$1.tmp" "$1"
+	EOF
+	clean_fake_sendmail &&
+	GIT_SEND_EMAIL_NOTTY=1 \
+	git send-email \
+		--compose \
+		--from="Example <from@example.com>" \
+		--to=nobody@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		HEAD^ &&
+	# Ideally the "to" header we specified would be used,
+	# but the program explicitly warns that these are
+	# ignored. For now, just make sure we did not abort.
+	grep "To:" msgtxt1
+'
+
 test_done
-- 
2.42.0.980.g8b5f6199be

