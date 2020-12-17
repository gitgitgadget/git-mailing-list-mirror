Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43DBC4361B
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 01:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84629233FB
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 01:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388966AbgLQB2C (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 20:28:02 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52965 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731386AbgLQB2C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 20:28:02 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B3AA8FB3F;
        Wed, 16 Dec 2020 20:27:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=EU4gVXREy8yqpJ29c60m+6eoSoE=; b=kwI9DPNSCMEnTX26U+tt
        qUV2t5A9BE1GtOJVv8xo7SiCVa+x5+46N8Kdhgj5BdaVpVpJPnOUu3v8DPhG+BP9
        8ORu7sWscBz39VT9sptDW9ZP0fQsT4bBQaVCqnsZrS5jWo59wEhZbur171/f8CWU
        30CsHxbniM9vau+r/eairx4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=rz8ZOlhlZx22r+UFn0m+3ITTz+52bG3cxzGDn6UWPVrkBF
        PkMxhIFtQrSaC7spUxletvONkXvhHg1yzb/Qys3v5c3Og1ZTdKKTApVUJ1R/abBb
        y/POcatVPxeQ8PGdcR8SvkxgTJfkFfBAv/1WZ7w9O7XwZo5v7og927QFdCrjM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 92F498FB3D;
        Wed, 16 Dec 2020 20:27:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1C97E8FB3C;
        Wed, 16 Dec 2020 20:27:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re* [PATCH] diff: suppress --name-only paths where all hunks are
 ignored
References: <xmqqeejsdv7x.fsf@gitster.c.googlers.com>
        <20201216231840.3163806-1-aclopte@gmail.com>
        <20201216231840.3163806-2-aclopte@gmail.com>
Date:   Wed, 16 Dec 2020 17:27:13 -0800
Message-ID: <xmqq4kkl1atq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FE0F0762-4006-11EB-B0C6-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Altmanninger <aclopte@gmail.com> writes:

> Diff options -w and the new -I<regex> can be used to suppress some hunks. Honor
> these ignores in combination with --name-only, --name-stat, and --raw,
> to not output files where all hunks are ignored.

Hmph, I am not sure if --raw should be affected by any of the
whitespace-difference suppression feature, though.

> Commit f245194f9a made "git diff -w --exit-code" exit with zero if all
> changed hunks are whitespace. This uses the diff_from_contents bit.
> Set that also when given -I<regex>, for consistent exit codes.

This one I can agree with.

> The diff_from_contents bit means that we have to look at content
> changes to know if a path has changed - modulo ignored hunks.  

I am not sure what you mean by " - modulo ignored hunks" here.  When
the diff_from_contents bit is not in effect, we can just rely on
byte-for-byte equality to determine if a path has changed, which
means we can say that two blobs are different by seeing that they
have different object names.  But when diff_from_contents bit is in
effect, two blobs that are not byte-for-byte equal could still be
considered the same.

But your sentence without " - modulo ignored hunks" says that very
clearly.  So perhaps these three words can just go away?

> Teach
> diff.c::flush_one_pair() to do so.  In the caller, reset the found_changes bit
> after each file pair, so we can test each file separately for content changes.

This part I am not sure (and later I will become even less sure it
is right).

It's not like we were buggy when diff_from_contents bit is in effect
for all output formats, is it?  How does this change interact with
the use of the found_changes bit in diffcore_flush() where NO_OUTPUT
format is given, the command wants to exit with status and
diff_from_contents is in effect?


> @@ -5967,6 +5966,26 @@ static void flush_one_pair(struct diff_filepair *p, struct diff_options *opt)
>  {
>  	int fmt = opt->output_format;
>  
> +	if (opt->flags.diff_from_contents &&
> +	    (fmt & (DIFF_FORMAT_RAW | DIFF_FORMAT_NAME | DIFF_FORMAT_NAME_STATUS))) {
> +		static FILE *devnull;
> +		FILE *diff_file;
> +
> +		if (!devnull)
> +			devnull = xfopen("/dev/null", "w");
> +
> +		diff_file = opt->file;
> +		opt->file = devnull;
> +		opt->color_moved = 0;

Why is color_moved so special?  If we added some other new option,
how would we make sure that the person who is adding that new option
would remember to reset it here?  And how does that person decide if
his or her new option needs resetting or not in the first place?

It almost feels backwards to me, to be honest.  All this rigmarole
comes because opt that is used for the 'main' diff is reused by the
inner diff you run here.  You save away opt->file and swap in a new
value, and restore it before you leave.  You disable color_moved but
forget to restore it, which may be an indication of new bug.  If we
used a brand new diff_options instance and copied the options that
mattered from *opt to the new one, and used the new one to drive
this inner diff, at least we wouldn't have to worry about destroying
the outer 'opt' like this patch tries to avoid (and probably not
very successfully).

Also I am not sure if "caching" the file handle to /dev/null is
good idea or not.  When will it be closed?  Would repeated
invocation of the diff machinery work well with it (think: "git log
-w --name-only")

> +		if (check_pair_status(p))
> +			diff_flush_patch(p, opt);
> +
> +		opt->file = diff_file;
> +		if (!opt->found_changes)
> +			return;

This somehow feels wrong.  For one thing, RAW is about showing
object names of preimage and postimage, which means it shows the
preimage and postimage are either identical or different, and
options like -w, -I, etc. that inspect and hide some textual
differences should not affect its outcome at all.

The body of this function (without the above addition) looks like
this:

        static void flush_one_pair(struct diff_filepair *p, struct diff_options *opt)
        {
                int fmt = opt->output_format;

                if (fmt & DIFF_FORMAT_CHECKDIFF)
                        diff_flush_checkdiff(p, opt);
                else if (fmt & (DIFF_FORMAT_RAW | DIFF_FORMAT_NAME_STATUS))
                        diff_flush_raw(p, opt);
                else if (fmt & DIFF_FORMAT_NAME) {
                        const char *name_a, *name_b;
                        name_a = p->two->path;
                        name_b = NULL;
                        strip_prefix(opt->prefix_length, &name_a, &name_b);
                        fprintf(opt->file, "%s", diff_line_prefix(opt));
                        write_name_quoted(name_a, opt->file, opt->line_termination);
                }
        }

and we notice that FORMAT_NAME case is an oddball among the three
with open-coded logic here without any helper function.  I would
have expected that FORMAT_NAME would be the only thing that should
be affected, and the way to do so would be to move what we see here
to a new diff_flush_name_only(p, opt) helper function, and have that
function pay the overhead of actually running a textual diff when
the diff_from_contents bit is in effect.

Having said that, after seeing RAW and NAME_STATUS are grouped into
the same group, I am having a second thought.

> @@ -6350,11 +6369,18 @@ void diff_flush(struct diff_options *options)
>  			     DIFF_FORMAT_NAME |
>  			     DIFF_FORMAT_NAME_STATUS |
>  			     DIFF_FORMAT_CHECKDIFF)) {
> +		int found_changes = 0;
>  		for (i = 0; i < q->nr; i++) {
>  			struct diff_filepair *p = q->queue[i];
> -			if (check_pair_status(p))
> -				flush_one_pair(p, options);
> +			if (!check_pair_status(p))
> +				continue;
> +			flush_one_pair(p, options);
> +			if (options->found_changes) {
> +				found_changes = 1;
> +				options->found_changes = 0;
> +			}
>  		}
> +		options->found_changes = found_changes;
>  		separator++;
>  	}

See above---this seems to be an unwanted side effect of an
unnecessary reuse of opt in flush_one_pair().

How about turning this into at least two patches?

 - We are not handling "-I" the same way as "-w", which is one
   issue.  I think I can agree with the patch to fix that bug.

 - And then there is an issue that we are not inspecting the
   contents when "--name-only" and "-w" is given together.  It is a
   separate issue, and I am not even sure if it is a bug.  The
   attempted "fix" we see here does not look so clean, either, and I
   am tempted to declare that just like "raw", "name-only" and
   "name-status" formats work with byte-for-byte equality and "-w"
   and friends are ignored just like in "diff --name-status --patch"
   the "--patch" option is ignored.

In any case, the first half is a lot more straightforward and it is
easy to convince any reader of its correctness.

Thanks.

--- >8 ------ >8 ------ >8 ------ >8 ------ >8 ------ >8 ------ >8 ---

Subject: [PATCH] diff: correct interaction between --exit-code and -I<pattern>

Just like "git diff -w --exit-code" should exit with 0 when ignoring
whitespace differences results in no changes shown, if ignoring
certain changes with "git diff -I<pattern> --exit-code" result in an
empty patch, we should exit with 0.

The test suite did not cover the interaction between "--exit-code"
and "-w"; add one while adding a new test for "--exit-code" + "-I".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c                     |  3 ++-
 t/t4015-diff-whitespace.sh | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 9768d8eab4..69e3bc00ed 100644
--- a/diff.c
+++ b/diff.c
@@ -4637,7 +4637,8 @@ void diff_setup_done(struct diff_options *options)
 	 * inside contents.
 	 */
 
-	if ((options->xdl_opts & XDF_WHITESPACE_FLAGS))
+	if ((options->xdl_opts & XDF_WHITESPACE_FLAGS) ||
+	    options->ignore_regex_nr)
 		options->flags.diff_from_contents = 1;
 	else
 		options->flags.diff_from_contents = 0;
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 47f0e2889d..8c574221b2 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -567,6 +567,30 @@ test_expect_success '--check and --quiet are not exclusive' '
 	git diff --check --quiet
 '
 
+test_expect_success '-w and --exit-code interact sensibly' '
+	test_when_finished "git checkout x" &&
+	{
+		test_seq 15 &&
+		echo " 16"
+	} >x &&
+	test_must_fail git diff --exit-code &&
+	git diff -w >actual &&
+	test_must_be_empty actual &&
+	git diff -w --exit-code
+'
+
+test_expect_success '-I and --exit-code interact sensibly' '
+	test_when_finished "git checkout x" &&
+	{
+		test_seq 15 &&
+		echo " 16"
+	} >x &&
+	test_must_fail git diff --exit-code &&
+	git diff -I. >actual &&
+	test_must_be_empty actual &&
+	git diff -I. --exit-code
+'
+
 test_expect_success 'check staged with no whitespace errors' '
 	echo "foo();" >x &&
 	git add x &&
-- 
2.30.0-rc0-217-gff80b81bc6

