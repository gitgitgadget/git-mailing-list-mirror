Return-Path: <SRS0=BObu=DK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13746C4363D
	for <git@archiver.kernel.org>; Sat,  3 Oct 2020 19:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8A7D206DB
	for <git@archiver.kernel.org>; Sat,  3 Oct 2020 19:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UWCA8+/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgJCTZq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Oct 2020 15:25:46 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64645 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgJCTZq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Oct 2020 15:25:46 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 66CB2EC5AE;
        Sat,  3 Oct 2020 15:25:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/EOXP57V+ZbGLkE5FTf52sdLpLI=; b=UWCA8+
        /jaGOeHwSmexUG1EqVoqs92VF43Bxuu+d7GzYikL2gF8LG8euWX5/NlF6cl1Os7m
        YtuIMTKZ1G+wIGgjuCBA+3iHZeCw28kJ/hm4PIdjCiJQMoS+Q5r9jiGI1iiDE6TG
        nCvjVMfYAefRb7eFy6B63/OCwh70Yhj5EAUok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BbMWu57zcb07quwJjZUq55g96xu/9ODm
        WwA84NoHVj8Zrla8jhGgV/UdOl1DOB6l4yO6fd5UGFL/E7v6WbuDLQ4qgBvGfc65
        abV305MGKr7ndWr6pr3ymn7pfkIupSYu7FeptKUR7mOPTjTDAGaJNkj1O1OTwfyg
        //Cq1Cjag60=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5FA08EC5AD;
        Sat,  3 Oct 2020 15:25:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A600CEC5AB;
        Sat,  3 Oct 2020 15:25:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Nico Weber via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Nico Weber <thakis@chromium.org>
Subject: Re: [PATCH] bisect: add a --verify flag to `bisect run`
References: <pull.741.git.1601750003858.gitgitgadget@gmail.com>
Date:   Sat, 03 Oct 2020 12:25:36 -0700
In-Reply-To: <pull.741.git.1601750003858.gitgitgadget@gmail.com> (Nico Weber
        via GitGitGadget's message of "Sat, 03 Oct 2020 18:33:23 +0000")
Message-ID: <xmqqeemf8633.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 37681780-05AE-11EB-8DE1-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Nico Weber via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Nico Weber <thakis@chromium.org>
>
> If it's passed, then `git bisect run --verify script` will first
> check out the good revision and verify that the script passes there,
> then check out the bad revision and verify that it fails there,
> and only then start the actual `git bisect run script`.
>
> We use `git bisect run` heavily for bisecting bugs in LLVM when using
> clang to build Chromium. We sometimes end up with run scripts that are
> broken in some way, either by missing the +x bit, or in more subtle
> ways, and this adds a simple, low conceptual overhead way to smoke check
> the run script before starting a bisect that could run for a day or two.

In our log message, we tend NOT to say "This commit does X" or "X is
done", because such a statement is often insufficient to illustrate
if the commit indeed does X, and explain why it is a good thing to
do X in the first place.

Instead, we 

 - first explain that the current system does not do X (in present
   tense, so we do NOT say "previously we did not do X"), then

 - explain why doing X would be a good thing, and finally

 - give an order to the codebase to start doing X.


For this change, it might look like this:

  The script given to the `git bisect run script` may broken in some
  way.  [Explain why it is bad that 'script' is not run on the known
  bad or good revisions here in the current code.  The script is run
  to test on the midway commit anyway and the lack of +x bit would
  be noticed just as quickly as you retest a known good or bad
  revision, so this 'feature' appears as a pure overhead to cause
  extra checkouts and builds for no great additional benefit, at
  least to me, and I tried but cannot make a good case for you
  here].

  As we already know at least one bad revision and good revision(s)
  when the command is run, we can sanity check the script by running
  on these revisions and checking if it produces expected results.

  Introduce `--verify` option to the `git bisect run` command for
  this purpose.  It would cost checking out extra revisions and
  retesting them but gives a basic sanity check for the script, to
  save a potentially long "bisect" session that may span days.

> @@ -93,7 +93,6 @@ Eventually there will be no more revisions left to inspect, and the
>  command will print out a description of the first bad commit. The
>  reference `refs/bisect/bad` will be left pointing at that commit.
>  
> -
>  Bisect reset
>  ~~~~~~~~~~~~

Why this removal?  Just checking to make sure that the document does
not use double-blank lines between sections, in which case this
removal is a bad idea.  In any case, this change does not have
anything to do with the `--verify` option, so leave it out---we can
review a documentation clean-up patch separately if you want.

> @@ -317,7 +316,7 @@ If you have a script that can tell if the current source code is good
>  or bad, you can bisect by issuing the command:
>  
>  ------------
> -$ git bisect run my_script arguments
> +$ git bisect run [--verify] my_script arguments
>  ------------
>  
>  Note that the script (`my_script` in the above example) should exit
> @@ -376,6 +375,13 @@ ignored.
>  This option is particularly useful in avoiding false positives when a merged
>  branch contained broken or non-buildable commits, but the merge itself was OK.
>  
> +--verify::
> ++
> +Before the actual bisect run, check out the current bad revision and
> +verify that the script exits with a code between 1 and 127 (inclusive),
> +except 125, then check out the current good revision and verify that
> +the script exits with code 0. If not, abort the bisect run.
> +

"current bad revision" is OK, there is no concenpt of "current good
revision", but "the last revision marked as good" is a better way to
phrase what the above paragraph may be trying to address.

> +get_current_bisect_bounds () {
> +	test -s "$GIT_DIR/BISECT_LOG" || die "$(gettext "We are not bisecting.")"
> +	oIFS="$IFS" IFS="$IFS$(printf '\015')"

What is this CR about?  Is anybody manually futzing with DOS line endings?

> +	while read git bisect command rev tail
> +	do

There are bisect/bad ref and bisect/good-* refs that lets you figure
out exactly where the unknown territories are, but because you are
only trying to find one bad and one good rev to use as a sample, you
do not have to enumerate all of them.

But I doubt that reading the bisect log a good way to do this.  If
you only want one good and one bad rev to test, why not peek into
the implementation of bisect_next and find

    git show-ref --hash --verify refs/bisect/$TERM_BAD
    git for-each-ref --format="%(objectname" "refs/bisect/$TERM_GOOD-*"

that can easily be mimicked?

> +		start)
> +			CURRENT_BISECT_BAD="$rev"
> +			CURRENT_BISECT_GOOD="$tail"
> +			;;
> +		"$TERM_GOOD")
> +			CURRENT_BISECT_GOOD="$rev" ;;
> +		"$TERM_BAD")
> +			CURRENT_BISECT_BAD="$rev" ;;

