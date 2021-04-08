Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E82DC433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 17:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEC5A6113B
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 17:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbhDHRZa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 13:25:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50743 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbhDHRZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 13:25:29 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CACDBC392C;
        Thu,  8 Apr 2021 13:25:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=341y468KF+XSFVT+EqEDAdVDY10=; b=k7m79P
        hwSa2ERhDF4uC/jSuYPH1wimWRNmqtEpD/xieb1Qfhm8Y4lYDcBgASxfVNTVWCU7
        rDqRmoif6R/+Os+s25zPLUpaKVzHJNb++TfLnlElF9GwbR1U5cEWLeab8s69iRYv
        8ZuXcjk81BUBhX6qTwAkBlw5tgLVKbT3KYTLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jVnCH7HgVWUMoC3Vrnls+RQhhhogCz0x
        cosjoB9p8A/GDYojWOveShJn3QH5SecD22DU3oQfPtXK4s0cBNCsDBfr2DbG5fSF
        FcC9aen91rL8FsORfBtxHUu5cI6GAxR1l860zARDydLZ2CZQ/vhJpgA0CW5RN3At
        uUJiEte50to=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C2AB1C392B;
        Thu,  8 Apr 2021 13:25:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 46A16C392A;
        Thu,  8 Apr 2021 13:25:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] config: Introduce GIT_CONFIG_NOGLOBAL
