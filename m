Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35E831F6DC
	for <e@80x24.org>; Thu, 26 Jan 2017 03:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752686AbdAZDfw (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 22:35:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:45081 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752576AbdAZDfv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 22:35:51 -0500
Received: (qmail 28869 invoked by uid 109); 26 Jan 2017 03:35:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Jan 2017 03:35:51 +0000
Received: (qmail 19580 invoked by uid 111); 26 Jan 2017 03:35:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 22:35:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jan 2017 22:35:48 -0500
Date:   Wed, 25 Jan 2017 22:35:48 -0500
From:   Jeff King <peff@peff.net>
To:     cornelius.weig@tngtech.com
Cc:     gitster@pobox.com, git@vger.kernel.org, novalis@novalis.org,
        pclouds@gmail.com
Subject: Re: [PATCH] refs: add option core.logAllRefUpdates = always
Message-ID: <20170126033547.7bszipvkpi2jb4ad@sigill.intra.peff.net>
References: <20170125213328.meehgxvzuajjgvag@sigill.intra.peff.net>
 <20170126011654.21729-1-cornelius.weig@tngtech.com>
 <20170126011654.21729-2-cornelius.weig@tngtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170126011654.21729-2-cornelius.weig@tngtech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 26, 2017 at 02:16:54AM +0100, cornelius.weig@tngtech.com wrote:

> From: Cornelius Weig <cornelius.weig@tngtech.com>
> 
> When core.logallrefupdates is true, we only create a new reflog for refs
> that are under certain well-known hierarchies. The reason is that we
> know that some hierarchies (like refs/tags) do not typically change, and
> that unknown hierarchies might not want reflogs at all (e.g., a
> hypothetical refs/foo might be meant to change often and drop old
> history immediately).

I tried to read this patch with fresh eyes. But given the history, you
may take my review with a grain of salt. :)

Overall it looks OK to me. A few comments below.

> This patch introduces a new "always" mode for the core.logallrefupdates
> option which will log updates to everything under refs/, regardless
> where in the hierarchy it is (we still will not log things like
> ORIG_HEAD and FETCH_HEAD, which are known to be transient).

I don't think my original had tests for this, but it might be worth
adding a test for this last bit (i.e., that an update of ORIG_HEAD does
not write a reflog when logallrefupdates is set to "always").

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index af2ae4c..2117616 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -517,10 +517,13 @@ core.logAllRefUpdates::
>  	"`$GIT_DIR/logs/<ref>`", by appending the new and old
>  	SHA-1, the date/time and the reason of the update, but
>  	only when the file exists.  If this configuration
> -	variable is set to true, missing "`$GIT_DIR/logs/<ref>`"
> +	variable is set to `true`, missing "`$GIT_DIR/logs/<ref>`"
>  	file is automatically created for branch heads (i.e. under
>  	refs/heads/), remote refs (i.e. under refs/remotes/),
> -	note refs (i.e. under refs/notes/), and the symbolic ref HEAD.
> +	`refs/heads/`), remote refs (i.e. under `refs/remotes/`),
> +	note refs (i.e. under `refs/notes/`), and the symbolic ref `HEAD`.
> +	If it is set to `always`, then a missing reflog is automatically
> +	created for any ref under `refs/`.

I guess the backtick fixups came from my original. It might be easier to
see the change if they were pulled into their own patch, but it's
probably not that big a deal.

> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -150,7 +150,8 @@ This option is only applicable when listing tags without annotation lines.
>  	'strip' removes both whitespace and commentary.
>  
>  --create-reflog::
> -	Create a reflog for the tag.
> +	Create a reflog for the tag. To globally enable reflogs for tags, see
> +	`core.logAllRefUpdates` in linkgit:git-config[1].

This documentation tweak makes sense to me.

> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 76d68fa..1d4d6a0 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -262,7 +262,7 @@ static int create_default_files(const char *template_path,
>  		const char *work_tree = get_git_work_tree();
>  		git_config_set("core.bare", "false");
>  		/* allow template config file to override the default */
> -		if (log_all_ref_updates == -1)
> +		if (log_all_ref_updates == LOG_REFS_UNSET)
>  			git_config_set("core.logallrefupdates", "true");
>  		if (needs_work_tree_config(original_git_dir, work_tree))
>  			git_config_set("core.worktree", work_tree);

I expected that this hunk would need tweaked due to refactoring around
init-db that happened earlier this year. But it seems fine.

> diff --git a/refs.c b/refs.c
> index 9bd0bc1..cd36b64 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -638,12 +638,17 @@ int copy_reflog_msg(char *buf, const char *msg)
>  
>  int should_autocreate_reflog(const char *refname)
>  {
> -	if (!log_all_ref_updates)
> +	switch (log_all_ref_updates) {
> +	case LOG_REFS_ALWAYS:
> +		return 1;
> +	case LOG_REFS_NORMAL:
> +		return starts_with(refname, "refs/heads/") ||
> +			starts_with(refname, "refs/remotes/") ||
> +			starts_with(refname, "refs/notes/") ||
> +			!strcmp(refname, "HEAD");
> +	default:
>  		return 0;
> -	return starts_with(refname, "refs/heads/") ||
> -		starts_with(refname, "refs/remotes/") ||
> -		starts_with(refname, "refs/notes/") ||
> -		!strcmp(refname, "HEAD");
> +	}
>  }

And this function got broken out already by David in an earlier patch.
Looks good.

> @@ -2835,8 +2835,8 @@ static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
>  {
>  	int logfd, result, oflags = O_APPEND | O_WRONLY;
>  
> -	if (log_all_ref_updates < 0)
> -		log_all_ref_updates = !is_bare_repository();
> +	if (log_all_ref_updates == LOG_REFS_UNSET)
> +		log_all_ref_updates = is_bare_repository() ? LOG_REFS_NONE : LOG_REFS_NORMAL;

This hunk is new, I think. The enum values are set in such a way that
the original code would have continued to work, but I think using the
symbolic names is an improvement.

I assume you grepped for log_all_ref_updates to find this. I see only
one spot that now doesn't use the symbolic names. In builtin/checkout.c,
update_refs_for_switch() checks:

  if (opts->new_branch_log && !log_all_ref_updates)

That looks buggy, as it would treat LOG_REFS_NORMAL and LOG_REFS_UNSET
the same, and I do not see us resolving the UNSET case to a true/false
value. But I don't think the bug is new in your patch; the default value
was "-1" already.

I doubt it can be triggered in practice, because either:

  - the config value is set in the config file, and we pick up that
    value, whether it's "true" or "false"

  - it's unset, in which case our default would be to enable reflogs in
    a non-bare repo. And since git-checkout would refuse to run in a
    bare repo, we must be non-bare, and thus enabling reflogs does the
    right thing.

But it works quite by accident. I wonder if we should this
"is_bare_repository" check into a function that can be called instead of
accessing log_all_ref_updates() directly.

> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -93,6 +93,36 @@ test_expect_success 'update-ref creates reflogs with --create-reflog' '
>  	git reflog exists $outside
>  '
>  
> +test_expect_success 'core.logAllRefUpdates=true does not create reflog by default' '
> +	test_config core.logAllRefUpdates true &&
> +	test_when_finished "git update-ref -d $outside" &&
> +	git update-ref $outside $A &&
> +	git rev-parse $A >expect &&
> +	git rev-parse $outside >actual &&
> +	test_cmp expect actual &&
> +	test_must_fail git reflog exists $outside
> +'
> +
> +test_expect_success 'core.logAllRefUpdates=always creates reflog by default' '
> +	test_config core.logAllRefUpdates always &&
> +	test_when_finished "git update-ref -d $outside" &&
> +	git update-ref $outside $A &&
> +	git rev-parse $A >expect &&
> +	git rev-parse $outside >actual &&
> +	test_cmp expect actual &&
> +	git reflog exists $outside
> +'

Adding the tests to the existing --create-reflog tests is a good choice.

> +test_expect_success 'update-ref does not create reflog with --no-create-reflog if core.logAllRefUpdates=always' '

This test title is _really_ long, and will wrap in the output on
reasonable-sized terminals. Maybe '--no-create-reflog overrides
core.logAllRefUpdates=always' would be shorter?

>  test_expect_success 'stdin creates reflogs with --create-reflog' '
> +	test_when_finished "git update-ref -d $outside" &&
>  	echo "create $outside $m" >stdin &&
>  	git update-ref --create-reflog --stdin <stdin &&
>  	git rev-parse $m >expect &&

Adding missing cleanup. Good.

> +test_expect_success 'stdin does not create reflog when core.logAllRefUpdates=true' '

I don't mind these extra stdin tests, but IMHO they are just redundant.
The "--stdin --create-reflog" one makes sure the option is propagated
down via the --stdin machinery. But we know the config option is handled
at a low level anyway.

I guess it depends on how black-box we want the testing to be. It just
seems unlikely for a regression to be found here and not in the tests
above.

-Peff
