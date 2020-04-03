Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC85C43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 21:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646CF20719
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 21:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z+/nVDYE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgDCVTU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 17:19:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59272 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbgDCVTU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 17:19:20 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C9D44BFE5;
        Fri,  3 Apr 2020 17:19:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7OZZK+SmxPF6YB1QnGuGoYKrMTs=; b=Z+/nVD
        YEJRDMIJMeAL0bIwVEGVhvCSf6TUILAkxGEVSvOxRKtl/LFGMtS+lKJl2/zD2SdU
        msAo767cFUepUWfwfJxwtq5f3IRLRrVtp37zqQ4jOPFZvEwgEX91XEbSzRefv+Vd
        stf7h6iHmF5plpxSyLzZgtg/5hccfit2PM2UU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mzwsmdzMx8dzM5F6ciejUhXQNhiciM8S
        rhbP5Fd588i/Pa5D3xKkFL6cm+X89d/Ylq0eEmX8PO4/CswgHMFyWu2TWbtERVUK
        CUddOeI7/pn3LPK2IlBKNvVc90a9qJQLLhrtv8T2zMPsZqVzWEnu1Dn0isuXNqao
        zP6ntzgLrj0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 01AED4BFE4;
        Fri,  3 Apr 2020 17:19:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7ED5F4BFE3;
        Fri,  3 Apr 2020 17:19:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH v2 03/11] bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell functions in C
References: <20200321161020.22817-1-mirucam@gmail.com>
        <20200321161020.22817-4-mirucam@gmail.com>
Date:   Fri, 03 Apr 2020 14:19:15 -0700
In-Reply-To: <20200321161020.22817-4-mirucam@gmail.com> (Miriam Rubio's
        message of "Sat, 21 Mar 2020 17:10:12 +0100")
Message-ID: <xmqq4ku0z2r0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C6C156CE-75F0-11EA-ABAC-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miriam Rubio <mirucam@gmail.com> writes:

> diff --git a/bisect.c b/bisect.c
> index 9154f810f7..a50278ea7e 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -635,6 +635,11 @@ static void bisect_rev_setup(struct repository *r, struct rev_info *revs,
>  	struct argv_array rev_argv = ARGV_ARRAY_INIT;
>  	int i;
>  
> +	/*
> +	 * `revs` could has been used before.
> +	 * Thus we first need to reset it.
> +	 */
> +	reset_revision_walk();
>  	repo_init_revisions(r, revs, prefix);

I don't have enough time and concentration to follow all the
codepaths in "bisect" that walk the commit graph starting here, but
seeing one codepath, e.g. check_ancestors(), after calling this and
walking with bisect_common(), uses clear_commit_marks_many() to
clear ALL_REV_FLAGS, not just the ones that reset_revision_walk()
clears, I am not sure what value this addition has.

To put it differently, what codepath are you protecting the revision
walk that is about to happen against with this "reset"?  Who are the
callers that could have used `revs` before calling this function and
touched only SEEN, ADDED, SHOWN, etc. without touching other bits
like COUNTED, TREESAME, UNINTERESTING that matter to the correct
operation of "bisect"?

The rest of the patch looks quite reasonably done.  Let me comment
on the patch out of order (in other words, I'll rearrange the
functions in the order I read them).  I am realizing that I feel it
easier to understand to read the code in a bottom-up fashion.

> +static enum bisect_error bisect_auto_next(struct bisect_terms *terms, const char *prefix)
> +{
> +	if (bisect_next_check(terms, NULL))
> +		return BISECT_OK;

The bisect_next_check() function returns what decide_next() returns,
which is either 0 or error() which is -1.  So this says "if
nect-check says there was an error, we return OK".  For the purpose
of not proceeding to bisect_next(), returning is perfectly correct,
but is the value returned correct?  The scripted original does

  git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD && bisect_next || :

meaning "try next-check and go on to bisect_next if check succeeds;
either way, ignore all errors from them".  So it probably is more
faithful conversion to make the returned value from auto_next()
void.

> +
> +	return bisect_next(terms, prefix);
> +}

In any case, this conversion of auto_next looks like a good one,
with or without fixing its type.  The caller in cmd_bisect__helper()
seems to store the returned value in 'res' and uses it for the exit
status, but for this to be a faithful conversion, it should ignore
the returned value from here and always exit with success (and if we
do so, it is one more reason why we would want to update the type of
this function to return void).

> +static enum bisect_error bisect_next(struct bisect_terms *terms, const char *prefix)
> +{
> +	int no_checkout;
> +	enum bisect_error res;
>
> +	if (bisect_next_check(terms, terms->term_good))
> +		return BISECT_FAILED;

The original makes sure it does not get any argument, but that is
done in cmd_bisect__helper(), so it is OK.

The next thing the original does is to call bisect_autostart, before
doing the next-check.  Was it a dead code that wasn't necessary, or
is its loss a regression during the conversion?

> +
> +	no_checkout = !is_empty_or_missing_file(git_path_bisect_head());
> +
> +	/* Perform all bisection computation, display and checkout */
> +	res = bisect_next_all(the_repository, prefix, no_checkout);

Looking good.  We've already converted next_all() in the previous
series, and we call it the same way as the original by checking if
$GIT_DIR/BISECT_HEAD is there.  The original said "if BISECT_HEAD
exists as a file, use '--no-checkout'" and did not care if its empty
or not, but the updated code seems to care.  Does the difference
matter (i.e. is it more correct to ignore an empty BISECT_HEAD and
pretend as if it did not exist)?

> +	if (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
> +		res = bisect_successful(terms);
> +		return res ? res : BISECT_INTERNAL_SUCCESS_MERGE_BASE;

It is unclear why "1st bad commit found" is turned into "success
merge base" here.  bisect_successfull() returns an error when it
cannot append to the log, and otherwise we would want to relay "we
are done successfully" back to the caller, no?  Puzzled....

> +	} else if (res == BISECT_ONLY_SKIPPED_LEFT) {
> +		res = bisect_skipped_commits(terms);
> +		return res ? res : BISECT_ONLY_SKIPPED_LEFT;
> +	}
> +	return res;
> +}
> +

This side, I can understand what it wants to do to the "we only have
skipped ones so we cannot continue" status.

What is done in bisect_skipped_commits() is dubious, though (we'll
see it later).


> +static int bisect_skipped_commits(struct bisect_terms *terms)
> +{
> +	int res = 0;
> +	FILE *fp = NULL;
> +	struct rev_info revs;
> +
> +	fp = fopen(git_path_bisect_log(), "a");
> +	if (!fp)
> +		return error_errno(_("could not open '%s' for appending"),
> +				  git_path_bisect_log());
> +
> +	res = prepare_revs(terms, &revs);
> +
> +	if (!res)
> +		res = process_skipped_commits(fp, terms, &revs);
> +
> +	fclose(fp);
> +	return res;
> +}
> +

Opens the log to append to, or returns if we cannot.  Calls
prepare_revs() and process() if successfully prepared, and then
close.  No resource leak, and the returned value is the result code
from the last function that matters.  Looks good.

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
> +	 * sets up a revision walk.
> +	 */
> +	reset_revision_walk();
> +	init_revisions(revs, NULL);
> +	rev_argv.argc = setup_revisions(rev_argv.argc, rev_argv.argv, revs, NULL);
> +	if (prepare_revision_walk(revs))
> +		res = error(_("revision walk setup failed\n"));
> +
> +	argv_array_clear(&rev_argv);
> +	return res;
> +}
> +

