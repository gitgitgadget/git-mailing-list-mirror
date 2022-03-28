Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD558C433F5
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 17:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244586AbiC1RZC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 13:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbiC1RZA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 13:25:00 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01BC11A37
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 10:23:18 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7E23118A2A2;
        Mon, 28 Mar 2022 13:23:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ay+aJ/ROKTw5TGhrih6u5EY+GrhLg4RE05I/EB
        VTpIQ=; b=RP4oPuWkDPbdMWD8zBaM18xCgNkgzZD7/B7MZ67M7tjcY5zDqCSBHJ
        XEhPEoN8inFq/P9zM54Ltp2LyfPbo2vAWJe+DFUtYzUtxvYyocx1ehDyZPNt4L9Z
        EqZTikvOQf1wIPyhoEL3UyyUonoUIUbua4XWcchbvUTZ6tEYkoPUo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6464C18A2A1;
        Mon, 28 Mar 2022 13:23:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B1D5D18A2A0;
        Mon, 28 Mar 2022 13:23:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH v3] tracking branches: add advice to ambiguous refspec
 error
References: <pull.1183.v2.git.1647940686394.gitgitgadget@gmail.com>
        <pull.1183.v3.git.1648450268285.gitgitgadget@gmail.com>
        <xmqqwnge2ghe.fsf@gitster.g>
        <kl6l7d8et314.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Mon, 28 Mar 2022 10:23:12 -0700
In-Reply-To: <kl6l7d8et314.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Mon, 28 Mar 2022 10:12:07 -0700")
Message-ID: <xmqqilry2dq7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BF8CE250-AEBB-11EC-AE0B-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Hm, what do you think of an alternate approach of storing of the
> matching remotes in a string_list, something like:
>
>   struct find_tracked_branch_cb {
>   	struct tracking *tracking;
>   	struct string_list matching_remotes;
>   };
>   
>   static int find_tracked_branch(struct remote *remote, void *priv)
>   {
>   	struct tracking *tracking = priv;
>   	struct find_tracked_branch_cb *ftb = priv;
>   	struct tracking *tracking = ftb->tracking;
>   
>   	if (!remote_find_tracking(remote, &tracking->spec)) {
>   		if (++tracking->matches == 1) {
>   			string_list_append(tracking->srcs, tracking->spec.src);
>   			tracking->remote = remote->name;
>   		} else {
>   			free(tracking->spec.src);
>   			string_list_clear(tracking->srcs, 0);
>   		}
>   		string_list_append(&ftb->matching_remotes, remote->name);
>   		tracking->spec.src = NULL;
>   	}
>
> then construct the advice message in setup_tracking()? To my untrained
> eye, "case 2" requires a bit of extra work to understand.

If I were writing this code from scratch, I would have probably
collected the names first in this callback, and assembled them at
the end into a single string when we need a single string to show.

Having said that, as long as you do that lazily not to penalize
those who have sane setting without the need for advice/error to
trigger, I do not particularly care how the list of matching remote
names are kept.  Having string_list_append() unconditionally like
the above patch has, even for folks with just a single match without
need for the advice/error message is suboptimal, I would think.

