Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2179207DF
	for <e@80x24.org>; Fri, 16 Sep 2016 17:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965100AbcIPR1P (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 13:27:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56894 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S936119AbcIPR1O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 13:27:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2511F3EC08;
        Fri, 16 Sep 2016 13:27:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XByHc3b/JN9q74A4NB1trJenxPA=; b=XXmSNj
        mXTduQgvPkKQOIpBHm3gkQxUEqjDMNt5dgmCqbHi5XrzKvfxpgbHFAsDiBHOMbEp
        JAuRZm/LKBQ+rcF8qdrYd8nbMSZWpqijfkVsJZGGI9w8DzG3NW6AyIlENGW4xlav
        SzIou6IsjmxmObpCrPKtkl7eFiCIw5qctUF58=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=g8NhG+qAa5jX0JI6tH+Ks9GDIduJGipA
        QZJlogpYxLkt2RTT7z4tOgxkEvksfYqGuyp3z1EWsw9khtlRdnTysIKhA+LI8UQE
        BmQP7k4158pL/TT3n18qPwkIGGkzBVcl6zpLJK/p2ZICZxgXcQjjXHhEdxeJacFw
        KmnKCAeRzwU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1DBFD3EC07;
        Fri, 16 Sep 2016 13:27:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 714A13EC06;
        Fri, 16 Sep 2016 13:27:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: Re: [PATCH 1/2] serialize collection of changed submodules
References: <20160824173017.24782-1-sbeller@google.com>
        <20160824183112.ceekegpzavnbybxp@sigill.intra.peff.net>
        <xmqqh9aaot49.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYOBqQ0FF4J-+KbefSD8HRrUeMqpO27m_jprhm93aB+LA@mail.gmail.com>
        <20160824230115.jhmcr4r7wobj5ejb@sigill.intra.peff.net>
        <20160914173124.GA7613@sandbox>
Date:   Fri, 16 Sep 2016 10:27:04 -0700
In-Reply-To: <20160914173124.GA7613@sandbox> (Heiko Voigt's message of "Wed,
        14 Sep 2016 19:31:24 +0200")
Message-ID: <xmqqintvlpqv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CA49F5AA-7C32-11E6-BED9-096F12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heiko Voigt <hvoigt@hvoigt.net> writes:

> +static struct sha1_array *get_sha1s_from_list(struct string_list *submodules,
> +		const char *path)
> +{
> +	struct string_list_item *item;
> +	struct sha1_array *hashes;
> +
> +	item = string_list_insert(submodules, path);
> +	if (item->util)
> +		return (struct sha1_array *) item->util;
> +
> +	hashes = (struct sha1_array *) xmalloc(sizeof(struct sha1_array));
> +	/* NEEDSWORK: should we add an initializer function for
> +	 * sha1_array ? */
> +	memset(hashes, 0, sizeof(struct sha1_array));
> +	item->util = hashes;


	/* NEEDSWORK: should we have SHA1_ARRAY_INIT etc.? */
	item->util = xcalloc(1, sizeof(struct sha1_array));

>  static void collect_submodules_from_diff(struct diff_queue_struct *q,
>  					 struct diff_options *options,
>  					 void *data)
>  {
>  	int i;
> -	struct string_list *needs_pushing = data;
> +	struct string_list *submodules = data;
>  
>  	for (i = 0; i < q->nr; i++) {
>  		struct diff_filepair *p = q->queue[i];
> +		struct sha1_array *hashes;
>  		if (!S_ISGITLINK(p->two->mode))
>  			continue;
> -		if (submodule_needs_pushing(p->two->path, p->two->oid.hash))
> -			string_list_insert(needs_pushing, p->two->path);
> +		hashes = get_sha1s_from_list(submodules, p->two->path);
> +		sha1_array_append(hashes, p->two->oid.hash);
>  	}
>  }

So the idea at this step is still let each commit in the top-level
history inspected for any submodule change, but the result is
collected in a mapping (submodule -> [ list of submodule commits ]).
As we do not expect too many "oops, the old commit was better, so
let's revert and rebind the old one from the submodule" in the
history of the top-level, appending and then running for-each-unique
is an efficient way, instead of first checking if we already have
it and then inserting new ones to maintain the uniqueness.

Makes sense.

> @@ -582,14 +601,41 @@ static void find_unpushed_submodule_commits(struct commit *commit,
>  	diff_tree_combined_merge(commit, 1, &rev);
>  }
>  
> +struct collect_submodule_from_sha1s_data {
> +	char *submodule_path;
> +	struct string_list *needs_pushing;
> +};
> +
> +static void collect_submodules_from_sha1s(const unsigned char sha1[20],
> +		void *data)
> +{
> +	struct collect_submodule_from_sha1s_data *me =
> +		(struct collect_submodule_from_sha1s_data *) data;
> +
> +	if (submodule_needs_pushing(me->submodule_path, sha1))
> +		string_list_insert(me->needs_pushing, me->submodule_path);
> +}

This is called from sha1_array_for_each_unique() that iterates over
the submodule commit object names for one submodule and then ends up
calling submodule_needs_pushing() number of times, which smells less
efficient than it could be.  You can ask

    rev-list <all the submodule commits to be pushed> --not --remotes

just once in the submodule repository.  I imagine that is what you'll
do in the next patch.

An obvious but much less efficient way to optimize this part would
be to see if me->needs_pushing already has me->submodule_path and
skip the check for submodule_needs_pushing(), but if you drop the
call by find_unpushed_submodule to sha1_array_for_each_unique() to
walk new submodule commits one by one, that would become irrelevant.

> +static void free_submodules_sha1s(struct string_list *submodules)
> +{
> +	int i;
> +	for (i = 0; i < submodules->nr; i++) {
> +		struct string_list_item *item = &submodules->items[i];
> +		struct sha1_array *hashes = (struct sha1_array *) item->util;
> +		sha1_array_clear(hashes);
> +	}
> +	string_list_clear(submodules, 1);
> +}
> +
>  int find_unpushed_submodules(unsigned char new_sha1[20],
>  		const char *remotes_name, struct string_list *needs_pushing)
>  {
>  	struct rev_info rev;
>  	struct commit *commit;
>  	const char *argv[] = {NULL, NULL, "--not", "NULL", NULL};
> -	int argc = ARRAY_SIZE(argv) - 1;
> +	int argc = ARRAY_SIZE(argv) - 1, i;
>  	char *sha1_copy;
> +	struct string_list submodules = STRING_LIST_INIT_DUP;
>  
>  	struct strbuf remotes_arg = STRBUF_INIT;
>  
> @@ -603,12 +649,23 @@ int find_unpushed_submodules(unsigned char new_sha1[20],
>  		die("revision walk setup failed");
>  
>  	while ((commit = get_revision(&rev)) != NULL)
> -		find_unpushed_submodule_commits(commit, needs_pushing);
> +		find_unpushed_submodule_commits(commit, &submodules);
>  
>  	reset_revision_walk();
>  	free(sha1_copy);
>  	strbuf_release(&remotes_arg);
>  
> +	for (i = 0; i < submodules.nr; i++) {
> +		struct string_list_item *item = &submodules.items[i];
> +		struct collect_submodule_from_sha1s_data data;
> +		data.submodule_path = item->string;
> +		data.needs_pushing = needs_pushing;
> +		sha1_array_for_each_unique((struct sha1_array *) item->util,
> +				collect_submodules_from_sha1s,
> +				&data);
> +	}
> +	free_submodules_sha1s(&submodules);
> +
>  	return needs_pushing->nr;
>  }
