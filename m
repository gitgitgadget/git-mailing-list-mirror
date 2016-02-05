From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 2/3] ident: add user.useConfigOnly boolean for when ident shouldn't be guessed
Date: Fri, 05 Feb 2016 11:31:34 -0800
Message-ID: <xmqqio23c5t5.fsf@gitster.mtv.corp.google.com>
References: <1454658148-3031-1-git-send-email-alonid@gmail.com>
	<1454658148-3031-3-git-send-email-alonid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Dan Aloni <alonid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 20:31:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRm6Y-0000Jg-H8
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 20:31:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754381AbcBETbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 14:31:38 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55262 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754258AbcBETbh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 14:31:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5D0AC402EE;
	Fri,  5 Feb 2016 14:31:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M1DKAPZPSEfv9tqqQfWXAGMAKRs=; b=x7zhGb
	d71zRNnqXb/ORtwXEtj3+t/d9uSDuFYeL8+ddjx5XtnwtORDM1QjjWyv1EpKE2M0
	mMwPipz15n98DUfj0YHEs/4jdz+ID2hw10AeTfGmV6QzaWmQDW2Hxm+uysOjKjWL
	h/2QHI7inz2ZllH5B7VQYnT0EijsMkBWRjewg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lBEVnIhQDrT9eWDWcTzHyBPe8UidjdVn
	srbHiNLW2iwkXNrlDxEw3U7ctt36dSCF8YbJkz6Qjb05OrVo8UWlezVnVgiCRCfW
	Oh0c9wyZQFTpxTicDFm0DgolZPZb+CfwNAO58tB2M5Fl6/pWbwy12tO19nxXayOY
	Pwp7YXv8GbY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5453B402ED;
	Fri,  5 Feb 2016 14:31:36 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A0B89402E7;
	Fri,  5 Feb 2016 14:31:35 -0500 (EST)
