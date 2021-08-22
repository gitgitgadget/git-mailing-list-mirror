Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34A1C4338F
	for <git@archiver.kernel.org>; Sun, 22 Aug 2021 19:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7BAF61266
	for <git@archiver.kernel.org>; Sun, 22 Aug 2021 19:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbhHVTgD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Aug 2021 15:36:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:55648 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231149AbhHVTgC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Aug 2021 15:36:02 -0400
Received: (qmail 4541 invoked by uid 109); 22 Aug 2021 19:35:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 22 Aug 2021 19:35:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22714 invoked by uid 111); 22 Aug 2021 19:35:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 22 Aug 2021 15:35:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 22 Aug 2021 15:35:13 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     "Daniel P." <danpltile@gmail.com>, git@vger.kernel.org
Subject: Re: Git is removing . from the last part of user.name
Message-ID: <YSKm8Q8nyTavQaox@coredump.intra.peff.net>
References: <CAL-s8C7makcRT_ufsv4THSrKeDkXfhFoAXSBKSiK5w0anMvZag@mail.gmail.com>
 <YSJuS1OoYsqgpF3j@camp.crustytoothpaste.net>
 <YSKleNynVrWWyyML@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YSKleNynVrWWyyML@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 22, 2021 at 03:28:57PM -0400, Jeff King wrote:

> On a somewhat lesser note, I'm tempted to say that "." probably was
> never that useful (compared to say, comma, which is the gecos
> separator), and we could probably just drop it from the crud list.

This does break a few tests, but none that I think explicitly were
arguing for keeping the dot. One was just a general crud test, and the
other was just documenting the current behavior while testing something
else (and perhaps even argues _for_ the change, as somebody bothered to
write --author='Jane D.' in the first place).

---
diff --git a/ident.c b/ident.c
index 85d9ba7120..2d136d27c8 100644
--- a/ident.c
+++ b/ident.c
@@ -198,7 +198,6 @@ void reset_ident_date(void)
 static int crud(unsigned char c)
 {
 	return  c <= 32  ||
-		c == '.' ||
 		c == ',' ||
 		c == ':' ||
 		c == ';' ||
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 0b2d21ec55..a1cdc2905f 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -466,7 +466,7 @@ test_expect_success 'gitmailmap(5) example output: example #1' '
 	Author Jane Doe <jane@laptop.(none)> maps to Jane Doe <jane@laptop.(none)>
 	Committer C O Mitter <committer@example.com> maps to C O Mitter <committer@example.com>
 
-	Author Jane D <jane@desktop.(none)> maps to Jane Doe <jane@desktop.(none)>
+	Author Jane D. <jane@desktop.(none)> maps to Jane Doe <jane@desktop.(none)>
 	Committer C O Mitter <committer@example.com> maps to C O Mitter <committer@example.com>
 	EOF
 	git -C doc log --reverse --pretty=format:"Author %an <%ae> maps to %aN <%aE>%nCommitter %cn <%ce> maps to %cN <%cE>%n" >actual &&
@@ -494,7 +494,7 @@ test_expect_success 'gitmailmap(5) example output: example #2' '
 	Author Jane Doe <jane@laptop.(none)> maps to Jane Doe <jane@example.com>
 	Committer C O Mitter <committer@example.com> maps to C O Mitter <committer@example.com>
 
-	Author Jane D <jane@desktop.(none)> maps to Jane Doe <jane@example.com>
+	Author Jane D. <jane@desktop.(none)> maps to Jane Doe <jane@example.com>
 	Committer C O Mitter <committer@example.com> maps to C O Mitter <committer@example.com>
 	EOF
 	git -C doc log --reverse --pretty=format:"Author %an <%ae> maps to %aN <%aE>%nCommitter %cn <%ce> maps to %cN <%cE>%n" >actual &&
diff --git a/t/t7518-ident-corner-cases.sh b/t/t7518-ident-corner-cases.sh
index 905957bd0a..738c723861 100755
--- a/t/t7518-ident-corner-cases.sh
+++ b/t/t7518-ident-corner-cases.sh
@@ -18,7 +18,7 @@ test_expect_success 'empty name and missing email' '
 '
 
 test_expect_success 'commit rejects all-crud name' '
-	test_must_fail env GIT_AUTHOR_NAME=" .;<>" \
+	test_must_fail env GIT_AUTHOR_NAME=" ,;<>" \
 		git commit --allow-empty -m foo
 '
 
