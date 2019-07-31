Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DC221F731
	for <e@80x24.org>; Wed, 31 Jul 2019 18:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfGaSMI (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 14:12:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61920 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbfGaSMH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 14:12:07 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 57A76159E78;
        Wed, 31 Jul 2019 14:12:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PRXM3dy3/ec2q9RMT9Nfz2ABZ/Y=; b=XnUC63
        sp52FBd0jjOnAPRoGecnPl1xa4aGdlA0QQfpMNZUAoWPxv8KDDjdcuRd29tfyj7q
        catnkP00NtbAxiVbzOZfHIRdV89dAxNlu2d3T3SliPtlQrd7bVFW24rYoae5s7uQ
        uA2qAzV8N6wMU+Iyh6oL9yEIAyC5n4WVKDYzs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cfSMwmvheTg333ZV7PV2FfdzOzBQzlcS
        c5I4xsN1tNVkUIgLFyT0a+NIU6ELwvrG1QzWDIob1L27dW/I03lWTQsAmc0ZkfRp
        IfuGhAWTO+cIDqdcbbn/RXJVZ7sHbP1HJ7PRdWeAMyIIZlblOggCl4MJ3oU/Rjel
        /Mfrl2Ot+6Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4CC9D159E77;
        Wed, 31 Jul 2019 14:12:05 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 879E1159E76;
        Wed, 31 Jul 2019 14:12:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Daniel Ferreira via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>, Daniel Ferreira <bnmvco@gmail.com>
Subject: Re: [PATCH v3 03/11] built-in add -i: implement the `status` command
References: <pull.170.v2.git.gitgitgadget@gmail.com>
        <pull.170.v3.git.gitgitgadget@gmail.com>
        <b93b055ebeef98be11a1658453df6f85fed87347.1563289115.git.gitgitgadget@gmail.com>
Date:   Wed, 31 Jul 2019 11:12:02 -0700
In-Reply-To: <b93b055ebeef98be11a1658453df6f85fed87347.1563289115.git.gitgitgadget@gmail.com>
        (Daniel Ferreira via GitGitGadget's message of "Tue, 16 Jul 2019
        07:58:38 -0700 (PDT)")
Message-ID: <xmqqsgqmoyz1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B35B2D7A-B3BE-11E9-994A-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Daniel Ferreira via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +struct item {
> +	const char *name;
> +};
> +
> +struct list_options {
> +	const char *header;
> +	void (*print_item)(int i, struct item *item, void *print_item_data);
> +	void *print_item_data;
> +};
> +
> +struct adddel {
> +	uintmax_t add, del;
> +	unsigned seen:1, binary:1;
> +};
> +
> +struct file_list {
> +	struct file_item {
> +		struct item item;
> +		struct adddel index, worktree;
> +	} **file;
> +	size_t nr, alloc;
> +};
> +
> +struct pathname_entry {
> +	struct hashmap_entry ent;
> +	size_t index;
> +	char pathname[FLEX_ARRAY];
> +};

All of the above are named too generic but assuming that add-i will
stay to be a single file and these names will never leak outside the
file to become global, it would be perfectly fine.

> +static void populate_wi_changes(struct strbuf *buf,
> +				struct adddel *ad, const char *no_changes)
> +{
> +	if (ad->binary)
> +		strbuf_addstr(buf, _("binary"));
> +	else if (ad->seen)
> +		strbuf_addf(buf, "+%"PRIuMAX"/-%"PRIuMAX,
> +			    (uintmax_t)ad->add, (uintmax_t)ad->del);
> +	else
> +		strbuf_addstr(buf, no_changes);
> +}

I offhand do not see the need for (uintmax_t) casts here...

> +static int run_status(struct repository *r, const struct pathspec *ps,
> +		      struct file_list *files, struct list_options *opts)
> +{
> +	reset_file_list(files);
> +
> +	if (get_modified_files(r, files, ps) < 0)
> +		return -1;
> +
> +	if (files->nr)
> +		list((struct item **)files->file, files->nr, opts);
> +	putchar('\n');

So, if there is anything to list, we show list() and then add an
empty line; if there is nothing to list, we show an empty line
anyway?

As long as that matches the current scripted "add -i", it's
perfectly fine.  It's just that the code structure above looked
somewhat odd.

> +static void collect_changes_cb(struct diff_queue_struct *q,
> +			       struct diff_options *options,
> +			       void *data)
> +{
> +	struct collection_status *s = data;
> +	struct diffstat_t stat = { 0 };
> +	int i;
> +
> +	if (!q->nr)
> +		return;
> +
> +	compute_diffstat(options, &stat, q);
> +
> +	for (i = 0; i < stat.nr; i++) {
> +		const char *name = stat.files[i]->name;
> +		int hash = strhash(name);
> +		struct pathname_entry *entry;
> +		size_t file_index;
> +		struct file_item *file;
> +		struct adddel *adddel;
> +
> +		entry = hashmap_get_from_hash(&s->file_map, hash, name);
> +		if (entry)
> +			file_index = entry->index;
> +		else {
> +			FLEX_ALLOC_STR(entry, pathname, name);
> +			hashmap_entry_init(entry, hash);
> +			entry->index = file_index = s->list->nr;
> +			hashmap_add(&s->file_map, entry);
> +
> +			add_file_item(s->list, name);
> +		}
> +		file = s->list->file[file_index];
> +
> +		adddel = s->phase == FROM_INDEX ? &file->index : &file->worktree;
> +		adddel->seen = 1;
> +		adddel->add = stat.files[i]->added;
> +		adddel->del = stat.files[i]->deleted;
> +		if (stat.files[i]->is_binary)
> +			adddel->binary = 1;
> +	}
> +}

Would resources held in the "stat" structure leak at the end of this
function?
