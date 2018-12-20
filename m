Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CE561F405
	for <e@80x24.org>; Thu, 20 Dec 2018 15:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731466AbeLTPso (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 10:48:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:46874 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731177AbeLTPso (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 10:48:44 -0500
Received: (qmail 1106 invoked by uid 109); 20 Dec 2018 15:48:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Dec 2018 15:48:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31667 invoked by uid 111); 20 Dec 2018 15:48:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Dec 2018 10:48:16 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Dec 2018 10:48:41 -0500
Date:   Thu, 20 Dec 2018 10:48:41 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH] diff: add support for reading files literally with
 --no-index
Message-ID: <20181220154841.GE27361@sigill.intra.peff.net>
References: <20181220002610.43832-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181220002610.43832-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 20, 2018 at 12:26:10AM +0000, brian m. carlson wrote:

> In some shells, such as bash and zsh, it's possible to use a command
> substitution to provide the output of a command as a file argument to
> another process, like so:
> 
>   diff -u <(printf "a\nb\n") <(printf "a\nc\n")
> 
> However, this syntax does not produce useful results with git diff
> --no-index.
> 
> On macOS, the arguments to the command are named pipes under /dev/fd,
> and git diff doesn't know how to handle a named pipe. On Linux, the
> arguments are symlinks to pipes, so git diff "helpfully" diffs these
> symlinks, comparing their targets like "pipe:[1234]" and "pipe:[5678]".
> 
> Because this behavior is not very helpful, and because git diff has many
> features that people would like to use even on non-Git files, add an
> option to git diff --no-index to read files literally, dereferencing
> symlinks and reading them as a normal file.
> 
> Note that this behavior requires that the files be read entirely into
> memory, just as we do when reading from standard input.

Yeah, I think this is a useful feature to have. It seemed familiar, and
indeed there were some patches a while back:

  https://public-inbox.org/git/20170113102021.6054-1-dennis@kaarsemaker.net/

Compared to that series, the implementation here seems simpler and less
likely to have unexpected effects.

Reading the patch, one thing I _thought_ it did (but it does not) is to
impact only the actual arguments on the command line, not entries we
find from recursing trees.

I.e., if I said:

  ln -s bar a/foo
  ln -s baz b/foo
  git diff --no-index --literally a/foo b/foo
  git diff --no-index --literally a/ b/

should I still see a/foo as a symlink in the second one, or not?

The distinction is a bit subtle, but I think treating only the actual
top-level arguments as symlinks would solve your problem, but still
allow a more detailed diff for the recursive cases.

There's some more discussion on this in the earlier iteration of that
series:

  https://public-inbox.org/git/20161111201958.2175-1-dennis@kaarsemaker.net/

I also suspect people might want a config option to make this the
default (which should be OK, as git-diff is, after all, porcelain). But
either way, a command line option is the first step.

> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> This is a long-standing annoyance of mine, and it also makes some use
> cases possible (for example, diffing filtered and non-filtered objects).
> 
> We don't include a test for the pipe scenario because I couldn't get
> that case to work in portable shell (although of course it works in
> bash). I have, however, tested it on both macOS and Linux. No clue how
> this works on Windows.

I think focusing on symlinks makes sense. You could probably test pipes
with mkfifo, but looking at your implementation, it's pretty clear that
it will operate on anything that works with read().

> diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
> index 030f162f30..4c4695c88d 100644
> --- a/Documentation/git-diff.txt
> +++ b/Documentation/git-diff.txt
> @@ -111,6 +111,11 @@ include::diff-options.txt[]
>  	"Unmerged".  Can be used only when comparing the working tree
>  	with the index.
>  
> +--literally::
> +  Read the specified files literally, as `diff` would,
> +  dereferencing any symlinks and reading data from pipes.
> +  This option only works with `--no-index`.
> +

Looks like spaces for indent, whereas the context uses tabs.

I think "literal" is a good way to describe this concept. If we do grow
a config option to make this the default, then countermanding it would
be "--no-literally", which parses a bit funny as English.

If you agree with my "only the top-level" line of reasoning above, maybe
"--literal-arguments" and "--no-literal-arguments" might make sense.

We could also in theory offer several levels: no literals, top-level
literals, everything literal, at which point it becomes a tri-state.

> -static struct diff_filespec *noindex_filespec(const char *name, int mode)
> +static int populate_literally(struct diff_filespec *s)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	size_t size = 0;
> +	int fd = xopen(s->path, O_RDONLY);
> +
> +	if (strbuf_read(&buf, fd, 0) < 0)
> +		return error_errno("error while reading from '%s'", s->path);
> +
> +	s->should_munmap = 0;
> +	s->data = strbuf_detach(&buf, &size);
> +	s->size = size;
> +	s->should_free = 1;
> +	s->read_literally = 1;
> +	return 0;
> +}
> +
> +static struct diff_filespec *noindex_filespec(const char *name, int mode,
> +					      struct diff_options *o)
> [...]
> +	else if (o->flags.read_literally)
> +		populate_literally(s);

The implementation is pleasantly simple. If we want to do the "only
top-level" thing, we'd just have to pass in a depth flag here.

> diff --git a/diff.c b/diff.c
> index dc9965e836..740d0087b9 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4282,18 +4282,18 @@ static void run_diff_cmd(const char *pgm,
>  		fprintf(o->file, "* Unmerged path %s\n", name);
>  }
>  
> -static void diff_fill_oid_info(struct diff_filespec *one, struct index_state *istate)
> +static void diff_fill_oid_info(struct diff_filespec *one, struct diff_options *o)

It might be worth breaking these "pass the options around" hunks into a
separate preparatory patch.

-Peff
