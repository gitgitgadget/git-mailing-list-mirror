Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3553BC433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 18:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbiDMSUc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 14:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbiDMSUb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 14:20:31 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A734ECDA
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 11:18:09 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 80A4112AE64;
        Wed, 13 Apr 2022 14:18:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xPAsvg2dJNn2wQlJZLByixYRYbWTD0M9BG00b+
        ZrxO8=; b=Wz2z1chbKCPfPgQxsl8HZjO/b+qlsA+IhjDLKXyRaDGvs8FbBP9+9V
        v+sO6oa72SBAzLFoJ/TBJdwjzXyAJNDdL+CXHHjIywTm20Wen1nrzCkukHHfcNfU
        7AOy7kx8qJNstiU8rfSFPjNKKeXJGQhmRHAdkw6+9x3Rt83kfudkc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6972912AE63;
        Wed, 13 Apr 2022 14:18:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9C27512AE62;
        Wed, 13 Apr 2022 14:18:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan <git.jonathan.bressat@gmail.com>
Cc:     cogoni.guillaume@gmail.com, Matthieu.Moy@univ-lyon1.fr,
        git@vger.kernel.org, guillaume.cogoni@gmail.com,
        Jonathan <Jonathan.bressat@etu.univ-lyon1.fr>
Subject: Re: [PATCH 1/1] Merge with untracked file that are the same without
 failure and test
References: <CAA0Qn1sBF=PAduCQCXbYkeu4cphw7O+AnvwFNMWijuKYskaT8g@mail.gmail.com>
        <20220412191556.21135-1-Jonathan.bressat@etu.univ-lyon1.fr>
        <20220412191556.21135-2-Jonathan.bressat@etu.univ-lyon1.fr>
Date:   Wed, 13 Apr 2022 11:18:03 -0700
In-Reply-To: <20220412191556.21135-2-Jonathan.bressat@etu.univ-lyon1.fr>
        (Jonathan's message of "Tue, 12 Apr 2022 21:15:56 +0200")
Message-ID: <xmqqfsmg97ac.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 104B6B3E-BB56-11EC-A861-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan <git.jonathan.bressat@gmail.com> writes:

> diff --git a/unpack-trees.c b/unpack-trees.c
> index 360844bda3..834aca0da9 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -2259,6 +2259,10 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
>  			return 0;
>  	}
>  
> +	if (!ie_modified(&o->result, ce, st, 0))
> +		return 0;
> +
> +
>  	return add_rejected_path(o, error_type, name);
>  }

It probably is better to step back a bit and take a wider look at
the original to assess this change.

The only two callers of this function appears in this function.

        /*
         * We do not want to remove or overwrite a working tree file that
         * is not tracked, unless it is ignored.
         */
        static int verify_absent_1(const struct cache_entry *ce,
                                   enum unpack_trees_error_types error_type,
                                   struct unpack_trees_options *o)
        {
		...

Notice what the comment in front says?  Does this patch change the
behaviour from what the comment tells us it does?  We should adjust
the comment to the new world order if it does.

The existing code before the pre-context of the hunk reads like
this:

            /*
             * The previous round may already have decided to
             * delete this path, which is in a subdirectory that
             * is being replaced with a blob.
             */
            result = index_file_exists(&o->result, name, len, 0);
            if (result) {
                    if (result->ce_flags & CE_REMOVE)
                            return 0;
            }

We've called index_file_exists(), and the new code added here does
not take the outcome into account.

If we truly care the case "we have _UNTRACKED_ path and it happens
to be identical to what we are going to resolve to anyway",
shouldn't we be making sure that the <name,len> refers to an
untracked path by checking if result is NULL here?  If so,

	if (result) {
		...
-	}
+	} else if (!ie_modified(...)) {
+		return 0;
+	}
	return add_rejected_path(...);

is what you want, perhaps?

Or if we have cases where we have a tracked path and ask this
function if it is OK to remove, should the same reasoning you
invented to deal with untracked paths equally apply?  If that is the
case, then the code may be OK but the proposed log message to
explain and justify the change needs to be updated to explain what
happens in such a case (or how such a case will not happen).

Thanks.

