From: Samuel GROOT <samuel.groot@grenoble-inp.org>
Subject: [WIP-PATCH 1/2] send-email: create email parser subroutine
Date: Fri, 27 May 2016 16:01:03 +0200
Message-ID: <20160527140104.11192-2-samuel.groot@grenoble-inp.org>
References: <20160527140104.11192-1-samuel.groot@grenoble-inp.org>
Cc: e@80x24.org, erwan.mathoniere@grenoble-inp.org,
	jordan.de-gea@grenoble-inp.org, matthieu.moy@grenoble-inp.fr,
	gitster@pobox.com, aaron@schrab.com,
	Samuel GROOT <samuel.groot@grenoble-inp.org>,
	Tom RUSSELLO <tom.russello@grenoble-inp.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 16:01:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6IKD-0005FU-Rc
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 16:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753177AbcE0OBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 10:01:13 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:35754 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbcE0OBM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 10:01:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id DB95D2572;
	Fri, 27 May 2016 16:01:09 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JS6hhTjApVUN; Fri, 27 May 2016 16:01:09 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id C17A7256E;
	Fri, 27 May 2016 16:01:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id BEA9A2077;
	Fri, 27 May 2016 16:01:09 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jB2_TJ7BEuBU; Fri, 27 May 2016 16:01:09 +0200 (CEST)
Received: from wificampus-031045.grenet.fr (wificampus-031045.grenet.fr [130.190.31.45])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 936E42055;
	Fri, 27 May 2016 16:01:09 +0200 (CEST)
X-Mailer: git-send-email 2.8.2.537.gb153d2a
In-Reply-To: <20160527140104.11192-1-samuel.groot@grenoble-inp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295752>

Parsing and processing in send-email is done in the same loop.

To make the code more maintainable, we create two subroutines:
- `parse_email` to separate header and body
- `parse_header` to retrieve data from header

Signed-off-by: Samuel GROOT <samuel.groot@grenoble-inp.org>
Signed-off-by: Tom RUSSELLO <tom.russello@grenoble-inp.org>
Signed-off-by: Matthieu MOY <matthieu.moy@grenoble-inp.fr>
---
 git-send-email.perl | 105 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index 6958785..f33a083 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1750,3 +1750,108 @@ sub body_or_subject_has_nonascii {
 	}
 	return 0;
 }
+
+sub parse_email {
+	my @header = ();
+	my @body = ();
+	my $fh = shift;
+
+	# First unfold multiline header fields
+	while (<$fh>) {
+		last if /^\s*$/;
+		if (/^\s+\S/ and @header) {
+			chomp($header[$#header]);
+			s/^\s+/ /;
+			$header[$#header] .= $_;
+		} else {
+			push(@header, $_);
+		}
+	}
+
+	# Now unfold the message body
+	while (<$fh>) {
+		push @body, $_;
+	}
+
+	return (@header, @body);
+}
+
+sub parse_header {
+	# Return variables
+	my $from = undef, $subject = undef;
+	my $date = undef, $message_id = undef;
+	my @to = (), @cc = (), @xh = ();
+	my %flags = ();
+
+
+	# Internal variables
+	my $input_format = undef;
+
+	foreach(@_) {
+		if (/^From /) {
+			$input_format = 'mbox';
+			next;
+		}
+		chomp;
+		if (!defined $input_format && /^[-A-Za-z]+:\s/) {
+			$input_format = 'mbox';
+		}
+
+		if (defined $input_format && $input_format eq 'mbox') {
+			if (/^Subject:\s+(.*)$/i) {
+				$subject = $1;
+			} elsif (/^From:\s+(.*)$/i) {
+				$from = $1;
+			} elsif (/^To:\s+(.*)$/i) {
+				foreach my $addr (parse_address_line($1)) {
+					push @to, $addr;
+				}
+			} elsif (/^Cc:\s+(.*)$/i) {
+				foreach my $addr (parse_address_line($1)) {
+					push @cc, $addr;
+				}
+			} elsif (/^Content-type:/i) {
+				$flags{"has_content_type"} = 1;
+				if (/charset="?([^ "]+)/) {
+					$flags{"body_encoding"} = 1;
+				}
+				push @xh, $_;
+			} elsif (/^MIME-Version/i) {
+				$flags{"has_mime_version"} = 1;
+				push @xh, $_;
+			} elsif (/^Message-Id: (.*)/i) {
+				$message_id = $1;
+			} elsif (/^Content-Transfer-Encoding: (.*)/i) {
+				$flags{"xfer_encoding"} = $1 if not defined $flags{"xfer_encoding"};
+			} elsif (/^Date:\s(.*)$/i) {
+				$date = $1;
+			} elsif (/^[-A-Za-z]+:\s+\S/) {
+				push @xh, $_;
+			}
+
+		} else {
+			# In the traditional
+			# "send lots of email" format,
+			# line 1 = cc
+			# line 2 = subject
+			# So let's support that, too.
+			$input_format = 'lots';
+			if (@cc == 0) {
+				push @cc, $_;
+			} elsif (!defined $subject) {
+				$subject = $_;
+			}
+		}
+	}
+
+	return (
+		"from" => $from,
+		"subject" => $subject,
+		"date" => $date,
+		"message_id" => $message_id,
+		"to" => [@to],
+		"cc" => [@cc],
+		"xh" => [@xh],
+		"flags" => {%flags}
+	);
+}
-- 
2.8.2.537.gb153d2a
