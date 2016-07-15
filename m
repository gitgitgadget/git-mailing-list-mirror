Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E65E5203C2
	for <e@80x24.org>; Fri, 15 Jul 2016 21:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbcGOVOf (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 17:14:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64829 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751054AbcGOVOe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 17:14:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CB12B2D2E3;
	Fri, 15 Jul 2016 17:14:32 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=soJHUiMGZPwI9q1XdLGkzp4OTYM=; b=AqBMOw
	CW1HmTD3bqMsMQyBYA79Z8TpsUMUnuUUwDo5JNy+y2jdY6Sq2mi7SRqY57W43nMp
	kmPIHXLWq5/blK2rR5VcM6eUNgo+NT9dUqoTeknNNqIfFFT/OhhwLPtYf5q29wV9
	zLd6d929g4KBVoHQeW2MVlnOro0unm7GwWwKw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FzfipcdBDvg2E8hkBYyQCLJqafRoAOaW
	hIzf4QEZMedFfpGwVb4lj0aaziiA7cAXikCX6/A9sW0TyAakPLLnldKo1KVU5YaK
	FDlFLa7qXlgl1s7SHeriL/Vc1OPXZlVm4P2zckMV5827rIzZEgnIz8a/Qsa3bLx9
	Vmu/9ul+EyQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C1C962D2E2;
	Fri, 15 Jul 2016 17:14:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4C48A2D2E1;
	Fri, 15 Jul 2016 17:14:32 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Mike Hommey <mh@glandium.org>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] blame: Allow to blame paths freshly added to the index
References: <20160715024254.29186-1-mh@glandium.org>
	<xmqqvb06lita.fsf@gitster.mtv.corp.google.com>
Date:	Fri, 15 Jul 2016 14:14:30 -0700
In-Reply-To: <xmqqvb06lita.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 15 Jul 2016 13:58:41 -0700")
Message-ID: <xmqqr3auli2x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1FC83C64-4AD1-11E6-A76E-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I suspect that the above change needs to be updated further if the
> user wants to run "blame path" during a conflicted renaming merge,
> i.e.
>
>  0. Before two histories diverged, there was old_path.
>  1. Our side updated contents of that file and kept it at old_path.
>  2. Their side updated contents of that file and moved it to path.
>  3. "git merge" notcied the rename, created three stages at "path",
>     with the result of conflicted content-level merge in the working
>     tree at "path".
>  4. The user edits "path" and resolves the conflict, but wants to
>     double check before running "git add path".
>  5. "git blame path"
>
> Perhaps something like this should suffice:
>
>     pos = cache_name_pos(path, strlen(path));
>     if (0 <= pos)
>     	; /* ok */
>     else if (!strcmp(active_cache[-1 - pos]->name), path)
>         ; /* ok -- just unmerged */
>     else
>     	die("no such path in HEAD");

I do not think the "conflicted renaming merge" example would not be
a problem in practice iff "git merge" was used, because the fake
working tree commit would look at both our tree and their tree, and
find "path" in theirs inside the loop above this "die".

But the user can be in the same conflicted rename situation with
"git am -3" or cherry-pick, and in these cases there won't be extra
parent commits for the fake work tree commit, hence the conclusion
does not change.

Thanks.
