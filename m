Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69009C04A6A
	for <git@archiver.kernel.org>; Wed, 16 Aug 2023 17:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345062AbjHPREx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Aug 2023 13:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345103AbjHPREg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2023 13:04:36 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161DE103
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 10:04:35 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B68602CF36;
        Wed, 16 Aug 2023 13:04:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Rk66W01N2Cnzoixiy5fT/nSpSAQCwXrdHWBpkd
        CouRs=; b=WqKp3gacR2z5mPfvnhgJaccs42sK13hcQ/GOFZFPqpir4ulY+cvSUb
        CY41I6s2q32pEHqsPKHHIXZE/52BOyqvb8PiLCROqIjeTKLlVVNx/yKh8MSOtAQa
        vergDmVVYSu3TxhSZ3jEB5pUKBUvXP+l6Qxv+9PccM6br7J4vaxCE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AF5112CF35;
        Wed, 16 Aug 2023 13:04:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B30922CF31;
        Wed, 16 Aug 2023 13:04:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [Leftoverbits] exit code clean-up?
References: <pull.1572.git.1691678450757.gitgitgadget@gmail.com>
        <fe028981d353158e9840eb035194ca15e6a2c15e.1692165840.git.ps@pks.im>
        <xmqqjztvezen.fsf@gitster.g>
Date:   Wed, 16 Aug 2023 10:04:28 -0700
In-Reply-To: <xmqqjztvezen.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        16 Aug 2023 09:16:00 -0700")
Message-ID: <xmqqsf8iex5v.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F69E3B98-3C56-11EE-84A5-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick earlier found that Gitaly's CI pipeline was being overly
picky and complained about the unintended change of the exit code of
"git fetch" in the affected codepath from 128 to 1 in a recent
change that went to 'next', made by 7ba7c52d (upload-pack: fix race
condition in error messages, 2023-08-10).

The thing is, we follow that exiting with 0 is success, and exiting
with non-zero means failure, and we generally do not specify which
non-zero value is used for the latter in our documentation.  This
particular case (i.e. "git fetch") certainly does not say anything
about how failure is signaled to the calling program.  "git help
git" does not have "EXIT CODES" section, and it is assumed that the
"common sense" of older generation (gee, this project is more than
18 years old) that exiting with 0 is success and non-zero is failure
is shared among its users, which might not be warranted these days.

We could either

 * Be more prescriptive and add "EXIT CODES" section to each and
   every document to describe how we fail in the current code.

or

 * Describe "In general, 0 is success, non-zero is failure, but some
   commands may signal more than that with its non-zero exit codes"
   in "git help git", and add "EXIT CODES" section to the manual
   page of the commands whose exit codes matter (there are a
   handful, like "git diff --exit-code" that explicitly says "1" is
   the signal that it found difference as opposed to it failing).

I'd prefer if community agrees that we should do the latter, but I
am OK if the community consensus goes the other way.

If we were to go the former, the task becomes larger but it would be
embarrassingly parallelizable.  Folks with extra time on their hand
can lend their eyes to tackle each command, find what exit code we
use in the current code, add "EXIT CODES" section to the documentation,
and extend test coverage to ensure their findings will stay unless
we deliberately change it in the future.

If we were to go the latter, the task will be significantly smaller.
We need to come up with a careful phrasing to add to "git help git"
and/or "git help cli" to give the general principle of zero vs
non-zero whose exact values are left unspecified and should not be
depended upon.  We also need to identify the special cases where the
exact values have meanings (like the "git diff --exit-code" example
above), describe them by adding "EXIT CODES" section to the manual
pages of these selected commands, and extend test coverage to ensure
these values are kept intact across future changes.

Comments?
