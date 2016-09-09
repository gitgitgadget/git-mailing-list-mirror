Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CC4D207DF
	for <e@80x24.org>; Fri,  9 Sep 2016 22:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755501AbcIIWfS (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 18:35:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:41093 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755396AbcIIWfR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 18:35:17 -0400
Received: (qmail 13387 invoked by uid 109); 9 Sep 2016 22:35:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 09 Sep 2016 22:35:17 +0000
Received: (qmail 29208 invoked by uid 111); 9 Sep 2016 22:35:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 09 Sep 2016 18:35:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Sep 2016 18:35:14 -0400
Date:   Fri, 9 Sep 2016 18:35:14 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC/PATCH] ls-files: adding support for submodules
Message-ID: <20160909223513.3rirneqxmrcyi4k4@sigill.intra.peff.net>
References: <1473458004-41460-1-git-send-email-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1473458004-41460-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 09, 2016 at 02:53:24PM -0700, Brandon Williams wrote:

> Allow ls-files to recognize submodules in order to retrieve a list of
> files from a repository's submodules.  This is done by forking off a
> process to recursively call ls-files on all submodules.
> 
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
> Hey git developers!
> 
> I'm new to the community and this is the first patch for an open source project
> that I have worked on.
> 
> I'm looking forward to working on the project!

Welcome. :)

Submodules are not really my area of expertise, so I don't have any
commentary on the goal of the patch, except that it sounds reasonable to
my layman's ears.

The implementation looks fairly clean. A few comments:

> +static void show_gitlink(const struct cache_entry *ce)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	struct strbuf buf = STRBUF_INIT;
> +	struct strbuf name = STRBUF_INIT;
> +	int submodule_name_len;
> +	FILE *fp;
> +
> +	argv_array_push(&cp.args, "ls-files");
> +	argv_array_push(&cp.args, "--recurse-submodules");
> +	cp.git_cmd = 1;
> +	cp.dir = ce->name;
> +	cp.out = -1;
> +	start_command(&cp);
> +	fp = fdopen(cp.out, "r");

You should error-check the result of start_command(). I guess the
reasonable outcome would be to die(), as it is a sign that we could not
fork, find git, etc.

Ditto for fdopen (you can use xfdopen for that).

> +	/*
> +	 * The ls-files child process produces filenames relative to
> +	 * the submodule. Prefix each line with the submodule path
> +	 * to make it relative to the current repository.
> +	 */
> +	strbuf_addstr(&name, ce->name);
> +	strbuf_addch(&name, '/');
> +	submodule_name_len = name.len;
> +	while (strbuf_getline(&buf, fp) != EOF) {
> +		strbuf_addbuf(&name, &buf);
> +		write_name(name.buf);
> +		strbuf_setlen(&name, submodule_name_len);
> +	}

What happens if the filename in the submodule needs quoting? You'll get
the quoted value in your buffer, and then re-quote it again in
write_name().

The simplest thing would probably be to use "ls-files -z" for the
recursive invocation, and then split on NUL bytes (we have
strbuf_getline_nul for that).

> +	finish_command(&cp);

What should happen if finish_command() tells us that the ls-files
sub-process reported an error? It may not be worth aborting the rest of
the listing, but we might want to propagate that in our own return code.

> +	strbuf_release(&buf);
> +	strbuf_release(&name);
> +	fclose(fp);
> +}

A minor style nit, but I would generally fclose(fp) before running
finish_command() (i.e., resource clean up in the reverse order of
allocation). It doesn't matter in this case because "fp" is output from
the process, and we know we've already read to EOF. For other cases, it
could cause a deadlock (e.g., we end up in wait() for the child process
to finish, but it is blocked in write() waiting for us to read). So I
think it's a good habit to get into.

> @@ -519,6 +566,17 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
>  	if (require_work_tree && !is_inside_work_tree())
>  		setup_work_tree();
>  
> +	if (recurse_submodules &&
> +	    (show_stage || show_deleted || show_others || show_unmerged ||
> +	     show_killed || show_modified || show_resolve_undo ||
> +	     show_valid_bit || show_tag || show_eol))
> +		die("ls-files --recurse-submodules can only be used in "
> +		    "--cached mode");

Woah, that list of variables is getting rather long. This is not a
problem introduced by your patch, so it's not a blocker. But I wonder if
some of them are mutually exclusive and could be collapsed to a single
variable.

I guess the reason for this "only with --cached" is that you do not
propagate the options down to the recursive process. If we were to do
that, then this big list of restrictions would go away. I'd be OK with
starting with more limited functionality like your patch, though. I
think doing the recursive thing correctly would also involve parsing the
output of each to append the filename prefix.

So I suppose another option would be to teach ls-files a "prefix" option
to add to each filename, and just pass in the submodule path. Then you
can let the sub-processes write directly to the common stdout, and I
think it would be safe to blindly pass the parent argv into the child
processes.

-Peff