References: <a23382059bb57022dd1e40d1c2c9a11307b0ff3b.1617891426.git.ps@pks.im>
Date:   Thu, 08 Apr 2021 10:25:15 -0700
In-Reply-To: <a23382059bb57022dd1e40d1c2c9a11307b0ff3b.1617891426.git.ps@pks.im>
        (Patrick Steinhardt's message of "Thu, 8 Apr 2021 16:17:23 +0200")
Message-ID: <xmqqczv4vgck.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 625EC168-988F-11EB-8231-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> While it's already possible to stop git from reading the system config
> via GIT_CONFIG_NOSYSTEM, doing the same for global config files requires
> the user to unset both HOME and XDG_CONFIG_HOME. This is an awkward
> interface and may even pose a problem e.g. when git hooks rely on these
> variables to be present.

Yeah, having to unset HOME would affect not just Git.  Git may call
out something else (e.g. an editor) that may want to know where HOME
is, Git may be used in something else (e.g. an IDE) that may want to
know where HOME is.  Same for XDG_CONFIG_HOME.  If it is a valid need
to not reading from $HOME/.gitconfig, unsetting HOME is an unacceptable
approach to satisfying that need.

> Introduce a new GIT_CONFIG_NOGLOBAL envvar, which is the simple
> equivalent to GIT_CONFIG_NOSYSTEM. If set to true, git will skip reading
> both `~/.gitconfig` and `$XDG_CONFIG_HOME/git/config`.

I do not think we'd add an unbounded number of new configuration
sources to the existing three-level hierarchy of system-wide
(/etc/gitconfig), per-user ($HOME/.gitconfig), and local
(.git/config), so it is not too bad, from scalability point of view,
to keep adding new GIT_CONFIG_NO$FROTZ variables.

Let me go in a couple of different tangents a bit, thinking aloud.

Tangent One.  I wonder if the presense of includeIf.<cond>.path
changes the "we won't have unbounded, so adding another here is OK"
reasoning.  If somebody wanted to say "Do not use the paths that
match this and that pattern", it is likely that we'd end up having
to support a single variable that allows more than one "value".  In
a straw-man syntax "GIT_CONFIG_EXCLUDE='/home/gitster/*
/home/peff/*'" might be a way to say "do not use files that are
under these two directories.

And when that happens, we'd probably notice that it is easier for
users to configure, if they can treat 'system' and 'global' as just
another special pattern to place on that list. //system and //global
might be the syntax we'd choose when time comes, i.e.

	GIT_CONFIG_EXCLUDE='//system //global'

might become a more scalable replacement for

	GIT_CONFIG_NOSYSTEM=yes GIT_CONFIG_NOHOME=yes

Tangent Two.  One thing we never managed to properly test in our
test suite is the unctioning of GIT_CONFIG_NOSYSTEM.  As we do not
want to get broken by whatever is in /etc/gitconfig, all our tests
run with the environment variable set.  For the same reason, in
order to avoid getting influenced by whatever the tester has in
$HOME/.gitconfig, we export HOME set to the throw-away directory
created during the test and control what is in the config file in
that directory.  In hindsight, it might have been a better design to
use GIT_CONFIG_SYSTEM variable that points at a path to be used as a
replacement for /etc/gitconfig when it is set; pointing /dev/null
with the variable would have been the natural way to say "do not use
anything from system configuration".  And GIT_CONFIG_GLOBAL can
easily follow the same pattern.

So, from these two perspective, for the longer term end-user
experience, I am not 100% onboard with GIT_CONFIG_NOGLOBAL.  An
alternative that allows us to move away from GIT_CONFIG_NOSYSTEM in
the direction to the tangent #2 would be not to repeat the same
mistake by doing GIT_CONFIG_NOGLOBAL, and instead adding
GIT_CONFIG_GLOBAL, which is

 (1) when not set, it does not do anything,

 (2) when set to "/dev/null" (a literal string; you do not have to
    spell it "NUL" when on Windows), it acts just like the case
    where your GIT_CONFIG_NOSYSTEM is set,

 (3) when set to any other string, it is taken as a filename that
     has the global configuration.  Unlike $HOME/.gitconfig or
     $XDG_HOME/git/config, it is an error if the named file does not
     exist (this is to catch misconfiguration).

And once this is accepted by users and established as a pattern, we
could migrate GIT_CONFIG_NOSYSTEM to GIT_CONFIG_SYSTEM=/dev/null


Having said all that (meaning: I am not 100% onboard with _NOGLOBAL
and think _GLOBAL=/dev/null might be a better design), let's give it
a review under the assumption that _NOGLOBAL is the design we would
want to choose.

> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index 4b4cc5c5e8..88cd064abb 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -340,6 +340,10 @@ GIT_CONFIG::
>  	Using the "--global" option forces this to ~/.gitconfig. Using the
>  	"--system" option forces this to $(prefix)/etc/gitconfig.
>  
> +GIT_CONFIG_NOGLOBAL::
> +	Whether to skip reading settings from the global ~/.gitconfig and
> +	$XDG_CONFIG_HOME/git/config files. See linkgit:git[1] for details.
> +
>  GIT_CONFIG_NOSYSTEM::
>  	Whether to skip reading settings from the system-wide
>  	$(prefix)/etc/gitconfig file. See linkgit:git[1] for details.

OK.  The new one mimics existing _NOSYSTEM and there is nothing
surprising in the new description.

> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 3a9c44987f..4462bd2da9 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -670,13 +670,21 @@ for further details.
>  	If this environment variable is set to `0`, git will not prompt
>  	on the terminal (e.g., when asking for HTTP authentication).
>  
> +`GIT_CONFIG_NOGLOBAL`::
> +	Whether to skip reading settings from the system-wide `~/.gitconfig`
> +	and `$XDG_CONFIG_HOME/git/config` files.  This environment variable can
> +	be used along with `$GIT_CONFIG_NOSYSTEM` to create a predictable
> +	environment for a picky script, or you can set it temporarily to avoid
> +	using a buggy global config file while waiting for someone with
> +	sufficient permissions to fix it.

"while waiting for someone with permissions" is a good backstory for
inventing _NOSYSTEM because you might not be able to futz with
/etc/gitconfig, but does not sound like an appropriate reasoning for
_NOGLOBAL that is about $HOME/.gitconfig or $HOME/.config/git/config.

>  `GIT_CONFIG_NOSYSTEM`::
>  	Whether to skip reading settings from the system-wide
>  	`$(prefix)/etc/gitconfig` file.  This environment variable can
> -	be used along with `$HOME` and `$XDG_CONFIG_HOME` to create a
> -	predictable environment for a picky script, or you can set it
> -	temporarily to avoid using a buggy `/etc/gitconfig` file while
> -	waiting for someone with sufficient permissions to fix it.
> +	be used along with `$GIT_CONFIG_NOGLOBAL` to create a predictable
> +	environment for a picky script, or you can set it temporarily to avoid
> +	using a buggy `/etc/gitconfig` file while waiting for someone with
> +	sufficient permissions to fix it.

> diff --git a/config.c b/config.c
> index 6428393a41..19c1b31c75 100644
> --- a/config.c
> +++ b/config.c
> @@ -1879,6 +1879,11 @@ int git_config_system(void)
>  	return !git_env_bool("GIT_CONFIG_NOSYSTEM", 0);
>  }
>  
> +static int git_config_global(void)
> +{
> +	return !git_env_bool("GIT_CONFIG_NOGLOBAL", 0);
> +}
> +
>  static int do_git_config_sequence(const struct config_options *opts,
>  				  config_fn_t fn, void *data)
>  {
> @@ -1903,10 +1908,10 @@ static int do_git_config_sequence(const struct config_options *opts,
>  					    data);
>  
>  	current_parsing_scope = CONFIG_SCOPE_GLOBAL;
> -	if (xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK))
> +	if (git_config_global() && xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK))
>  		ret += git_config_from_file(fn, xdg_config, data);
>  
> -	if (user_config && !access_or_die(user_config, R_OK, ACCESS_EACCES_OK))
> +	if (git_config_global() && user_config && !access_or_die(user_config, R_OK, ACCESS_EACCES_OK))
>  		ret += git_config_from_file(fn, user_config, data);
>  
>  	current_parsing_scope = CONFIG_SCOPE_LOCAL;

The implementation itself is quite straightforward for _NOSYSTEM; I
see nothing wrong in the code change for the given design.

> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index e0dd5d65ce..0754189974 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -2059,6 +2059,37 @@ test_expect_success '--show-scope with --show-origin' '
>  	test_cmp expect output
>  '
>  
> +test_expect_success 'GIT_CONFIG_NOGLOBAL' '
> +	test_when_finished rm -f "$HOME"/.config/git &&
> +	cat >"$HOME"/.gitconfig <<-EOF &&
> +	[home]
> +		config = true
> +	EOF
> +	mkdir -p "$HOME"/.config/git &&
> +	cat >"$HOME"/.config/git/config <<-EOF &&
> +	[xdg]
> +		config = true
> +	EOF
> +	cat >.git/config <<-EOF &&
> +	[local]
> +		config = true
> +	EOF
> +
> +	cat >expect <<-EOF &&
> +	global	xdg.config=true
> +	global	home.config=true
> +	local	local.config=true
> +	EOF
> +	git config --show-scope --list >output &&
> +	test_cmp expect output &&
> +
> +	cat >expect <<-EOF &&
> +	local	local.config=true
> +	EOF
> +	GIT_CONFIG_NOGLOBAL=true git config --show-scope --list >output &&
> +	test_cmp expect output
> +'

This test was what initially piqued my curiosity, as the fact that
the result filtered with the new mechanism has only 'local' misled
me to incorrectly think that we are suppressing both 'system' and
'global' with the single variable.  Until I realized that we cannot
test the 'system' configuration in our test suite, that is.

Thanks.
