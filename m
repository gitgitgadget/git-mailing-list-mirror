Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B0A21F453
	for <e@80x24.org>; Fri, 28 Sep 2018 05:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbeI1LsN (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 07:48:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:34804 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726473AbeI1LsM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 07:48:12 -0400
Received: (qmail 31218 invoked by uid 109); 28 Sep 2018 05:26:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 28 Sep 2018 05:26:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10191 invoked by uid 111); 28 Sep 2018 05:25:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 28 Sep 2018 01:25:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Sep 2018 01:26:13 -0400
Date:   Fri, 28 Sep 2018 01:26:13 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        sbeller@google.com
Subject: Re: [PATCH v3 3/4] transport.c: introduce core.alternateRefsCommand
Message-ID: <20180928052613.GC25850@sigill.intra.peff.net>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1538108385.git.me@ttaylorr.com>
 <2dbcd5419073f06def007be3746ce90fffaf6a6d.1538108385.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2dbcd5419073f06def007be3746ce90fffaf6a6d.1538108385.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 27, 2018 at 09:25:42PM -0700, Taylor Blau wrote:

> Let the repository that has alternates configure this command to avoid
> trusting the alternate to provide us a safe command to run in the shell.
> To behave differently on each alternate (e.g., only list tags from
> alternate A, only heads from B) provide the path of the alternate as the
> first argument.

Well, you also need to pass the path so it knows which repo to look at.
Which I think is the primary reason we do it, but behaving differently
for each alternate is another option.

> +core.alternateRefsCommand::
> +	When advertising tips of available history from an alternate, use the shell to
> +	execute the specified command instead of linkgit:git-for-each-ref[1]. The
> +	first argument is the absolute path of the alternate. Output must be of the
> +	form: `%(objectname)`, where multiple tips are separated by newlines.

I wonder if people may be confused about the %(objectname) syntax, since
it's specific to for-each-ref.  Now that we've simplified the output
format to a single value, perhaps we should define it more directly.
E.g., like:

  The output should contain one hex object id per line (i.e., the same
  as produced by `git for-each-ref --format='%(objectname)'`).

Now that we've dropped the refname requirement from the output, it is
more clear that this really does not have to be about refs at all.  In
the most technical sense, what we really allow in the output is any
object id X for which the alternate promises it has all objects
reachable from X. Ref tips are a convenient and efficient way of
providing that, but they are not the only possibility (and likewise, it
is fine to omit duplicates or even tips that are ancestors of other
tips).

I think that's probably getting _too_ technical, though. It probably
makes sense to just keep thinking of these as "what are the ref tips".

> +This is useful when a repository only wishes to advertise some of its
> +alternate's references as ".have"'s. For example, to only advertise branch

Maybe put ".have" into backticks for formatting?

> +heads, configure `core.alternateRefsCommand` to the path of a script which runs
> +`git --git-dir="$1" for-each-ref --format='%(objectname)' refs/heads`.

Does that script actually work? Because of the way we invoke shell
commands with arguments, I think we'd end up with:

  git --git-dir="$1" for-each-ref --format='%(objectname)' refs/heads "$@"

Possibly for-each-ref would ignore the extra path argument (thinking
it's a ref pattern that just doesn't match), but it's definitely not
what you intended. You'd have to write:

  f() { git --git-dir=$1 ...etc; } f

in the usual way. That's a minor pain, but it's what makes the more
direct:

  /my/script

work.

The other alternative is to pass $GIT_DIR in the environment on behalf
of the program. Then writing:

  git for-each-ref --format='%(objectname)' refs/heads

would Just Work. But it's a bit subtle, since it is not immediately
obvious that the command is meant to run in a different repository.

> diff --git a/t/t5410-receive-pack.sh b/t/t5410-receive-pack.sh
> new file mode 100755
> index 0000000000..503dde35a4
> --- /dev/null
> +++ b/t/t5410-receive-pack.sh
> @@ -0,0 +1,49 @@
> +#!/bin/sh
> +
> +test_description='git receive-pack test'

The name of this test file and the description are pretty vague. Can we
say something like "test handling of receive-pack with alternate-refs
config"?

> +test_expect_success 'setup' '
> +	test_commit one &&
> +	git update-ref refs/heads/a HEAD &&
> +	test_commit two &&
> +	git update-ref refs/heads/b HEAD &&
> +	test_commit three &&
> +	git update-ref refs/heads/c HEAD &&
> +	git clone --bare . fork &&
> +	git clone fork pusher &&
> +	(
> +		cd fork &&
> +		git update-ref --stdin <<-\EOF &&
> +		delete refs/heads/a
> +		delete refs/heads/b
> +		delete refs/heads/c
> +		delete refs/heads/master
> +		delete refs/tags/one
> +		delete refs/tags/two
> +		delete refs/tags/three
> +		EOF
> +		echo "../../.git/objects" >objects/info/alternates
> +	)
> +'

This setup is kind of convoluted. You're deleting those refs in the
fork, I think, because we don't want them to suppress the duplicate
.have lines from the alternate. Might it be easier to just create the
.have lines we're interested in after the fact?

I think we can also use "clone -s" to make the setup of the alternate a
little simpler.

I don't see the "pusher" repo being used for anything here. Leftover
cruft from when you were using "git push" to test?

So all together, perhaps something like:

  # we have a fork which points back to us as an alternate
  test_commit base &&
  git clone -s . fork &&

  # the alternate has two refs with new tips, in two separate hierarchies
  git checkout -b public/branch master &&
  test_commit public &&
  git checkout -b private/branch master &&
  test_commit private

And then...

> +test_expect_success 'with core.alternateRefsCommand' '
> +	write_script fork/alternate-refs <<-\EOF &&
> +		git --git-dir="$1" for-each-ref \
> +			--format="%(objectname)" \
> +			refs/heads/a \
> +			refs/heads/c
> +	EOF

...this can just look for refs/heads/public/, and...

> +	test_config -C fork core.alternateRefsCommand alternate-refs &&
> +	git rev-parse a c >expect &&

...we verify that we saw public/branch but not private/branch.

It's not that much shorter, but I had trouble understanding from the
setup why we needed to delete all those refs (and why we cared about
those tags in the first place).

> diff --git a/transport.c b/transport.c
> index 2825debac5..e271b66603 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1328,10 +1328,21 @@ char *transport_anonymize_url(const char *url)
>  static void fill_alternate_refs_command(struct child_process *cmd,
>  					const char *repo_path)

The code change itself looks good to me.

-Peff
