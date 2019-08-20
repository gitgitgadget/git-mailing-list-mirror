Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9A741F461
	for <e@80x24.org>; Tue, 20 Aug 2019 21:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730886AbfHTVSt (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 17:18:49 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57380 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730811AbfHTVSr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 17:18:47 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DDC047C264;
        Tue, 20 Aug 2019 17:18:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b5Vvw2batdHmMbgOP8Lhx8VX5VA=; b=pzEUyU
        qrnyj7D+KWD4lt5TkpwmpvHIMKbwKdh7wT6iIGKqKLSJ5dyWmouEKaiwPnr5lcvh
        2A/5sRC97FqtXtEJXUV6Ix0Rfx3+mfp+0XR19h+0EUwzMeRoQ2/mSC+FmUY+oUrv
        FyTykMbyrVIWgmbJigDDFJZH1kHZhFRZhejhk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FmRpmsuyfazAchaSDfMxSqSXwwHdvQ0y
        VVLBS/Pj+PPJZREHa/T0SEaAtRYpjHpVLPlMZUhu3/FyabcxTZZsa0HBtT7AOKvm
        3f86GqYeDlxltteZvbPhK6FQt/HNOMlvQDHSItecqPAJ0wqWz2skCSJJBwKu5s/5
        lwSj8waBoig=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D64F07C263;
        Tue, 20 Aug 2019 17:18:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0BC0B7C262;
        Tue, 20 Aug 2019 17:18:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff: skip GITLINK when lazy fetching missing objs
References: <20190820205320.139006-1-jonathantanmy@google.com>
Date:   Tue, 20 Aug 2019 14:18:40 -0700
In-Reply-To: <20190820205320.139006-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 20 Aug 2019 13:53:20 -0700")
Message-ID: <xmqqblwjtu1b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 166F8BD2-C390-11E9-ABEE-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> In 7fbbcb21b1 ("diff: batch fetching of missing blobs", 2019-04-08),
> diff was taught to batch the fetching of missing objects when operating
> on a partial clone, but was not taught to refrain from fetching
> GITLINKs. Teach diff to check if an object is a GITLINK before including
> it in the set to be fetched.

OK, so in a lazy repository, running "git diff" (or "git log") could
have resulted in "git fetch" of a history of a submodule, which may
likely have failed?

> (As stated in the commit message of that commit, unpack-trees was also
> taught a similar thing prior, but unpack-trees correctly checks for
> GITLINK before including objects in the set to be fetched.)
> ---

Sign-off?

> One of my colleagues noticed this when switching branches in a
> superproject with a dirty working tree (hence triggering the diff
> mechanism). The test I included in this commit tests a simpler use case,
> but I've verified that this solves my colleague's case too.
> ---
>  diff.c                        |  1 +
>  t/t4067-diff-partial-clone.sh | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/diff.c b/diff.c
> index efe42b341a..e28b463f57 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -6512,6 +6512,7 @@ static void add_if_missing(struct repository *r,
>  			   const struct diff_filespec *filespec)
>  {
>  	if (filespec && filespec->oid_valid &&
> +	    !S_ISGITLINK(filespec->mode) &&
>  	    oid_object_info_extended(r, &filespec->oid, NULL,
>  				     OBJECT_INFO_FOR_PREFETCH))
>  		oid_array_append(to_fetch, &filespec->oid);

Makes sense.

Thanks.