These variables are better called LAST_BISECT_(GOOD/BAD), as current
set of good revs have multiple commits in it.  CURRENT_BISECT_BAD is
OK as-is when taken by itself, but as a contrasting pair to
LAST_BISECT_GOOD, renaming it to LAST_BISECT_BAD would make more
sense.

In any case, I am not sure why we need to read thru the log, futzing
with $IFS and all that.

>  bisect_run () {
> +	verify=
> +	while test $# -ne 0
> +	do
> +		case "$1" in
> +		--verify)
> +			verify=t
> +			;;
> +		--no-verify)
> +			verify=
> +			;;
> +	--)

Funny indentation.

> +			shift
> +			break
> +			;;


> +		-*)
> +			usage
> +			;;
> +		*)
> +			break
> +			;;
> +		esac
> +		shift
> +	done
> +
> +	if [ -n "$verify" ]; then

Style (Documentation/CodingGuidelines):

 - We prefer "test" over "[ ... ]".

 - Do not write control structures on a single line with semicolon.
   "then" should be on the next line for if statements, and "do"
   should be on the next line for "while" and "for".

> +		git rev-parse --verify -q BISECT_HEAD > /dev/null && die "$(gettext "bisect run --verify is incompatible with --no-checkout")"

 - Overlong line (cut after && _without_ adding trailing backslash)

 - Redirection operators should be written with space before, but no
   space after them.  In other words, write 'echo test >"$file"'
   instead of 'echo test> $file' or 'echo test > $file'.

> +
> +		get_current_bisect_bounds
> +		test -n "$CURRENT_BISECT_BAD" || die "$(gettext "bisect run --verify: no current bad revision")"
> +		test -n "$CURRENT_BISECT_GOOD" || die "$(gettext "bisect run --verify: no current good revision")"

Dotto.

> +		bisected_head=$(bisect_head)
> +		rev=$(git rev-parse --verify "$bisected_head") ||
> +			die "$(eval_gettext "Bad rev input: \$bisected_head")"
> +
> +		trap "git checkout -q $rev" 0
> +
> +		# Check script passes for good rev.
> +		command="$@"

What effect do we expect out of this assignment to $command?

> +		eval_gettextln "verifying script passes at \$TERM_GOOD rev"
> +		eval git checkout -q "$CURRENT_BISECT_GOOD" || die "$(eval_gettext "failed to check out \$TERM_GOOD rev")"
> +		"$@"
> +		res=$?
> +		if [ $res -ne 0 ]
> +		then
> +			die_with_status $res "$(eval_gettext "aborting: run script fails for \$TERM_GOOD rev")"
> +		fi
> +
> +		# Check script fails orderly for bad rev.
> +		command="$@"

Ditto.

> +		eval_gettextln "verifying script fails at \$TERM_BAD rev"
> +		eval git checkout -q "$CURRENT_BISECT_BAD" || die "$(eval_gettext "failed to check out \$TERM_BAD rev")"
> +		"$@"
> +		res=$?
> +		if [ $res -lt 0 -o $res -ge 128 ]


 - We do not write our "test" command with "-a" and "-o" and use "&&"
   or "||" to concatenate multiple "test" commands instead,...

