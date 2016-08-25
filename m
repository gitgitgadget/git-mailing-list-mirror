Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 948E91F859
	for <e@80x24.org>; Thu, 25 Aug 2016 19:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932822AbcHYTEI (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 15:04:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53975 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753696AbcHYTDi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 15:03:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 24E3335F67;
        Thu, 25 Aug 2016 15:02:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6bUkwyT4D7eRDIDKfBrCuPbQ/AQ=; b=g80mz7
        KvT9c7yNK6AqE0Oft/74sZHNouQuOkP/KOGia7TxLpW4td7yC8vwdYgeD+mUD8yj
        I9icpzEJwWec8qphupj+1alBgnRnY9WkoIk3Lzy4XKBiMUgac6rJ8+VHwipPRdaC
        nMbShIL5eo5kp3FYNSfGzSoAkAMYPYPTyhuds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=F0kABo+iBvvvEqgCNJQMjO4A5J/qxWbW
        OF7sm5o+lwaPQ1Gh1WvWsh3xRB9TKPdZKgsMjZ/FMtMaPNYI8PyUo/UeCfSu8DeQ
        VdDVz9sLeFP5znVpptKvjXarw//HnwPDUfrndfaPH/Kx8pCUHSuMvrevUo496kB1
        Y1PTNkAEffQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1D71D35F66;
        Thu, 25 Aug 2016 15:02:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 96FC235F64;
        Thu, 25 Aug 2016 15:02:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v14 13/27] bisect--helper: `bisect_start` shell function partially in C
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
        <01020156b73fe6b9-5e500c96-9bc3-4a6b-beb9-b5988dc9ee85-000000@eu-west-1.amazonses.com>
