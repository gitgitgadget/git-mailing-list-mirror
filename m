Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9806DEB64D8
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 17:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjFTRon (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 13:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjFTRol (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 13:44:41 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D25F1728
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 10:44:39 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 830AA18CD83;
        Tue, 20 Jun 2023 13:44:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=985dmxoJqWDZOtYLDjK6BP2eNp+7pAe5KtFwqd
        QWKcQ=; b=HYpylDWYgmOs+Kx+kmtK9bH4StSVJehS1KHMY2fwPxsef56TP24Z70
        A8Z/35CFw4VAvu5eMh9QFo1dPzp8G997Rrc10rlOmX+bGntilVEOEEARDy0Gw/mx
        w4HIHZdv+6eanPneVNvAHWQZR639GYZpv2u3YHh5vNsAjZLKwCS5w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B61D18CD82;
        Tue, 20 Jun 2023 13:44:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DCD9618CD81;
        Tue, 20 Jun 2023 13:44:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [Bug?] Information around newlines lost in merge
References: <CAOLa=ZRumrpfG8FxQQG=Q8tGvxEapMvOx6SZyRPh0GSpn5iuUg@mail.gmail.com>
Date:   Tue, 20 Jun 2023 10:44:29 -0700
In-Reply-To: <CAOLa=ZRumrpfG8FxQQG=Q8tGvxEapMvOx6SZyRPh0GSpn5iuUg@mail.gmail.com>
        (Karthik Nayak's message of "Tue, 20 Jun 2023 11:22:23 +0200")
Message-ID: <xmqqh6r2ni4i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1C489BE6-0F92-11EE-A8B0-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Karthik Nayak <karthik.188@gmail.com> writes:

> When merging two files which contain newlines at the end, the blob
> created (with conflicts) is the same as two files created without
> newlines at the end.
>
> If this is expected behavior, what would be the best way to
> differentiate the two? This is not a bug introduced, but rather the
> behavior since,
> the start, which makes me think that I'm missing something (verified
> via git bisect on latest git).

Strictly speaking, I suspect that the behaviour was different before
we introduced in-core 3-way merges of two blobs---back then we ran
the "merge" program (from the RCS suite).

If we start from an empty file and have two sides add different
incomplete lines (i.e. your "half" example, but without the leading
blank line), i.e.

	$ >O
	$ M="with a single line added by side %s (without terminating LF)"
	$ printf "$M" A >A
	$ printf "$M" B >B

The original "git merge" that used the external "merge" program
would have produced this:

	$ merge -p B O A 2>E
        <<<<<<< B
        with a single line added by side B (without terminating LF).=======
        with a single line added by side A (without terminating LF).>>>>>>> A
	$ cat E
	merge: warning: conflicts during merge

That is, the output would be a mess that cannot even be machine
parsed.  It probably has changed in a slightly improved way when we
switched to our own internal 3-way merge of two blobs, exposed as
the "git merge-file", which gives you:

        $ git merge-file -p A O B
        <<<<<<< A
        with a single line added by side A (without terminating LF).
        ||||||| O
        =======
        with a single line added by side B (without terminating LF).
        >>>>>>> B

And as you found out, if we added terminating LF to A and/or B, the
output would be the same.  You could argue that the result is at
least machine parseable, instead of the output that is more faithful
to the input (which we've seen above, in the output from "merge").

As "7 repeated marker characters followed by a random label string"
the merge machinery inserts cannot be relied on if you are building
a truly automated conflict resolver, lack of this one bit of
information each from both sides may be the least of your problems,
but what it means at the same time is that you _could_ propose an
augmented output format, perhaps like this one:

        $ git merge-file -p A O B
        <<<<<<< A
        with a single line added by side A (without terminating LF).
	\No newline at end of file
        ||||||| O
        =======
        with a single line added by side B (without terminating LF).
	\No newline at end of file
        >>>>>>> B

It has exactly the same problem we already have as these conflict
section separator lines in that lines that exactly would look like
these extra lines _could_ exist in the payload, so it is not
creating a new problem, but people may have built and are happy
enough with their incomplete automation that relies on the faulty
assumption that the merged payload would never contain lines that
are mistaken as conflict section separator lines, and such an
augmented output format _will_ be a breaking change to them.

So, I dunno.
