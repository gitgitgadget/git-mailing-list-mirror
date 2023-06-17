Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD790EB64D9
	for <git@archiver.kernel.org>; Sat, 17 Jun 2023 04:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjFQE0f (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jun 2023 00:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjFQE0e (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jun 2023 00:26:34 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EDD137
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 21:26:32 -0700 (PDT)
Received: (qmail 7242 invoked by uid 109); 17 Jun 2023 04:26:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Jun 2023 04:26:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6373 invoked by uid 111); 17 Jun 2023 04:26:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Jun 2023 00:26:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 17 Jun 2023 00:26:24 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Christian Couder <chriscool@tuxfamily.org>,
        "eric.frederich@siemens.com" <eric.frederich@siemens.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH] commit: pass --no-divider to interpret-trailers
Message-ID: <20230617042624.GA562686@coredump.intra.peff.net>
References: <PH7PR07MB9467452EBAFAB2C825295C0C8C5BA@PH7PR07MB9467.namprd07.prod.outlook.com>
 <42e4373e-b700-45a6-99cc-db2f8896d5b7@app.fastmail.com>
 <20230616042407.GA54009@coredump.intra.peff.net>
 <CAP8UFD2JYAFv=iTDzvn4fzwYpJHt7TBLMXV0GV1-S7tXd7Bp=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD2JYAFv=iTDzvn4fzwYpJHt7TBLMXV0GV1-S7tXd7Bp=A@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 16, 2023 at 08:19:58PM +0200, Christian Couder wrote:

> > But when we run "git commit --trailer", we know that we have a complete
> > commit message, not an email. And so we should not look for "---" at
> > all. But we do, and the commit object we write is broken (the trailer is
> > in the wrong spot):
> 
> Yeah, I agree with the above analysis.

Thanks for confirming. Here it is with a test and commit message.

-- >8 --
Subject: [PATCH] commit: pass --no-divider to interpret-trailers

When git-commit sees any "--trailer" options, it passes the
COMMIT_EDITMSG file through git-interpret-trailers. But it does so
without passing --no-divider, which means that interpret-trailers will
look for a "---" divider to signal the end of the commit message.

That behavior doesn't make any sense in this context; we know we have a
complete and solitary commit message, not something we have to further
parse. And as a result, we'll do the wrong thing if the commit message
contains a "---" marker (which otherwise is not syntactically
significant), inserting any new trailers at the wrong spot.

We can fix this by passing --no-divider. This is the exact situation for
which it was added in 1688c9a489 (interpret-trailers: allow suppressing
"---" divider, 2018-08-22). As noted in the message for that commit, it
just adds the mechanism, and further patches were needed to trigger it
from various callers.  We did that back then in a few spots, like
ffce7f590f (sequencer: ignore "---" divider when parsing trailers,
2018-08-22), but obviously missed this one.

Reported-by: <eric.frederich@siemens.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/commit.c            |  3 ++-
 t/t7502-commit-porcelain.sh | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index e67c4be221..9f4448f6b9 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1043,7 +1043,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		struct child_process run_trailer = CHILD_PROCESS_INIT;
 
 		strvec_pushl(&run_trailer.args, "interpret-trailers",
-			     "--in-place", git_path_commit_editmsg(), NULL);
+			     "--in-place", "--no-divider",
+			     git_path_commit_editmsg(), NULL);
 		strvec_pushv(&run_trailer.args, trailer_args.v);
 		run_trailer.git_cmd = 1;
 		if (run_command(&run_trailer))
diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
index 38a532d81c..b5bf7de7cd 100755
--- a/t/t7502-commit-porcelain.sh
+++ b/t/t7502-commit-porcelain.sh
@@ -466,6 +466,25 @@ test_expect_success 'commit --trailer with -c and command' '
 	test_cmp expected actual
 '
 
+test_expect_success 'commit --trailer not confused by --- separator' '
+	cat >msg <<-\EOF &&
+	subject
+
+	body with dashes
+	---
+	in it
+	EOF
+	git commit --allow-empty --trailer="my-trailer: value" -F msg &&
+	{
+		cat msg &&
+		echo &&
+		echo "my-trailer: value"
+	} >expected &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -e "1,/^\$/d" commit.msg >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'multiple -m' '
 
 	>negative &&
-- 
2.41.0.373.g569912ea65

