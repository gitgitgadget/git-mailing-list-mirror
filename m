Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC23C6FD1D
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 19:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjC3Tah (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 15:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjC3Tag (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 15:30:36 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C25213C
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 12:30:33 -0700 (PDT)
Received: (qmail 31328 invoked by uid 109); 30 Mar 2023 19:30:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 30 Mar 2023 19:30:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20640 invoked by uid 111); 30 Mar 2023 19:30:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 Mar 2023 15:30:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 30 Mar 2023 15:30:31 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Michael J Gruber <git@grubix.eu>
Subject: [PATCH v2 3/5] tests: diagnose unclosed here-doc in chainlint.pl
Message-ID: <20230330193031.GC27989@coredump.intra.peff.net>
References: <20230330192712.GA27719@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230330192712.GA27719@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Sunshine <sunshine@sunshineco.com>

An unclosed here-doc in a test is a problem, because it silently gobbles
up any remaining commands. Since 99a64e4b73c (tests: lint for run-away
here-doc, 2017-03-22) we detect this by piggy-backing on the internal
chainlint checker in test-lib.sh.

However, it would be nice to detect it in chainlint.pl, for a few
reasons:

  - the output from chainlint.pl is much nicer; it can show the exact
    spot of the error, rather than a vague "somewhere in this test you
    broke the &&-chain or had a bad here-doc" message.

  - the implementation in test-lib.sh runs for each test snippet. And
    since it requires a subshell, the extra cost is small but not zero.
    If chainlint.pl can reliably find the problem, we can optimize the
    test-lib.sh code.

The chainlint.pl code never intended to find here-doc problems. But
since it has to parse them anyway (to avoid reporting problems inside
here-docs), most of what we need is already there. We can detect the
problem when we fail to find the missing end-tag in swallow_heredocs().
The extra change in scan_heredoc_tag() stores the location of the start
of the here-doc, which lets us mark it as the source of the error in the
output (see the new tests for examples).

[jk: added commit message and tests]

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Jeff King <peff@peff.net>
---
New in this iteration (thanks again, Eric!).

I changed the error-tag from "HERE" to "UNCLOSED-HEREDOC". I don't think
there any syntactic limitations to worry about (it's just shown to the
user). And it needs to be descriptive enough not to confuse users.
"HERE" is especially bad because my brain interprets it as "HERE there
is an error", which makes me say "Right. What error?".

So "HEREDOC" would work, but there is no reason (aside from length) not
to err on the side of being descriptive.

 t/chainlint.pl                              | 15 ++++++++++++---
 t/chainlint/unclosed-here-doc-indent.expect |  4 ++++
 t/chainlint/unclosed-here-doc-indent.test   |  4 ++++
 t/chainlint/unclosed-here-doc.expect        |  7 +++++++
 t/chainlint/unclosed-here-doc.test          |  7 +++++++
 5 files changed, 34 insertions(+), 3 deletions(-)
 create mode 100644 t/chainlint/unclosed-here-doc-indent.expect
 create mode 100644 t/chainlint/unclosed-here-doc-indent.test
 create mode 100644 t/chainlint/unclosed-here-doc.expect
 create mode 100644 t/chainlint/unclosed-here-doc.test

diff --git a/t/chainlint.pl b/t/chainlint.pl
index e966412999a..556ee91a15b 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -80,7 +80,8 @@ sub scan_heredoc_tag {
 	return "<<$indented" unless $token;
 	my $tag = $token->[0];
 	$tag =~ s/['"\\]//g;
-	push(@{$self->{heretags}}, $indented ? "\t$tag" : "$tag");
+	$$token[0] = $indented ? "\t$tag" : "$tag";
+	push(@{$self->{heretags}}, $token);
 	return "<<$indented$tag";
 }
 
@@ -169,10 +170,18 @@ sub swallow_heredocs {
 	my $tags = $self->{heretags};
 	while (my $tag = shift @$tags) {
 		my $start = pos($$b);
-		my $indent = $tag =~ s/^\t// ? '\\s*' : '';
-		$$b =~ /(?:\G|\n)$indent\Q$tag\E(?:\n|\z)/gc;
+		my $indent = $$tag[0] =~ s/^\t// ? '\\s*' : '';
+		$$b =~ /(?:\G|\n)$indent\Q$$tag[0]\E(?:\n|\z)/gc;
+		if (pos($$b) > $start) {
+			my $body = substr($$b, $start, pos($$b) - $start);
+			$self->{lineno} += () = $body =~ /\n/sg;
+			next;
+		}
+		push(@{$self->{parser}->{problems}}, ['UNCLOSED-HEREDOC', $tag]);
+		$$b =~ /(?:\G|\n).*\z/gc; # consume rest of input
 		my $body = substr($$b, $start, pos($$b) - $start);
 		$self->{lineno} += () = $body =~ /\n/sg;
+		last;
 	}
 }
 
diff --git a/t/chainlint/unclosed-here-doc-indent.expect b/t/chainlint/unclosed-here-doc-indent.expect
new file mode 100644
index 00000000000..7c30a1a024e
--- /dev/null
+++ b/t/chainlint/unclosed-here-doc-indent.expect
@@ -0,0 +1,4 @@
+command_which_is_run &&
+cat >expect <<-\EOF ?!UNCLOSED-HEREDOC?! &&
+we forget to end the here-doc
+command_which_is_gobbled
diff --git a/t/chainlint/unclosed-here-doc-indent.test b/t/chainlint/unclosed-here-doc-indent.test
new file mode 100644
index 00000000000..5c841a9dfd4
--- /dev/null
+++ b/t/chainlint/unclosed-here-doc-indent.test
@@ -0,0 +1,4 @@
+command_which_is_run &&
+cat >expect <<-\EOF &&
+we forget to end the here-doc
+command_which_is_gobbled
diff --git a/t/chainlint/unclosed-here-doc.expect b/t/chainlint/unclosed-here-doc.expect
new file mode 100644
index 00000000000..d65e50f78d4
--- /dev/null
+++ b/t/chainlint/unclosed-here-doc.expect
@@ -0,0 +1,7 @@
+command_which_is_run &&
+cat >expect <<\EOF ?!UNCLOSED-HEREDOC?! &&
+	we try to end the here-doc below,
+	but the indentation throws us off
+	since the operator is not "<<-".
+	EOF
+command_which_is_gobbled
diff --git a/t/chainlint/unclosed-here-doc.test b/t/chainlint/unclosed-here-doc.test
new file mode 100644
index 00000000000..69d3786c348
--- /dev/null
+++ b/t/chainlint/unclosed-here-doc.test
@@ -0,0 +1,7 @@
+command_which_is_run &&
+cat >expect <<\EOF &&
+	we try to end the here-doc below,
+	but the indentation throws us off
+	since the operator is not "<<-".
+	EOF
+command_which_is_gobbled
-- 
2.40.0.692.g7c4c956fc5c

