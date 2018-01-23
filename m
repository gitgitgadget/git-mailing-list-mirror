Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A77191F404
	for <e@80x24.org>; Tue, 23 Jan 2018 20:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752524AbeAWUDe (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 15:03:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54580 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752519AbeAWUDc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 15:03:32 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CEB20C7B14;
        Tue, 23 Jan 2018 15:03:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZjoEjiKPpR9MaJyGl9u8n0Yudzg=; b=PKqyTR
        ELmFtCFU1i3uUPZ5NEwozq34o/lJRQYgoEZvbddp708CgD+KtKzY2EnQOzwcc4N7
        Vw64GRGv1ddoPxvngGrCHtr0iofZyytwpZUtNpbqlYv0RN7mdxBFKK3QeULwveTs
        eTapRt3gV/py9jlKQ5E6+PJNK0AxxhJ3rzRdg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FHgPomZcuGCu90Xmpuwd9XeymEeJVDYE
        flQlMynES3EDJTXvDjpqTfDR1IRN0Snt2G+yrlkTl7POwbYVbQfd0J8D0rqB08kN
        nEg1GrM3K/bTft0nQlMJWlw+KKbaRKiPf3eM9JLikazewAjA0NdeUviUDmJg2cMg
        ivTieL27oeg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C69DBC7B13;
        Tue, 23 Jan 2018 15:03:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 44A7BC7B11;
        Tue, 23 Jan 2018 15:03:31 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 4/8] rebase-helper --make-script: introduce a flag to recreate merges
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
        <b9cb2d915aa4ff564b1960ce0352664b1d26eecb.1516225925.git.johannes.schindelin@gmx.de>
Date:   Tue, 23 Jan 2018 12:03:30 -0800
In-Reply-To: <b9cb2d915aa4ff564b1960ce0352664b1d26eecb.1516225925.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Thu, 18 Jan 2018 16:35:40 +0100
        (STD)")
Message-ID: <xmqqh8rcgx65.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7C19E50E-0078-11E8-A9EB-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The sequencer just learned a new commands intended to recreate branch

s/a //;

> structure (similar in spirit to --preserve-merges, but with a
> substantially less-broken design).
> ...
> @@ -2785,6 +2787,335 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
>  	strbuf_release(&sob);
>  }
>  
> +struct labels_entry {
> +	struct hashmap_entry entry;
> +	char label[FLEX_ARRAY];
> +};
> +
> +static int labels_cmp(const void *fndata, const struct labels_entry *a,
> +		      const struct labels_entry *b, const void *key)
> +{
> +	return key ? strcmp(a->label, key) : strcmp(a->label, b->label);
> +}

label_oid() accesses state->labels hash using strihash() as the hash
function, but the final comparison between the entries in the same
hash buckets are done with case sensitivity.  It is unclear to me if
that is what was intended, and why.

