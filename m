Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4703C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 17:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BC6D61101
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 17:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbhHTRlA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 13:41:00 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56085 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbhHTRky (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 13:40:54 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9DD85140721;
        Fri, 20 Aug 2021 13:40:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5RppaBnzPjwVfH4uK34LGjpubOyma2cb8f0W/B
        RJTHc=; b=BP2N+a92vLHyZusgvMMsaKnWxqu/wpDrkTd+8zsQ1xfpY4ZHWel3z6
        7DtvK3N990q20IBEZoSfyt24G646hLyuNkifgnmOtTtd5Mdu/53D/Ei7vLRCCFDK
        +/jvLlRs+bPwLo4VkjjEGDOHPjt9VHKMytV1uqxpKeNVE5lcVEjUo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9668C140720;
        Fri, 20 Aug 2021 13:40:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DA31D14071E;
        Fri, 20 Aug 2021 13:40:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Jan Kratochvil <jan@jankratochvil.net>, git@vger.kernel.org
Subject: Re: bugreport: git apply -3 confusing "lacks the necessary blob"
References: <YR1OszUm08BMAE1N@host1.jankratochvil.net>
        <73a31988-d298-0168-43d5-849f91366d7d@gmail.com>
Date:   Fri, 20 Aug 2021 10:40:12 -0700
In-Reply-To: <73a31988-d298-0168-43d5-849f91366d7d@gmail.com> (Bagas Sanjaya's
        message of "Fri, 20 Aug 2021 16:19:39 +0700")
Message-ID: <xmqqtujkui9v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ACBCBA5A-01DD-11EC-95ED-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 19/08/21 01.17, Jan Kratochvil wrote:
>> reproducer:
>> (set -ex;: rm -rf gitgit;mkdir gitgit;cd gitgit;git init;echo a >x;git add x;git commit -am.;git checkout -b b;echo b >x;git commit -am.;git checkout master;echo c >x;git commit -am.;git diff master^..b|grep -v ^index >b.diff;git apply -3 b.diff || cat b.diff)
>
> I can reproduce your issue on latest Git (2.33.0).
>
> It seems like you remove `index` line, which **may** contain blob hash
> information required for three-way merge with git apply -3.
>
> But if you don't remove it when generating patch that way, you will
> get expected conflict when git applying.

You make it sound like an "it hurts when I do this, doctor. ---do
not do it, then" exchange ;-).

But I think Jan is talking about the case where users get a patch
that lacks the "index" information out of other people's "diff"
implementation and try to "apply -3" without realizing that it is
not Git's "diff" output.

Perhaps something like the attached patch would be a good start.

There is another place that relies on the index line (application of
binary patch), but the code rejects any patch that does not have the
full-length object name with "... without full index line".  This
message was originally meant to reject patches with abbreviated
object names on the index line, but it would equally apply to one
without the index line (perhaps by accident), so there is no need to
touch that one.


 apply.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git i/apply.c w/apply.c
index 44bc31d6eb..9972ada57e 100644
--- i/apply.c
+++ w/apply.c
@@ -3566,6 +3566,8 @@ static int try_threeway(struct apply_state *state,
 	/* Preimage the patch was prepared for */
 	if (patch->is_new)
 		write_object_file("", 0, blob_type, &pre_oid);
+	else if (!*patch->old_oid_prefix && !*patch->new_oid_prefix)
+		return error(_("cannot 'apply -3' a patch without the index line"));
 	else if (get_oid(patch->old_oid_prefix, &pre_oid) ||
 		 read_blob_object(&buf, &pre_oid, patch->old_mode))
 		return error(_("repository lacks the necessary blob to perform 3-way merge."));

