Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D6C61F406
	for <e@80x24.org>; Sat,  9 Dec 2017 15:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750931AbdLIPhw (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Dec 2017 10:37:52 -0500
Received: from cisrsmtp.univ-lyon1.fr ([134.214.188.146]:59744 "EHLO
        cisrsmtp.univ-lyon1.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750908AbdLIPhv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Dec 2017 10:37:51 -0500
Received: from localhost (localhost [127.0.0.1])
        by cisrsmtp.univ-lyon1.fr (Postfix) with ESMTP id 5DDCAA013F;
        Sat,  9 Dec 2017 16:37:49 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at cisrsmtp.univ-lyon1.fr
Received: from cisrsmtp.univ-lyon1.fr ([127.0.0.1])
        by localhost (cisrsmtp.univ-lyon1.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5RsaZ0QM1dA3; Sat,  9 Dec 2017 16:37:47 +0100 (CET)
Received: from BEMBX2013-01.univ-lyon1.fr (bembx2013-01.univ-lyon1.fr [134.214.201.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by cisrsmtp.univ-lyon1.fr (Postfix) with ESMTPS id 9B239A002A;
        Sat,  9 Dec 2017 16:37:47 +0100 (CET)
Received: from localhost.localdomain (134.214.126.172) by
 BEMBX2013-01.univ-lyon1.fr (134.214.201.247) with Microsoft SMTP Server (TLS)
 id 15.0.1263.5; Sat, 9 Dec 2017 16:37:46 +0100
From:   Nathan Payre <nathan.payre@etu.univ-lyon1.fr>
To:     <git@vger.kernel.org>
CC:     Eric Sunshine <sunshine@sunshineco.com>,
        Nathan Payre <nathan.payre@etu.univ-lyon1.fr>,
        Matthieu Moy <matthieu.moy@univ-lyon1.fr>,
        Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>,
        Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] send-email: extract email-parsing code into a subroutine
Date:   Sat, 9 Dec 2017 16:37:27 +0100
Message-ID: <20171209153727.30113-1-nathan.payre@etu.univ-lyon1.fr>
X-Mailer: git-send-email 2.15.0.318.g7c8d76e5a.dirty
In-Reply-To: <CAGb4CBWZciqxdfpSkK1vezhiuSYX5Yy-xSq=Uj4h+vhRo9uyoQ@mail.gmail.com>
References: <CAGb4CBWZciqxdfpSkK1vezhiuSYX5Yy-xSq=Uj4h+vhRo9uyoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [134.214.126.172]
X-ClientProxiedBy: BEMBX2013-02.univ-lyon1.fr (134.214.201.248) To
 BEMBX2013-01.univ-lyon1.fr (134.214.201.247)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The existing code mixes parsing of email header with regular
expression and actual code. Extract the parsing code into a new
subroutine "parse_header_line()". This improves the code readability
and make parse_header_line reusable in other place.

"parsed_header_line()" and "filter_body()" could be used for
refactoring the part of code which parses the header to prepare the
email and send it.

Signed-off-by: Nathan Payre <nathan.payre@etu.univ-lyon1.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@univ-lyon1.fr>
Signed-off-by: Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>
Signed-off-by: Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Thanks-to: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

I fixed the last reported problems and removed some other old
variable as $need_8bit_cte.

 git-send-email.perl | 110 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 73 insertions(+), 37 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 2208dcc21..ac36c6aac 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -685,7 +685,7 @@ Lines beginning in "GIT:" will be removed.
 Consider including an overall diffstat or table of contents
 for the patch you are writing.
 
-Clear the body content if you don't wish to send a summary.
+Clear the body content if you dont wish to send a summary.
 EOT2
 From: $tpl_sender
 Subject: $tpl_subject
@@ -709,51 +709,61 @@ EOT3
 	open $c, "<", $compose_filename
 		or die sprintf(__("Failed to open %s: %s"), $compose_filename, $!);
 
-	my $need_8bit_cte = file_has_nonascii($compose_filename);
-	my $in_body = 0;
-	my $summary_empty = 1;
 	if (!defined $compose_encoding) {
 		$compose_encoding = "UTF-8";
 	}
-	while(<$c>) {
-		next if m/^GIT:/;
-		if ($in_body) {
-			$summary_empty = 0 unless (/^\n$/);
-		} elsif (/^\n$/) {
-			$in_body = 1;
-			if ($need_8bit_cte) {
-				print $c2 "MIME-Version: 1.0\n",
-					 "Content-Type: text/plain; ",
-					   "charset=$compose_encoding\n",
-					 "Content-Transfer-Encoding: 8bit\n";
-			}
-		} elsif (/^MIME-Version:/i) {
-			$need_8bit_cte = 0;
-		} elsif (/^Subject:\s*(.+)\s*$/i) {
-			$initial_subject = $1;
-			my $subject = $initial_subject;
-			$_ = "Subject: " .
-				quote_subject($subject, $compose_encoding) .
-				"\n";
-		} elsif (/^In-Reply-To:\s*(.+)\s*$/i) {
-			$initial_reply_to = $1;
-			next;
-		} elsif (/^From:\s*(.+)\s*$/i) {
-			$sender = $1;
-			next;
-		} elsif (/^(?:To|Cc|Bcc):/i) {
-			print __("To/Cc/Bcc fields are not interpreted yet, they have been ignored\n");
-			next;
+
+
+	my %parsed_email;
+	$parsed_email{'body'} = '';
+	while (my $line = <$c>) {
+		next if $line =~ m/^GIT:/;
+		parse_header_line($line, \%parsed_email);
+		if ($line =~ /^$/) {
+			$parsed_email{'body'} = filter_body($c);
 		}
-		print $c2 $_;
 	}
-	close $c;
-	close $c2;
 
-	if ($summary_empty) {
+	if ($parsed_email{'from'}) {
+		$sender = $parsed_email{'from'};
+	}
+	if ($parsed_email{'in-reply-to'}) {
+		$initial_reply_to = $parsed_email{'in-reply-to'};
+	}
+	if ($parsed_email{'subject'}) {
+		$initial_subject = $parsed_email{'subject'};
+		print $c2 "Subject: " .
+			quote_subject($parsed_email{'subject'}, $compose_encoding) .
+			"\n";
+	}
+	if ($parsed_email{'mime-version'}) {
+		print $c2 "MIME-Version: $parsed_email{'mime-version'}\n",
+				"Content-Type: $parsed_email{'content-type'};\n",
+				"Content-Transfer-Encoding: $parsed_email{'content-transfer-encoding'}\n";
+	}
+
+	if ($parsed_email{'content-type'}) {
+		print $c2 "MIME-Version: 1.0\n",
+			 "Content-Type: $parsed_email{'content-type'};\n",
+			 "Content-Transfer-Encoding: 8bit\n";
+	} elsif (file_has_nonascii($compose_filename)) {
+                my $content_type = ($parsed_email{'content-type'} or
+                        "text/plain; charset=$compose_encoding");
+                print $c2 "MIME-Version: 1.0\n",
+                          "Content-Type: $content_type\n",
+                          "Content-Transfer-Encoding: 8bit\n";
+        }
+
+	if ($parsed_email{'body'}) {
+		print $c2 "\n$parsed_email{'body'}\n";
+	} else {
 		print __("Summary email is empty, skipping it\n");
 		$compose = -1;
 	}
+
+	close $c;
+	close $c2;
+
 } elsif ($annotate) {
 	do_edit(@files);
 }
@@ -792,6 +802,32 @@ sub ask {
 	return;
 }
 
+sub parse_header_line {
+	my $lines = shift;
+	my $parsed_line = shift;
+	my $pattern = join "|", qw(To Cc Bcc);
+	
+	foreach (split(/\n/, $lines)) {
+		if (/^($pattern):\s*(.+)$/i) {
+		        $parsed_line->{lc $1} = [ parse_address_line($2) ];
+		} elsif (/^([^:]*):\s*(.+)\s*$/i) {
+		        $parsed_line->{lc $1} = $2;
+		}
+	}
+}
+
+sub filter_body {
+	my $c = shift;
+	my $body = "";
+	while (my $body_line = <$c>) {
+		if ($body_line !~ m/^GIT:/) {
+			$body .= $body_line;
+		}
+	}
+	return $body;
+}
+
+
 my %broken_encoding;
 
 sub file_declares_8bit_cte {
-- 
2.15.1

