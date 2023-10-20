Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106F015E9A
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 10:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44604B6
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 03:15:26 -0700 (PDT)
Received: (qmail 15433 invoked by uid 109); 20 Oct 2023 10:15:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Oct 2023 10:15:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12759 invoked by uid 111); 20 Oct 2023 10:15:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Oct 2023 06:15:30 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 20 Oct 2023 06:15:24 -0400
From: Jeff King <peff@peff.net>
To: Michael Strawbridge <michael.strawbridge@amd.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 3/3] send-email: handle to/cc/bcc from --compose message
Message-ID: <20231020101524.GA2673857@coredump.intra.peff.net>
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

If the user writes a message via --compose, send-email will pick up
varius headers like "From", "Subject", etc and use them for other
patches as if they were specified on the command-line. But we don't
handle "To", "Cc", or "Bcc" this way; we just tell the user "those
aren't interpeted yet" and ignore them.

But it seems like an obvious thing to want, especially as the same
feature exists when the cover letter is generated separately by
format-patch. There it is gated behind the --to-cover option, but I
don't think we'd need the same control here; since we generate the
--compose template ourselves based on the existing input, if the user
leaves the lines unchanged then the behavior remains the same.

So let's fill in the implementation; like those other headers we already
handle, we just need to assign to the initial_* variables. The only
difference in this case is that they are arrays, so we'll feed them
through parse_address_line() to split them (just like we would when
reading a single string via prompting).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-send-email.txt | 11 ++++++-----
 git-send-email.perl              | 16 ++++++++++++++--
 t/t9001-send-email.sh            | 16 +++++++++++-----
 3 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 021276329c..f4d7166275 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -68,11 +68,12 @@ This option may be specified multiple times.
 	Invoke a text editor (see GIT_EDITOR in linkgit:git-var[1])
 	to edit an introductory message for the patch series.
 +
-When `--compose` is used, git send-email will use the From, Subject,
-Reply-To, and In-Reply-To headers specified in the message. If the body
-of the message (what you type after the headers and a blank line) only
-contains blank (or Git: prefixed) lines, the summary won't be sent, but
-the headers mentioned above will be used unless they are removed.
+When `--compose` is used, git send-email will use the From, To, Cc, Bcc,
+Subject, Reply-To, and In-Reply-To headers specified in the message. If
+the body of the message (what you type after the headers and a blank
+line) only contains blank (or Git: prefixed) lines, the summary won't be
+sent, but the headers mentioned above will be used unless they are
+removed.
 +
 Missing From or In-Reply-To headers will be prompted for.
 +
diff --git a/git-send-email.perl b/git-send-email.perl
index bbda2a931b..9e21b0b3f4 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -861,6 +861,9 @@ sub get_patch_subject {
 	my $tpl_subject = $initial_subject || '';
 	my $tpl_in_reply_to = $initial_in_reply_to || '';
 	my $tpl_reply_to = $reply_to || '';
+	my $tpl_to = join(',', @initial_to);
+	my $tpl_cc = join(',', @initial_cc);
+	my $tpl_bcc = join(', ', @initial_bcc);
 
 	print $c <<EOT1, Git::prefix_lines("GIT: ", __(<<EOT2)), <<EOT3;
 From $tpl_sender # This line is ignored.
@@ -872,6 +875,9 @@ sub get_patch_subject {
 Clear the body content if you don't wish to send a summary.
 EOT2
 From: $tpl_sender
+To: $tpl_to
+Cc: $tpl_cc
+Bcc: $tpl_bcc
 Reply-To: $tpl_reply_to
 Subject: $tpl_subject
 In-Reply-To: $tpl_in_reply_to
@@ -928,8 +934,14 @@ sub get_patch_subject {
 		} elsif (/^From:\s*(.+)\s*$/i) {
 			$sender = $1;
 			next;
-		} elsif (/^(?:To|Cc|Bcc):/i) {
-			print __("To/Cc/Bcc fields are not interpreted yet, they have been ignored\n");
+		} elsif (/^To:\s*(.+)\s*$/i) {
+			@initial_to = parse_address_line($1);
+			next;
+		} elsif (/^Cc:\s*(.+)\s*$/i) {
+			@initial_cc = parse_address_line($1);
+			next;
+		} elsif (/^Bcc:/i) {
+			@initial_bcc = parse_address_line($1);
 			next;
 		}
 		print $c2 $_;
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 9644ff5793..2e8e8137fb 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -2522,7 +2522,7 @@ test_expect_success $PREREQ '--compose handles lowercase headers' '
 
 test_expect_success $PREREQ '--compose handles to headers' '
 	write_script fake-editor <<-\EOF &&
-	sed "s/^$/To: edited-to@example.com\n/" <"$1" >"$1.tmp" &&
+	sed "s/^To: .*/&, edited-to@example.com/" <"$1" >"$1.tmp" &&
 	echo this is the body >>"$1.tmp" &&
 	mv "$1.tmp" "$1"
 	EOF
@@ -2534,10 +2534,16 @@ test_expect_success $PREREQ '--compose handles to headers' '
 		--to=nobody@example.com \
 		--smtp-server="$(pwd)/fake.sendmail" \
 		HEAD^ &&
-	# Ideally the "to" header we specified would be used,
-	# but the program explicitly warns that these are
-	# ignored. For now, just make sure we did not abort.
-	grep "To:" msgtxt1
+	# Check both that the cover letter used our modified "to" line,
+	# but also that it was picked up for the patch.
+	q_to_tab >expect <<-\EOF &&
+	To: nobody@example.com,
+	Qedited-to@example.com
+	EOF
+	grep -A1 "^To:" msgtxt1 >msgtxt1.to &&
+	test_cmp expect msgtxt1.to &&
+	grep -A1 "^To:" msgtxt2 >msgtxt2.to &&
+	test_cmp expect msgtxt2.to
 '
 
 test_done
-- 
2.42.0.980.g8b5f6199be
