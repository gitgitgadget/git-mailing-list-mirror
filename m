Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01B6F203BD
	for <e@80x24.org>; Thu, 14 Jul 2016 22:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbcGNWNt (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 18:13:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58467 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751262AbcGNWNt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 18:13:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EAC122BA3C;
	Thu, 14 Jul 2016 18:13:47 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6WBh42qNdQlTxO2EojmmYvPwI90=; b=mSIS2m
	Jbmgth9LWrJTh4nJf1aDf5gq8R3jL4I1tA4yMUuOVcfW0ozeocZ8s3LVZPwtQMve
	VIfEo489c+LPTx51qIiJFjoLRgTHJJMTTAvaZPrnwsQ/w+L+vHJTR4SVlFJ3rZXY
	SG4QgYAiDww86eWaJaODwg/qHu63aWEoKcC0E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AdcHIU0gMsvHSe5dZ7BpxP2Vi+ExiO+Z
	gV6v0SGt8sg0aoBVn3oIlc1k3cqtAaBtj5YLNxs1Sw5+dKZPCEZkriLyvAW4Tv1F
	Lw/vw0yxX9AIHI5sjhbY/jOdPsL7n0KZ5xAs6rUQ+/C8LU65AC6WxdIDT3kqlu54
	5DXEv5Es0tA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E34562BA3B;
	Thu, 14 Jul 2016 18:13:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 692D62BA3A;
	Thu, 14 Jul 2016 18:13:47 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Kevin Willford <kcwillford@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] Use path comparison for patch ids before the file content
References: <20160714201758.13180-1-kcwillford@gmail.com>
Date:	Thu, 14 Jul 2016 15:13:45 -0700
In-Reply-To: <20160714201758.13180-1-kcwillford@gmail.com> (Kevin Willford's
	message of "Thu, 14 Jul 2016 16:17:58 -0400")
Message-ID: <xmqqy453ookm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3C6311E4-4A10-11E6-88B8-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Kevin Willford <kcwillford@gmail.com> writes:

> When limiting the list in a revision walk using cherry pick, patch ids are
> calculated by producing the diff of the content of the files.  This would
> be more efficent by using a patch id looking at the paths that were
> changed in the commits and only if all the file changed are the same fall
> back to getting the content of the files in the commits to determine if
> the commits are the same.

The basic idea of this change makes sense.  When we have many
commits, but if we can tell that no other commit changes the same
set of paths as this commit does, we can immediately know that this
commit cannot have an equivalent other commit among the rest.  By
first computing a lot cheaper "hash of touched paths" for commits,
and throwing them into separate bins keyed by the "hash of touched
paths", you can narrow the commits whose patch IDs must be compared,
and if a bin happens to be a singleton, you do not even need to
produce any patch ID by running a textual diff.  I like it.

Explaining this as "hash of touched paths" is somewhat misleading.
Your "use_path_only" mode actually hashes a lot more than just
paths.  Because the "use_path_only" mode actually hashes the entire
basic diff header and not just paths, it can differentiate a commit
that adds a file and another commit that modifies the same file, for
example.

> ...  This will speed up a rebase where the
> upstream has many changes but none of them have been pulled into the
> current branch.
> ---

Missing sign-off.

>  diff.c      |  16 +++++----
>  diff.h      |   2 +-

The changes in the above two files looked OK to me.
I didn't read the changes to the other three files carefully.

>  patch-ids.c | 114 +++++++++++++++++++++++++++++-------------------------------
>  patch-ids.h |   7 ++--
>  revision.c  |  19 ++--------
>  5 files changed, 73 insertions(+), 85 deletions(-)

>
> diff --git a/patch-ids.c b/patch-ids.c
> index a4d0016..f0262ce 100644
> --- a/patch-ids.c
> +++ b/patch-ids.c
> @@ -4,8 +4,9 @@
> ...
> +}
> \ No newline at end of file

No newline at end of file.


Thanks.