> +struct string_entry {
> +	struct oidmap_entry entry;
> +	char string[FLEX_ARRAY];
> +};
> +
> +struct label_state {
> +	struct oidmap commit2label;
> +	struct hashmap labels;
> +	struct strbuf buf;
> +};
> +
> +static const char *label_oid(struct object_id *oid, const char *label,
> +			     struct label_state *state)
> +{
> +	struct labels_entry *labels_entry;
> +	struct string_entry *string_entry;
> +	struct object_id dummy;
> +	size_t len;
> +	int i;
> +
> +	string_entry = oidmap_get(&state->commit2label, oid);
> +	if (string_entry)
> +		return string_entry->string;
> +
> +	/*
> +	 * For "uninteresting" commits, i.e. commits that are not to be
> +	 * rebased, and which can therefore not be labeled, we use a unique
> +	 * abbreviation of the commit name. This is slightly more complicated
> +	 * than calling find_unique_abbrev() because we also need to make
> +	 * sure that the abbreviation does not conflict with any other
> +	 * label.
> +	 *
> +	 * We disallow "interesting" commits to be labeled by a string that
> +	 * is a valid full-length hash, to ensure that we always can find an
> +	 * abbreviation for any uninteresting commit's names that does not
> +	 * clash with any other label.
> +	 */
> +	if (!label) {
> +		char *p;
> +
> +		strbuf_reset(&state->buf);
> +		strbuf_grow(&state->buf, GIT_SHA1_HEXSZ);
> +		label = p = state->buf.buf;
> +
> +		find_unique_abbrev_r(p, oid->hash, default_abbrev);
> +
> +		/*
> +		 * We may need to extend the abbreviated hash so that there is
> +		 * no conflicting label.
> +		 */
> +		if (hashmap_get_from_hash(&state->labels, strihash(p), p)) {
> +			size_t i = strlen(p) + 1;
> +
> +			oid_to_hex_r(p, oid);
> +			for (; i < GIT_SHA1_HEXSZ; i++) {
> +				char save = p[i];
> +				p[i] = '\0';
> +				if (!hashmap_get_from_hash(&state->labels,
> +							   strihash(p), p))
> +					break;
> +				p[i] = save;
> +			}
> +		}

If oid->hash required full 40-hex to disambiguate, then
find-unique-abbrev would give 40-hex and we'd want the same "-<num>"
suffix technique employed below to make it consistently unique.  I
wonder if organizing the function this way ...

	if (!label)
		label = oid-to-hex(oid);

	if (label already exists or full oid) {
		make it unambiguous;
	}

... allows the resulting code easier to understand and manage.

A related tangent.  Does an auto-label given to "uninteresting"
commit need to be visible to end users?  I doubted it and that is
why I said oid-to-hex in the above, but if it is given to end users,
use of find-unique-abbrev-r is perfectly fine.

> +static int make_script_with_merges(struct pretty_print_context *pp,
> +				   struct rev_info *revs, FILE *out,
> +				   unsigned flags)
> +{
> + ...
> +	int abbr = flags & TODO_LIST_ABBREVIATE_CMDS;
> +	const char *p = abbr ? "p" : "pick", *l = abbr ? "l" : "label",
> +		 *t = abbr ? "t" : "reset", *b = abbr ? "b" : "bud",
> +		 *m = abbr ? "m" : "merge";

It would be easier to understand if these short named variables are
reserved only for temporary use, not as constants.  It is not too
much to spell 

	fprintf(out, "%s onto\n", cmd_label);

than

	fprintf(out, "%s onto\n", l);

and would save readers from head-scratching, wondering where the
last assignment to variable "l" is.

> +
> +	oidmap_init(&commit2todo, 0);
> +	oidmap_init(&state.commit2label, 0);
> +	hashmap_init(&state.labels, (hashmap_cmp_fn) labels_cmp, NULL, 0);
> +	strbuf_init(&state.buf, 32);
> +
> +	if (revs->cmdline.nr && (revs->cmdline.rev[0].flags & BOTTOM)) {
> +		struct object_id *oid = &revs->cmdline.rev[0].item->oid;
> +		FLEX_ALLOC_STR(entry, string, "onto");
> +		oidcpy(&entry->entry.oid, oid);
> +		oidmap_put(&state.commit2label, entry);
> +	}
> +
> +	/*
> +	 * First phase:
> +	 * - get onelines for all commits
> +	 * - gather all branch tips (i.e. 2nd or later parents of merges)
> +	 * - label all branch tips
> +	 */

When an early part of a branch is merged and then the remaining part
of the same branch is merged again, "branch tip" and "2nd or later
parents of merges" would become different concepts.  The 2nd parent
of an early merge is not among the branch tips.

For the purpose of the "recreate the topology" algorithm, I am
imagining that you would need not just the tips but all the 2nd and
subsequent parents of merges, and my quick skimming tells me that
the following code grabs them correctly.
