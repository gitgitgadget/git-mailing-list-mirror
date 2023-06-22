Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FDEEB64D8
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 19:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjFVTMz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jun 2023 15:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjFVTMx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 15:12:53 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AEA1BCC
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 12:12:52 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C796C1A68A1;
        Thu, 22 Jun 2023 15:12:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tjR2whTH/2yH17F0loWl2JPlst1gWna6Y4yd+h
        dsOUA=; b=KvKihKHuMoujSKpH3YqPKQf/VdfbwOSkGu3GBDA8x6vJYB/iOasK58
        4kZIojMYtXKQMM0MMhCLEKxyno6KQLIN5KK8KEyfA6lsvYvQkzZ+91goHwVVjePK
        aLTetV67ah9/kA+Gutx+4qxqUnphwoXAVw58reaJJkN3AJrLnJVGo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BFA5A1A68A0;
        Thu, 22 Jun 2023 15:12:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 345431A689F;
        Thu, 22 Jun 2023 15:12:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joshua Hudson <jhudson@cedaron.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: Design issue in git merge driver interface
References: <6e1b9ce4-e86d-fe30-e5de-27a3be57eefd@cedaron.com>
Date:   Thu, 22 Jun 2023 12:12:50 -0700
In-Reply-To: <6e1b9ce4-e86d-fe30-e5de-27a3be57eefd@cedaron.com> (Joshua
        Hudson's message of "Thu, 22 Jun 2023 09:50:01 -0700")
Message-ID: <xmqqttuze2fh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C85667F2-1130-11EE-9673-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joshua Hudson <jhudson@cedaron.com> writes:

> Looking at the merge driver found that some things cannot be handled,
> such as OOM condition. The fault has to propagate upwards, unwinding
> as it goes.

Even though the end-user facing documentation says:

    The merge driver is expected to leave the result of the merge in
    the file named with `%A` by overwriting it, and exit with zero
    status if it managed to merge them cleanly, or non-zero if there
    were conflicts.

the ll-merge.c:ll_ext_merge() function that calls an external merge
driver does this:

        static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
                ...
                status = run_command(&child);
                ...
                ret = (status > 0) ? LL_MERGE_CONFLICT : status;
                return ret;
        }

so a true "failure" from run_command() to run the external merge
driver will be noticed as a failure by the upper layer of the
callchain.  merge-ort.c:merge_3way() relays the return value of
ll-merge.c:ll_merge() and merge-ort.c:handle_content_merge() reacts
to a negative return as an _("Failed to execute internal merge")
error, for example.  merge-recursive uses the same logic.

Unfortunately, I see no provision for the merge driver to actively
signal such a condition.  The return value of run_command() is a
return value from run-command.c:wait_or_whine() and exit status of
the process is cleansed with WEXITSTATUS() so we cannot make it
negative X-<.

In the worst case, we may retroactively have to reserve one exit
status so that the external merge driver can actively say "I give
up" to cause LL_MERGE_ERROR to be returned from the codepath, but I
wonder if it is safe to abuse "exit due to signal" (which shows up
as a return value greater than 128) as such a "merge driver went
away without leaving a useful result"?  Elijah, what do you think?

Stepping back a bit and even disregarding such a merge driver that
OOMs, if a long-running merge driver is killed, by definition we
cannot trust what the driver left on the filesystem, so handling
"exit due to signal" case differently does sound like a sensible
thing to do, at least to me, offhand.

And once we have such an enhancement to the ll-ext-merge interface,
a merge driver that voluntarily "gives up" can send a signal to kill
itself (or call abort(3)).

With a tentative commit log message (which would need to be updated
to mention what the triggering topic was that led to this
enhancement) but without associated documentation update and test,
here is to summarize and illustrate the above idea.

----- >8 ---------- >8 ---------- >8 -----
ll-merge: external merge driver died with a signal causes an error

When an external merge driver dies with a signal, we should not
expect that the result left on the filesystem is in any useful
state.  However, because the current code uses the return value from
run_command() and declares any positive value as a sign that the
driver successfully left conflicts in the result, and because the
return value from run_command() for a subprocess that died upon a
signal is positive, we end up treating whatever garbage left on the
filesystem as the result the merge driver wanted to leave us.

run_command() returns larger than 128 (WTERMSIG(status) + 128, to be
exact) when it notices that the subprocess died with a signal, so
detect such a case and return LL_MERGE_ERROR from ll_ext_merge().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ll-merge.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git c/ll-merge.c w/ll-merge.c
index 07ec16e8e5..5599f55ffc 100644
--- c/ll-merge.c
+++ w/ll-merge.c
@@ -243,7 +243,14 @@ static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
 		unlink_or_warn(temp[i]);
 	strbuf_release(&cmd);
 	strbuf_release(&path_sq);
-	ret = (status > 0) ? LL_MERGE_CONFLICT : status;
+
+	if (!status)
+		ret = LL_MERGE_OK;
+	else if (status <= 128)
+		ret = LL_MERGE_CONFLICT;
+	else
+		/* died due to a signal: WTERMSIG(status) + 128 */
+		ret = LL_MERGE_ERROR;
 	return ret;
 }
 
