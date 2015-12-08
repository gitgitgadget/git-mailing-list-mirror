From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] config: add core.untrackedCache
Date: Tue, 08 Dec 2015 11:28:57 -0800
Message-ID: <xmqqsi3ckadi.fsf@gitster.mtv.corp.google.com>
References: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
	<1449594916-21167-8-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6gersh?= =?utf-8?Q?ausen?= 
	<tboegi@web.de>, Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 20:29:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6Nwg-0002Ib-LR
	for gcvg-git-2@plane.gmane.org; Tue, 08 Dec 2015 20:29:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112AbbLHT3B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2015 14:29:01 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61730 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752068AbbLHT3A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2015 14:29:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 65F9530E77;
	Tue,  8 Dec 2015 14:28:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sV9MOZ5odvnBoDitTPo4bXrIuFM=; b=hPn85Y
	IoWOaTxCTFMjmB/xXfK9quc2Y1AThotldpo4UEzoavXLKlsF3L+opRYdbSJMSXiw
	Xr4t51PKiOXGUn+dK4ePUbrQWzc/8eejB9UBneGNUMKIK0hEnFJPrV3pLz9ZlJty
	YizpS669BjO1taIfZRztPQVSh/pnprJU8BbdU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LQ9pBhWLo+ryu8+SwtZ0yPk0i/r7ohj2
	MGorYI+i5g5tD0azoodsvCC1HigXNv4vwmMLVGgHrx8q7MBxGZdaDx9+j8qKhQH7
	I9EPLNGQKylVpk1pHCZPP3DrQcoZAzyloF282pfa8/XeOOq7X36pnkraPRIz5qep
	gklkRmV/a0s=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5C89B30E76;
	Tue,  8 Dec 2015 14:28:59 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A407830E75;
	Tue,  8 Dec 2015 14:28:58 -0500 (EST)
