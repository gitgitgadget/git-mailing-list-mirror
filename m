Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE95C433F5
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 23:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbhLPXhP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 18:37:15 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65162 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhLPXhP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 18:37:15 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 08E70162AD9;
        Thu, 16 Dec 2021 18:37:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fRmzqVl1QXjGuR32H8dHBljSeRrfl9F6zQXCyD
        UXCqg=; b=So5FJvRXJ5w03Y3OTwa/KegXJmSAZ1njt+kp1CrD+S9vRF7lWmuf04
        HMQ3TorsSKi1nOPkCKicWOmE4rtO3HbqHPeu7LYuwMsQZ1kTaYWedm/B3AzQSdFA
        oA88XTm2KDK7FPz2hEmLq6lf+ULAulDHI0TdWH3I46V4mhd/gfBhM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 00AA1162AD6;
        Thu, 16 Dec 2021 18:37:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5AA45162AD3;
        Thu, 16 Dec 2021 18:37:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jerry Zhang <jerry@skydio.com>
Subject: [PATCH] format-patch: mark rev_info with UNLEAK
References: <20211213220327.16042-1-jerry@skydio.com>
        <20211213220327.16042-2-jerry@skydio.com> <xmqqee6dz5s9.fsf@gitster.g>
Date:   Thu, 16 Dec 2021 15:37:10 -0800
In-Reply-To: <xmqqee6dz5s9.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        15 Dec 2021 17:40:06 -0800")
Message-ID: <xmqqpmpw6s0p.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 174AE34A-5EC9-11EC-8DB6-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The comand uses a single instance of rev_info on stack, makes a
single revision traversal and exit.  Mark the resources held by the
rev_info structure with UNLEAK().

We do not do this at lower level in revision.c or cmd_log_walk(), as
a new caller of the revision traversal API can make unbounded number
of rev_info during a single run, and UNLEAK() would not a be
suitable mechanism to deal with such a caller.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

    Junio C Hamano <gitster@pobox.com> writes:

    > Jerry Zhang <jerry@skydio.com> writes:
    >
    >>  t/t4126-apply-empty.sh      | 22 ++++++++++++++++++----
    >>  4 files changed, 30 insertions(+), 7 deletions(-)
    >> ...
    >> diff --git a/t/t4126-apply-empty.sh b/t/t4126-apply-empty.sh
    >> index ceb6a79fe0..949e284d14 100755
    >> --- a/t/t4126-apply-empty.sh
    >> +++ b/t/t4126-apply-empty.sh
    >> @@ -7,10 +7,12 @@ test_description='apply empty'
    >>  test_expect_success setup '
    >>  	>empty &&
    >>  	git add empty &&
    >>  	test_tick &&
    >>  	git commit -m initial &&
    >> +	git commit --allow-empty -m "empty commit" &&
    >> +	git format-patch --always HEAD~ >empty.patch &&
    >>  	for i in a b c d e
    >
    > When merged with anything that has ab/mark-leak-free-tests-even-more
    > topic, this will start breaking the tests, as it is my understanding
    > that "git log" family hasn't been audited and converted for leak
    > sanitizer.
    > ...
    > I am tempted to drop the "TEST_PASSES" bit from this script for now,
    > but I have to say that the "mark leak-free tests" topic took us in
    > an awkward place.  We probably want to do something a bit more fine
    > grained about it.

    Luckily, this test script is small enough that format-patch is the
    only new offender, it seems, and with the attached patch I plan to
    queue on a separate topic merged, it seem it no longer upsets the
    sanitizer.

 builtin/log.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/log.c b/builtin/log.c
index f75d87e8d7..a7bca8353b 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -2241,6 +2241,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	strbuf_release(&rdiff1);
 	strbuf_release(&rdiff2);
 	strbuf_release(&rdiff_title);
+	UNLEAK(rev);
 	return 0;
 }
 
-- 
2.34.1-472-g213ab46be7
