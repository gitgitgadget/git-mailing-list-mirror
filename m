Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF17AC433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 20:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbiCYUbt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 16:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbiCYUbr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 16:31:47 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB2F1EEF1
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 13:30:12 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 68EF1111099;
        Fri, 25 Mar 2022 16:30:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fTUI4tKWf989
        SJ1ordXje1WAyWSh81tKiberkG/WXxg=; b=qxZX87aypckzDB6GxycJ0eET+Irb
        jHWg9/9uzWnOdsPxigBZ2dCZhjTwWqy1alvRR2ZSaguXKOjh/tjgTab+vx1ikmaz
        Dz3pSNNobqGceUe+FzyM9w4p9rfzTOKy3ykFc8ttk83Jb3/KpKhln5eXlOFbOIGf
        fsm6ztj4PSASRJU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 49221111097;
        Fri, 25 Mar 2022 16:30:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4B35C111095;
        Fri, 25 Mar 2022 16:30:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 08/27] revisions API users: add "goto cleanup" for
 "rev_info" early exit
References: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
        <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
        <patch-v3-08.27-f8a9443fe6f-20220325T171340Z-avarab@gmail.com>
Date:   Fri, 25 Mar 2022 13:30:08 -0700
In-Reply-To: <patch-v3-08.27-f8a9443fe6f-20220325T171340Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 25 Mar
 2022 18:18:32
        +0100")
Message-ID: <xmqqtubl93n3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5DEC43E4-AC7A-11EC-AF38-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> It would be a lot cleaner to be able to initialize "struct rev_info"
> with "{ 0 }" here, or if a "REV_INFO_INIT" existed, we'll hopefully
> get around to making the initialization easier in the future (now it
> can't be done via a macro).

If "struct rev_info" can be initialized with "{ 0 }" here, i.e.

-	struct rev_info rev;
+	struct rev_info rev =3D { 0 };

to give us a valid solution, why wouldn't you be able to do

+#define REV_INFO_INIT { 0 }

elsewhere in a common *.h file, and then

-	struct rev_info rev;
+	struct rev_info rev =3D REV_INFO_INIT;

to make the fact that "rev" is initialized (and ready to be handed
to the releaser) even more explicit?  It's like arguing against
fixing a code like this:

	struct char *pointer;
	...
	if (condition)
		pointer =3D malloc(...);
	...
        /* pointer leaks */
=20
by initializing

	struct char *pointer =3D NULL;
	...
	if (condition)
		pointer =3D malloc(...);
	...
        free(pointer);

because for some reason you are against the macro NULL but you are
willing to spell it out as "0" (without double-quotes)?

Puzzled.
