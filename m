Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 215221F453
	for <e@80x24.org>; Thu, 20 Sep 2018 19:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733046AbeIUBW5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 21:22:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:54212 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727241AbeIUBW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 21:22:57 -0400
Received: (qmail 3727 invoked by uid 109); 20 Sep 2018 19:37:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Sep 2018 19:37:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28229 invoked by uid 111); 20 Sep 2018 19:37:47 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Sep 2018 15:37:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Sep 2018 15:37:51 -0400
Date:   Thu, 20 Sep 2018 15:37:51 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <ttaylorr@github.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] transport.c: introduce core.alternateRefsCommand
Message-ID: <20180920193751.GC29603@sigill.intra.peff.net>
References: <cover.1537466087.git.me@ttaylorr.com>
 <4c4900722cab253b3ce33cb28910c4602ce44536.1537466087.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4c4900722cab253b3ce33cb28910c4602ce44536.1537466087.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 20, 2018 at 02:04:11PM -0400, Taylor Blau wrote:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 112041f407..b908bc5825 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -616,6 +616,12 @@ core.preferSymlinkRefs::
>  	This is sometimes needed to work with old scripts that
>  	expect HEAD to be a symbolic link.
>  
> +core.alternateRefsCommand::
> +	When listing references from an alternate (e.g., in the case of ".have"), use
> +	the shell to execute the specified command instead of
> +	linkgit:git-for-each-ref[1]. The first argument is the path of the alternate.
> +	Output must be of the form: `%(objectname) SPC %(refname)`.

We discussed off-list the notion that this could just be the objectname,
since the ".have" mechanism doesn't care about the actual refnames.

There's a little prior discussion from the list:

  https://public-inbox.org/git/xmqqefzraqbu.fsf@gitster.mtv.corp.google.com/

My "rev-list --alternate-refs" patches _do_ use the refnames, since you
could do something like "--source" that cares about them. But there's
some awkwardness there, because the names are in a different namespace
than the rest of the refs. If we were to just say "nope, you do not get
to see the names of the alternates" then that awkwardness goes away. But
it also loses some information that could _possibly_ be of use to a
caller.

Back in that earlier discussion I did not have a strong opinion, but
here we are cementing that decision into a user-visible interface. So it
probably makes sense to revisit and decide once and for all.

> +test_description='git receive-pack test'
> +
> +. ./test-lib.sh
> +
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
> +		git config receive.advertisealternates true &&
> +		git update-ref -d refs/heads/a &&
> +		git update-ref -d refs/heads/b &&
> +		git update-ref -d refs/heads/c &&
> +		git update-ref -d refs/heads/master &&
> +		git update-ref -d refs/tags/one &&
> +		git update-ref -d refs/tags/two &&
> +		git update-ref -d refs/tags/three &&

Probably not worth nit-picking process count, but this could done with a
single "update-ref --stdin".

> +		printf "../../.git/objects" >objects/info/alternates

Also a nitpick, but I think "echo" would be more usual here (we handle
the lack of a trailing newline just fine, but any use of printf makes me
wonder if something tricky is going on with line endings).

> +test_expect_success 'with core.alternateRefsCommand' '
> +	test_config -C fork core.alternateRefsCommand \
> +		"git --git-dir=\"\$1\" for-each-ref \
> +		--format=\"%(objectname) %(refname)\" \
> +		refs/heads/a refs/heads/c;:" &&

This is cute and all, but might it be more readable to use
write_script() to stick it into its own script?

> +	cat >expect <<-EOF &&
> +	$(git rev-parse a) .have
> +	$(git rev-parse c) .have
> +	EOF
> +	printf "0000" | git receive-pack fork | extract_haves >actual &&

There's been a push lately to avoid having git on the left-hand side of
a fork, since we might otherwise miss its exit code (including things
like asan/valgrind errors). So maybe:

   ... receive-pack fork >actual &&
   extract_haves <actual >actual.haves &&
   test_cmp expect actual.haves

or similar?

> diff --git a/transport.c b/transport.c
> index 24ae3f375d..e7d2cdf00b 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1328,10 +1328,21 @@ char *transport_anonymize_url(const char *url)
>  static void fill_alternate_refs_command(struct child_process *cmd,
>  					const char *repo_path)
>  {
> -	cmd->git_cmd = 1;
> -	argv_array_pushf(&cmd->args, "--git-dir=%s", repo_path);
> -	argv_array_push(&cmd->args, "for-each-ref");
> -	argv_array_push(&cmd->args, "--format=%(objectname) %(refname)");
> +	const char *value;
> +
> +	if (!git_config_get_value("core.alternateRefsCommand", &value)) {
> +		cmd->use_shell = 1;
> +
> +		argv_array_push(&cmd->args, value);
> +		argv_array_push(&cmd->args, repo_path);

Setting use_shell allows the shell trickery in your test, and matches
the modern way we run config-based commands. Good.

> +	} else {
> +		cmd->git_cmd = 1;
> +
> +		argv_array_pushf(&cmd->args, "--git-dir=%s", repo_path);
> +		argv_array_push(&cmd->args, "for-each-ref");
> +		argv_array_push(&cmd->args, "--format=%(objectname) %(refname)");
> +	}
> +
>  	cmd->env = local_repo_env;
>  	cmd->out = -1;

And we still clear local_repo_env for the custom command, which is good
to avoid confusion like $GIT_DIR being set when the custom command does
"cd $1 && git ...". Good.

-Peff
