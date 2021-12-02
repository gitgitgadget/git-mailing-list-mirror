Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2232BC433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 18:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376603AbhLBS1g (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 13:27:36 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60111 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237675AbhLBS1g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 13:27:36 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8320D15F92F;
        Thu,  2 Dec 2021 13:24:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hqVzCYxcqzD0P1MbPFGBGwlZNCQKs48gEyC3xp
        lAR+Q=; b=hMLsDUyID9rkObbrLzMSRaFFMIbkU8p0p4QkILQeU1wiE5AKLoDb9H
        2GHSsVNjqsjz+QmZZ5+mHSl735m5Q7LaOEt9fJVzF6ciXY9gL923+D+KYY8qjNTk
        8oTcwIhh+0IIchaVl4N8rmtzyXvTqNQ0NJtkn8Zla+Tpj0D/AEWXc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7B7A715F92E;
        Thu,  2 Dec 2021 13:24:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2BAE315F929;
        Thu,  2 Dec 2021 13:24:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] push: make '-u' have default arguments
References: <20211202144354.17416-1-chakrabortyabhradeep79@gmail.com>
        <20211202144354.17416-2-chakrabortyabhradeep79@gmail.com>
Date:   Thu, 02 Dec 2021 10:24:07 -0800
In-Reply-To: <20211202144354.17416-2-chakrabortyabhradeep79@gmail.com>
        (Abhradeep Chakraborty's message of "Thu, 2 Dec 2021 20:13:54 +0530")
Message-ID: <xmqqbl1yvpa0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0A738172-539D-11EC-B4E1-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com> writes:

> For now, -u in 'push' command requires two arguments (<repository>

Drop "For now"; we start our log message by explaining the current
system without the proposed change in the present tense, so it is
unneeded.  Spelling out the option name "--set-upstream" in full, or
at least "-u" in quotes, would make it more readable.

> and <refspec>) to successfully track upstream branch. In most cases,
> users want to set an upstream branch for the local branch they are
> currently on and the short names of these two branches are same in
> most of the cases.
>
> There are plenty of configurations to set default
> branches for push but again users can't run argumentless pull, rebase
> etc. So it will be good to have '-u' having default arguments.

Don't judge what's "most" common without a survey.  A casual "Often"
is acceptable.

Taking all together, something like

    "git push -u" (set-upstream) requires where to push to and what
    to push.  Often people push only the current branch to update
    the branch of the same name at the 'origin' repository.  For
    them, it would be convenient if "git push -u" without repository
    or refspec defaulted to push to the branch of the same name at
    the remote repository that is used by default.

> This commit gives ability to '-u' to have default arguments. 'git push

cf. Documentation/SubmittingPatches[[imperative-mood]]

> -u' runs normally if <repository> and <refspec> are given. But
> if those are not given then it tries to get the value of <repository>
> from 'branch.<current_branch>.remote'. If not found, it sets 'origin'
> as the value of <repository>. <refspec> would be the current branch's
> short name.

Do not invent an undefined word "short name".  The name of the
'main' branch is 'main', and it is not a short name.  When people
encounter multi-level names, like ac/push-u-default, use of an
undefined word "short name" will mislead readers that you meant
the leaf level, 'push-u-default', but I do not think that is what
you meant (this is not the only instance of "short name" in this
submission; all need to be fixed).

> However 'git push -u --all' work normally as before.

Is this even necessary?  --all is to push all branches to the
default repository, so clearly it is outside the "we need default
because the user did not tell us what to push to where" case.

Taking the above together, perhaps something along this line,

    Teach "git push -u" not to require repository and refspec.  When
    the user did not give what repository to push to, or which
    branch(es) to push, behave as if the default remote repository
    and the name of the current branch are given.  Note that use of
    "--all" option, together with "-u", behaves as before, since the
    user is telling us to push all the branches to the default
    remote repository and there is no need for this new behaviour to
    kick in.

perhaps?

One thing that bothers me is that unlike your assumption, not
everybody uses push.default set to simple or upstream.  I am not
convinced that the "git push -u" that defaults to do the 'current'
push with TRANSPORT_PUSH_SET_UPSTREAM for them is an improvement
for them.  If the new feature does not kick in for them, that should
be explained in the proposed log message when you sell the patch to
reviewers and documented for the users.

> @@ -375,6 +375,12 @@ Specifying `--no-force-if-includes` disables this behavior.
>  	upstream (tracking) reference, used by argument-less
>  	linkgit:git-pull[1] and other commands. For more information,
>  	see `branch.<name>.merge` in linkgit:git-config[1].
> ++
> +If you use -u without any arguments (i.e. no <repository> and <refspec>),

Be careful to quote `-u` and things like that by studyng the text
around what you are changing.

> +it will first try to get the <repository> from current branch's remote
> +configuration (i.e. from `branch.<name>.remote`). If not found, it will set
> +`origin` as the value of <repository> and <refspec> will be the current
> +branch's refspec.

This makes it sound as if the push will only affect the current
branch even for folks who use the matching push.  As I said, I do
not know if that is desirable.

> diff --git a/builtin/push.c b/builtin/push.c
> index 4b026ce6c6..2e417a06ad 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -527,6 +527,25 @@ static int git_push_config(const char *k, const char *v, void *cb)
>  	return git_default_config(k, v, NULL);
>  }
>  
> +static struct remote *pushremote_get_remote(const char *repo)
> +{
> +	struct remote *remote = pushremote_get(repo);
> +	if (!remote) {
> +		if (repo)
> +			die(_("bad repository '%s'"), repo);
> +		die(_("No configured push destination.\n"
> +		    "Either specify the URL from the command-line or configure a remote repository using\n"
> +		    "\n"
> +		    "    git remote add <name> <url>\n"
> +		    "\n"
> +		    "and then push using the remote name\n"
> +		    "\n"
> +		    "    git push <name>\n"));
> +	}
> +
> +	return remote;
> +}
> +
>  int cmd_push(int argc, const char **argv, const char *prefix)
>  {
>  	int flags = 0;
> @@ -537,6 +556,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>  	struct string_list push_options_cmdline = STRING_LIST_INIT_DUP;
>  	struct string_list *push_options;
>  	const struct string_list_item *item;
> +	struct remote *default_remote = NULL;
>  	struct remote *remote;
>  
>  	struct option options[] = {
> @@ -603,23 +623,27 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>  	if (tags)
>  		refspec_append(&rs, "refs/tags/*");
>  
> +	if ((argc == 0) && (flags & TRANSPORT_PUSH_SET_UPSTREAM) && !(flags & TRANSPORT_PUSH_ALL)) {
> +		struct branch *branch = branch_get(NULL);
> +		if (branch) {
> +			argc += 2;
> +			default_remote = pushremote_get_remote(repo);
> +			argv[0] = default_remote->name;
> +			argv[1] = branch->name;

This does look like it breaks unless the user is a novice without
custom configuration.  For example, if the current branch has a
configuration to integrate with a branch at the default remote of a
different name already, this (1) clobbers the tip of a wrong branch
by pushing to it, and (2) overrites the upstream configuration.  If
the user uses push.default set to 'current' or 'simple', this would
be OK, but for all other users, I doubt this would be an improvement.


> diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
> index fdb4292056..69970b6263 100755
> --- a/t/t5523-push-upstream.sh
> +++ b/t/t5523-push-upstream.sh
> @@ -60,6 +60,17 @@ test_expect_success 'push -u :topic_2' '
>  	check_config topic_2 upstream refs/heads/other2
>  '
>  
> +test_expect_success 'push -u' '

We may want to future-proof by checking the current tracking info
(or lack of it) before doing "git push -u" here?  You cannot control
what other developers would do in the future to tests before this
one.

> +	git push -u &&
> +	check_config main upstream refs/heads/main
> +'

And we make sure "-u" without the repository or branch works
in the basic case, which is a good "positive" test.

> +test_expect_success 'push -u --dry-run' '
> +	git push -u upstream main:other &&
> +	git push -u --dry-run &&
> +	check_config main upstream refs/heads/other
> +'

This verifies that under '--dry-run' the upstream configuration does
not get changed.  It is a good "negative" test to have, but there
probably are a lot more "negative" tests to ensure that the new
feature does not kick in in cases where it should not.  Various
settings of push.default is probably a good place to start and with
or without existing upstream info already set up.

Thanks for working on this topic.  I suspect that the implementation
and design covers too broadly to hurt some users while helping
others, and needs tightening up to fix that, but I think the users
appreciate the part that helps some users ;-)
