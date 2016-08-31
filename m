Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C9641F859
	for <e@80x24.org>; Wed, 31 Aug 2016 18:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754626AbcHaSvZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 14:51:25 -0400
Received: from smtprelay0063.hostedemail.com ([216.40.44.63]:50411 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752637AbcHaSvX (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 31 Aug 2016 14:51:23 -0400
Received: from filter.hostedemail.com (unknown [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id E2DD7235A7;
        Wed, 31 Aug 2016 18:51:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: stew28_460524d064b58
X-Filterd-Recvd-Size: 4995
Received: from joe-laptop.perches.com (unknown [96.251.125.34])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Wed, 31 Aug 2016 18:51:21 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] git-send-email: Add ability to cc: any "bylines" in the commit message
Date:   Wed, 31 Aug 2016 11:51:19 -0700
Message-Id: <aa4c9e0b37e70423baa69bc27cc9adda0f152efe.1472669418.git.joe@perches.com>
X-Mailer: git-send-email 2.10.0.rc2.1.gaa4c9e0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many commits have various forms of bylines similar to
     "Acked-by: Name <address>" and "Reported-by: Name <address>"

Add the ability to cc: bylines (e.g. Acked-by:) when using git send-email.

This can be suppressed with --suppress-cc=bylines.

Signed-off-by: Joe Perches <joe@perches.com>
---
 Documentation/git-send-email.txt | 11 +++++++----
 git-send-email.perl              | 16 +++++++++++-----
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 642d0ef..0b0d945 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -278,9 +278,10 @@ Automating
 	the value of `sendemail.identity`.
 
 --[no-]signed-off-by-cc::
-	If this is set, add emails found in Signed-off-by: or Cc: lines to the
-	cc list. Default is the value of `sendemail.signedoffbycc` configuration
-	value; if that is unspecified, default to --signed-off-by-cc.
+	If this is set, add emails found in Signed-off-by: or Cc: or any other
+	byline (e.g. Acked-by:) lines to the cc list. Default is the value of
+	`sendemail.signedoffbycc` configuration value; if that is unspecified,
+	default to --signed-off-by-cc.
 
 --[no-]cc-cover::
 	If this is set, emails found in Cc: headers in the first patch of
@@ -307,8 +308,10 @@ Automating
   patch body (commit message) except for self (use 'self' for that).
 - 'sob' will avoid including anyone mentioned in Signed-off-by lines except
    for self (use 'self' for that).
+- 'bylines' will avoid including anyone mentioned in any "<foo>-by:" lines
+  in the patch header except for Signed-off-by.
 - 'cccmd' will avoid running the --cc-cmd.
-- 'body' is equivalent to 'sob' + 'bodycc'
+- 'body' is equivalent to 'sob' + 'bodycc' + 'bylines'
 - 'all' will suppress all auto cc values.
 --
 +
diff --git a/git-send-email.perl b/git-send-email.perl
index da81be4..1f53328 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -84,7 +84,7 @@ git send-email --dump-aliases
     --identity              <str>  * Use the sendemail.<id> options.
     --to-cmd                <str>  * Email To: via `<str> \$patch_path`
     --cc-cmd                <str>  * Email Cc: via `<str> \$patch_path`
-    --suppress-cc           <str>  * author, self, sob, cc, cccmd, body, bodycc, all.
+    --suppress-cc           <str>  * author, self, sob, cc, cccmd, body, bodycc, bylines, all.
     --[no-]cc-cover                * Email Cc: addresses in the cover letter.
     --[no-]to-cover                * Email To: addresses in the cover letter.
     --[no-]signed-off-by-cc        * Send to Signed-off-by: addresses. Default on.
@@ -431,13 +431,13 @@ my(%suppress_cc);
 if (@suppress_cc) {
 	foreach my $entry (@suppress_cc) {
 		die "Unknown --suppress-cc field: '$entry'\n"
-			unless $entry =~ /^(?:all|cccmd|cc|author|self|sob|body|bodycc)$/;
+			unless $entry =~ /^(?:all|cccmd|cc|author|self|sob|body|bodycc|bylines)$/;
 		$suppress_cc{$entry} = 1;
 	}
 }
 
 if ($suppress_cc{'all'}) {
-	foreach my $entry (qw (cccmd cc author self sob body bodycc)) {
+	foreach my $entry (qw (cccmd cc author self sob body bodycc bylines)) {
 		$suppress_cc{$entry} = 1;
 	}
 	delete $suppress_cc{'all'};
@@ -448,7 +448,7 @@ $suppress_cc{'self'} = $suppress_from if defined $suppress_from;
 $suppress_cc{'sob'} = !$signed_off_by_cc if defined $signed_off_by_cc;
 
 if ($suppress_cc{'body'}) {
-	foreach my $entry (qw (sob bodycc)) {
+	foreach my $entry (qw (sob bodycc bylines)) {
 		$suppress_cc{$entry} = 1;
 	}
 	delete $suppress_cc{'body'};
@@ -1545,7 +1545,7 @@ foreach my $t (@files) {
 	# Now parse the message body
 	while(<$fh>) {
 		$message .=  $_;
-		if (/^(Signed-off-by|Cc): (.*)$/i) {
+		if (/^(Signed-off-by|Cc|[^\s]+[\w-]by): (.*)$/i) {
 			chomp;
 			my ($what, $c) = ($1, $2);
 			chomp $c;
@@ -1555,6 +1555,12 @@ foreach my $t (@files) {
 			} else {
 				next if $suppress_cc{'sob'} and $what =~ /Signed-off-by/i;
 				next if $suppress_cc{'bodycc'} and $what =~ /Cc/i;
+				next if $suppress_cc{'bylines'} and $what !~ /Signed-off-by/i and $what =~ /by$/i;
+			}
+			if ($c !~ /.+@.+/) {
+				printf("(body) Ignoring %s from line '%s'\n",
+				       $what, $_) unless $quiet;
+				next;
 			}
 			push @cc, $c;
 			printf("(body) Adding cc: %s from line '%s'\n",
-- 
2.10.0.rc2.1.gaa4c9e0

