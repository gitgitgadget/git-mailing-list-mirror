Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 175A21F453
	for <e@80x24.org>; Tue, 16 Oct 2018 07:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbeJPP2z (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 11:28:55 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43327 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbeJPP2y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 11:28:54 -0400
Received: by mail-ed1-f65.google.com with SMTP id y20-v6so20297718eds.10
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 00:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VqzXTukhLqC813DsnUwOg5tYq5g4s4ggOPE98hqHr2c=;
        b=KITQTfrzdcspbKuvIrpvC9vMq4VUYuJ4uqQKs7oJUCaUwOMzTZiLwEuIkMp8qef1ER
         TUrpbEydLAZcvtR/K7l0vIdpTCM+zZeeIsD0XuZUq6gTFth9+BaV5MxonhwFZiSOLAuN
         CqsEJePoGH9WnJPn4C9gJx4jqA7pa2nUTTfF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VqzXTukhLqC813DsnUwOg5tYq5g4s4ggOPE98hqHr2c=;
        b=j2CV2ji9k1W4GkDClUki5hnERC+xvRgGBVmFk4N7xFl+jlI6zJi+HddoM/TmJf8jVK
         B2kMovLZHXP7A9ns0s3SNDTRMy1Ees2wQSWNpsRrv2RsYcV3cG0UCLZYlBlmZjhM8Te8
         n9p/n82OIRLqntdR3extlv89Qo/1YHfTvNVBQf5myJVILgaUgNHtkUjKNHsi93FoJ4Aa
         N6ROR0lNbqFAitn6KBYHvyKBiknAdLlhh/9JStvMhWewq4KGadex+s03/UXVQ/OoKasq
         Eq91ehlaBB9yPCryyQGoB3HrjOJlIe2xXnnmSfZFZkEhrCy6acUU/2ch1o9+szhmIr2V
         sCsQ==
X-Gm-Message-State: ABuFfoigtoLcbtUervanRgVTs9C/GI5HCeCyWldmOBdyX3gJdxggrMIa
        zZcz82ULyA3UqZ2DzJlSgYPi+5S8XOE=
X-Google-Smtp-Source: ACcGV638QiEHd2JjoQvotNmuiQWJsOdBXq2TzGoYNecIvlrlJ8xor+PIA5Rve2tt+/i2T/PNiN6Cbw==
X-Received: by 2002:a50:eb97:: with SMTP id y23-v6mr28397652edr.38.1539675584812;
        Tue, 16 Oct 2018 00:39:44 -0700 (PDT)
Received: from prevas-ravi.vestasvisitor.net ([193.47.71.171])
        by smtp.gmail.com with ESMTPSA id q18-v6sm2774661ejr.8.2018.10.16.00.39.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Oct 2018 00:39:44 -0700 (PDT)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Rasmus Villemoes <rv@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v2 3/3] send-email: also pick up cc addresses from -by trailers
Date:   Tue, 16 Oct 2018 09:39:23 +0200
Message-Id: <20181016073923.28134-4-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
In-Reply-To: <20181016073923.28134-1-rv@rasmusvillemoes.dk>
References: <20181010111351.5045-1-rv@rasmusvillemoes.dk>
 <20181016073923.28134-1-rv@rasmusvillemoes.dk>
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
 git-send-email.perl              | 19 ++++++++++++-------
 2 files changed, 16 insertions(+), 8 deletions(-)

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
index 1916159d2a..58c6aa9d0e 100755
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
@@ -1691,8 +1691,13 @@ sub process_file {
 			if ($sc eq $sender) {
 				next if ($suppress_cc{'self'});
 			} else {
-				next if $suppress_cc{'sob'} and $what =~ /Signed-off-by/i;
-				next if $suppress_cc{'bodycc'} and $what =~ /Cc/i;
+				if ($what =~ /^Signed-off-by$/i) {
+					next if $suppress_cc{'sob'};
+				} elsif ($what =~ /-by$/i) {
+					next if $suppress_cc{'misc-by'};
+				} elsif ($what =~ /Cc/i) {
+					next if $suppress_cc{'bodycc'};
+				}
 			}
 			if ($c !~ /.+@.+|<.+>/) {
 				printf("(body) Ignoring %s from line '%s'\n",
-- 
2.19.1.6.gbde171bbf5

