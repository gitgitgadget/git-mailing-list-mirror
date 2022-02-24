Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12F2C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 21:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234945AbiBXVbQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 16:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbiBXVbP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 16:31:15 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7281CB10
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 13:30:44 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0B71E1836BB;
        Thu, 24 Feb 2022 16:30:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1oKcF4gcgLPsypGL1uKY6rgAFQZbL+VkCdSmej
        CVqeU=; b=Nq7qAZcqSBKYTM8Kxoq+qn95gBE62jJl/35ASQe8PXBkh8KPgaC3wV
        naQqDspItrx+S66zoS74JvdCsz0Vp9SQowUvE8EU7cfa2k23Gb3vuvJ9xue5MGmE
        0XXm+a/3uk7aj8G/6KN3LIauHwGC4NZ+8dcZXg+PsXS8LAscfoMig=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 03E5A1836BA;
        Thu, 24 Feb 2022 16:30:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5B9FB1836B9;
        Thu, 24 Feb 2022 16:30:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v3 09/10] fetch: fetch unpopulated, changed submodules
References: <20220215172318.73533-1-chooglen@google.com>
        <20220224100842.95827-1-chooglen@google.com>
        <20220224100842.95827-10-chooglen@google.com>
Date:   Thu, 24 Feb 2022 13:30:40 -0800
In-Reply-To: <20220224100842.95827-10-chooglen@google.com> (Glen Choo's
        message of "Thu, 24 Feb 2022 18:08:41 +0800")
Message-ID: <xmqqy220j6kf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0437BC34-95B9-11EC-8E4D-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> +	char *path;
>  	/* The submodule commits that have changed in the rev walk. */
>  	struct oid_array new_commits;
>  };
> @@ -818,6 +828,7 @@ struct changed_submodule_data {
>  static void changed_submodule_data_clear(struct changed_submodule_data *cs_data)
>  {
>  	oid_array_clear(&cs_data->new_commits);
> +	free(cs_data->path);

OK.

>  }
>  
>  static void collect_changed_submodules_cb(struct diff_queue_struct *q,
> @@ -865,6 +876,8 @@ static void collect_changed_submodules_cb(struct diff_queue_struct *q,
>  		if (!item->util)
>  			item->util = xcalloc(1, sizeof(struct changed_submodule_data));
>  		cs_data = item->util;
> +		cs_data->super_oid = commit_oid;
> +		cs_data->path = xstrdup(p->two->path);

Iffy.  If item->util were populated already, wouldn't cs_data
already have its .path member pointing at an allocated piece of
memory?  Can we safely free it before assigning a new value, or does
somebody else still have a copy of .path and we cannot free it?
