Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE2CC433F5
	for <git@archiver.kernel.org>; Sat, 26 Mar 2022 00:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiCZAOz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 20:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiCZAOw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 20:14:52 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEA71D4C2F
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 17:13:16 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B0759112D8A;
        Fri, 25 Mar 2022 20:13:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=uJL/vNf6zxLf
        FE/2guwUS6RMWfe1MB9mApZs/3O2XQ8=; b=N1ae8mC4MceHiEE7Szw8GH2sIOsA
        3ugn67/VFzqyl8HAIGZet38pRkVYE7bja+MC6lipRkhCN2KezigYiXKKCpSG0LOn
        GhBbCXM0SBcYd+TLzVxZ/zdi16fR9+hSFm8RKFIdmDGvMUS+NSHG5UsgqyEBE9V2
        vB3+Pu/VIFzHlgM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A74A7112D89;
        Fri, 25 Mar 2022 20:13:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DDDD6112D88;
        Fri, 25 Mar 2022 20:13:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3] http API: fix dangling pointer issue noted by GCC 12.0
References: <patch-v2-1.1-777838267a5-20220225T090816Z-avarab@gmail.com>
        <patch-v3-1.1-69190804c67-20220325T143322Z-avarab@gmail.com>
        <Yj4FwuyEW0b5ImEC@nand.local>
Date:   Fri, 25 Mar 2022 17:13:12 -0700
In-Reply-To: <Yj4FwuyEW0b5ImEC@nand.local> (Taylor Blau's message of "Fri, 25
        Mar 2022 14:11:14 -0400")
Message-ID: <xmqqy20x7eqv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8729C528-AC99-11EC-A13E-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Fri, Mar 25, 2022 at 03:34:49PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>> This isn't the only caller that assigns to "slot->finished", see see
>
> s/see see/see ?
>
>> the assignments in http-walker.c:process_alternates_response() and
>> http.c:finish_active_slot().
>>
>> But those assignments are both to the pointer to our local variable
>> here, so this fix is correct. The only way that code in http-walker.c
>> could have done its assignments is to the pointer to this specific
>> variable.
>
> Got it; this is the key piece that I was missing in my earlier review.
> Sorry about that, this looks completely safe to me now.

It does not exactly look safe to me, though.

With a bit of rewrite, here is what I'd queue for now.  I really
hope that the pre-release compiler will be fixed soon so that we do
not have to worry about this patch.

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Date: Fri, 25 Mar 2022 15:34:49 +0100

The pre-release GCC 12.0 development branch has a new warning about
dangling pointers in -Wall:

    http.c: In function =E2=80=98run_active_slot=E2=80=99:
    http.c:1332:24: error: storing the address of local variable =E2=80=98=
finished=E2=80=99 in =E2=80=98*slot.finished=E2=80=99 [-Werror=3Ddangling=
-pointer=3D]
     1332 |         slot->finished =3D &finished;
          |         ~~~~~~~~~~~~~~~^~~~~~~~~~~
    http.c:1330:13: note: =E2=80=98finished=E2=80=99 declared here
     1330 |         int finished =3D 0;
          |             ^~~~~~~~

This is on a locally built "gcc (GCC) 12.0.1 20220120 (experimental)",
built from gcc.git's 8bc700f4c3f (Enhance vec_pack_trunc for integral
mode mask., 2022-01-17).

The GCC warning is specifically about pointers that survive the exit
of the function. See a comment added to
"pass_waccess::use_after_inval_p" in the GCC commit that added the
warning, or:

    /* The use is one of a dangling pointer if a clobber of the variable
      [the pointer points to] has not been found before the function exit
      point.  */
    [...]

There's a few possible ways to fix this, but the simplest is to assign
NULL to "slot->finished" at the end of run_active_slot().

It was suggested[2] to guard that with "if (slot->finished =3D=3D
&finished)", but that'll still trigger the bogus warning from the
compiler.

This is the only place that assigns to "slot->finished"; other
mention of slot->finished in http-walker.c:process_alternates_response() =
and
http.c:finish_active_slot() are assignments through the pointer,
and not moving where the pointer points at.

As long as the same slot is never passed to run_active_slot()
recursively, clearing the member unconditionally when the control
leaves the function should not break the code.  Knock wood, as
nobody seems to have made sure if that is the case.

We could add

	if (slot->finished)
		BUG("the uncoditional clearing at the end is wrong");

early in run_active_slot(), before we assign the pointer to our
on-stack variable to this field, to give us such a guarantee,
though.

1. https://gcc.gnu.org/git/?p=3Dgcc.git;a=3Dcommitdiff;h=3D9d6a0f388eb048=
f8d87f47af78f07b5ce513bfe6
2. https://lore.kernel.org/git/xmqq8rv2nggn.fsf@gitster.g/

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 http.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/http.c b/http.c
index 229da4d148..2f67fbb33c 100644
--- a/http.c
+++ b/http.c
@@ -1367,6 +1367,7 @@ void run_active_slot(struct active_request_slot *sl=
ot)
 			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
 		}
 	}
+	slot->finished =3D NULL;
 }
=20
 static void release_active_slot(struct active_request_slot *slot)
--=20
2.35.1-832-gfc83ccf5d8

