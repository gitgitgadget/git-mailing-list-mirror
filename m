Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B4CC433F5
	for <git@archiver.kernel.org>; Thu, 29 Sep 2022 20:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiI2UO2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Sep 2022 16:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiI2UO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2022 16:14:27 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970451FD887
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 13:14:26 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D2CFF1537B5;
        Thu, 29 Sep 2022 16:14:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=V2AW8EJwC3a6QsbCf2sUOBqLZ1gohZ79EtwWQK
        4TAxY=; b=YkuVFuz13Oy7t27EWsKlyigxX7NW3Kd+cKJjlY6qlf5HVvGUWGvA9E
        9bbVOL4ibCJy/zTrAeY8koRXh8IlL3ZI0z3kjrTR+vC3u4kXrBjq6XMvonJ+pfEz
        2MCWyZV6f2nN6mzwcATZLIf2AXlXItc+6is74dBhbTQH03Di8KgS0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CAF961537B4;
        Thu, 29 Sep 2022 16:14:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 430DC1537B3;
        Thu, 29 Sep 2022 16:14:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] promisor-remote: die upon failing fetch
References: <cover.1664316642.git.jonathantanmy@google.com>
        <7f6412eb8ce0c47a7645b89fab171a212353f8b2.1664316642.git.jonathantanmy@google.com>
Date:   Thu, 29 Sep 2022 13:14:22 -0700
In-Reply-To: <7f6412eb8ce0c47a7645b89fab171a212353f8b2.1664316642.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Tue, 27 Sep 2022 15:12:30 -0700")
Message-ID: <xmqqh70qndk1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F18F130-4033-11ED-A766-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> diff --git a/object-file.c b/object-file.c
> index 5b270f046d..5e30960234 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1599,10 +1599,6 @@ static int do_oid_object_info_extended(struct repository *r,
>  		if (fetch_if_missing && repo_has_promisor_remote(r) &&
>  		    !already_retried &&
>  		    !(flags & OBJECT_INFO_SKIP_FETCH_OBJECT)) {
> -			/*
> -			 * TODO Investigate checking promisor_remote_get_direct()
> -			 * TODO return value and stopping on error here.
> -			 */
>  			promisor_remote_get_direct(r, real, 1);
>  			already_retried = 1;
>  			continue;
> diff --git a/promisor-remote.c b/promisor-remote.c
> index 8b4d650b4c..faa7612941 100644
> --- a/promisor-remote.c
> +++ b/promisor-remote.c
> @@ -4,6 +4,7 @@
>  #include "config.h"
>  #include "transport.h"
>  #include "strvec.h"
> +#include "packfile.h"
>  
>  struct promisor_remote_config {
>  	struct promisor_remote *promisors;
> @@ -238,6 +239,7 @@ void promisor_remote_get_direct(struct repository *repo,
>  	struct object_id *remaining_oids = (struct object_id *)oids;
>  	int remaining_nr = oid_nr;
>  	int to_free = 0;
> +	int i;
>  
>  	if (oid_nr == 0)
>  		return;
> @@ -255,9 +257,16 @@ void promisor_remote_get_direct(struct repository *repo,
>  				continue;
>  			}
>  		}
> -		break;
> +		goto all_fetched;

OK.  So when fetch_object() says it got everything we asked it to
give, there is no behaviour change.  But if invocations of
fetch_objects() on all promisor remotes end unsuccessfully, we see
if some are supposed to be available from the promisor remote and
die.

An obvious alternative would be to do without the previous step, and
instead tighten the callers to react to error return, and then from
the new code, return a different error return value to allow the
caller to tell what kind of breakage it got.  But this extra die()
with more sloppy callers would probably work just fine in practice.

> +	}
> +
> +	for (i = 0; i < remaining_nr; i++) {
> +		if (is_promisor_object(&remaining_oids[i]))
> +			die(_("could not fetch %s from promisor remote"),
> +			    oid_to_hex(&remaining_oids[i]));
>  	}
>  
> +all_fetched:
>  	if (to_free)
>  		free(remaining_oids);
>  }
