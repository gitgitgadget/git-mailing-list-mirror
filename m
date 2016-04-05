From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff --exit-code does not honour textconv setting
Date: Tue, 05 Apr 2016 16:16:58 -0700
Message-ID: <xmqqvb3vzlw5.fsf@gitster.mtv.corp.google.com>
References: <56EE9B09.6040700@gmail.com>
	<5703CA0D.2090808@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Georg Pichler <georg.pichler@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Apr 06 01:17:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anaDk-0002fs-1j
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 01:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753458AbcDEXRF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 19:17:05 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:60902 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752267AbcDEXRD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 19:17:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 491095165F;
	Tue,  5 Apr 2016 19:17:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qtH6ipHk70NEwKLHvL2H/+C46Ko=; b=Uf92tj
	Uky8pRQK7xFv08nSjdxgnqGm+8qN9g1xq9L/bIX9Mp1QgpiawBvtzzy4kJnI/d7V
	7vZL2yQGKvq6oPMKcaQewax1W0OM3ESy7LoqiGPlovedYu/Wf3hqpokFNsK19Xw6
	v/zlPbvfZjMVg+9gJBIM446Q7mGpBegIN/ReI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SKFkjfhxQP2OkEPR2qPWycwQj5AMoD6d
	kA6+MmwVoJ83jlBf6TKJAwgJlvZ7cX65vaHTg6rGW5dYw9j6BDek8vQhYH3tJGOp
	QF3aejB1kKA4g0NqDgUyFaZ4d1gnxBrBJM+Qa3FjcCfKnyTyk3Xp36nlwXaTJhO2
	3dLLLyyr3JA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E0C755165E;
	Tue,  5 Apr 2016 19:17:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1B9265165D;
	Tue,  5 Apr 2016 19:17:00 -0400 (EDT)
In-Reply-To: <5703CA0D.2090808@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Tue, 5 Apr 2016 16:22:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7FB16BC4-FB84-11E5-B981-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290817>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> The "test" command is used as it does not generate any output on stdout.
>
> "test" is a bit of a red herring here since it will receive commands.
> But your example works even with "true" which ignores its commands and
> produces no output.

Either sounds strange, as they exit without reading their input at
all, so the other side of the pipe may get an write error it has to
handle ;-)

> The description doesn't make it clear whether exit-code refers to
> the actual diff (foo vs. bar) or to the diff after textconv (empty
> vs. empty). In any case, "-b" should not make a difference for
> your example.
>
> diff_flush() in diff.c has this piece of code:
>

It is understandable that "-b" makes difference.  The actual
short-cut happens a bit before the code you quoted.

	if (output_format & DIFF_FORMAT_NO_OUTPUT &&
	    DIFF_OPT_TST(options, EXIT_WITH_STATUS) &&
	    DIFF_OPT_TST(options, DIFF_FROM_CONTENTS)) {
		/*
		 * run diff_flush_patch for the exit status. setting
		 * options->file to /dev/null should be safe, because we
		 * aren't supposed to produce any output anyway.
		 */
		if (options->close_file)
			fclose(options->file);
		options->file = fopen("/dev/null", "w");
		if (!options->file)
			die_errno("Could not open /dev/null");
		options->close_file = 1;
		for (i = 0; i < q->nr; i++) {
			struct diff_filepair *p = q->queue[i];
			if (check_pair_status(p))
				diff_flush_patch(p, options);
			if (options->found_changes)
				break;
		}
	}

When running without producing output but we need the exit status,
unless DIFF_FROM_CONTENTS is set (e.g. "-b" in use), we do not run
the code that would inspect the blob contents that would have
produced the actual patch.  When DIFF_FROM_CONTENTS is set, we need
to dig into the blob contents and the body of the above if() gets
run only to trigger o->found_changes (e.g. in builtin_diff() that
sets ecbdata.found_changesp to point at o->found_changes before
calling into the xdiff machinery), but the output is discarded to
/dev/null.

The textconv filter is an unfortunate beast, in that while some
paths use one while others don't, so it won't be as simple as "-b"
that flips DIFF_FROM_CONTENTS to say "We need to inspect blobs for
ALL FILEPAIRS to see if there is any difference" if we want to keep
the optimization as much as possible.

