Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0808C2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 22:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F6FF20872
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 22:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MYUmS4x/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbgKXWeN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 17:34:13 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56243 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729895AbgKXWeN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 17:34:13 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 83FCB97255;
        Tue, 24 Nov 2020 17:34:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=bPtof4Yejq5e
        WeBVOEHVAuSTVj0=; b=MYUmS4x/lkalG1j9b7dL0qXn5gLwMnMtjptiEp/ijE9X
        AIWzDPmf16WVswsbOmTAM29hvU+l5S5y2Fn80CNBNMxzENqZkdXfn9SA55tae+ET
        4IaUSQ+gwtyu+/6khJsMApj1qub805XAXxO24crVddElWFIztK5rMTNCFkipugU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=xX78At
        0U0AnoQy9wvBwgYtgho/0VWGoze68sI319zaVmqGym6ZNZtWThh/61tB7R7cTnn3
        dACJ9Q67lTrslIoRT/aQFirOELZGj9iFj9dUHWCVh+Uz3VHpwuX11YR8FLH6Ehxp
        OQ2gfbgk9kwwzMNgZ7KnP+iPIg9tI10fKDlaA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7BDC997254;
        Tue, 24 Nov 2020 17:34:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 06D5897253;
        Tue, 24 Nov 2020 17:34:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 3/4] grep: copy struct in one fell swoop
References: <cover.1605972564.git.martin.agren@gmail.com>
        <cover.1606251357.git.martin.agren@gmail.com>
        <359355fb4eff6d99cb1baad9b72ff96e7dcda51d.1606251358.git.martin.agren@gmail.com>
Date:   Tue, 24 Nov 2020 14:34:08 -0800
In-Reply-To: <359355fb4eff6d99cb1baad9b72ff96e7dcda51d.1606251358.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Tue, 24 Nov 2020 22:04:15
 +0100")
Message-ID: <xmqqsg8ygza7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2AFA513C-2EA5-11EB-9D24-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> We have a `struct grep_opt` with our defaults which we then copy into
> the caller's struct. Rather than zeroing the target struct and copying
> each element one by one, just copy everything at once. This leaves the
> code simpler and more maintainable.
>
> We don't have any ownership issues with what we're copying now and can
> just greedily copy the whole thing. If and when we do need to handle
> such elements (`char *`?), we must and can handle it appropriately.

That is correct, but ...

> This
> commit doesn't really change that.

... I suspect this is not.

In the original code, those who are adding a new field would notice
that it is not copied over to the new instance (because they didn't
add anything to grep_init() to copy the field) and at that point
they must stop and think how the new field need to be copied.

The structure assignment of the outer shell done in this patch means
they are robbed of the opportunity to stop and think, because most
of the time it "works" out of the box.  I'd feel safer if we left a
clue to future developers if we were to do your clean-up, perhaps
like:

diff --git c/grep.h w/grep.h
index b5c4e223a8..388d226da3 100644
--- c/grep.h
+++ w/grep.h
@@ -115,6 +115,14 @@ struct grep_expr {
 	} u;
 };
=20
+/*
+ * grep_config() initializes one "default" instance of this type, and
+ * it is copied by grep_init() to be used by each individual
+ * invocation.  When adding a new field to this structure that is
+ * populated from the configuration, be sure to think about ownership
+ * (i.e. a shallow copy may not be what you want for the type of your
+ * newly added field).
+ */
 struct grep_opt {
 	struct grep_pat *pattern_list;
 	struct grep_pat **pattern_tail;