In-Reply-To: <1449594916-21167-8-git-send-email-chriscool@tuxfamily.org>
	(Christian Couder's message of "Tue, 8 Dec 2015 18:15:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EDCD82E2-9DE1-11E5-91DB-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282175>

Christian Couder <christian.couder@gmail.com> writes:

> When we know that mtime is fully supported by the environment, we
> might want the untracked cache to be always used by default without
> any mtime test or kernel version check being performed.
>
> Also when we know that mtime is not supported by the environment,
> for example because the repo is shared over a network file system,
> then we might want 'git update-index --untracked-cache' to fail
> immediately instead of preforming tests (because it might work on
> some systems using the repo over the network file system but not
> others).
>
> The normal way to achieve the above in Git is to use a config
> variable. That's why this patch introduces "core.untrackedCache".
>
> To keep things simple, this variable is a bool which default to
> false.
>
> When "git status" is run, it now adds or removes the untracked
> cache in the index to respect the value of this variable.
>
> This means that `git update-index --[no-|force-]untracked-cache`,
> to be compatible with the new config variable, have to set or
> unset it. This new behavior is backward incompatible change, but
> that is deliberate.

The logic in this paragraph is fuzzy to me.  Shouldn't the config
give a sensible default, that is overriden by command line options?
I agree that it is insane to do a runtime check when the user says
"update-index --untracked-cache" to enable it, as the user _knows_
that enabling it would help (or the user _knows_ that she wants to
play with it).  Similarly, shouldn't the config be ignored when the
user says "update-index --no-untracked-cache" (hence removing the
untracked cache from the resulting index no matter the config is set
to)?  Why is it a good idea to allow an explicit operation from the
command line to muck with the configuration?  If the user wants to
change the configuration permanently, "git config" has been there
for the purpose for all the configuration variables to do so for
almost forever.  Why is it a good idea to make this variable so
special that the user does not have to use "git config" but disable
or enable it in some other way?

> Also `--untracked-cache` used to check that the underlying
> operating system and file system change `st_mtime` field of a
> directory if files are added or deleted in that directory. But
> those tests take a long time and there is now
> `--test-untracked-cache` to perform them.
>
> So to be more consistent with other git commands, this patch
> prevents `--untracked-cache` to perform tests.

Good change.

> This means that
> after this patch there is no difference any more between
> `--untracked-cache` and `--force-untracked-cache`.

A tip to write the explanation.  Every time you say "This means
that...", you are (perhaps unconsciously) admitting that what you
wrote immedidately before that may not be understandable and what
comes after it may be a better explanation.  Discard the sentence
before "This means that", and try to formulate your explanation
around what you wrote after it, adding information in the discarded
earlier sentence back to the later one.  Doing this exercise often
helps the result read much better.

>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/config.txt               |  7 +++++++
>  Documentation/git-update-index.txt     | 28 ++++++++++++++++++----------
>  builtin/update-index.c                 | 23 +++++++++++++----------
>  cache.h                                |  1 +
>  config.c                               |  4 ++++
>  contrib/completion/git-completion.bash |  1 +
>  dir.c                                  |  2 +-
>  environment.c                          |  1 +
>  t/t7063-status-untracked-cache.sh      |  4 +---
>  wt-status.c                            |  9 +++++++++
>  10 files changed, 56 insertions(+), 24 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 2d06b11..94820eb 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -308,6 +308,13 @@ core.trustctime::
>  	crawlers and some backup systems).
>  	See linkgit:git-update-index[1]. True by default.
>  
> +core.untrackedCache::
> +	Determines if untracked cache will be enabled. Using
> +	'git update-index --[no-|force-]untracked-cache' will set
> +	this variable. Before setting it to true, you should check
> +	that mtime is working properly on your system.
> +	See linkgit:git-update-index[1]. False by default.
> +
>  core.checkStat::
>  	Determines which stat fields to match between the index
>  	and work tree. The user can set this to 'default' or
> diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
> index 0ff7396..0fb39db 100644
> --- a/Documentation/git-update-index.txt
> +++ b/Documentation/git-update-index.txt
> @@ -175,22 +175,28 @@ may not support it yet.
>  --no-untracked-cache::
>  	Enable or disable untracked cache extension. This could speed
>  	up for commands that involve determining untracked files such
> -	as `git status`. The underlying operating system and file
> -	system must change `st_mtime` field of a directory if files
> -	are added or deleted in that directory.
> +	as `git status`.
> ++
> +The underlying operating system and file system must change `st_mtime`
> +field of a directory if files are added or deleted in that
> +directory. You can test that using
> +`--test-untracked-cache`. `--untracked-cache` used to test that too
> +but it doesn't anymore.
> ++
> +This sets the `core.untrackedCache` configuration variable to 'true'
> +or 'false' in the repo config file, (see linkgit:git-config[1]), so
> +that the untracked cache stays enabled or disabled.
>  
>  --test-untracked-cache::
>  	Only perform tests on the working directory to make sure
>  	untracked cache can be used. You have to manually enable
> -	untracked cache using `--force-untracked-cache` (or
> -	`--untracked-cache` but this will run the tests again)
> -	afterwards if you really want to use it.
> +	untracked cache using `--untracked-cache` or
> +	`--force-untracked-cache` or the `core.untrackedCache`
> +	configuration variable afterwards if you really want to use
> +	it.
>  
>  --force-untracked-cache::
> -	For safety, `--untracked-cache` performs tests on the working
> -	directory to make sure untracked cache can be used. These
> -	tests can take a few seconds. `--force-untracked-cache` can be
> -	used to skip the tests.
> +	Same as `--untracked-cache`.
>  
>  \--::
>  	Do not interpret any more arguments as options.
> @@ -406,6 +412,8 @@ It can be useful when the inode change time is regularly modified by
>  something outside Git (file system crawlers and backup systems use
>  ctime for marking files processed) (see linkgit:git-config[1]).
>  
> +Untracked cache look at `core.untrackedCache` configuration variable
> +(see linkgit:git-config[1]).
>  
>  SEE ALSO
>  --------
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index e427657..7fe3a86 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -1115,19 +1115,22 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>  		the_index.split_index = NULL;
>  		the_index.cache_changed |= SOMETHING_CHANGED;
>  	}
> +	if (untracked_cache == TEST_UC) {
> +		setup_work_tree();
> +		return !test_if_untracked_cache_is_supported();
> +	}
>  	if (untracked_cache > NO_UC) {
> -		if (untracked_cache < FORCE_UC) {
> -			setup_work_tree();
> -			if (!test_if_untracked_cache_is_supported())
> -				return 1;
> -			if (untracked_cache == TEST_UC)
> -				return 0;
> -		}
> +		if (!use_untracked_cache && git_config_set("core.untrackedCache", "true"))
> +			die("could not set core.untrackedCache to true");
>  		add_untracked_cache();
>  		fprintf(stderr, _("Untracked cache enabled for '%s'\n"), get_git_work_tree());
> -	} else if (untracked_cache == NO_UC && the_index.untracked) {
> -		remove_untracked_cache();
> -		fprintf(stderr, _("Untracked cache disabled\n"));
> +	} else if (untracked_cache == NO_UC) {
> +		if (use_untracked_cache > 0 && git_config_set("core.untrackedCache", "false"))
> +			die("could not set core.untrackedCache to false");
> +		if (the_index.untracked) {
> +			remove_untracked_cache();
> +			fprintf(stderr, _("Untracked cache disabled\n"));
> +		}
>  	}
>  
>  	if (active_cache_changed) {
> diff --git a/cache.h b/cache.h
> index 2a9e902..0cc2c2f 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -619,6 +619,7 @@ extern void set_alternate_index_output(const char *);
>  /* Environment bits from configuration mechanism */
>  extern int trust_executable_bit;
>  extern int trust_ctime;
> +extern int use_untracked_cache;
>  extern int check_stat;
>  extern int quote_path_fully;
>  extern int has_symlinks;
> diff --git a/config.c b/config.c
> index 248a21a..f023ee7 100644
> --- a/config.c
> +++ b/config.c
> @@ -691,6 +691,10 @@ static int git_default_core_config(const char *var, const char *value)
>  		trust_ctime = git_config_bool(var, value);
>  		return 0;
>  	}
> +	if (!strcmp(var, "core.untrackedcache")) {
> +		use_untracked_cache = git_config_bool(var, value);
> +		return 0;
> +	}
>  	if (!strcmp(var, "core.checkstat")) {
>  		if (!strcasecmp(value, "default"))
>  			check_stat = 1;
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 111b053..b7e5736 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2054,6 +2054,7 @@ _git_config ()
>  		core.sparseCheckout
>  		core.symlinks
>  		core.trustctime
> +		core.untrackedCache
>  		core.warnAmbiguousRefs
>  		core.whitespace
>  		core.worktree
> diff --git a/dir.c b/dir.c
> index ffc0286..aa07aca 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -2014,7 +2014,7 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
>  	if (dir->exclude_list_group[EXC_CMDL].nr)
>  		return NULL;
>  
> -	if (!ident_in_untracked(dir->untracked)) {
> +	if (use_untracked_cache != 1 && !ident_in_untracked(dir->untracked)) {
>  		warning(_("Untracked cache is disabled on this system."));
>  		return NULL;
>  	}
> diff --git a/environment.c b/environment.c
> index 2da7fe2..9ca71b1 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -14,6 +14,7 @@
>  
>  int trust_executable_bit = 1;
>  int trust_ctime = 1;
> +int use_untracked_cache;
>  int check_stat = 1;
>  int has_symlinks = 1;
>  int minimum_abbrev = 4, default_abbrev = 7;
> diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
> index 0e8d0d4..253160a 100755
> --- a/t/t7063-status-untracked-cache.sh
> +++ b/t/t7063-status-untracked-cache.sh
> @@ -8,10 +8,8 @@ avoid_racy() {
>  	sleep 1
>  }
>  
> -# It's fine if git update-index returns an error code other than one,
> -# it'll be caught in the first test.
>  test_lazy_prereq UNTRACKED_CACHE '
> -	{ git update-index --untracked-cache; ret=$?; } &&
> +	{ git update-index --test-untracked-cache; ret=$?; } &&
>  	test $ret -ne 1
>  '
>  
> diff --git a/wt-status.c b/wt-status.c
> index 435fc28..3e0fe02 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -586,6 +586,15 @@ static void wt_status_collect_untracked(struct wt_status *s)
>  		dir.flags |= DIR_SHOW_IGNORED_TOO;
>  	else
>  		dir.untracked = the_index.untracked;
> +
> +	if (!dir.untracked && use_untracked_cache == 1) {
> +		add_untracked_cache();
> +		dir.untracked = the_index.untracked;
> +	} else if (dir.untracked && use_untracked_cache == 0) {
> +		remove_untracked_cache();
> +		dir.untracked = NULL;
> +	}
> +
>  	setup_standard_excludes(&dir);
>  
>  	fill_directory(&dir, &s->pathspec);
