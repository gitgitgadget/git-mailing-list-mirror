Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C771818
	for <git@vger.kernel.org>; Sun, 31 Mar 2024 02:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711851306; cv=none; b=cPiAU0Hwm+IwHGqADMQJnQU2UuJex7ziBrxC/JYPDqe9nk7vZlovDM3aslpUVUwFsH6HmediD+l1ewbZsH5+fbdqaw2V9y/OyXBtx2SFBzI8WCrm+zWSiK/aww5HoC7pR51TFaFZiLbXB7gRD2L70tC+WdPV1vpsxFL27Glbies=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711851306; c=relaxed/simple;
	bh=/oZ05e33eOYVkwmh5Oy5r9Wnwx7Wfcnp5nfDgQjIVqA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R9zmbiperTJt63IaEjSu0mSMcU+PAgV40J2tRzG8lhTlf7LvURiAl5/UbjJc+ppDomr7pyI/CpanSLceVdw1FzkvYM+Z8vqZ0rBmgvpv7owX3goDhoH95lyk24ZAJMVaA+zXtb7aDV82o4SSqbNMqnn8OZ7zz/OawE0kqYE15WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=oW3tsuVP; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oW3tsuVP"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2E70519AF1;
	Sat, 30 Mar 2024 22:14:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/oZ05e33eOYVkwmh5Oy5r9Wnwx7Wfcnp5nfDgQ
	jIVqA=; b=oW3tsuVPfy71kc6GxKeFJSFeAiDmvoQJ0YzmsG66Z8ml7sp2Dfwwsy
	wmXpF1cu639DpRBrW3Af6aIHABqAWfFidRsgDjYUp63rDaApPKkz68V3QL2zLkdG
	hsgvy0W10k6YtfkKfOf2WJUe5rMsmr7RvrmqZN+j9r1/Grk09MQ6o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 16D1019AF0;
	Sat, 30 Mar 2024 22:14:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 879BE19AEF;
	Sat, 30 Mar 2024 22:14:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Peter Krefting <peter@softwolves.pp.se>
Cc: git@vger.kernel.org,  "Osipov, Michael (IN IT IN)"
 <michael.osipov@innomotics.com>
Subject: Re: [PATCH v2] bisect: Honor log.date
In-Reply-To: <3ec4ec15-8889-913a-1184-72e55a1e0432@softwolves.pp.se> (Peter
	Krefting's message of "Sun, 31 Mar 2024 00:10:24 +0100 (CET)")
References: <3ec4ec15-8889-913a-1184-72e55a1e0432@softwolves.pp.se>
Date: Sat, 30 Mar 2024 19:14:52 -0700
Message-ID: <xmqqh6gni1ur.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 76B80A42-EF04-11EE-96E8-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Peter Krefting <peter@softwolves.pp.se> writes:

> When bisect finds the target commit to display, it calls git diff-tree
> to do so. This is a plumbing command that is not affected by the user's
> log.date setting. Switch to instead use "git show", which does honor
> it.

I suspect that log.date is a small tip of an iceberg of the benefit
we'll get from this switch.  There is an untold assumption that
honoring the user's configuration is a good thing behind the move
against "plumbing" in the above description, but singling log.date
out would give a wrong message.  It makes it harder to answer a
question, "The commit meant to make the command honor `log.date` and
make no other behaviour changes, but there are many small behaviour
changes---are they intended?", when somebody reads this commit log
message after we all forgot about the true motivation behind the
change.

    Subject: [PATCH vN] bisect: report the final commit with "show"

    When "git bisect" finds the first bad commit and shows it to the
    user, it calls "git diff-tree", whose output is meant to be
    stable and deliberately ignores end-user customizations.

    As this output is meant to be consumed by humans, let's switch
    it to use "git show" so that we honor end-user customizations
    via the configuration mechanism (e.g., "log.mailmap") and
    benefit from UI improvements meant for human consumption (e.g.,
    the output is sent to the pager) in "git show" relative to "git
    diff-tree".

    We have to give "git show" some hardcoded options, like not
    showing the patch text at all, as the patch is too much for the
    purpose of "git bisect" reporting the final commit.

would be how I would explain and justify this change.  If we later
add more configuration to tweak "git show" output, it will affect
the output from "git bisect" automatically, which is another thing
you may want to explain and use as another reason to justify the
change (in the second paragraph).

Some differences in the proposed output and the current output I see
are:

 - the output now goes to the pager

 - it now honors log.mailmap (which may default to true, so you
   could disable it with log.mailmap=false).

 - it shows the ref decoration by default (when the output goes to
   terminal).

 - the commit object names for the merge parents are abbreviated.

 - it no longer shows the change summary (creation, deletion,
   rename, copy).

 - it no longer shows the diffstat when the final commit turns out
   to be a merge commit.

There may be other differences.

I personally welcome the first four changes above, which I suspect
you didn't intend to make (I suspect that you weren't even aware of
making these changes).

