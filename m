Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51341C433FE
	for <git@archiver.kernel.org>; Sat, 16 Apr 2022 02:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiDPCJP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 22:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiDPCIj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 22:08:39 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0001F12ADA
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 19:06:07 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CF94C18D0AD;
        Fri, 15 Apr 2022 21:00:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hgtnyLxvwI5/hEiylJvXd8pUf6pMchAsgmA/aY
        fZC/w=; b=idMvdI3hqNX/qi7CsmS8In6jO61nPJlKe7KsMx/IxcB9ksUIMUBW92
        odwd0Rwq8w2Q+gD2Cp//dTWBpwnXZgmcRwHhCLFPBtf4PhyojXFmEeSrZ9GL4JZJ
        7OPZGUA6LaalexMRWJItOTZDmx0d9V1faNQGvyIqxHK/GRXlIgbUU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C890118D0AB;
        Fri, 15 Apr 2022 21:00:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5890C18D0A6;
        Fri, 15 Apr 2022 21:00:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood@talktalk.net, avarab@gmail.com
Subject: Re: [PATCH 2/2] config.mak.dev: alternative workaround to gcc 12
 warning in http.c
References: <20220415123922.30926-1-carenas@gmail.com>
        <20220415231342.35980-1-carenas@gmail.com>
        <20220415231342.35980-3-carenas@gmail.com>
        <xmqqh76taplg.fsf@gitster.g>
        <CAPUEspj4zu-59qxoVPMDGwMvWmu977WRDe7=t0if7raz=H24AQ@mail.gmail.com>
        <xmqqwnfp98ix.fsf@gitster.g>
Date:   Fri, 15 Apr 2022 18:00:33 -0700
In-Reply-To: <xmqqwnfp98ix.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        15 Apr 2022 17:28:06 -0700")
Message-ID: <xmqq35id970u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9EE11A6C-BD20-11EC-A2AE-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> ...  We can take
> the patch you posted and then post release we can apply the "clear
> the .finished member as we are done with the slot" fix, which is a
> good hygiene regardless of any compiler warning issue.
> ...
> At this point, my inclination is to merge these two DEVELOPER_CFLAGS
> changes before the 2.36 final gets tagged.

So, the post release longer term clean-up with log message may look
like this.

----- >8 --------- >8 --------- >8 --------- >8 -----
Subject: [PATCH] http.c: clear the 'finished' member once we are done with it

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
returns.  In finish_active_slot(), clear the finished member after
it is used to signal the run_active_slot() caller, because we know
we are done with the pointer at that point.

Also, because compilers may not be able to follow the callchain that
deep from run_active_slot() down to finish_active_slot(), clear the
finished member but make sure to limit it to the case where the
pointer still points at the on-stack variable of ours (the pointer
may be set to point at the on-stack variable of somebody else after
the slot gets reused, in which case we do not want to touch it).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 http.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/http.c b/http.c
index 229da4d148..626b4051e1 100644
--- a/http.c
+++ b/http.c
@@ -197,8 +197,10 @@ static void finish_active_slot(struct active_request_slot *slot)
 	closedown_active_slot(slot);
 	curl_easy_getinfo(slot->curl, CURLINFO_HTTP_CODE, &slot->http_code);
 
-	if (slot->finished != NULL)
-		(*slot->finished) = 1;
+	if (slot->finished != NULL) {
+		*slot->finished = 1;
+		slot->finished = NULL;
+	}
 
 	/* Store slot results so they can be read after the slot is reused */
 	if (slot->results != NULL) {
@@ -1367,6 +1369,9 @@ void run_active_slot(struct active_request_slot *slot)
 			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
 		}
 	}
+
+	if (slot->finished == &finished)
+		slot->finished = NULL;
 }
 
 static void release_active_slot(struct active_request_slot *slot)
-- 
2.36.0-rc2-233-gc1d9011153

