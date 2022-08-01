Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9C8C19F2C
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 18:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbiHASPZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 14:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbiHASPX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 14:15:23 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1C5FD0
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 11:15:21 -0700 (PDT)
Received: (qmail 733 invoked by uid 109); 1 Aug 2022 18:15:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 01 Aug 2022 18:15:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23752 invoked by uid 111); 1 Aug 2022 18:15:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 01 Aug 2022 14:15:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 1 Aug 2022 14:15:19 -0400
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio Hamano C <gitster@pobox.com>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: "git symbolic-ref" doesn't do a very good job
Message-ID: <YugYNzQYWqDCmOqN@coredump.intra.peff.net>
References: <CAHk-=wh9f0EmsNFgoxUa8BzVej06+7MbLr-MLBjDjtj_=Pf90A@mail.gmail.com>
 <CAHk-=wg9LaHeg0UmZ90gLOaBpO-5fhoaH22iNNm=1eror95pFg@mail.gmail.com>
 <YuXKaLXhnR3mVlWk@coredump.intra.peff.net>
 <YuXLtIBXYG+JBKdV@coredump.intra.peff.net>
 <CAHk-=wi5pfUcuaAUz=rifon9d51mshE7k6bkpMXddog0On9jow@mail.gmail.com>
 <YugQqp4oN26OFOpt@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YugQqp4oN26OFOpt@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 01, 2022 at 01:43:06PM -0400, Jeff King wrote:

> I'd be in favor of (2), which is really just catching syntactically
> invalid crap, and shouldn't break anyone. Technically it's possible
> somebody could be using a symref pointing at arbitrary data for
> who-knows-what reason, and extracting it with "symbolic-ref", but that
> is getting beyond far-fetched, I think.

Just to keep things moving forward, here it is with a commit message. I
left you as the author, but if you're OK with it, please tell Junio he
can forge your sign-off.

-- >8 --
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] symbolic-ref: refuse to set syntactically invalid target

You can feed absolute garbage to symbolic-ref as a target like:

  git symbolic-ref HEAD refs/heads/foo..bar

While this doesn't technically break the repo entirely (our "is it a git
directory" detector looks only for "refs/" at the start), we would never
resolve such a ref, as the ".." is invalid within a refname.

Let's flag these as invalid at creation time to help the caller realize
that what they're asking for is bogus.

A few notes:

  - We use REFNAME_ALLOW_ONELEVEL here, which lets:

     git update-ref refs/heads/foo FETCH_HEAD

    continue to work. It's unclear whether anybody wants to do something
    so odd, but it does work now, so this is erring on the conservative
    side. There's a test to make sure we didn't accidentally break this,
    but don't take that test as an endorsement that it's a good idea, or
    something we might not change in the future.

  - The test in t4202-log.sh checks how we handle such an invalid ref on
    the reading side, so it has to be updated to touch the HEAD file
    directly.

  - We need to keep our HEAD-specific check for "does it start with
    refs/". The ALLOW_ONELEVEL flag means we won't be enforcing that for
    other refs, but HEAD is special here because of the checks in
    validate_headref().

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/symbolic-ref.c  |  2 ++
 t/t1401-symbolic-ref.sh | 10 ++++++++++
 t/t4202-log.sh          |  4 ++--
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index e547a08d6c..1b0f10225f 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -71,6 +71,8 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
 		if (!strcmp(argv[0], "HEAD") &&
 		    !starts_with(argv[1], "refs/"))
 			die("Refusing to point HEAD outside of refs/");
+		if (check_refname_format(argv[1], REFNAME_ALLOW_ONELEVEL) < 0)
+			die("Refusing to set '%s' to invalid ref '%s'", argv[0], argv[1]);
 		ret = !!create_symref(argv[0], argv[1], msg);
 		break;
 	default:
diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
index 9fb0b90f25..0c204089b8 100755
--- a/t/t1401-symbolic-ref.sh
+++ b/t/t1401-symbolic-ref.sh
@@ -165,4 +165,14 @@ test_expect_success 'symbolic-ref can resolve d/f name (ENOTDIR)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'symbolic-ref refuses invalid target for non-HEAD' '
+	test_must_fail git symbolic-ref refs/heads/invalid foo..bar
+'
+
+test_expect_success 'symbolic-ref allows top-level target for non-HEAD' '
+	git symbolic-ref refs/heads/top-level FETCH_HEAD &&
+	git update-ref FETCH_HEAD HEAD &&
+	test_cmp_rev top-level HEAD
+'
+
 test_done
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 6e66352558..f0aaa1fa02 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -2112,9 +2112,9 @@ test_expect_success REFFILES 'log diagnoses bogus HEAD hash' '
 	test_i18ngrep broken stderr
 '
 
-test_expect_success 'log diagnoses bogus HEAD symref' '
+test_expect_success REFFILES 'log diagnoses bogus HEAD symref' '
 	git init empty &&
-	git --git-dir empty/.git symbolic-ref HEAD refs/heads/invalid.lock &&
+	echo "ref: refs/heads/invalid.lock" > empty/.git/HEAD &&
 	test_must_fail git -C empty log 2>stderr &&
 	test_i18ngrep broken stderr &&
 	test_must_fail git -C empty log --default totally-bogus 2>stderr &&
-- 
2.37.1.804.g1775fa20e0

