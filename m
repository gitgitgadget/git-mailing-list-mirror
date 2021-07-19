Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D130C6379A
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 23:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 935D96113E
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 23:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376499AbhGSWYt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 18:24:49 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53598 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388255AbhGSUrk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 16:47:40 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A4691134C13;
        Mon, 19 Jul 2021 17:28:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7CYd1/+9AZbhOrmM81/f1YeWtYjs6Nr7xb/Rj/
        vhZWk=; b=saaw9xU57sn52nSiP223ImFTbqQlVsrfd8idydH7l3L+4dmfb0SWI3
        8kwlwjfuNkzB5hXnTyb0zNBcpC6X9cq5uq3as3vUw1BwgrP7ntB/LoYRSPlpo/qi
        zEQgE6GPW4idiGcdgx+++r9Ng9qHEXCO22TunVQ9QWo6ZBi6LjtpQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9C982134C12;
        Mon, 19 Jul 2021 17:28:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EA471134C0D;
        Mon, 19 Jul 2021 17:28:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, iankaz@google.com,
        sandals@crustytoothpaste.net, avarab@gmail.com,
        emilyshaffer@google.com
Subject: Re: [RFC PATCH v2 2/2] hook: remote-suggested hooks
References: <cover.1623881977.git.jonathantanmy@google.com>
        <cover.1626453569.git.jonathantanmy@google.com>
        <1ec1c958eb2b8aa2581280d050836dd0e7f6edef.1626453569.git.jonathantanmy@google.com>
Date:   Mon, 19 Jul 2021 14:28:09 -0700
In-Reply-To: <1ec1c958eb2b8aa2581280d050836dd0e7f6edef.1626453569.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Fri, 16 Jul 2021 10:57:41 -0700")
Message-ID: <xmqqzguij8nq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 37AF9598-E8D8-11EB-82F8-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Teach the "git hook install all|<hook-name>" command, that can install
> one or all remote-suggested hooks.
>
> If a configuration option hook.promptRemoteSuggested is set, inform the
> user of the aforementioned command:
>
>  - when cloning, and refs/remotes/origin/suggested-hooks is present in
>    the newly cloned repo
>  - when fetching, and refs/remotes/origin/suggested-hooks is updated
>  - when committing, there is a remote-suggested commit-msg hook, and
>    there is currently no commit-msg hook configured
>
> NEEDSWORK: Write a more detailed commit message once the design is
> finalized.

OK.  Let's take this more as WIP.

> diff --git a/builtin/clone.c b/builtin/clone.c
> index 2a2a03bf76..c2c8596aa9 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1393,6 +1393,18 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  			   branch_top.buf, reflog_msg.buf, transport,
>  			   !is_local);
>  
> +	if (hook_should_prompt_suggestions()) {
> +		for (ref = mapped_refs; ref; ref = ref->next) {
> +			if (ref->peer_ref &&
> +			    !strcmp(ref->peer_ref->name,
> +				    "refs/remotes/origin/suggested-hooks")) {
> +				fprintf(stderr, _("The remote has suggested hooks in refs/remotes/origin/suggested-hooks.\n"
> +						  "Run `git hook install all` to install them.\n"));
> +				break;
> +			}
> +		}

Hmph, do we really need to iterate over these mapped refs array?  It
seems to me that it would be vastly simpler to check if that single
ref exists after "clone" finishes depositing all the refs we are
supposed to create.

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 769af53ca4..e86c312473 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -28,6 +28,7 @@
>  #include "promisor-remote.h"
>  #include "commit-graph.h"
>  #include "shallow.h"
> +#include "hook.h"
>  
>  #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)
>  
> @@ -1313,6 +1314,22 @@ static int consume_refs(struct transport *transport, struct ref *ref_map)
>  				 ref_map);
>  	transport_unlock_pack(transport);
>  	trace2_region_leave("fetch", "consume_refs", the_repository);
> +
> +	if (hook_should_prompt_suggestions()) {
> +		struct ref *ref;
> +
> +		for (ref = ref_map; ref; ref = ref->next) {
> +			if (ref->peer_ref &&
> +			    !strcmp(ref->peer_ref->name,
> +				    "refs/remotes/origin/suggested-hooks") &&
> +			    oidcmp(&ref->old_oid, &ref->peer_ref->old_oid)) {
> +				fprintf(stderr, _("The remote has updated its suggested hooks.\n"));
> +				fprintf(stderr, _("Run 'git hook install all' to update.\n"));
> +				break;

Again we _could_ do "remember if we had it and at where, and then
compare after we fetch", but this _might_ be simpler.

I however do not know if it makes sense to have a separate loop just
for this.  This should be done as a part of store_updated_refs(),
no?

On top of this patch, if we wanted to add yet another "this ref is
special and pay attention to it when it got updated", it makes a lot
more sense not to add yet another loop that is a copy of this one in
consume_refs(), but roll the handling of that new ref into a loop
that already exists.  And for the purpose of such an update, I do
not see why that "loop that already exists" should not be the one
that goes over ref_map in store_updated_refs().  For the same
reason, "the remote-tracking ref 'origin/suggested-hooks' is special"
can and should go to an existing loop in store_updated_refs(), no?

How does this interact with the "--dry-run" option, by the way?
What if ref_map proposes to update this suggested-hooks ref, but
"--atomic" fetch feature finds that some other branches do not
fast-forward and we end up not updating the suggested-hooks ref,
either?

So, unlike my earlier guess, it _might_ turn out that "remember the
state before the fetch, see if the fetch actually updated and then
report" could be simpler to design and implement.  I dunno.