In-Reply-To: <1454658148-3031-3-git-send-email-alonid@gmail.com> (Dan Aloni's
	message of "Fri, 5 Feb 2016 09:42:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 11B43774-CC3F-11E5-8C2F-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285600>

Dan Aloni <alonid@gmail.com> writes:

> +user.useConfigOnly::
> +	This instruct Git to avoid trying to guess defaults for 'user.email'
> +	and 'user.name' other than strictly from environment or config.

OK.

> +	If you have multiple email addresses that you would like to set
> +	up per repository, you may want to set this to 'true' in the global
> +	config, and then Git would prompt you to set user.email separately,
> +	in each of the cloned repositories.

The first sentence mentioned both name and email, but here the
example is only about email.  A first time reader might be led into
thinking this is only about email and not name, but I am assuming
that is not the intention (i.e. this is merely showing just one use
case).

> +	Defaults to `false`.
> +
>  user.signingKey::
>  	If linkgit:git-tag[1] or linkgit:git-commit[1] is not selecting the
>  	key you want it to automatically when creating a signed tag or
> diff --git a/ident.c b/ident.c
> index f3a431f738cc..9bd6ac69bfe8 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -13,11 +13,14 @@ static struct strbuf git_default_date = STRBUF_INIT;
>  static int default_email_is_bogus;
>  static int default_name_is_bogus;
>  
> +static int ident_use_config_only;
> +
>  #define IDENT_NAME_GIVEN 01
>  #define IDENT_MAIL_GIVEN 02
>  #define IDENT_ALL_GIVEN (IDENT_NAME_GIVEN|IDENT_MAIL_GIVEN)
>  static int committer_ident_explicitly_given;
>  static int author_ident_explicitly_given;
> +static int ident_config_given;
>  
>  #ifdef NO_GECOS_IN_PWENT
>  #define get_gecos(ignored) "&"
> @@ -354,6 +357,9 @@ const char *fmt_ident(const char *name, const char *email,
>  				fputs(env_hint, stderr);
>  				die("unable to auto-detect name (got '%s')", name);
>  			}
> +			if (strict && ident_use_config_only &&
> +			    !(ident_config_given & IDENT_NAME_GIVEN))
> +				die("user.useConfigOnly set but no name given");
>  		}
>  		if (!*name) {
>  			struct passwd *pw;
> @@ -373,6 +379,9 @@ const char *fmt_ident(const char *name, const char *email,
>  			fputs(env_hint, stderr);
>  			die("unable to auto-detect email address (got '%s')", email);
>  		}
> +		if (strict && ident_use_config_only
> +		    && !(ident_config_given & IDENT_MAIL_GIVEN))
> +			die("user.useConfigOnly set but no mail given");

I can read the split expression either with && hanging at the end of
line or && leading the next line just fine, but you'd want to be
consistent especially when you are writing two almost identical
things.

> diff --git a/t/t9904-per-repo-email.sh b/t/t9904-per-repo-email.sh
> new file mode 100755
> index 000000000000..0430f2e38434
> --- /dev/null
> +++ b/t/t9904-per-repo-email.sh
> @@ -0,0 +1,58 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2016 Dan Aloni
> +#
> +
> +test_description='per-repo forced setting of email address'
> +
> +. ./test-lib.sh
> +
> +prepare () {
> +	# Have a non-empty repository
> +	rm -fr .git
> +	git init

Hmm, do we do something drastic like this in any of our existing
tests?

When your test script starts by dot-sourcing test-lib.sh, you will
be given an initial repository with an empty history, so I'd expect
that you would be able to use that without calling "prepare" over
and over again.  The usual convention is to do this kind of setup
to establish a reasonable baseline in the first test titled 'setup'.
I think the part up to where you unset the environment variables (by
the way, don't you need to unset GIT_COMMITTER_* variables, too?)
belongs to the 'setup' that is done only once at the beginning of
this script.

Each of your tests will make changes to the state by setting or
unsetting configuration variables and possibly making commits, that
would affect the state of the repository that will be used by the
next and subsequent tests.  test_when_finished helper can register
the clean-up procedure to revert these possible state changes, and
you can further avoid code duplication by calling that same clean-up
procedure at the end of the setup test.

So if this followed the style of a typical existing test, we would
probably do something along these lines:

	reprepare () {
		git reset --hard initial &&
                echo Second >foo &&
                git add foo
	}

	test_expect_success setup '
		echo Initial >foo &&
                git add foo &&
                git commit -m foo &&
                git tag initial &&

		sane_unset GIT_AUTHOR_NAME GIT_COMMITTER_NAME ... &&
                git config --global user.name test &&
                git config --global user.useConfigOnly true &&
		reprepare
        '

	test_expect_success 'fail without email anywhere' '
        	test_when_finished reprepare &&
                test_must_fail git commit -m msg
	'

	test_expect_success 'suceed with config' '
        	test_when_finished reprepare &&
		test_config user.email test@ok.com &&
                test_must_fail git commit -m msg
	'

Note that you do not need "test_unconfig user.email" in reprepare,
as the variable is set in one test with test_config, which uses
test_when_finished to arrange the variable to be removed after
running the test.

> +	echo "Initial" >foo &&
> +	git add foo &&
> +	git commit -m foo &&
> +
> +	# Setup a likely user.useConfigOnly use case
> +	sane_unset GIT_AUTHOR_NAME &&
> +	sane_unset GIT_AUTHOR_EMAIL &&
> +	test_unconfig --global user.name &&
> +	test_unconfig --global user.email &&
> +	test_config user.name "test" &&
> +	test_unconfig user.email &&
> +	test_config_global user.useConfigOnly true
> +}
> +
> +about_to_commit () {
> +	echo "Second" >>foo &&
> +	git add foo
> +}

> +test_expect_success 'fails committing if clone email is not set' '
> +	prepare && about_to_commit &&
> +
> +	test_must_fail git commit -m msg
> +'

> +test_expect_success 'fails committing if clone email is not set, but EMAIL set' '
> +	prepare && about_to_commit &&
> +
> +	test_must_fail env EMAIL=test@fail.com git commit -m msg
> +'
> +
> +test_expect_success 'succeeds committing if clone email is set' '
> +	prepare && about_to_commit &&
> +
> +	test_config user.email "test@ok.com" &&
> +	git commit -m msg
> +'
> +
> +test_expect_success 'succeeds cloning if global email is not set' '
> +	prepare &&
> +
> +	git clone . clone
> +'
> +
> +test_done
