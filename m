Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0846C11D00
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 22:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A173D207FD
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 22:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JFi9k1eW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgBTWFA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 17:05:00 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60768 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbgBTWE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 17:04:59 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9EB92AEDD9;
        Thu, 20 Feb 2020 17:04:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VnV9wdTa+DF6QFgqkswc0vBz9XU=; b=JFi9k1
        eWpOvWXImAbKTISt9LFJc9AozC1fClrzUuAwgUhz83fj6HbLPvxpkA0eohwS7rlH
        8JB1oCV2IJfSpscXHJlUJsqv/ruerx3DYx7YsGTHj5S+hnox0X656urLk494ts4j
        l07N6Z7rCKVyM021SJUg2EVI4MVbuccGsi7Lk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KQxfhZu54uVi023L8xubR+h48wgyEVRr
        1tjINQLRxZ0y/5ml5GBsZlUdotxSfp45iEGcNySObdgX6vTkVg5OfVI6XTXmKlnD
        JHUsyAH22k78E7W/aBHfm1Th54SEe/FpBOsa0cvU0yfHOMEvqXCnDAuAgiJSJeir
        b5VRuRcew4s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 97045AEDD7;
        Thu, 20 Feb 2020 17:04:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E862AAEDC8;
        Thu, 20 Feb 2020 17:04:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 13/15] bugreport: add packed object summary
References: <20200220015858.181086-1-emilyshaffer@google.com>
        <20200220015858.181086-14-emilyshaffer@google.com>
Date:   Thu, 20 Feb 2020 14:04:52 -0800
In-Reply-To: <20200220015858.181086-14-emilyshaffer@google.com> (Emily
        Shaffer's message of "Wed, 19 Feb 2020 17:58:56 -0800")
Message-ID: <xmqq1rqoapa3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 06A09A24-542D-11EA-82AB-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> +static void get_packed_object_summary(struct strbuf *obj_info, int nongit)
> +{
> +	struct packed_git *pack = NULL;
> +	int pack_count = 0;
> +	int object_count = 0;
> +
> +	if (nongit) {
> +		strbuf_addstr(obj_info,
> +			"not run from a git repository - no objects to show\n");
> +		return;
> +	}
> +
> +	for_each_pack(the_repository, pack) {
> +		pack_count++;
> +		/*
> +		 * To accurately count how many objects are packed, look inside
> +		 * the packfile's index.
> +		 */
> +		open_pack_index(pack);
> +		object_count += pack->num_objects;
> +	}
> +
> +	strbuf_addf(obj_info, "%d total packs (%d objects)\n", pack_count,
> +		    object_count);
> +
> +}

Makes sense.

> @@ -447,4 +448,9 @@ int for_each_object_in_pack(struct packed_git *p,
>  int for_each_packed_object(each_packed_object_fn, void *,
>  			   enum for_each_object_flags flags);
>  
> +#define for_each_pack(repo, pack) 		\
> +		for (pack = get_all_packs(repo);\
> +		     pack;			\
> +		     pack = pack->next)

I generally avoid #define'ing a control loop pseudo-syntax unless it
makes the resulting code hide overly ugly implementation detail.

for_each_string_list() is there to hide the fact that items are
stored in an embedded array whose name is .items and size is .nr
that is sufficiently ugnly to expose, but iterating over packs
does not look so bad.

If you MUST have this as a pseudo-syntax macro, we need

 - to match for_each_string_list_item(), have iterating variable
   'pack' as the first parameter, and the scope of what's iterated
   'repo' as the second.

 - to make sure the syntax works correctly even if a parameter is
   *not* a simple identifier (I think the above is OK, but there may
   be cases that it does not work well).

Regarding the latter, the way 'item' is incremented at the end of
iteration in for_each_string_list_item() is subtle and correct.

#define for_each_string_list_item(item,list)            \
	for (item = (list)->items;                      \
	     item && item < (list)->items + (list)->nr; \
	     ++item)

You would break it if you changed pre-increment to post-increment
for a user like this:

	struct string_list *list;
	struct string_list_item *i, **p;
	p = &i;

	for_each_string_list_item(*p, list) {
		...
	}

because ++*p is ++(*p), while *p++ is (*p)++, and we do want the
former (i.e. increment the memory cell pointed at by pointer p).

Personally, I would prefer not to introduce this macro if I were
working on this topic.

>  #endif /* OBJECT_STORE_H */
> diff --git a/packfile.c b/packfile.c
> index 99dd1a7d09..95afcc1187 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -2095,8 +2095,7 @@ int for_each_packed_object(each_packed_object_fn cb, void *data,
>  	int r = 0;
>  	int pack_errors = 0;
>  
> -	prepare_packed_git(the_repository);
> -	for (p = get_all_packs(the_repository); p; p = p->next) {
> +	for_each_pack(the_repository, p) {
>  		if ((flags & FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
>  			continue;
>  		if ((flags & FOR_EACH_OBJECT_PROMISOR_ONLY) &&
