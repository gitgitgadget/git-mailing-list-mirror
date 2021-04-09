Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1A1C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 15:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F50F610E5
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 15:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhDIPiq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 11:38:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:46286 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233288AbhDIPip (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 11:38:45 -0400
Received: (qmail 31739 invoked by uid 109); 9 Apr 2021 15:38:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 09 Apr 2021 15:38:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12442 invoked by uid 111); 9 Apr 2021 15:38:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 09 Apr 2021 11:38:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 9 Apr 2021 11:38:31 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/3] config: allow overriding of global and system
 configuration
Message-ID: <YHB092HN2oVLmqC1@coredump.intra.peff.net>
References: <a23382059bb57022dd1e40d1c2c9a11307b0ff3b.1617891426.git.ps@pks.im>
 <cover.1617975637.git.ps@pks.im>
 <272a3b31aa73da8d65b04e647b1b9ca860f4e783.1617975637.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <272a3b31aa73da8d65b04e647b1b9ca860f4e783.1617975637.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 09, 2021 at 03:43:30PM +0200, Patrick Steinhardt wrote:

> In order to have git run in a fully controlled environment without any
> misconfiguration, it may be desirable for users or scripts to override
> global- and system-level configuration files. We already have a way of
> doing this, which is to unset both HOME and XDG_CONFIG_HOME environment
> variables and to set `GIT_CONFIG_NOGLOBAL=true`. This is quite kludgy,
> and unsetting the first two variables likely has an impact on other
> executables spawned by such a script.
> 
> The obvious way to fix this would be to introduce `GIT_CONFIG_NOSYSTEM`
> as an equivalent to `GIT_CONFIG_NOGLOBAL`. But in the past, it has

I think you have NOSYSTEM and NOGLOBAL mixed up in both paragraphs here?

Otherwise the motivation and description here look very good (and I like
the overall direction).

> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 3a9c44987f..2129629296 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -670,6 +670,16 @@ for further details.
>  	If this environment variable is set to `0`, git will not prompt
>  	on the terminal (e.g., when asking for HTTP authentication).
>  
> +`GIT_CONFIG_GLOBAL`::
> +`GIT_CONFIG_SYSTEM`::
> +	Take the configuration from the given files instead from global or
> +	system-level configuration files. The files must exist and be readable
> +	by the current user. If `GIT_CONFIG_SYSTEM` is set, `/etc/gitconfig`
> +	will not be read. Likewise, if `GIT_CONFIG_GLOBAL` is set, neither
> +	`$HOME/.gitconfig` nor `$XDG_CONFIG_HOME/git/config` will be read. Can
> +	be set to `/dev/null` to skip reading configuration files of the
> +	respective level.

Makes sense. The reference to `/etc/gitconfig` here may not be accurate,
depending on the build parameters. I notice below in the context that we
say:

>  `GIT_CONFIG_NOSYSTEM`::
>  	Whether to skip reading settings from the system-wide
>  	`$(prefix)/etc/gitconfig` file.  This environment variable can

which is _also_ not quite right (if $(prefix) is "/usr", then the file
really is /etc/gitconfig).

I think it might be possible to pull the value of the ETC_GITCONFIG
Makefile variable into the documentation, so we could probably give the
"real" value. But I wonder if it would suffice to just say:

   ...the system config (usually `/etc/gitconfig`) will not be read.