If there were no existing users of "git bisect" other than me, I
would even suggest dropping "--no-abbrev-commit" from the set of
hardcoded "git show" options, so that the commit object name itself,
just like the commit object names for the merge parents, gets
abbreviated.  The abbreviation is designed to give us unique prefix,
so for the purpose of cutting and pasting from the output to some
other Git command, it should not break my workflow.  If some tool is
reading the output and blindly assuming that the object names are
spelled in full, such a change will break it.

The final two changes, lack of diffstat for merges, may or may not
be considered a regression, depending on the user you ask.  I was
just surprised by them but personally was not too unhappy with the
behaviour change, but reactions from other couple of thousands of
Git users (we have at least that many users these days, no?) may be
different from mine, ranging from "Meh" to "you broke my workflow".

A good test case to try is to do a bisection that finds c2f3bf07
(GIT 1.0.0, 2005-12-21) with and without your patch and compare
the output from them.  I say it is "good test case", not because
I view any difference is a bug in this patch, but because many
differences are probably good things that helps us to promote the
behaviour changes.  They just need to be explained in the proposed
log message to tell our future developers that we knew about these
behaviour changes and we meant to make them.

Having said all that.

> +static void show_commit(struct commit *commit)
>  {
> -	const char *argv[] = {
> -		"diff-tree", "--pretty", "--stat", "--summary", "--cc", NULL
> -	};
> -	struct rev_info opt;
> +	struct child_process show = CHILD_PROCESS_INIT;

It is very good that we no longer use the separate argv[] array and
use the more convenient strvec_pushl() call, which will make it
easier for us to later tweak the arguments we pass to the command
invocation dynamically if needed.

> -	git_config(git_diff_ui_config, NULL);
> -	repo_init_revisions(r, &opt, prefix);
> -
> -	setup_revisions(ARRAY_SIZE(argv) - 1, argv, &opt, NULL);
> -	log_tree_commit(&opt, commit);
> -	release_revisions(&opt);

And not doing this in process lets us not have to bother with the
configuration and other things we did in the original.  We now spawn
an extra process to show the final commit, but this is done only at
the very end of a bisection session, so it shouldn't matter.

> +	strvec_pushl(&show.args, "show", "--pretty=medium", "--stat", "--no-abbrev-commit", "--no-patch",
> +		     oid_to_hex(&commit->object.oid), NULL);

I would write it either like this:

	strvec_pushl(&show.args, "show",
		     "--pretty=medium", "--stat",
		     "--no-abbrev-commit", "--no-patch",
		     oid_to_hex(&commit->object.oid), NULL);

in anticipation for changing the set of options over the evolution
of this code (but the first "show" line or the last "oid_to_hex()"
line would have much less chance of needing to change), or even
spread the middle part one-option-per-line.

As to the exact set of options to pass to "git show", the preference
would be different from person to person, but I probably would drop
"--pretty=medium", as it is the default and if/when "git show"
learns to tweak it via configuration variable, you would want the
output from here honor it just like you wanted it honor `log.date`.
I would not be too unhappy to see `--no-abbrev-commit` to go myself,
but some tool authors might hate you if you did so.  I dunno.

If you add --stat, don't you want to add --summary as well?  Try to
bisect down to a commit that adds or removes files to see the output
difference to decide.

Thanks.




