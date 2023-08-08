Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D202C001B0
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 19:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbjHHT71 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 15:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbjHHT6f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 15:58:35 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F4C783FF
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 11:15:32 -0700 (PDT)
Received: (qmail 32741 invoked by uid 109); 8 Aug 2023 18:15:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Aug 2023 18:15:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22685 invoked by uid 111); 8 Aug 2023 18:15:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Aug 2023 14:15:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 8 Aug 2023 14:15:31 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] send-email: avoid creating more than one Term::ReadLine
 object
Message-ID: <20230808181531.GB2097200@coredump.intra.peff.net>
References: <20230808180935.GA2096901@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230808180935.GA2096901@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Every time git-send-email calls its ask() function to prompt the user,
we call term(), which instantiates a new Term::ReadLine object. But in
v1.46 of Term::ReadLine::Gnu (which provides the Term::ReadLine
interface on some platforms), its constructor refuses to create a second
instance[1]. So on systems with that version of the module, most
git-send-email instances will fail (as we usually prompt for both "to"
and "in-reply-to" unless the user provided them on the command line).

We can fix this by keeping a single instance variable and returning it
for each call to term(). In perl 5.10 and up, we could do that with a
"state" variable. But since we only require 5.008, we'll do it the
old-fashioned way, with a lexical "my" in its own scope.

Note that the tests in t9001 detect this problem as-is, since the
failure mode is for the program to die. But let's also beef up the
"Prompting works" test to check that it correctly handles multiple
inputs (if we had chosen to keep our FakeTerm hack in the previous
commit, then the failure mode would be incorrectly ignoring prompts
after the first).

[1] For discussion of why multiple instances are forbidden, see:
    https://github.com/hirooih/perl-trg/issues/16

Signed-off-by: Jeff King <peff@peff.net>
---
 git-send-email.perl   | 18 +++++++++++++-----
 t/t9001-send-email.sh |  5 +++--
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 4cb6ee9327..897cea6564 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -959,11 +959,19 @@ sub get_patch_subject {
 	do_edit(@files);
 }
 
-sub term {
-	require Term::ReadLine;
-	return $ENV{"GIT_SEND_EMAIL_NOTTY"}
-			? Term::ReadLine->new('git-send-email', \*STDIN, \*STDOUT)
-			: Term::ReadLine->new('git-send-email');
+{
+	# Only instantiate one $term per program run, since some
+	# Term::ReadLine providers refuse to create a second instance.
+	my $term;
+	sub term {
+		require Term::ReadLine;
+		if (!defined $term) {
+			$term = $ENV{"GIT_SEND_EMAIL_NOTTY"}
+				? Term::ReadLine->new('git-send-email', \*STDIN, \*STDOUT)
+				: Term::ReadLine->new('git-send-email');
+		}
+		return $term;
+	}
 }
 
 sub ask {
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 48bf0af2ee..0662ff8120 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -337,13 +337,14 @@ test_expect_success $PREREQ 'Show all headers' '
 test_expect_success $PREREQ 'Prompting works' '
 	clean_fake_sendmail &&
 	(echo "to@example.com" &&
-	 echo ""
+	 echo "my-message-id@example.com"
 	) | GIT_SEND_EMAIL_NOTTY=1 git send-email \
 		--smtp-server="$(pwd)/fake.sendmail" \
 		$patches \
 		2>errors &&
 		grep "^From: A U Thor <author@example.com>\$" msgtxt1 &&
-		grep "^To: to@example.com\$" msgtxt1
+		grep "^To: to@example.com\$" msgtxt1 &&
+		grep "^In-Reply-To: <my-message-id@example.com>" msgtxt1
 '
 
 test_expect_success $PREREQ,AUTOIDENT 'implicit ident is allowed' '
-- 
2.42.0.rc0.376.g66bfc4f195
