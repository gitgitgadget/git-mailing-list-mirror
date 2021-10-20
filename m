Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB66C433EF
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 21:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E64F610E7
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 21:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhJTVej (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 17:34:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54311 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhJTVei (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 17:34:38 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 890B9F581B;
        Wed, 20 Oct 2021 17:32:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=y5qoQsiw6YVpUv9Cp4gkzqK7E+NlelYbYkvU/k
        QX+6Q=; b=orF7axOAPRAYPCa+y7lR0PA0HXTwoIidLjDnTM23FxXBkqrvzEqR18
        u7fQ8P/7RDU3tlvEUpzF7fhzLwORkOsIzTuU9+J9FbK5qVnvv3aqOHORfTo4x1IK
        9hwaJqeM+NOCXxRgXpIp2XRC2Ghk878XzfWti+7yqCo2mEOhus/4U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B28FF581A;
        Wed, 20 Oct 2021 17:32:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B3723F5817;
        Wed, 20 Oct 2021 17:32:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] for-each-ref: delay parsing of --sort=<atom> options
References: <xmqqv91uw5dl.fsf@gitster.g>
        <YW9EP5UNX0f+eOke@coredump.intra.peff.net>
        <xmqq4k9bssr7.fsf@gitster.g>
        <YXCAuAwZenM6EPug@coredump.intra.peff.net>
Date:   Wed, 20 Oct 2021 14:32:21 -0700
In-Reply-To: <YXCAuAwZenM6EPug@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 20 Oct 2021 16:48:56 -0400")
Message-ID: <xmqqpmrzo00q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 362CBA1C-31ED-11EC-9BA5-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yeah, I faced something similar with 7c5045fc18 (ref-filter: apply
> fallback refname sort only after all user sorts, 2020-05-03). I suspect
> you could use the same keys as those tests, though I am OK if we simply
> leave it as a quietly-fixed bug.

Ah, I guess I can cheat and add a new test after these.

If --no-sort weren't taking effect, the expected outcome would be
the asme as the previous step this copied from, but with --no-sort
clearing the sort keys, we sort by taggerdate and then tiebreak with
the refname, and taggeremail does not get into the picture (other
than being repeated at the end of the refname).

 t/t6300-for-each-ref.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git c/t/t6300-for-each-ref.sh w/t/t6300-for-each-ref.sh
index 83921502a4..9f2c706c12 100755
--- c/t/t6300-for-each-ref.sh
+++ w/t/t6300-for-each-ref.sh
@@ -1024,6 +1024,27 @@ test_expect_success 'equivalent sorts fall back on refname' '
 	test_cmp expected actual
 '
 
+test_expect_success '--no-sort cancels the previous sort keys' '
+	cat >expected <<-\EOF &&
+	100000 <user1@example.com> refs/tags/multi-ref1-100000-user1
+	100000 <user2@example.com> refs/tags/multi-ref1-100000-user2
+	100000 <user1@example.com> refs/tags/multi-ref2-100000-user1
+	100000 <user2@example.com> refs/tags/multi-ref2-100000-user2
+	200000 <user1@example.com> refs/tags/multi-ref1-200000-user1
+	200000 <user2@example.com> refs/tags/multi-ref1-200000-user2
+	200000 <user1@example.com> refs/tags/multi-ref2-200000-user1
+	200000 <user2@example.com> refs/tags/multi-ref2-200000-user2
+	EOF
+	git for-each-ref \
+		--format="%(taggerdate:unix) %(taggeremail) %(refname)" \
+		--sort=-refname \
+		--sort=taggeremail \
+		--no-sort \
+		--sort=taggerdate \
+		"refs/tags/multi-*" >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'do not dereference NULL upon %(HEAD) on unborn branch' '
 	test_when_finished "git checkout main" &&
 	git for-each-ref --format="%(HEAD) %(refname:short)" refs/heads/ >actual &&
