Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD09C00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 21:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbiHJVEK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 17:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiHJVEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 17:04:09 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2619B7AC1A
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 14:04:09 -0700 (PDT)
Received: (qmail 6851 invoked by uid 109); 10 Aug 2022 21:04:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Aug 2022 21:04:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15547 invoked by uid 111); 10 Aug 2022 21:04:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Aug 2022 17:04:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 10 Aug 2022 17:04:07 -0400
From:   Jeff King <peff@peff.net>
To:     Xavier Morel <xavier.morel@masklinn.net>
Cc:     git@vger.kernel.org
Subject: [PATCH 3/3] fsck: downgrade tree badFilemode to "info"
Message-ID: <YvQdR3sDqDMCIjIE@coredump.intra.peff.net>
References: <YvQcNpizy9uOZiAz@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YvQcNpizy9uOZiAz@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous commit un-broke the "badFileMode" check; before then it was
literally testing nothing. And as far as I can tell, it has been so
since the very initial version of fsck.

The current severity of "badFileMode" is just "warning". But in the
--strict mode used by transfer.fsckObjects, that is elevated to an
error. This will potentially cause hassle for users, because historical
objects with bad modes will suddenly start causing pushes to many server
operators to be rejected.

At the same time, these bogus modes aren't actually a big risk. Because
we canonicalize them everywhere besides fsck, they can't cause too much
mischief in the real world. The worst thing you can do is end up with
two almost-identical trees that have different hashes but are
interpreted the same. That will generally cause things to be inefficient
rather than wrong, and is a bug somebody working on a Git implementation
would want to fix, but probably not worth inconveniencing users by
refusing to push or fetch.

So let's downgrade this to "info" by default, which is our setting for
"mention this when fscking, but don't ever reject, even under strict
mode". If somebody really wants to be paranoid, they can still adjust
the level using config.

Suggested-by: Xavier Morel <xavier.morel@masklinn.net>
Signed-off-by: Jeff King <peff@peff.net>
---
 fsck.h                          |  2 +-
 t/t5504-fetch-receive-strict.sh | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/fsck.h b/fsck.h
index d07f7a2459..6f801e53b1 100644
--- a/fsck.h
+++ b/fsck.h
@@ -56,7 +56,6 @@ enum fsck_msg_type {
 	FUNC(GITMODULES_PATH, ERROR) \
 	FUNC(GITMODULES_UPDATE, ERROR) \
 	/* warnings */ \
-	FUNC(BAD_FILEMODE, WARN) \
 	FUNC(EMPTY_NAME, WARN) \
 	FUNC(FULL_PATHNAME, WARN) \
 	FUNC(HAS_DOT, WARN) \
@@ -66,6 +65,7 @@ enum fsck_msg_type {
 	FUNC(ZERO_PADDED_FILEMODE, WARN) \
 	FUNC(NUL_IN_COMMIT, WARN) \
 	/* infos (reported as warnings, but ignored by default) */ \
+	FUNC(BAD_FILEMODE, INFO) \
 	FUNC(GITMODULES_PARSE, INFO) \
 	FUNC(GITIGNORE_SYMLINK, INFO) \
 	FUNC(GITATTRIBUTES_SYMLINK, INFO) \
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index b0b795aca9..ac4099ca89 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -352,4 +352,21 @@ test_expect_success \
 	grep "Cannot demote unterminatedheader" act
 '
 
+test_expect_success 'badFilemode is not a strict error' '
+	git init --bare badmode.git &&
+	tree=$(
+		cd badmode.git &&
+		blob=$(echo blob | git hash-object -w --stdin | hex2oct) &&
+		printf "123456 foo\0${blob}" |
+		git hash-object -t tree --stdin -w --literally
+	) &&
+
+	rm -rf dst.git &&
+	git init --bare dst.git &&
+	git -C dst.git config transfer.fsckObjects true &&
+
+	git -C badmode.git push ../dst.git $tree:refs/tags/tree 2>err &&
+	grep "$tree: badFilemode" err
+'
+
 test_done
-- 
2.37.1.917.gf0c714241f
