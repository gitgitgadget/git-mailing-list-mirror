Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8623C433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 19:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346417AbiEZThj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 15:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345069AbiEZThh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 15:37:37 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B961055D
        for <git@vger.kernel.org>; Thu, 26 May 2022 12:37:34 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DF820126380;
        Thu, 26 May 2022 15:37:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7ksPgQX287nc
        OB+hOVraZ5Ee6uQ7c21U2kPlsUy2oOI=; b=Dk5WQiQT22V4Wba4ksEdmYHu1feZ
        59T3cgzTLpTNWm3DJC+lAEGF5O1wLpwglG/4HSvCk/AdqtcftRN5448TprSfBfPb
        QIgwKNsYtUfqLmvtX49DZdy8RxC97NSH7axOTebqwAZfXF8Lw8lL/Max+GyWx0FX
        QVCgbqeN1C/fEBk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D68C512637F;
        Thu, 26 May 2022 15:37:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F0E3412637D;
        Thu, 26 May 2022 15:37:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re* jc/http-clear-finished-pointer
References: <xmqqzgj41ya2.fsf@gitster.g>
        <220526.86v8ts3z2k.gmgdl@evledraar.gmail.com>
Date:   Thu, 26 May 2022 12:37:31 -0700
In-Reply-To: <220526.86v8ts3z2k.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 26 May 2022 20:51:23 +0200")
Message-ID: <xmqq7d68ytj8.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 499DD664-DD2B-11EC-BD1E-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, May 26 2022, Junio C Hamano wrote:
>
>> * jc/http-clear-finished-pointer (2022-05-24) 1 commit
>>  - http.c: clear the 'finished' member once we are done with it
>>
>>  Meant to go with js/ci-gcc-12-fixes
>>
>>  Will merge to 'next'?
>>  source: <xmqqczgqjr8y.fsf_-_@gitster.g>
>
> The end of the proposed commit message says:
>
>     [...]Clear the finished member before the control leaves the
>     function, which has a side effect of unconfusing compilers like
>     recent GCC 12 that is over-eager to warn against such an assignment=
.
>
> I cannot reproduce this suppressing the warning as noted in past
> exchanges, it's not affected by this "clear if we set it" pattern. It
> needs to be unconditionally cleared.

Interesting.  I still have conditional clearing in the tree, though
I was reasonably sure I got rid of the conditional and made it
always clear, when I rewrote that part of the log message.  After
all, I ran "commit --amend" so that I do not forget the issue after
sending https://lore.kernel.org/git/xmqqleurlt31.fsf@gitster.g/ X-<.

Thanks for catching.  What is queued is not what I intended to
queue.

But there is one thing that is puzzling.  Ever since this, together
with the three patches from Dscho for gcc12, got included in 'seen',
the branch started passing the Windows build that used to complain
and did not work, so at least with the version of gcc12 used over
there, it apparently is sufficient to clear only when we are
responsible for placing an address that is about to become invalid,
while leaving the pointer we didn't stuff in unmodified.

As far as I understand, with the most recent analysis by Dscho on
the http-push codepath, we can return to the loop while the slot is
holding a different request that is unrelated to ours that has
already finished without recursively calling run_active_slot(), and
with the current *(slot->finished)=3D1 trick, it will successfully
notify our loop that our request is done, even though slot->in_use
is set to true back again when it happens.  But by definition, at
that point, slot->finished is not used by anybody (obviously not by
us, but also not by the request that is currently using the slot,
because it hasn't used run_active_slot() and slot->finished is not
touched by it), so it is safe to unconditionally clear the member.

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
Subject: [PATCH v3] http.c: clear the 'finished' member once we are done =
with it

In http.c, the run_active_slot() function allows the given "slot" to
make progress by calling step_active_slots() in a loop repeatedly,
and the loop is not left until the request held in the slot
completes.

Ages ago, we used to use the slot->in_use member to get out of the
loop, which misbehaved when the request in "slot" completes (at
which time, the result of the request is copied away from the slot,
and the in_use member is cleared, making the slot ready to be
reused), and the "slot" gets reused to service a different request
(at which time, the "slot" becomes in_use again, even though it is
for a different request).  The loop terminating condition mistakenly
thought that the original request has yet to be completed.

Today's code, after baa7b67d (HTTP slot reuse fixes, 2006-03-10)
fixed this issue, uses a separate "slot->finished" member that is
set in run_active_slot() to point to an on-stack variable, and the
code that completes the request in finish_active_slot() clears the
on-stack variable via the pointer to signal that the particular
request held by the slot has completed.  It also clears the in_use
member (as before that fix), so that the slot itself can safely be
reused for an unrelated request.

One thing that is not quite clean in this arrangement is that,
unless the slot gets reused, at which point the finished member is
reset to NULL, the member keeps the value of &finished, which
becomes a dangling pointer into the stack when run_active_slot()
returns.  Clear the finished member before the control leaves the
function, which has a side effect of unconfusing compilers like
recent GCC 12 that is over-eager to warn against such an assignment.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 http.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/http.c b/http.c
index 229da4d148..9a98372f74 100644
--- a/http.c
+++ b/http.c
@@ -1367,6 +1367,32 @@ void run_active_slot(struct active_request_slot *s=
lot)
 			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
 		}
 	}
+
+	/*
+	 * The value of slot->finished we set before the loop was used
+	 * to set our "finished" variable when our request completed.
+	 *
+	 * 1. The slot may not have been reused for another requst
+	 *    yet, in which case it still has &finished.
+	 *
+	 * 2. The slot may already be in-use to serve another request,
+	 *    which can further be divided into two cases:
+	 *
+	 * (a) If call run_active_slot() hasn't been called for that
+	 *     other request, slot->finished may still have the
+	 *     address of our &finished.
+	 *
+	 * (b) If the request did call run_active_slot(), then the
+	 *     call would have updated slot->finished at the beginning
+	 *     of this function, and with the clearing of the member
+	 *     below, we would find that slot->finished is now NULL.
+	 *
+	 * In all cases, slot->finished has no useful information to
+	 * anybody at this point.  Some compilers warn us for
+	 * attempting to smuggle a pointer that is about to become
+	 * invalid, i.e. &finished.  We clear it here to assure them.
+	 */
+	slot->finished =3D NULL;
 }
=20
 static void release_active_slot(struct active_request_slot *slot)
--=20
2.36.1-306-g0dbcc0e187
