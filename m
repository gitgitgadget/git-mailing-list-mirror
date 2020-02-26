Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92990C4BA21
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 19:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651312467F
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 19:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="S7NOTUzj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgBZTeH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 14:34:07 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54318 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbgBZTeH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 14:34:07 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DDB3D58A0C;
        Wed, 26 Feb 2020 14:34:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oBBdWOPTsVoa4zmHb2RXFHsqdzY=; b=S7NOTU
        zjWscZx5yAeqyFh0hvH5NwW2CWJSkfa9nfYdaC9KdNtjTqwiO8rjeEp0p1IOxhhN
        iJu+LdVgJM/2yud84y8WhrJaiKgzNJr4p54XXjHqDGfe8YOusuGDnsUgAqCcXrIC
        xQb6+bsA0VKW744eVjWRmroEH7E3izQ3lIkUw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WsOVSts0qxfV+Boc2WTwUMpJs60MOiJE
        BwiVWiGyGKKDzYPLgXONBICu3t/gbUQbYNHX0QG9p2xrts8Ukx7C4Q5y7w7041pJ
        qQUZ3ni8N4mUTwZZqOMZgWmzteR35s370lNSoRlk94Y4FwyC67qZ4yICRJ+BCYxu
        HJTBDqUx0eM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C852358A0B;
        Wed, 26 Feb 2020 14:34:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EDB7D58A0A;
        Wed, 26 Feb 2020 14:34:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH 02/10] bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell functions in C
References: <20200226101429.81327-1-mirucam@gmail.com>
        <20200226101429.81327-3-mirucam@gmail.com>
Date:   Wed, 26 Feb 2020 11:34:01 -0800
In-Reply-To: <20200226101429.81327-3-mirucam@gmail.com> (Miriam Rubio's
        message of "Wed, 26 Feb 2020 11:14:21 +0100")
Message-ID: <xmqqzhd5i1na.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F1B9A4F6-58CE-11EA-91B4-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miriam Rubio <mirucam@gmail.com> writes:

> +static int register_good_ref(const char *refname,
> +			     const struct object_id *oid, int flags,
> +			     void *cb_data)
> +{
> +	struct string_list *good_refs = cb_data;
> +
> +	string_list_append(good_refs, oid_to_hex(oid));
> +	return 0;
> +}
> +
> +static void prepare_rev_argv(struct bisect_terms *terms, struct argv_array *rev_argv)
> +{
> +	struct string_list good_revs = STRING_LIST_INIT_DUP;
> +	char *term_good = xstrfmt("%s-*", terms->term_good);
> +
> +	for_each_glob_ref_in(register_good_ref, term_good,
> +			     "refs/bisect/", &good_revs);
> +
> +	argv_array_pushl(rev_argv, "skipped_commits", "refs/bisect/bad", "--not", NULL);
> +	for (int i = 0; i < good_revs.nr; i++)
> +		argv_array_push(rev_argv, good_revs.items[i].string);
> +
> +	string_list_clear(&good_revs, 0);
> +	free(term_good);

Why do you need good_revs string_list in the first place?  Wouldn't
it be simpler and easier to understand to pass in the argv as part
of the callback data and push the good refs in the callback function?

> +static int prepare_revs(struct bisect_terms *terms, struct rev_info *revs)
> +{
> +	int res = 0;
> +	struct argv_array rev_argv = ARGV_ARRAY_INIT;
> +
> +	prepare_rev_argv(terms, &rev_argv);
> +
> +	/*
> +	 * It is important to reset the flags used by revision walks
> +	 * as the previous call to bisect_next_all() in turn
> +	 * setups a revision walk.

"setup" is not a verb X-<.  "... in turn sets up a ..." would be OK.

> +static int process_skipped_commits(FILE *fp, struct bisect_terms *terms, struct rev_info *revs)
> +{
> +	struct commit *commit;
> +	struct pretty_print_context pp = {0};
> +
> +	if (fprintf(fp, "# only skipped commits left to test\n") < 1)
> +		return -1;
> +
> +	while ((commit = get_revision(revs)) != NULL) {
> +		struct strbuf commit_name = STRBUF_INIT;
> +		format_commit_message(commit, "%s",
> +				      &commit_name, &pp);
> +		fprintf(fp, "# possible first %s commit: [%s] %s\n",
> +			terms->term_bad, oid_to_hex(&commit->object.oid),
> +			commit_name.buf);
> +		strbuf_release(&commit_name);
> +		clear_commit_marks(commit, ALL_REV_FLAGS);

clear_commit_marks() is to clear the given flag bits from the named
commit *AND* all of its ancestors (recursively) as long as they have
these bits on, and it typically is used in order to clean up the
state bits left on objects _after_ a revision walk is _done_.

Calling it, especially to clear ALL_REV_FLAGS that contains crucial
flag bits necessary to drive get_revision(), inside a loop that is
still walking commits one by one by calling get_revision(), is
extremely unusual.

It would be surprising if this code were correct.  It may be that it
happens to (appear to) work because parents of the commit hasn't
been painted and calling the helper only clears the mark from the
commit (so we won't see repeated "painting down to the root commit")
in which case this might be an extremely expensive looking variant
of

	commit->object.flags &= ~ALL_REV_FLAGS;

that only confuses the readers.

Even then, I think by clearing bits like SEEN from commit, it breaks
the revision traversal machinery---for example, doesn't this mean
that the commit we just processed can be re-visited by
get_revision() without deduping in a history with forks and merges?

Has this been shown to any of your mentors before sending it to the
list?

> +static int bisect_successful(struct bisect_terms *terms)
> +{
> +	struct object_id oid;
> +	struct commit *commit;
> +	struct pretty_print_context pp = {0};
> +	struct strbuf commit_name = STRBUF_INIT;
> +	char *bad_ref = xstrfmt("refs/bisect/%s",
> +				terms->term_bad);
> +	char *content;
> +	int res;
> +
> +	read_ref(bad_ref, &oid);
> +	printf("%s\n", bad_ref);
> +	commit = lookup_commit_reference(the_repository, &oid);
> +	format_commit_message(commit, "%s", &commit_name, &pp);
> +
> +	content = xstrfmt("# first %s commit: [%s] %s",
> +	terms->term_bad, oid_to_hex(&oid),
> +	commit_name.buf);

Strange indentation.

> +	res = write_in_file(git_path_bisect_log(), content, 1);

So this is a new use of the helper introduced in [01/10].  It is
true that use of it lets this caller not to worry about opening,
writing and closing, but it needs an extra allocation to prepare
"content".

If the calling convention were more like this:

	res = write_to_file(git_path_bisect_log(), "a",
			    "# first %s commit: [%s] %s",
			    terms->term_bad, oid_to_hex(&oid), commit_name.buf,
			    NULL);

this callsite and the callsite in [01/10] wouldn't have had to make
an unnecessary allocation, perhaps?