Unlike the one in rev_setup() above, the only codepath this thing is
used is quite limited (i.e. after doing all the bisection
computation including walking the graph and counting the weights
with various bits in bisect_next) and we know all that is left to do
is to run a single rev-list call, so it is clear to see that
reset_revision_walk() is sufficient here.

> +static void prepare_rev_argv(struct bisect_terms *terms, struct argv_array *rev_argv)
> +{
> +	char *term_good = xstrfmt("%s-*", terms->term_good);
> +
> +	argv_array_pushl(rev_argv, "skipped_commits", "refs/bisect/bad", "--not", NULL);
> +	for_each_glob_ref_in(register_good_ref, term_good, "refs/bisect/", rev_argv);
> +
> +	free(term_good);
> +}
> +

This sets up to find commits that can be reached by BAD that cannot
be reached by any GOOD revs, which is a quite faithful translation
from the original one.

> +static int process_skipped_commits(FILE *fp, struct bisect_terms *terms, struct rev_info *revs)
> +{
> +	struct commit *commit;
> +	struct pretty_print_context pp = {0};
> +
> +	if (fprintf(fp, "# only skipped commits left to test\n") < 1)
> +		return -1;

What's that comparison with "< 1" doing?  That's a 36-byte message,
and you are saying that it is OK if we showed only 10-byte from it,
but it is not OK, even if the function did not report an output error
by returning a negative value, if it returned that it wrote 0 bytes?

I can understand it if it were

	if (fprintf(fp, "...") < 0)
		return error_errno(_("failed to write to ..."));

though.

> +	while ((commit = get_revision(revs)) != NULL) {
> +		struct strbuf commit_name = STRBUF_INIT;
> +		format_commit_message(commit, "%s",
> +				      &commit_name, &pp);
> +		fprintf(fp, "# possible first %s commit: [%s] %s\n",
> +			terms->term_bad, oid_to_hex(&commit->object.oid),
> +			commit_name.buf);
> +		strbuf_release(&commit_name);
> +	}

Again, this is a faithful translation of the rev-list that appears
in the original, provided that &revs was set up correctly, and
relevant object flags cleared correctly before we start the
traversal, both of which seem to be the case.

> +	/*
> +	 * Reset the flags used by revision walks in case
> +	 * there is another revision walk after this one.
> +	 */
> +	reset_revision_walk();
> +
> +	return 0;
> +}
> +

So, overall, this step was a quite pleasant read, except for the
very first bit above.

Thanks.

> +static int register_good_ref(const char *refname,
> +			     const struct object_id *oid, int flags,
> +			     void *cb_data)
> +{
> +	struct argv_array *rev_argv = cb_data;
> +
> +	argv_array_push(rev_argv, oid_to_hex(oid));
> +	return 0;
> +}
> +
> +static int bisect_successful(struct bisect_terms *terms)
> +{
> +	struct object_id oid;
> +	struct commit *commit;
> +	struct pretty_print_context pp = {0};
> +	struct strbuf commit_name = STRBUF_INIT;
> +	char *bad_ref = xstrfmt("refs/bisect/%s",terms->term_bad);
> +	int res;
> +
> +	read_ref(bad_ref, &oid);
> +	printf("%s\n", bad_ref);
> +	commit = lookup_commit_reference(the_repository, &oid);
> +	format_commit_message(commit, "%s", &commit_name, &pp);
> +
> +	res = write_in_file(git_path_bisect_log(), "a", "# first %s commit: [%s] %s\n",
> +			    terms->term_bad, oid_to_hex(&oid),
> +			    commit_name.buf);
> +
> +	strbuf_release(&commit_name);
> +	free(bad_ref);
> +	return res;
> +}
> +