Or is that too confusing (it invites the question "when is it not
/etc/gitconfig")? I guess we could say "the system config file defined
at build-time (usually `/etc/gitconfig`)", which is perhaps more clear.

> @@ -1847,8 +1847,22 @@ static int git_config_from_blob_ref(config_fn_t fn,
>  const char *git_system_config(void)
>  {
>  	static const char *system_wide;
> -	if (!system_wide)
> -		system_wide = system_path(ETC_GITCONFIG);
> +
> +	if (!system_wide) {
> +		system_wide = xstrdup_or_null(getenv("GIT_CONFIG_SYSTEM"));

I wondered, given the "const char *" return values in the last patch, if
you might pass back the result of getenv() directly. But you duplicate
it here, which is good, as it avoids portability problems hanging on to
the result of getenv().

> +		if (system_wide) {
> +			/*
> +			 * If GIT_CONFIG_SYSTEM is set, it overrides the
> +			 * /etc/gitconfig. Furthermore, the file must exist in
> +			 * order to prevent any typos by the user.
> +			 */
> +			if (access(system_wide, R_OK))
> +				die(_("cannot access '%s'"), system_wide);
> +		} else {
> +			system_wide = system_path(ETC_GITCONFIG);
> +		}
> +	}

I was on the fence about whether to enforce the "this file must exist"
property, with respect to the overall design. But seeing how we must
actually add extra code here to handle it makes me want to just treat it
exactly like the other files.

Using a separate access() here is also a TOCTOU race, but I'm pretty
sure the existing config code makes the same mistake (and it's not that
big a deal in this context).

> @@ -1857,8 +1871,20 @@ void git_global_config(const char **user, const char **xdg)
>  	static const char *user_config, *xdg_config;
>  
>  	if (!user_config) {
> -		user_config = expand_user_path("~/.gitconfig", 0);
> -		xdg_config = xdg_config_home("config");
> +		user_config = xstrdup_or_null(getenv("GIT_CONFIG_GLOBAL"));
> +		if (user_config) {
> +			/*
> +			 * If GIT_CONFIG_GLOBAL is set, then it overrides both
> +			 * the ~/.gitconfig and the XDG configuration file.
> +			 * Furthermore, the file must exist in order to prevent
> +			 * any typos by the user.
> +			 */
> +			if (access(user_config, R_OK))
> +				die(_("cannot access '%s'"), user_config);
> +		} else {
> +			user_config = expand_user_path("~/.gitconfig", 0);
> +			xdg_config = xdg_config_home("config");
> +		}
>  	}

And this looks as I'd expect (but the same comments as above apply, of
course).

> +test_expect_success 'override global and system config' '
> +	test_when_finished rm -f "$HOME"/.config/git &&
> +
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
> +	cat >custom-global-config <<-EOF &&
> +	[global]
> +		config = true
> +	EOF
> +	cat >custom-system-config <<-EOF &&
> +	[system]
> +		config = true
> +	EOF

Minor style nit, but we usually prefer non-interpolating "\EOF" if we
don't intend to interpolate within the here-doc. It does look like
t1300 has quite a mix of styles, though.

> +	cat >expect <<-EOF &&
> +	global	xdg.config=true
> +	global	home.config=true
> +	local	local.config=true
> +	EOF
> +	git config --show-scope --list >output &&
> +	test_cmp expect output &&
> +
> +	sane_unset GIT_CONFIG_NOSYSTEM &&
> +
> +	cat >expect <<-EOF &&
> +	system	system.config=true
> +	global	global.config=true
> +	local	local.config=true
> +	EOF
> +	GIT_CONFIG_SYSTEM=custom-system-config GIT_CONFIG_GLOBAL=custom-global-config \
> +		git config --show-scope --list >output &&
> +	test_cmp expect output &&
> +
> +	cat >expect <<-EOF &&
> +	local	local.config=true
> +	EOF
> +	GIT_CONFIG_SYSTEM=/dev/null GIT_CONFIG_GLOBAL=/dev/null git config --show-scope --list >output &&
> +	test_cmp expect output
> +'

And this test covers all of the new stuff we care about. Good.

> +test_expect_success 'override global and system config with missing file' '
> +	sane_unset GIT_CONFIG_NOSYSTEM &&
> +	test_must_fail env GIT_CONFIG_GLOBAL=does-not-exist git version &&
> +	test_must_fail env GIT_CONFIG_SYSTEM=does-not-exist git version &&
> +	GIT_CONFIG_NOSYSTEM=true GIT_CONFIG_SYSTEM=does-not-exist git version
> +'

Makes sense to test given the patch, though if we rip out the "missing"
check, then obviously this goes away.

> +test_expect_success 'write to overridden global and system config' '

Hmm. I hadn't really considered _writing_ to these files (after all, you
can just use "git config --file" to do so). I guess it is consistent,
and would probably be more work (and more error-prone) to try to
distinguish reading versus writing in the code.

> +	cat >expect <<EOF &&
> +[config]
> +	key = value
> +EOF

No "<<-EOF" here to fix the indentation?

> +	test_must_fail env GIT_CONFIG_GLOBAL=write-to-global git config --global config.key value &&
> +	touch write-to-global &&
> +	GIT_CONFIG_GLOBAL=write-to-global git config --global config.key value &&
> +	test_cmp expect write-to-global &&

In the writing case, the "must exist" thing makes it even weirder, since
we might be intending to create the file! If we leave in the writing,
that makes me even more convinced that we should drop the "must exist"
check.

-Peff