Without DIFF_FROM_CONTENTS set, any filepair that point at two
different blobs that might end up to be the same after applying
textconv will flip the o->found_changes bit on, and with
EXIT_WITH_STATUS bit on, we have another optimization to skip
checking the remainder of the filepairs.  So if you want to support
textconv with QUICK, you would also need to disable that
optimization by teaching diff_change() to refrain from setting
HAS_CHANGES bit, i.e.

    diff --git a/diff.h b/diff.h
    index 125447b..f6c0c07 100644
    --- a/diff.h
    +++ b/diff.h
    @@ -69,7 +69,7 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
     #define DIFF_OPT_FIND_COPIES_HARDER  (1 <<  6)
     #define DIFF_OPT_FOLLOW_RENAMES      (1 <<  7)
     #define DIFF_OPT_RENAME_EMPTY        (1 <<  8)
    -/* (1 <<  9) unused */
    +#define DIFF_OPT_WITH_TEXTCONV       (1 <<  9)
     #define DIFF_OPT_HAS_CHANGES         (1 << 10)
     #define DIFF_OPT_QUICK               (1 << 11)
     #define DIFF_OPT_NO_INDEX            (1 << 12)

    diff --git a/diff.c b/diff.c
    index 4dfe660..0016ad2 100644
    --- a/diff.c
    +++ b/diff.c
    @@ -5018,6 +5018,11 @@ void diff_change(struct diff_options *options,
            two->dirty_submodule = new_dirty_submodule;
            p = diff_queue(&diff_queued_diff, one, two);

    +       if (either path one or path two has textconv defined) {
    +               DIFF_OPT_SET(options, DIFF_WITH_TEXTCONV);
    +               return;
    +       }
    +
            if (DIFF_OPT_TST(options, DIFF_FROM_CONTENTS))
                    return;

And then in order to keep the optimization, add this to the above
codepath:

    diff --git a/diff.c b/diff.c
    index 4dfe660..7b318cc 100644
    --- a/diff.c
    +++ b/diff.c
    @@ -4598,6 +4598,7 @@ void diff_flush(struct diff_options *options)
            int i, output_format = options->output_format;
            int separator = 0;
            int dirstat_by_line = 0;
    +       int textconv_hack;

            /*
             * Order: raw, stat, summary, patch
    @@ -4652,9 +4653,17 @@ void diff_flush(struct diff_options *options)
                    separator++;
            }

    +       /*
    +        * If there is any path that needs textconv and we haven't
    +        * found any change on paths that don't, we need to pass
    +        * them through textconv and see the textual difference.
    +        */
    +       textconv_hack = (DIFF_OPT_TST(options, DIFF_WITH_TEXTCONV) &&
    +                        !DIFF_OPT_TST(options, HAS_CHANGES));
    +
            if (output_format & DIFF_FORMAT_NO_OUTPUT &&
                DIFF_OPT_TST(options, EXIT_WITH_STATUS) &&
    -           DIFF_OPT_TST(options, DIFF_FROM_CONTENTS)) {
    +           (textconv_hack || DIFF_OPT_TST(options, DIFF_FROM_CONTENTS))) {
                    /*
                     * run diff_flush_patch for the exit status. setting
                     * options->file to /dev/null should be safe, because we

so that if we find some other change (e.g. diff_addremove() noticed
a path added or removed, or diff_change() noticed a changed blob
that does not have textconv defined), we do not have to inspect all
the paths to see if there is any change at all by going into the
body of this if() block.

And then finally, clean things up in a way similar to how
DIFF_FROM_CONTENTS codepath handles the HAS_CHANGES bit.

    diff --git a/diff.c b/diff.c
    index 4dfe660..7b318cc 100644
    --- a/diff.c
    +++ b/diff.c
    @@ -4709,7 +4718,7 @@ free_queue:
             * diff_addremove/diff_change does not set the bit when
             * DIFF_FROM_CONTENTS is in effect (e.g. with -w).
             */
    -       if (DIFF_OPT_TST(options, DIFF_FROM_CONTENTS)) {
    +       if (textconv_hack || DIFF_OPT_TST(options, DIFF_FROM_CONTENTS)) {
                    if (options->found_changes)
                            DIFF_OPT_SET(options, HAS_CHANGES);
                    else

By the way, I have a suspicion that the existing code immediately
after the context of this hunk is wrong to clear HAS_CHANGES bit
when options->found_changes is clear.  HAS_CHANGES bit should be
clear upon entry to this function, when DIFF_FROM_CONTENTS is in
use.

I also suspect that addremove() that refrains from setting
HAS_CHANGES when DIFF_FROM_CONTENTS is in effect is wrong.  No
matter what combination of -w or -b is used, an addition of a new
file, or a removal of an existing file, is a change.
