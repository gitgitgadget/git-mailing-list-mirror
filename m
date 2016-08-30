Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 012841F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 20:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753071AbcH3USg (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 16:18:36 -0400
Received: from smtprelay0009.hostedemail.com ([216.40.44.9]:52826 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750859AbcH3USe (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 30 Aug 2016 16:18:34 -0400
Received: from filter.hostedemail.com (unknown [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 3878D2366C;
        Tue, 30 Aug 2016 20:18:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: tin97_2d46c4564c24b
X-Filterd-Recvd-Size: 4965
Received: from joe-laptop.perches.com (unknown [96.251.125.34])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Tue, 30 Aug 2016 20:18:30 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     git@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Joe Perches <joe@perches.com>
Subject: [PATCH] git-send-email: Add ability to cc: any "trailers" from commit message
Date:   Tue, 30 Aug 2016 13:18:29 -0700
Message-Id: <b2aa91d59a6cdd468bcbe85b45807cc1b82b23ed.1472588158.git.joe@perches.com>
X-Mailer: git-send-email 2.10.0.rc2.1.gb2aa91d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many commits have various forms of trailers similar to
     "Acked-by: Name <address>" and "Reported-by: Name <address>"

Add the ability to cc these trailers when using git send-email.

This can be suppressed with --suppress-cc=trailers.

Signed-off-by: Joe Perches <joe@perches.com>
---
 Documentation/git-send-email.txt | 10 ++++++----
 git-send-email.perl              | 16 +++++++++++-----
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 642d0ef..999c842 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -278,9 +278,10 @@ Automating
 	the value of `sendemail.identity`.
 
 --[no-]signed-off-by-cc::
-	If this is set, add emails found in Signed-off-by: or Cc: lines to the
-	cc list. Default is the value of `sendemail.signedoffbycc` configuration
-	value; if that is unspecified, default to --signed-off-by-cc.
+	If this is set, add emails found in Signed-off-by: or Cc: or any other
+	trailer <foo>-by: lines to the cc list. Default is the value of
+	`sendemail.signedoffbycc` configuration value; if that is unspecified,
+	default to --signed-off-by-cc.
 
 --[no-]cc-cover::
 	If this is set, emails found in Cc: headers in the first patch of
@@ -307,8 +308,9 @@ Automating
   patch body (commit message) except for self (use 'self' for that).
 - 'sob' will avoid including anyone mentioned in Signed-off-by lines except
    for self (use 'self' for that).
+- 'trailers' will avoid including anyone mentioned in any "<foo>-by:" lines.
 - 'cccmd' will avoid running the --cc-cmd.
-- 'body' is equivalent to 'sob' + 'bodycc'
+- 'body' is equivalent to 'sob' + 'bodycc' + 'trailers'
 - 'all' will suppress all auto cc values.
 --
 +
diff --git a/git-send-email.perl b/git-send-email.perl
index da81be4..255465a 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -84,7 +84,7 @@ git send-email --dump-aliases
     --identity              <str>  * Use the sendemail.<id> options.
     --to-cmd                <str>  * Email To: via `<str> \$patch_path`
     --cc-cmd                <str>  * Email Cc: via `<str> \$patch_path`
-    --suppress-cc           <str>  * author, self, sob, cc, cccmd, body, bodycc, all.
+    --suppress-cc           <str>  * author, self, sob, cc, cccmd, body, bodycc, trailers, all.
     --[no-]cc-cover                * Email Cc: addresses in the cover letter.
     --[no-]to-cover                * Email To: addresses in the cover letter.
     --[no-]signed-off-by-cc        * Send to Signed-off-by: addresses. Default on.
@@ -431,13 +431,13 @@ my(%suppress_cc);
 if (@suppress_cc) {
 	foreach my $entry (@suppress_cc) {
 		die "Unknown --suppress-cc field: '$entry'\n"
-			unless $entry =~ /^(?:all|cccmd|cc|author|self|sob|body|bodycc)$/;
+			unless $entry =~ /^(?:all|cccmd|cc|author|self|sob|body|bodycc|trailers)$/;
 		$suppress_cc{$entry} = 1;
 	}
 }
 
 if ($suppress_cc{'all'}) {
-	foreach my $entry (qw (cccmd cc author self sob body bodycc)) {
+	foreach my $entry (qw (cccmd cc author self sob body bodycc trailers)) {
 		$suppress_cc{$entry} = 1;
 	}
 	delete $suppress_cc{'all'};
@@ -448,7 +448,7 @@ $suppress_cc{'self'} = $suppress_from if defined $suppress_from;
 $suppress_cc{'sob'} = !$signed_off_by_cc if defined $signed_off_by_cc;
 
 if ($suppress_cc{'body'}) {
-	foreach my $entry (qw (sob bodycc)) {
+	foreach my $entry (qw (sob bodycc trailers)) {
 		$suppress_cc{$entry} = 1;
 	}
 	delete $suppress_cc{'body'};
@@ -1545,7 +1545,7 @@ foreach my $t (@files) {
 	# Now parse the message body
 	while(<$fh>) {
 		$message .=  $_;
-		if (/^(Signed-off-by|Cc): (.*)$/i) {
+		if (/^(Signed-off-by|Cc|[^\s]+[_-]by): (.*)$/i) {
 			chomp;
 			my ($what, $c) = ($1, $2);
 			chomp $c;
@@ -1555,6 +1555,12 @@ foreach my $t (@files) {
 			} else {
 				next if $suppress_cc{'sob'} and $what =~ /Signed-off-by/i;
 				next if $suppress_cc{'bodycc'} and $what =~ /Cc/i;
+				next if $suppress_cc{'trailers'} and $what !~ /Signed-off-by/i && $what =~ /by$/i;
+			}
+			if ($c !~ /.+@.+/) {
+				printf("(body) Ignoring %s from line '%s'\n",
+				       $what, $_) unless $quiet;
+				next;
 			}
 			push @cc, $c;
 			printf("(body) Adding cc: %s from line '%s'\n",
-- 
2.10.0.rc2.1.gb2aa91d