Date:   Thu, 25 Aug 2016 12:02:38 -0700
In-Reply-To: <01020156b73fe6b9-5e500c96-9bc3-4a6b-beb9-b5988dc9ee85-000000@eu-west-1.amazonses.com>
        (Pranit Bauva's message of "Tue, 23 Aug 2016 11:53:53 +0000")
Message-ID: <xmqqd1kwn035.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7EFB86A6-6AF6-11E6-AFF1-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

> +static int bisect_start(struct bisect_terms *terms, int no_checkout,
> +			const char **argv, int argc)
> +{
> +	int i, has_double_dash = 0, must_write_terms = 0, bad_seen = 0;
> +	int flags, pathspec_pos;
> +	struct string_list revs = STRING_LIST_INIT_DUP;
> +	struct string_list states = STRING_LIST_INIT_DUP;

The original has a single state, not states.  Let's see if there is
a reason behind the name change....

> +	unsigned char sha1[20];
> +	struct object_id oid;

More on these below...

> + ...
> +	for (i = 0; i < argc; i++) {
> +		const char *commit_id = xstrfmt("%s^{commit}", argv[i]);
> +		if (!strcmp(argv[i], "--")) {
> +			has_double_dash = 1;
> +			break;
> +		} else if (!strcmp(argv[i], "--no-checkout"))
> +			no_checkout = 1;
> +		else if (!strcmp(argv[i], "--term-good") ||
> + ...
> +		} else if (starts_with(argv[i], "--") &&
> +			 !one_of(argv[i], "--term-good", "--term-bad", NULL)) {
> +			string_list_clear(&revs, 0);
> +			string_list_clear(&states, 0);
> +			die(_("unrecognised option: '%s'"), argv[i]);
> +		} else if (get_oid(commit_id, &oid) && has_double_dash) {
> +			string_list_clear(&revs, 0);
> +			string_list_clear(&states, 0);
> +			die(_("'%s' does not appear to be a valid revision"), argv[i]);
> +		} else {
> +			string_list_append(&revs, oid_to_hex(&oid));
> +		}
> +	}

What I do not understand is clearing the string list "states" inside
this loop.  It may have been INIT_DUPed, but nothing in this loop
adds anything to it.  Because "revs" does get extended in the loop,
it is understandable if you wanted to clear it before dying, but "if
you are dying anyway why bother clearing?" is also a valid stance to
take.

The same "perhaps want to use the 'retval' with goto 'finish:' pattern?"
comment applies here, too.

> +	pathspec_pos = i;
> +
> +	/*
> +	 * The user ran "git bisect start <sha1> <sha1>", hence did not
> +	 * explicitly specify the terms, but we are already starting to
> +	 * set references named with the default terms, and won't be able
> +	 * to change afterwards.
> +	 */
> +	must_write_terms |= !!revs.nr;
> +	for (i = 0; i < revs.nr; i++) {
> +		if (bad_seen)
> +			string_list_append(&states, terms->term_good.buf);
> +		else {
> +			bad_seen = 1;
> +			string_list_append(&states, terms->term_bad.buf);
> +		}
> +	}

This is certainly different from the original.  We used to do one
"bisect_write" per element in revs in the loop; we no longer do that
and instead collect them in states list.  Each element in these two
lists, i.e. revs.item[i] and states.item[i], corresponds to each
other.

That explains why the variable is renamed to states.  We haven't
seen enough to say if this behaviour change is a good idea or not.

> +	/*
> +	 * Verify HEAD
> +	 */
> +	head = resolve_ref_unsafe("HEAD", 0, sha1, &flags);
> +	if (!head) {
> +		if (get_sha1("HEAD", sha1)) {
> +			string_list_clear(&revs, 0);
> +			string_list_clear(&states, 0);
> +			die(_("Bad HEAD - I need a HEAD"));
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
> +				error(_("checking out '%s' failed. Try 'git "
> +					"bisect start <valid-branch>'."),
> +				      start_head.buf);
> +				strbuf_release(&start_head);
> +				string_list_clear(&revs, 0);
> +				string_list_clear(&states, 0);
> +				return -1;

The original died here, but you expect the caller to respond to a
negative return.  I haven't read enough to judge if that is a good
idea, but doesn't it make sense to do the same throughout the
function consistently?  I saw a few die()'s already in the command
line parsing loop--shouldn't they also return -1?

The original has called bisect_write already when we attempt this
checkout and the user will see the states in the filesystem.  This
rewrite does not.  What effect does this behaviour change have to
the end-user experience?  The error message tells the end user to
run another "git bisect start" with a valid commit, and when that
happens, hopefully she will give us something we can check out, and
then we will hit the bisect_clean_state() call we see below before
starting to do anything meaningful, so I am guessing it won't, but
I just want to make sure that you thought about the ramifications
of the change above to delay calls to bisect_write.

> +			}
> +		}
> +	} else {
> +		if (starts_with(head, "refs/heads/") ||
> +		    !get_oid_hex(head, &oid) || ref_exists(head)) {

This ref_exists() check is new, and I think it should not be there.
In the original, if .git/HEAD pointed at refs/tags/v1.0, we would
have diagnosed it as a strange symbolic ref.  This no longer does.

If you wanted to make sure that the branch exists, it should have
been

	if ((starts_with(head, "refs/heads/") && ref_exists(head)) ||
	    !get_oid_hex(head, &oid)) {

anyway.

Also, why do you use get_oid_hex() here?  You used get_sha1("HEAD",
sha1) in the early part of "Verify HEAD" above, which seems to be
perfectly adequate.  That sha1 taken from get_sha1() is what you end
up using in the code below anyway.  If you can stick to one or the
other, please do so.

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

Not to be done as part of this series, but it probably is safe to
retire this part by now.  Cogito has been dead for how many years?

> +			if (starts_with(head, "refs/heads/")) {
> +				strbuf_reset(&start_head);
> +				strbuf_addstr(&start_head, head + 11);

skip_prefix?

> +			}
> +			else {
> +				strbuf_reset(&start_head);
> +				strbuf_addstr(&start_head, sha1_to_hex(sha1));
> +			}
> +		} else {
> +			strbuf_release(&start_head);
> +			string_list_clear(&revs, 0);
> +			string_list_clear(&states, 0);
> +			die(_("Bad HEAD - strange symbolic ref"));
> +		}
> +	}

I wonder the whole thing above is better restructured to avoid
repeated checks of the same thing.

	if (is it 40-hex, i.e. detached?) {
		stuff it to start_head;
	} else if (skip_prefix(head, "refs/heads/", &branchname)) {
        	do the "cogito" check;
                stuff it to start_head;
	} else {
        	that's a strange symbolic ref HEAD you have there;
	}

> +	/*
> +	 * Get rid of any old bisect state.
> +	 */
> +	if (bisect_clean_state()) {
> +		return -1;
> +	}

If we are going to get a lot more code inside {} in later patches,
then this single "return -1" enclosed inside a {} pair is
justifiable (but in that case we'd prefer an empty line after it to
separate it from the next comment block).  Otherwise lose the {}.

> +	/*
> +	 * In case of mistaken revs or checkout error, or signals received,
> +	 * "bisect_auto_next" below may exit or misbehave.
> +	 * We have to trap this to be able to clean up using
> +	 * "bisect_clean_state".
> +	 */

That explains the "trap" statements in the original.  Does it apply
to this code here?

> +	/*
> +	 * Write new start state
> +	 */
> +	write_file(git_path_bisect_start(), "%s\n", start_head.buf);
> +
> +	if (no_checkout) {
> +		get_oid(start_head.buf, &oid);
> +		if (update_ref(NULL, "BISECT_HEAD", oid.hash, NULL, 0,
> +			       UPDATE_REFS_MSG_ON_ERR)) {
> +			strbuf_release(&start_head);
> +			string_list_clear(&revs, 0);
> +			string_list_clear(&states, 0);
> +			return -1;
> +		}
> +	}
> +	strbuf_release(&start_head);
> +
> +	if (pathspec_pos < argc - 1)
> +		sq_quote_argv(&bisect_names, argv + pathspec_pos, 0);
> +	write_file(git_path_bisect_names(), "%s\n", bisect_names.buf);
> +	strbuf_release(&bisect_names);
> +
> +	for (i = 0; i < states.nr; i++) {
> +		if (bisect_write(states.items[i].string,
> +				  revs.items[i].string, terms, 1)) {
> +			string_list_clear(&revs, 0);
> +			string_list_clear(&states, 0);
> +			return -1;
> +		}
> +	}

Hmph.  I do not particuarly see why doing this in a separate loop
here, instead of doing it just like in the original, i.e. inside the
loop we already saw, is an improvement.  It seems to me that the
only effect of this change is to make the code more complex by
forcing you to maintain (and clear) another string list "states" and
have a separate loop here.

Unless there is a reason why delaying calls to bisect_write() is a
good thing and I am not seeing it, that is.

> diff --git a/git-bisect.sh b/git-bisect.sh
> index d6c8b5a..f0896b3 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -71,122 +71,7 @@ bisect_autostart() {
>  }
>  
>  bisect_start() {
> -...
> +	git bisect--helper --bisect-start $@ || exit
>  ...
> +	get_terms

Understandable.  As the handling of the terms is done in the helper,
you need to read the terms it left in the filesystem.  OK.

>  	bisect_auto_next

