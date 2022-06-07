Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7109AC433EF
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 19:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352267AbiFGT2o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 15:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356406AbiFGT1m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 15:27:42 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E431A0045
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 11:09:51 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A3B3E198B23;
        Tue,  7 Jun 2022 14:09:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IPyXUko23UTqbuektbGVrDmal5dhlMIr+6ZngY
        w0/No=; b=AymFRortNFEkDmdtyssrTZuksQrCzZ3ZpDed/xJECWKUqf1Db9WSIC
        AIJ7sorknO+ihpwLA3rdqDsql22qiJh8F+7xCpEI7lXwH+YNVGx+1omVYKpECFvO
        H3xcC/YwL/zVHlQQC2BRq/owqD0G4hjzcrQU59R408zYk/MrLOKho=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9BECD198B22;
        Tue,  7 Jun 2022 14:09:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4C66E198B1F;
        Tue,  7 Jun 2022 14:09:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood@talktalk.net>
Subject: Re: [PATCH 3/3] remote API: don't buggily FREE_AND_NULL(), free()
 instead
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
        <cover-0.3-00000000000-20220607T154520Z-avarab@gmail.com>
        <patch-3.3-062fb3f454e-20220607T154520Z-avarab@gmail.com>
        <kl6lv8tccspo.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Tue, 07 Jun 2022 11:09:45 -0700
In-Reply-To: <kl6lv8tccspo.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Tue, 07 Jun 2022 10:02:27 -0700")
Message-ID: <xmqqsfogwdjq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03FBE98C-E68D-11EC-A30C-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> I suppose the question of whether or not to free() in the 'destructor'
> depends on whether we expect the struct to be reusable? I don't expect
> that "struct remote_state" needs to be reused, so free()-ing it is ok to
> me.
>
> The API is not _that_ odd though ;) As you noted, my initial use of
> FREE_AND_NULL() is for consistency reasons with the rest of
> repo_clear(), which looks like this:
>
> 	if (repo->config) {
> 		git_configset_clear(repo->config);
> 		FREE_AND_NULL(repo->config);

So git_configset_clear() does clear but does not free.

> 	}
>
> 	if (repo->submodule_cache) {
> 		submodule_cache_free(repo->submodule_cache);

submodule_cache_free() does (probably clear and) free.

> 		repo->submodule_cache = NULL;
> 	}
>
> 	if (repo->index) {
> 		discard_index(repo->index);

discard_index() does not free.

> 		if (repo->index != &the_index)
> 			FREE_AND_NULL(repo->index);
> 	}
>
> 	if (repo->promisor_remote_config) {
> 		promisor_remote_clear(repo->promisor_remote_config);

promisor_remote_clear() does not free.

> 		FREE_AND_NULL(repo->promisor_remote_config);
> 	}
>
> 	if (repo->remote_state) {
> 		remote_state_clear(repo->remote_state);
>  -	FREE_AND_NULL(repo->remote_state);
>  +	repo->remote_state = NULL;
> 	}
>
> promisor_remote_clear(), discard_index(), and git_configset_clear()
> don't free() the struct, so it makes sense for them to use
> FREE_AND_NULL(). AFAICT, these structs are meant to be reused, so it
> makes sense that we "clear" it without freeing the struct pointer
> itself.
>
> On the other hand, submodule_cache_free() _does_ free() the struct, and
> so we just use "= NULL". I noticed that this uses the verb "free", and
> not "clear".
>
> So now that remote_state_clear() *does* free() the struct, it is
> perfectly fine to use "= NULL" here as well, though it uses the verb
> "clear".
>
> I'm not sure if we have a style around clear/free. Feel free to ignore
> if there isn't one.

It does bother me.  Changing _clear() that did not free the
container resource to free it, without changing the name to free or
release or whatever, smells like leaving a source of confusion for
future developers.


