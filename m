Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE989C433EF
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 20:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350787AbiFJU1b (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 16:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350808AbiFJU1K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 16:27:10 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E8731C15E
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 13:25:16 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3E39C1A20BB;
        Fri, 10 Jun 2022 16:25:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lzSnNHuoC3OLpPNNIyyej2tFXj3o5Jp0uBhSTn
        Zb5bM=; b=L6CHiCCCpxygjGht6+k/Baucf70QbbNvd/U7XLWk4SOKylthLc0Ey5
        HXdoeGhMCILMs6UYal3ikIPC6XtUA07jj3HT+rEGE47h13T64+6HmvRqcv4FnENP
        KR1BO+2faHA9evrRAp+tZ3aIJ0cT9gWnv+83jwfaSSJZGUbnLySbo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 378E71A20BA;
        Fri, 10 Jun 2022 16:25:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 545FB1A20B9;
        Fri, 10 Jun 2022 16:25:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH v2] fetch,fetch-pack: clarify connectivity check error
References: <20220608210537.185094-1-jonathantanmy@google.com>
        <20220610195247.1177549-1-jonathantanmy@google.com>
Date:   Fri, 10 Jun 2022 13:25:10 -0700
In-Reply-To: <20220610195247.1177549-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Fri, 10 Jun 2022 12:52:47 -0700")
Message-ID: <xmqqr13wclll.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6D869FA8-E8FB-11EC-A44E-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> When the connectivity check after a fetch fails, an error message
> "<remote> did not send all necessary objects" is printed. That error
> message is printed regardless of the reason of failure: in particular,
> that message may be printed if the connectivity check fails because a
> local object is missing. (The connectivity check reads local objects too
> because it compares the set of objects that the remote claims to send
> against the set of objects that our refs directly or indirectly
> reference.)
>
> Since it is not necessarily true that the remote did not send all
> necessary objects, update the error message to be something that more
> correctly reflects the situation.
>
> The updated error message is admittedly vague and one alternative
> solution would be to update the revision walking code to be able to more
> precisely specify if a bad object is supposed to be available locally or
> supposed to have been sent by the remote. That would likely require, in
> the revision walking code, to delay parsing any object until all its
> children has been parsed, which seems to be a significant undertaking.
>

While that is all true, I do not think the posted patch as-is is a
good idea.  After all, object missing on our side locally before you
start "git fetch" is a local repository corruption, which ought to
be a much rarer event than a still in development and in flux server
end sending nonsense packfiles, no?

At least, "they didn't do X" would give the user somewhere to start
investigation (e.g. complain to the server folks about the error,
stating where they started from and what they tried to fetch).  The
new message may be playing it "safe" by not saying anything you are
not absolutely sure about, but that is much less useful to the users
who got the message.

Now, when check_connected() fails early in store_updated_refs(), we
haven't updated the remote-tracking refs to point at the tips we
obtained, have we?

One thing we could do is to run "git fsck" to see if the local
history is broken.  We may have added unreferenced objects that have
come from the remote end, but having dangling or unreachable objects
is not an error, while it is a sure sign of repository corruption if
there are missing objects.  Because we haven't update any of the
refs (local or remote-tracking), we still should be able to see if
the problem is on our end at this point

If "o" or "X" (in the illustrated history in my review of your v1)
is found to be missing by "git fsck" (or "git fsck A"), then you
know that the server end is not the culprit (or at least may not be
the sole culprit) for this connectivity check failure.  If "git
fsck" reports no missing objects, then what was found to be missing
is not "X" but is "x" or "B", and we are more certain that the
remote end is more likely to be problematic.

As it is on the error codepath, we could even automatically run fsck
to figure out if we have objects missing after giving an initial
diagnosis, but at least it would be easy to give an advice at this
point in the code to run fsck after seeing a failure from this
fetch.

As you have two places that show the error, perhaps the first step
is to introduce a helper function:

	int diagnose_check_connected_error(const char *url)
	{
		return error(_("%s may not have sent necessary objects"),
                		url ? url : "remote");
	}

and call it instead of calling error() in the places you touched in
v2.

As a follow up step, then, we could do something like

	int diagnose_check_connected_error(const char *url)
	{
+		static const char advice[] =
+			N_("run 'git fsck' to see if your repository "
+			"is missing objects; if it passes, the problem is "
+			"on the remote end");
+
+		advise_if_enabled(ADVICE_CONNECTIVETY_FAILURE, advice);
		return error(_("%s may not have sent necessary	objects"),
                		url ? url : "remote");
	}

or if we are more ambitious, actually run "git fsck" via the run_command() 
API for the user.
