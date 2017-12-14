Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43F951F406
	for <e@80x24.org>; Thu, 14 Dec 2017 11:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751466AbdLNLNS (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 06:13:18 -0500
Received: from cisrsmtp.univ-lyon1.fr ([134.214.188.146]:45303 "EHLO
        cisrsmtp.univ-lyon1.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751164AbdLNLNS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 06:13:18 -0500
Received: from localhost (localhost [127.0.0.1])
        by cisrsmtp.univ-lyon1.fr (Postfix) with ESMTP id E9CB5A01C4;
        Thu, 14 Dec 2017 12:13:16 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at cisrsmtp.univ-lyon1.fr
Received: from cisrsmtp.univ-lyon1.fr ([127.0.0.1])
        by localhost (cisrsmtp.univ-lyon1.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tk37H-vZH_Zd; Thu, 14 Dec 2017 12:13:14 +0100 (CET)
Received: from BEMBX2013-01.univ-lyon1.fr (bembx2013-01.univ-lyon1.fr [134.214.201.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by cisrsmtp.univ-lyon1.fr (Postfix) with ESMTPS id EB942A00DC;
        Thu, 14 Dec 2017 12:13:14 +0100 (CET)
Received: from Laptops-nathan.univ-lyon1.fr (134.214.126.172) by
 BEMBX2013-01.univ-lyon1.fr (134.214.201.247) with Microsoft SMTP Server (TLS)
 id 15.0.1263.5; Thu, 14 Dec 2017 12:13:14 +0100
From:   Nathan Payre <nathan.payre@etu.univ-lyon1.fr>
To:     <git@vger.kernel.org>
CC:     Eric Sunshine <sunshine@sunshineco.com>,
        Nathan Payre <nathan.payre@etu.univ-lyon1.fr>,
        Matthieu Moy <matthieu.moy@univ-lyon1.fr>,
        Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>,
        Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] send-email: extract email-parsing code into a subroutine
Date:   Thu, 14 Dec 2017 12:12:43 +0100
Message-ID: <20171214111243.13349-1-nathan.payre@etu.univ-lyon1.fr>
X-Mailer: git-send-email 2.15.0.318.g5fe043d57.dirty
In-Reply-To: <CAGb4CBVcUv111dUy9waScAL2WATkk0LVqJQ55g3-XbH1H228YQ@mail.gmail.com>
References: <CAGb4CBVcUv111dUy9waScAL2WATkk0LVqJQ55g3-XbH1H228YQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [134.214.126.172]
X-ClientProxiedBy: BPMBX2013-02.univ-lyon1.fr (134.214.201.244) To
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

>> "PAYRE NATHAN p1508475" <nathan.payre@etu.univ-lyon1.fr> wrote:
>>> +     my %parsed_email;
>>> +     $parsed_email{'body'} = '';
>>> +     while (my $line = <$c>) {
>>> +             next if $line =~ m/^GIT:/;
>>> +             parse_header_line($line, \%parsed_email);
>>> +             if ($line =~ /^$/) {
>>> +                     $parsed_email{'body'} = filter_body($c);
>>>               }
>>> -             print $c2 $_;
>>
>> I didn't notice this at first, but you're modifying the behavior here:
>> the old code used to print to $c2 anything that didn't match any of
>> the if/else if branches.
>>
>> To keep this behavior, you need to keep all these extra headers in
>> $parsed_email (you do, in this version) and print them after taking
>> care of all the known headers (AFAICT, you don't).
>
> This case is not that easy to correct because:
> - It's could weigh the code.
> - The refactoring may not be legitimate anymore.
> 
> I've found two way to resolve this:
> .1) After every if($parsed_email{'key'}) remove the corresponding key
> and just before closing $c2 create a new loop which add all the
> remaining parts.
>
> .2) Making a mix between the old and new code. Some parts of
> my patch can improve the old code (like the removing of
> $need_8bit_cte) then it will be kept and the while loop will be
> similar the old code
>
> I think that the first version will look like better than the second
> one, easy to read, but it will change the order of the email header.

This is how I see the first choice of the two I've proposed in my last
email.

 git-send-email.perl | 116
 +++++++++++++++++++++++++++++++++++----------------- 1 file changed,
 78 insertions(+), 38 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 2208dcc21..f942fc2a5 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -703,57 +703,71 @@ EOT3
 		do_edit($compose_filename);
 	}
 
-	open my $c2, ">", $compose_filename . ".final"
-		or die sprintf(__("Failed to open %s.final: %s"), $compose_filename, $!);
-
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
+	my %parsed_email;
+	while (my $line = <$c>) {
+		next if $line =~ m/^GIT:/;
+		parse_header_line($line, \%parsed_email);
+		if ($line =~ /^$/) {
+			$parsed_email{'body'} = filter_body($c);
 		}
-		print $c2 $_;
 	}
+
 	close $c;
-	close $c2;
 
-	if ($summary_empty) {
+	open my $c2, ">", $compose_filename . ".final"
+	or die sprintf(__("Failed to open %s.final: %s"), $compose_filename, $!);
+
+
+	if ($parsed_email{'From'}) {
+		$sender = delete($parsed_email{'From'});
+	}
+	if ($parsed_email{'In-Reply-To'}) {
+		$initial_reply_to = delete($parsed_email{'In-Reply-To'});
+	}
+	if ($parsed_email{'Subject'}) {
+		$initial_subject = delete($parsed_email{'Subject'});
+		print $c2 "Subject: " .
+			quote_subject($initial_subject, $compose_encoding) .
+			"\n";
+	}
+
+	if ($parsed_email{'MIME-Version'}) {
+		print $c2 "MIME-Version: $parsed_email{'MIME-Version'}\n",
+				"Content-Type: $parsed_email{'Content-Type'};\n",
+				"Content-Transfer-Encoding: $parsed_email{'Content-Transfer-Encoding'}\n";
+		delete($parsed_email{'MIME-Version'});
+		delete($parsed_email{'Content-Type'});
+		delete($parsed_email{'Content-Transfer-Encoding'});
+	} elsif (file_has_nonascii($compose_filename)) {
+		my $content_type = (delete($parsed_email{'Content-Type'}) or
+			"text/plain; charset=$compose_encoding");
+		print $c2 "MIME-Version: 1.0\n",
+			"Content-Type: $content_type\n",
+			"Content-Transfer-Encoding: 8bit\n";
+	}
+
+	foreach my $key (keys %parsed_email) {
+		next if $key == 'body';
+		print $c2 "$key: $parsed_email{$key}";
+	}
+
+	if ($parsed_email{'body'}) {
+		print $c2 "\n$parsed_email{'body'}\n";
+		delete($parsed_email{'body'});
+	} else {
 		print __("Summary email is empty, skipping it\n");
 		$compose = -1;
 	}
+
+	close $c2;
+
 } elsif ($annotate) {
 	do_edit(@files);
 }
@@ -792,6 +806,32 @@ sub ask {
 	return;
 }
 
+sub parse_header_line {
+	my $lines = shift;
+	my $parsed_line = shift;
+	my $pattern = join "|", qw(To Cc Bcc);
+	
+	foreach (split(/\n/, $lines)) {
+		if (/^($pattern):\s*(.+)$/i) {
+		        $parsed_line->{$1} = [ parse_address_line($2) ];
+		} elsif (/^([^:]*):\s*(.+)\s*$/i) {
+		        $parsed_line->{$1} = $2;
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

