Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F1E620220
	for <e@80x24.org>; Tue,  2 Aug 2016 20:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932886AbcHBUZ2 (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 16:25:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65123 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933160AbcHBUZR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 16:25:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 677A3311D4;
	Tue,  2 Aug 2016 16:19:03 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RI6lyoaVEuXjI+y0VrXlMWjVfhc=; b=uaU6a8
	YplG0u17kBbucAuZydpn8TeUT09JDu5CwK5bv8PkWppoyGtBLhOob5umutkrfPU2
	S37wtconBh5nAaVi9NPSgcLBDMif1s5Nc/ljGQ28rE0DtAheZET165ogyPkp1+9m
	oaxNdVb1hCvHKMgxYFOZGOXiWApDzRlf1a1aI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LXWxpG0LHPvwuX2iOIAw8igRS438Mrfb
	yWCWNzuUJAFoIU1exVzEUi/NAmTEjHUj9hEBnyvNbwdebwwN1svpSKBMQ27bPjcO
	AuATHWS824thxRsDNn5tfPz3LoMBj/MIJ0HwWbVm42QQbuDNqhWnsBu/vy4Kn3ku
	80Lb6XZGPu0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5E994311D1;
	Tue,  2 Aug 2016 16:19:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BF742311CB;
	Tue,  2 Aug 2016 16:19:02 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Pranit Bauva <pranit.bauva@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: [RFC/PATCH v11 13/13] bisect--helper: `bisect_start` shell function partially in C
References: <0102015640423c26-2060fd70-c90d-4de3-ae8c-1801ad160b1c-000000@eu-west-1.amazonses.com>
	<0102015640423d18-86d50542-5e5d-40ff-860e-caf56146982d-000000@eu-west-1.amazonses.com>
Date:	Tue, 02 Aug 2016 13:19:00 -0700
In-Reply-To: <0102015640423d18-86d50542-5e5d-40ff-860e-caf56146982d-000000@eu-west-1.amazonses.com>
	(Pranit Bauva's message of "Sun, 31 Jul 2016 09:21:38 +0000")
Message-ID: <xmqqr3a6divf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5AAA5BFC-58EE-11E6-8582-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

> +static int bisect_start(struct bisect_terms *terms, int no_checkout,
> +			const char **argv, int argc)
> +{
> +	int i, j, has_double_dash = 0, must_write_terms = 0, bad_seen = 0;
> +	int flag;
> +	struct string_list revs = STRING_LIST_INIT_DUP;
> +	struct string_list states = STRING_LIST_INIT_DUP;
> +	struct strbuf start_head = STRBUF_INIT;
> +	const char *head;
> +	unsigned char sha1[20];
> +	FILE *fp;
> +	struct object_id oid;
> +
> +	if (is_bare_repository())
> +		no_checkout = 1;
> +
> +	for(i = 0; i < argc; i++) {

SP after for.

> +		if (!strcmp(argv[i], "--")) {
> +			has_double_dash = 1;
> +			break;
> +		}
> +		if (!strcmp(argv[i], "--term-good")) {
> +			must_write_terms = 1;
> +			strbuf_reset(&terms->term_good);
> +			strbuf_addstr(&terms->term_good, argv[++i]);
> +			break;
> +		}
> +		if (!strcmp(argv[i], "--term-bad")) {
> +			must_write_terms = 1;
> +			strbuf_reset(&terms->term_bad);
> +			strbuf_addstr(&terms->term_bad, argv[++i]);
> +			break;
> +		}

The original was not careful, either, but what if the user ends the
command line with "--term-good", without anything after it?

Also the original is prepared to handle --term-good=boa; because
this function can be be called directly from the UI (i.e. "git
bisect start --term-good=boa"), not supporting that form would be
seen as a regression.

> +		if (starts_with(argv[i], "--") &&
> +		    !one_of(argv[i], "--term-good", "--term-bad", NULL)) {
> +			string_list_clear(&revs, 0);
> +			string_list_clear(&states, 0);
> +			die(_("unrecognised option: '%s'"), argv[i]);
> +		}
> +		if (get_oid(argv[i], &oid) || has_double_dash) {

Calling get_oid() alone is insufficient to make sure argv[i] refers
to an existing object that is a committish.  The "^{commit}" suffix
in the original is there for a reason.

> +			string_list_clear(&revs, 0);
> +			string_list_clear(&revs, 0);

You seem to want the revs list really really clean ;-)

> +			die(_("'%s' does not appear to be a valid revision"), argv[i]);
> +		}
> +		else
> +			string_list_append(&revs, oid_to_hex(&oid));
> +	}
> +
> +	for (j = 0; j < revs.nr; j++) {

Why "j", not "i", as clearly the previous loop has finished at this
point?  The only reason why replacing "j" with "i" would make this
function buggy would be if a later part of this function depended on
the value of "i" when the control left the above loop, but if that
were the case (I didn't check carefully), such a precious value that
has long term effect throughout the remainder of the function must
not be kept in an otherwise throw-away loop counter variable "i".

Introduce a new "int pathspec_pos" and set it to "i" immediately
after the "for (i = 0; i < argc; i++) { ... }" loop above, perhaps.

> +		struct strbuf state = STRBUF_INIT;
> +		/*
> +		 * The user ran "git bisect start <sha1> <sha1>", hence
> +		 * did not explicitly specify the terms, but we are already
> +		 * starting to set references named with the default terms,
> +		 * and won't be able to change afterwards.
> +		 */
> +		must_write_terms = 1;
> +
> +		if (bad_seen)
> +			strbuf_addstr(&state, terms->term_good.buf);
> +		else {
> +			bad_seen = 1;
> +			strbuf_addstr(&state, terms->term_bad.buf);
> +		}
> +		string_list_append(&states, state.buf);
> +		strbuf_release(&state);
> +	}

How about this instead?

	/*
         * that comment block goes here
         */
       	must_write_terms = !!revs.nr;
	for (i = 0; i < revs.nr; i++) {
                if (bad_seen)
                	string_list_append(&states, terms->term_good.buf);
		else
                	string_list_append(&states, terms->term_bad.buf);
	}

> +
> +	/*
> +	 * Verify HEAD
> +	 */
> +	head = resolve_ref_unsafe("HEAD", 0, sha1, &flag);

The last parameter is a set of flag bits, so call it flags.

> +	if (!head) {
> +		if (get_sha1("HEAD", sha1)) {
> +			string_list_clear(&revs, 0);
> +			string_list_clear(&states, 0);
> +			die(_("Bad HEAD - I need a HEAD"));

We see many repeated calls to clear these two string lists before
exiting with failure, either by dying or return -1.

I wonder how bad the resulting code would look like if we employed
the standard pattern of having a "fail_return:" label at the end of
the function (after the "return" for the usual control flow) to
clear them.  If the result becomes less readable (and I suspect that
you would end up making it less readable), leaving the current code
structure is OK.

> +		}
> +	}
> +	if (!is_empty_or_missing_file(git_path_bisect_start())) {
> +		/* Reset to the rev from where we started */
> +		strbuf_read_file(&start_head, git_path_bisect_start(), 0);
> +		strbuf_trim(&start_head);
> +		if (!no_checkout) {
> +			struct argv_array argv = ARGV_ARRAY_INIT;
> +			argv_array_pushl(&argv, "checkout", start_head.buf,
> +					 "--", NULL);
> +			if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
> +				error(_("checking out '%s' failed. Try again."),
> +				      start_head.buf);

The original suggests to try "git bisect reset" here to recover.

> +				strbuf_release(&start_head);
> +				string_list_clear(&revs, 0);
> +				string_list_clear(&states, 0);
> +				return -1;
> +			}
> +		}
> +	} else {
> +		if (starts_with(head, "refs/head/") || !get_oid(head, &oid)) {

get_oid() is insufficient to ensure what you have in $head is
40-hex.  I think you meant get_oid_hex() here.

> +			/*
> +			 * This error message should only be triggered by
> +			 * cogito usage, and cogito users should understand
> +			 * it relates to cg-seek.
> +			 */
> +			if (!is_empty_or_missing_file(git_path_head_name())) {
> +				strbuf_release(&start_head);
> +				string_list_clear(&revs, 0);
> +				string_list_clear(&states, 0);
> +				die(_("won't bisect on cg-seek'ed tree"));
> +			}
> +			if (starts_with(head, "refs/heads/")) {

skip_prefix(), perhaps, if "head" is no longer used from here on?

> +	/*
> +	 * Write new start state
> +	 */
> +	fp = fopen(git_path_bisect_start(), "w");
> +	if (!fp) {
> +		bisect_clean_state();
> +		strbuf_release(&start_head);
> +		string_list_clear(&revs, 0);
> +		string_list_clear(&states, 0);
> +		return -1;
> +	}
> +	if (!fprintf(fp, "%s\n", start_head.buf)) {

man 3 fprintf and look for "Return Value"?

> +		fclose(fp);
> +		bisect_clean_state();
> +		strbuf_release(&start_head);
> +		string_list_clear(&revs, 0);
> +		string_list_clear(&states, 0);
> +		return -1;
> +	}
> +	fclose(fp);

Perhaps use write_file() instead of the above block of text?

> +	if (no_checkout) {
> +		get_oid(start_head.buf, &oid);
> +		if (update_ref(NULL, "BISECT_HEAD", oid.hash, NULL, 0,
> +			       UPDATE_REFS_MSG_ON_ERR)) {

Doesn't the original use --no-deref for this update-ref call?

> +			bisect_clean_state();
> +			strbuf_release(&start_head);
> +			string_list_clear(&revs, 0);
> +			string_list_clear(&states, 0);
> +			return -1;
> +		}
> +	}
> +	strbuf_release(&start_head);
> +	fp = fopen(git_path_bisect_names(), "w");
> +
> +	for (; i < argc; i++) {
> +		if (!fprintf(fp, "%s ", argv[i])) {

man 3 fprintf and look for "Return Value"?

More importantly, the original does --sq-quote so that BISECT_NAMES
file can be read back by a shell.  This is important as argv[i] can
have whitespace in it, and you are concatenating them with SP in
between here.  Also you are not terminating that line.

> +			fclose(fp);
> +			bisect_clean_state();
> +			string_list_clear(&revs, 0);
> +			string_list_clear(&states, 0);
> +			return -1;
> +		}
> +	}
> +	fclose(fp);

Perhaps

	strbuf_reset(&bisect_names);
	if (pathspec_pos < argc)
		sq_quote_argv(&bisect_names, argv + pathspec_pos, 0);
	write_file(git_path_bisect_names(), "%s\n", bisect_names.buf);

or something like that?

> +	for (j = 0; j < states.nr; j ++) {

Again, is "i" still precious here?  Style: drop SP between j and ++.

> +	fp = fopen(git_path_bisect_log(), "a");
> +	if (!fp) {
> +		bisect_clean_state();
> +		return -1;
> +	}
> +	if (!fprintf(fp, "git bisect start")) {
> +		bisect_clean_state();
> +		return -1;
> +	}
> +	for (i = 0; i < argc; i++) {
> +		if (!fprintf(fp, " '%s'", argv[i])) {
> +			fclose(fp);
> +			bisect_clean_state();
> +			return -1;
> +		}
> +	}
> +	if (!fprintf(fp, "\n")) {
> +		fclose(fp);
> +		bisect_clean_state();
> +		return -1;
> +	}

Again, the original writes orig_args which was protected with --sq-quote.

> +	fclose(fp);
> +
> +	return 0;
> +}
> +
