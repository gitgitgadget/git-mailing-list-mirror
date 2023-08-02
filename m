Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67148C04FDF
	for <git@archiver.kernel.org>; Wed,  2 Aug 2023 16:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjHBQt6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Aug 2023 12:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbjHBQtp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2023 12:49:45 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E2C30F1
        for <git@vger.kernel.org>; Wed,  2 Aug 2023 09:49:35 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A0F2E19EBBE;
        Wed,  2 Aug 2023 12:49:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2AioVkGfeGOAG9Jn3dHI3V9GXM/2yx1R2XRpvX
        JJKGc=; b=wqKOC/DzrEy+qUhbSi1UWVJUprVvvYwV4UnYLFxqI5pKnc2lZ6rLLR
        WDWdZBalVE0ZF+qQyz2rIi6Wy//YZ96+wYg6szqC2WchsCrvMwSbYBVHbsjA81vb
        aVG/zDrtm0CXceAILzgxU4hXPrb9cukAnb1HJEryScIs38y8w/T5I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 991AA19EBBD;
        Wed,  2 Aug 2023 12:49:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F3E5F19EBBC;
        Wed,  2 Aug 2023 12:49:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        "Thomas J. Faughnan Jr." <thomas@faughnan.net>,
        "Daniel P." <danpltile@gmail.com>
Subject: Re: [PATCH] ident: don't consider trailing dot crud
References: <ZMghdgIaQB4L88WR@tapette.crustytoothpaste.net>
        <20230731214435.1462098-1-sandals@crustytoothpaste.net>
        <xmqqpm4721lm.fsf@gitster.g>
Date:   Wed, 02 Aug 2023 09:49:32 -0700
In-Reply-To: <xmqqpm4721lm.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        31 Jul 2023 14:49:25 -0700")
Message-ID: <xmqqsf918k4j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8EEFD7A2-3154-11EE-BB74-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I wonder if this needs some credit to those involved in the original
> thread?

I've had this on 'seen' as-is, hoping to see a quick update so that
we can merge it down to 'next' before -rc0; here is a minimally
touched-up version I'll replace it with.

Thanks.

------- >8 ------------- >8 ------------- >8 ------------- >8 -------
From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] ident: don't consider '.' a crud

When we process a user's name (as in user.name), we strip all
leading and trailing crud from it.  Right now, we consider a dot
a crud character, and strip it off.

However, this is unsuitable for many personal names because humans
frequently have abbreviated suffixes, such as "Jr." or "Sr." at the end
of their names, and this corrupts them.  Some other users may wish to
use an abbreviated name or initial, which will pose a problem especially
in cultures that write the family name first, followed by the personal
name.

Since the current approach causes lots of practical problems, let's
avoid it by no longer considering a dot to be crud.

Note that "." in the name forces the entire name to be quoted to
please mailers, but stripping "." only at the beginning and the end
does not help a name with "." in the middle (like "brian m. carlson")
so this change will not make it much worse.  A name like "Given
Family, Jr." that did not have to be quoted now would need to be, in
order to be placed on the e-mail headers, though.

This is based on a weather-balloon patch by Jeff King sent in Aug 2021
https://lore.kernel.org/git/YSKm8Q8nyTavQaox@coredump.intra.peff.net/

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

1:  4ce0751970 ! 1:  9478b6dadc ident: don't consider trailing dot crud
    @@ Metadata
     Author: brian m. carlson <sandals@crustytoothpaste.net>
     
      ## Commit message ##
    -    ident: don't consider trailing dot crud
    +    ident: don't consider '.' a crud
     
    -    When we process a user's name (as in user.name), we strip all trailing
    -    crud from it.  Right now, we consider a dot trailing crud, and strip it
    -    off.
    +    When we process a user's name (as in user.name), we strip all
    +    leading and trailing crud from it.  Right now, we consider a dot
    +    a crud character, and strip it off.
     
         However, this is unsuitable for many personal names because humans
         frequently have abbreviated suffixes, such as "Jr." or "Sr." at the end
    @@ Commit message
         Since the current approach causes lots of practical problems, let's
         avoid it by no longer considering a dot to be crud.
     
    +    Note that "." in the name forces the entire name to be quoted to
    +    please mailers, but stripping "." only at the beginning and the end
    +    does not help a name with "." in the middle (like "brian m. carlson")
    +    so this change will not make it much worse.  A name like "Given
    +    Family, Jr." that did not have to be quoted now would need to be, in
    +    order to be placed on the e-mail headers, though.
    +
    +    This is based on a weather-balloon patch by Jeff King sent in Aug 2021
    +    https://lore.kernel.org/git/YSKm8Q8nyTavQaox@coredump.intra.peff.net/
    +
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     



 ident.c                       |  1 -
 t/t4203-mailmap.sh            |  4 ++--
 t/t7518-ident-corner-cases.sh | 11 ++++++++++-
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/ident.c b/ident.c
index 8fad92d700..8d490df7d5 100644
--- a/ident.c
+++ b/ident.c
@@ -203,7 +203,6 @@ void reset_ident_date(void)
 static int crud(unsigned char c)
 {
 	return  c <= 32  ||
-		c == '.' ||
 		c == ',' ||
 		c == ':' ||
 		c == ';' ||
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index fa7f987284..2016132f51 100755
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
index fffdb6ff2e..9ab2ae2f3b 100755
--- a/t/t7518-ident-corner-cases.sh
+++ b/t/t7518-ident-corner-cases.sh
@@ -20,10 +20,19 @@ test_expect_success 'empty name and missing email' '
 '
 
 test_expect_success 'commit rejects all-crud name' '
-	test_must_fail env GIT_AUTHOR_NAME=" .;<>" \
+	test_must_fail env GIT_AUTHOR_NAME=" ,;<>" \
 		git commit --allow-empty -m foo
 '
 
+test_expect_success 'commit does not strip trailing dot' '
+	author_name="Pat Doe Jr." &&
+	env GIT_AUTHOR_NAME="$author_name" \
+		git commit --allow-empty -m foo &&
+	git log -1 --format=%an >actual &&
+	echo "$author_name" >expected &&
+	test_cmp actual expected
+'
+
 # We must test the actual error message here, as an unwanted
 # auto-detection could fail for other reasons.
 test_expect_success 'empty configured name does not auto-detect' '
-- 
2.41.0-478-gee48e70a82

