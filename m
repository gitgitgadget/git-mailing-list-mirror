Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32A2B1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 11:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbeJJSfv (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 14:35:51 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42518 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbeJJSfv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 14:35:51 -0400
Received: by mail-ed1-f65.google.com with SMTP id b7-v6so4543712edd.9
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 04:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LHkXNhIjpWezbfLp3zJ/9TZ53JCOgvmTw6ydBDf9F8Y=;
        b=Cqbg7srp/Go/ciIV31xxlR+8G00yNxG+zevrM3yDte16JRrAN0YHhGTIt8n2xwvAG3
         23UMBMh2Nznebkya3xJyxAWPoGEDYHU0QeWPGPp4L3PKkOjDfcSJAXKOCLUcKUlTEBDP
         QQgm7hofZAwJFKDFUvMPHDKp5NBtcrvBE5q/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LHkXNhIjpWezbfLp3zJ/9TZ53JCOgvmTw6ydBDf9F8Y=;
        b=DzX906WQJRFTEbo4TA8k67WwQKgYsLBeBN5Hq2bLeL+tuRRKWBKCtv8CtahIWXTS4y
         1nJo5gLmCEQRw3dz7+TJWmvzPmiVNQoXmbGhiReF4FMjGKVxJ3G5ZXzTmWiFElbCRFNl
         ZMkE6AYFZABlqrFK/awJivqe365RJGPk/40lF6eeMEmLuZfBzN5dX+0cGKPO1fhO7Cj1
         wd3mJq9WENU9Y65wSYeDedMjGAVLGQa8ol1LKVomgMtz2jGWycplCCqF5+1RFn36qLby
         +99pZSOqLBzUZ9amw128FsP0SBYMQo8M3YIyaHenYj34JbLgNIIjf5qLYZcdr2/oSpkJ
         Z1Iw==
X-Gm-Message-State: ABuFfogcOoLC0gFtbLR4c80T6dI1/f5U5VHgzLyONJZJyZHWo4d2+DIh
        GHM5Z1nfozVM9e1I0ntVGOBqW2hZHzU=
X-Google-Smtp-Source: ACcGV60M/T3SIxO40rNgpGICxXtp85/gKCsciGAIvMKb70q8mSiLJDr0nrT9cjN9SqNiFpOTtMeQNw==
X-Received: by 2002:a50:8d1b:: with SMTP id s27-v6mr41203656eds.107.1539170049512;
        Wed, 10 Oct 2018 04:14:09 -0700 (PDT)
Received: from prevas-ravi.vestasvisitor.net ([193.47.71.171])
        by smtp.gmail.com with ESMTPSA id e10-v6sm4154596ejl.25.2018.10.10.04.14.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Oct 2018 04:14:08 -0700 (PDT)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
To:     git@vger.kernel.org
Cc:     Rasmus Villemoes <rv@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>
Subject: [PATCH 3/3] send-email: also pick up cc addresses from -by trailers
Date:   Wed, 10 Oct 2018 13:13:51 +0200
Message-Id: <20181010111351.5045-4-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.g084f1d7761
In-Reply-To: <20181010111351.5045-1-rv@rasmusvillemoes.dk>
References: <20181010111351.5045-1-rv@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When rerolling a patch series, including various Reviewed-by etc. that
may have come in, it is quite convenient to have git-send-email
automatically cc those people.

So pick up any *-by lines, with a new suppression category 'misc-by',
but special-case Signed-off-by, since that already has its own
suppression category. It seems natural to make 'misc-by' implied by
'body'.

Based-on-patch-by: Joe Perches <joe@perches.com>
Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 Documentation/git-send-email.txt |  5 ++++-
 git-send-email.perl              | 14 ++++++++------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index ea6ea512fe..f6010ac68b 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -329,8 +329,11 @@ Automating
   patch body (commit message) except for self (use 'self' for that).
 - 'sob' will avoid including anyone mentioned in Signed-off-by lines except
   for self (use 'self' for that).
+- 'misc-by' will avoid including anyone mentioned in Acked-by,
+  Reviewed-by, Tested-by and other "-by" lines in the patch body,
+  except Signed-off-by (use 'sob' for that).
 - 'cccmd' will avoid running the --cc-cmd.
-- 'body' is equivalent to 'sob' + 'bodycc'.
+- 'body' is equivalent to 'sob' + 'bodycc' + 'misc-by'.
 - 'all' will suppress all auto cc values.
 --
 +
diff --git a/git-send-email.perl b/git-send-email.perl
index 1916159d2a..7a6391e5d8 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -94,7 +94,7 @@ sub usage {
     --identity              <str>  * Use the sendemail.<id> options.
     --to-cmd                <str>  * Email To: via `<str> \$patch_path`
     --cc-cmd                <str>  * Email Cc: via `<str> \$patch_path`
-    --suppress-cc           <str>  * author, self, sob, cc, cccmd, body, bodycc, all.
+    --suppress-cc           <str>  * author, self, sob, cc, cccmd, body, bodycc, misc-by, all.
     --[no-]cc-cover                * Email Cc: addresses in the cover letter.
     --[no-]to-cover                * Email To: addresses in the cover letter.
     --[no-]signed-off-by-cc        * Send to Signed-off-by: addresses. Default on.
@@ -454,13 +454,13 @@ sub read_config {
 if (@suppress_cc) {
 	foreach my $entry (@suppress_cc) {
 		die sprintf(__("Unknown --suppress-cc field: '%s'\n"), $entry)
-			unless $entry =~ /^(?:all|cccmd|cc|author|self|sob|body|bodycc)$/;
+			unless $entry =~ /^(?:all|cccmd|cc|author|self|sob|body|bodycc|misc-by)$/;
 		$suppress_cc{$entry} = 1;
 	}
 }
 
 if ($suppress_cc{'all'}) {
-	foreach my $entry (qw (cccmd cc author self sob body bodycc)) {
+	foreach my $entry (qw (cccmd cc author self sob body bodycc misc-by)) {
 		$suppress_cc{$entry} = 1;
 	}
 	delete $suppress_cc{'all'};
@@ -471,7 +471,7 @@ sub read_config {
 $suppress_cc{'sob'} = !$signed_off_by_cc if defined $signed_off_by_cc;
 
 if ($suppress_cc{'body'}) {
-	foreach my $entry (qw (sob bodycc)) {
+	foreach my $entry (qw (sob bodycc misc-by)) {
 		$suppress_cc{$entry} = 1;
 	}
 	delete $suppress_cc{'body'};
@@ -1681,7 +1681,7 @@ sub process_file {
 	# Now parse the message body
 	while(<$fh>) {
 		$message .=  $_;
-		if (/^(Signed-off-by|Cc): (.*)/i) {
+		if (/^([a-z-]*-by|Cc): (.*)/i) {
 			chomp;
 			my ($what, $c) = ($1, $2);
 			# strip garbage for the address we'll use:
@@ -1691,7 +1691,9 @@ sub process_file {
 			if ($sc eq $sender) {
 				next if ($suppress_cc{'self'});
 			} else {
-				next if $suppress_cc{'sob'} and $what =~ /Signed-off-by/i;
+				next if $suppress_cc{'sob'} and $what =~ /^Signed-off-by$/i;
+				next if $suppress_cc{'misc-by'}
+					and $what =~ /-by$/i and $what !~ /^Signed-off-by$/i;
 				next if $suppress_cc{'bodycc'} and $what =~ /Cc/i;
 			}
 			if ($c !~ /.+@.+|<.+>/) {
-- 
2.19.1.6.g084f1d7761

