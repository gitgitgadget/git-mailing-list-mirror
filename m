Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95376C433F5
	for <git@archiver.kernel.org>; Fri,  6 May 2022 21:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444382AbiEFVUy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 17:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348961AbiEFVUw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 17:20:52 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFD561285
        for <git@vger.kernel.org>; Fri,  6 May 2022 14:17:07 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 647F11874FC;
        Fri,  6 May 2022 17:17:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T71K7bM7KYgTfWDUdlDhMzW7uiV/LlMoEbWN+F
        pFh+Y=; b=FgtqFOR8MWkQdBcpqhCzWmdjXKkmVfyh1ppAHekbl48c3MVoHus0nx
        wbdpOrrRiAtmiVxr+0gpjbY96RXZZtld584ynLr+lXWGAhxJL18/UGd5toNzYOi9
        R/13DyUh9yVQ1ofGTUIrgli3UtTK3wOscoW/0M8R97IFlG8+3K5Vs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5D8FC1874FB;
        Fri,  6 May 2022 17:17:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 038871874F9;
        Fri,  6 May 2022 17:17:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Michael J Gruber <git@grubix.eu>
Subject: [PATCH] http.c: clear the 'finished' member once we are done with it
References: <cover.1651859773.git.git@grubix.eu>
        <3f0e462e86625a3c253653e4a4eefabcd8590bf9.1651859773.git.git@grubix.eu>
        <xmqqtua2jtr0.fsf@gitster.g>
Date:   Fri, 06 May 2022 14:17:01 -0700
In-Reply-To: <xmqqtua2jtr0.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        06 May 2022 13:22:59 -0700")
Message-ID: <xmqqczgqjr8y.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DFC4371E-CD81-11EC-A8F8-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
function, but make sure to limit it to the case where the pointer
still points at the on-stack variable of ours (the pointer may be
set to point at the on-stack variable of somebody else after the
slot gets reused, in which case we do not want to touch it).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * So, this has been sitting in my pile of random patches for a few
   weeks.

 http.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/http.c b/http.c
index 229da4d148..85437b1980 100644
--- a/http.c
+++ b/http.c
@@ -1367,6 +1367,9 @@ void run_active_slot(struct active_request_slot *slot)
 			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
 		}
 	}
+
+	if (slot->finished == &finished)
+		slot->finished = NULL;
 }
 
 static void release_active_slot(struct active_request_slot *slot)
-- 
2.36.1-200-gf89ea983ca

