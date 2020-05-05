Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E234C47256
	for <git@archiver.kernel.org>; Tue,  5 May 2020 05:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4CAF206B9
	for <git@archiver.kernel.org>; Tue,  5 May 2020 05:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bgEikyT2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbgEEFku (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 01:40:50 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62011 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgEEFku (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 01:40:50 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BA642C0EC2;
        Tue,  5 May 2020 01:40:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+8RrteK0z+zMXga6oQ8CKJxiuzk=; b=bgEiky
        T23coOCus+KTnQoNzExbp9/9G6j6SVG81WfHqqtzWcQsGzSlcNwbT78HUeJA/0qK
        SnUU+Wv1HS2s6c+SoYMCIiBnio2Tq7CJkhRQhkC2AkI6x0HJm4L5uzqyvAMFb1cG
        Q3X1X3yzOjL/7o2NODmuVWzs6WfI4Nq74fmCs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DAyYzaNEDEjpV+12Uobn33d/LrMZyiAw
        y1SJbms6RfJx3z/tl4d0CTbP9//Cq/RRuoa346H9riICYeIFZqpOXuhf9ojz8Rwx
        LjR4Kty6PoiuQpnVFaPuj6rvAhmtj7OGd9PnrCFL8i1cblOm5iT1cvZZZDE8sU6E
        Xoev0MsKqNA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B2634C0EC1;
        Tue,  5 May 2020 01:40:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A9956C0EC0;
        Tue,  5 May 2020 01:40:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, chriscool@tuxfamily.org
Subject: Re: [PATCH 4/4] pack-bitmap: pass object filter to fill-in traversal
References: <cover.1588633810.git.me@ttaylorr.com>
        <f1eb194b9fdf5e385610fa3c0ddee22b89cf4f0e.1588633810.git.me@ttaylorr.com>
Date:   Mon, 04 May 2020 22:40:43 -0700
In-Reply-To: <f1eb194b9fdf5e385610fa3c0ddee22b89cf4f0e.1588633810.git.me@ttaylorr.com>
        (Taylor Blau's message of "Mon, 4 May 2020 17:12:38 -0600")
Message-ID: <xmqq1rnzc52c.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F6E9CFEC-8E92-11EA-B2D6-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> But now that we support tree filters, there's opportunity for savings. A
> tree:depth=0 filter means we can avoid accessing trees entirely, since
> we know we won't them (or any of the subtrees or blobs they point to).

"we know we won't _have_ them"?

> @@ -506,7 +506,8 @@ static int should_include(struct commit *commit, void *_data)
>  static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
>  				   struct rev_info *revs,
>  				   struct object_list *roots,
> -				   struct bitmap *seen)
> +				   struct bitmap *seen,
> +				   struct list_objects_filter_options *filter)
>  {
>  	struct bitmap *base = NULL;
>  	int needs_walk = 0;
> @@ -599,8 +600,9 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
>  		show_data.bitmap_git = bitmap_git;
>  		show_data.base = base;
>  
> -		traverse_commit_list(revs, show_commit, show_object,
> -				     &show_data);
> +		traverse_commit_list_filtered(filter, revs,
> +					      show_commit, show_object,
> +					      &show_data, NULL);

And then finally the change in step 1/4 pays off.

>  	}
>  
>  	return base;
> @@ -999,7 +1001,8 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
>  
>  	if (haves) {
>  		revs->ignore_missing_links = 1;
> -		haves_bitmap = find_objects(bitmap_git, revs, haves, NULL);
> +		haves_bitmap = find_objects(bitmap_git, revs, haves, NULL,
> +					    filter);
>  		reset_revision_walk();
>  		revs->ignore_missing_links = 0;
>  
> @@ -1007,7 +1010,8 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
>  			BUG("failed to perform bitmap walk");
>  	}
>  
> -	wants_bitmap = find_objects(bitmap_git, revs, wants, haves_bitmap);
> +	wants_bitmap = find_objects(bitmap_git, revs, wants, haves_bitmap,
> +				    filter);
>  
>  	if (!wants_bitmap)
>  		BUG("failed to perform bitmap walk");
> diff --git a/t/perf/p5310-pack-bitmaps.sh b/t/perf/p5310-pack-bitmaps.sh
> index 75ccf9f4e3..b3e725f031 100755
> --- a/t/perf/p5310-pack-bitmaps.sh
> +++ b/t/perf/p5310-pack-bitmaps.sh
> @@ -91,4 +91,9 @@ test_perf 'pack to file (partial bitmap)' '
>  	git pack-objects --use-bitmap-index --all pack2b </dev/null >/dev/null
>  '
>  
> +test_perf 'rev-list with tree filter (partial bitmap)' '
> +	git rev-list --use-bitmap-index --count --objects --all \
> +		--filter=tree:0 >/dev/null
> +'
> +
>  test_done
