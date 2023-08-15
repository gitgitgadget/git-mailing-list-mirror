Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CCCC001B0
	for <git@archiver.kernel.org>; Tue, 15 Aug 2023 19:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239697AbjHOTbx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Aug 2023 15:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240031AbjHOTbq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2023 15:31:46 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE707198B
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 12:31:39 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 32C9A1A44E4;
        Tue, 15 Aug 2023 15:31:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SDfP29O2b/JGoNE+a0MZAfczIU1ibsAaI4Yp6i
        fHzA0=; b=jfvBe8g39Jhl3nWGxr742BMpFweuriXc6Z7mDIik5xNZ1idZ7XTdPn
        QuEIqiEpCibimmTp0sDnfbD6euB1BC5Im1BFKKYyiY7xwN0tWNRkySm0m6AcnLVH
        b55BiKK4/hC6p9ExaMDtg5ijm2qrBWZMUjqRQCN2sf44VOTWWXGOE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C2B31A44E3;
        Tue, 15 Aug 2023 15:31:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9A6BC1A44E1;
        Tue, 15 Aug 2023 15:31:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [Bug] In `git-rev-list(1)`, using the `--objects` flag doesn't
 work well with the `--not` flag, as non-commit objects are not excluded
References: <CAOLa=ZQmjroDiOcUsu_MHtQ-88QHU9qeZPOPh+KJJ3dFoF2q0A@mail.gmail.com>
Date:   Tue, 15 Aug 2023 12:31:37 -0700
In-Reply-To: <CAOLa=ZQmjroDiOcUsu_MHtQ-88QHU9qeZPOPh+KJJ3dFoF2q0A@mail.gmail.com>
        (Karthik Nayak's message of "Tue, 15 Aug 2023 18:44:18 +0200")
Message-ID: <xmqqttt0hzl2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5AA3323E-3BA2-11EE-A3A2-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Karthik Nayak <karthik.188@gmail.com> writes:

> If you notice here, the objects
> `8baef1b4abc478178b004d62031cf7fe6db6f903`,
> `086885f71429e3599c8c903b0e9ed491f6522879` and
> `7a67abed5f99fdd3ee203dd137b9818d88b1bafd` are included in the output,
> these objects are reachable from
> `91fa9611a355db77a07f963c746d57f75af380da` and shouldn't have been
> included since we used the `--not` flag.

For performance reasons, we cannot afford to enumerate all objects
that are reachable from --not objects and exclude them from the
output.  So it is a balancing act to decide where to draw the line.

Spending more cycles and heaps for traversing the --not side deeper
may make the --objects output smaller and more precise, but there of
course is cost associated with it.  And --objects do not promise
that it gives absolute minimum---the reason it exists is to make
sure the objects listed are sufficient to fill gaps between the
--not tips and positive ones, which is the primary reason for its
existence.

> The diff below fixes the issue:
>
> @@ -3790,11 +3833,12 @@ int prepare_revision_walk(struct rev_info *revs)
>          commit_list_sort_by_date(&revs->commits);
>      if (revs->no_walk)
>          return 0;
> -    if (revs->limited) {
> +    if (revs->limited && !revs->tree_objects) {
>          if (limit_list(revs) < 0)
>              return -1;
>          if (revs->topo_order)

This might change the size of the output and "fix" the output in
your particular small test case, but I am not sure what kind of bugs
this will introduce in the more general codepath.

Not calling limit_list() when the .limited bit is on is breaking one
of the most fundamental assumptions in the revision traversal.  When
a feature is enabled that needs to paint the graph upfront before it
can compute its result, the code that enables the feature flips the
.limited to ask this part of the code to make sure it calls
limit_list() to paint the graph with UNINTERESTING bit.

This area to paint uninteresting trees have changed quite
drastically at d5d2e935 (revision: implement sparse algorithm,
2019-01-16).  Some of what it removed may be contributing the "over
counting" of trees that are relevant in your example.



