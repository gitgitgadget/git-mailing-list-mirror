Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C85DC04A95
	for <git@archiver.kernel.org>; Sat, 22 Oct 2022 05:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiJVF3o (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Oct 2022 01:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiJVF3m (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2022 01:29:42 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C122D74B
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 22:29:37 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4A2C41B669E;
        Sat, 22 Oct 2022 01:29:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1kDVE3p0s1uMnWmGH6NnV36rYYPGYYhA677vhY
        OGmPk=; b=TtscNF8m+ISNMr/VFlSbxSmc30/4lauckYUo60t+MO18JFMl1T6RLT
        M9KZFRJPVpqNPai6btDQrRw+z4OFo4/3z9NZO+ORCPi4ryx2XbdjE7E5Hf/IperH
        oCc2MIDcUcm3UUXAHGQxBRB0uIARLH5O451ay16oC6i/bdXmALv1U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 439791B669D;
        Sat, 22 Oct 2022 01:29:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6F1B21B6698;
        Sat, 22 Oct 2022 01:29:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael McClimon <michael@mcclimon.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] setup: allow Git.pm to do unsafe repo checking
References: <20221016212236.12453-1-michael@mcclimon.org>
        <20221022011931.43992-1-michael@mcclimon.org>
        <20221022011931.43992-3-michael@mcclimon.org>
Date:   Fri, 21 Oct 2022 22:29:33 -0700
In-Reply-To: <20221022011931.43992-3-michael@mcclimon.org> (Michael McClimon's
        message of "Fri, 21 Oct 2022 21:19:32 -0400")
Message-ID: <xmqq1qr0ifya.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8331FA5E-51CA-11ED-9AB8-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael McClimon <michael@mcclimon.org> writes:

> The previous commit exposes a security flaw: it is possible to bypass
> unsafe repository checks by using Git.pm, where before the syntax error
> accidentally prohibited it. This problem occurs because Git.pm sets
> GIT_DIR explicitly, which bypasses the safe repository checks.
>
> Fix this by introducing a new environment variable,
> GIT_PERL_FORCE_OWNERSHIP_CHECK, which we set true in Git.pm. In setup.c,
> if that environment variable is true, force ownership checks even if
> an explicit GIT_DIR is provided.

Drop "PERL_" from the name, as any third-party tool that does its
own repository discovery and sets GIT_DIR before it invokes git
would need a similar "Yes, I am setting GIT_DIR, but I still want
you to check if that passes the usual ownership check", and there
is no reason to expect that these tools are always written in Perl.

How about "GIT_SAFE_DIRECTORY_STRICT" or something along that line,
instead?

I also have to wonder (and this is *not* a suggestion for inventing
an alternative fix for perl/Git.pm) if we were creating perl/Git.pm
from scratch today, we even need to be worried about this issue.  We
may have Git::repo_path() helper but if we call it in a natural way
(read: as if an interactive end-user would type commands), it is
likely that we would run "git rev-parse --git-dir" or something
without setting GIT_DIR, and when we need to run "git" command, say
"git diff", we would also run "git diff" as if the end user would
type from within their interactive session and without setting
GIT_DIR, and everything should work.  IOW, why do we even setting
and exporting the auto-detected value in GIT_DIR?

Also, if the end user had GIT_DIR in the environment _before_
calling something that uses "import Git", what should happen?  In
that case, the end-user is who is telling us that the named
directory is OK without any forced ownership check, so it feels
WRONG that this patch UNCONDITIONALLY exports FORCE_CHECK.  Only
when we did auto-discovery via Git::repo_path() without end-user
supplied GIT_DIR and exported GIT_DIR, we should also export
FORCE_CHECK to tell the underlying "git" that our auto-detection
may be flawed and it needs to double check, no?

> Signed-off-by: Michael McClimon <michael@mcclimon.org>
> ---
>  perl/Git.pm         |  1 +
>  setup.c             |  3 +++
>  t/t9700-perl-git.sh |  4 ++++
>  t/t9700/test.pl     | 18 ++++++++++++++++++
>  4 files changed, 26 insertions(+)
>
> diff --git a/perl/Git.pm b/perl/Git.pm
> index cf15ead6..002c29bb 100644
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -1674,6 +1674,7 @@ sub _cmd_exec {
>  sub _setup_git_cmd_env {
>  	my $self = shift;
>  	if ($self) {
> +		$ENV{GIT_PERL_FORCE_OWNERSHIP_CHECK} = 1;
>  		$self->repo_path() and $ENV{'GIT_DIR'} = $self->repo_path();
>  		$self->repo_path() and $self->wc_path()
>  			and $ENV{'GIT_WORK_TREE'} = $self->wc_path();
> diff --git a/setup.c b/setup.c
> index cefd5f63..33d4e6fd 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1250,6 +1250,9 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
>  	 */
>  	gitdirenv = getenv(GIT_DIR_ENVIRONMENT);
>  	if (gitdirenv) {
> +		if (git_env_bool("GIT_PERL_FORCE_OWNERSHIP_CHECK", 0) &&
> +		    !ensure_valid_ownership(NULL, NULL, gitdirenv, report))
> +			return GIT_DIR_INVALID_OWNERSHIP;
>  		strbuf_addstr(gitdir, gitdirenv);
>  		return GIT_DIR_EXPLICIT;
>  	}
> diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
> index 4aa5d90d..b14a40b1 100755
> --- a/t/t9700-perl-git.sh
> +++ b/t/t9700-perl-git.sh
> @@ -45,6 +45,10 @@ test_expect_success \
>       git config --add test.pathmulti bar
>       '
>  
> +test_expect_success 'set up bare repository' '
> +     git init --bare bare.git
> +'
> +
>  test_expect_success 'use t9700/test.pl to test Git.pm' '
>  	"$PERL_PATH" "$TEST_DIRECTORY"/t9700/test.pl 2>stderr &&
>  	test_must_be_empty stderr
> diff --git a/t/t9700/test.pl b/t/t9700/test.pl
> index e046f7db..1c91019f 100755
> --- a/t/t9700/test.pl
> +++ b/t/t9700/test.pl
> @@ -142,6 +142,24 @@ sub adjust_dirsep {
>  		     "abc\"\\ \x07\x08\x09\x0a\x0b\x0c\x0d\x01 ",
>  		     'unquote escape sequences');
>  
> +# safe directory
> +{
> +	local $ENV{GIT_TEST_ASSUME_DIFFERENT_OWNER} = 1;
> +	# Save stderr to a tempfile so we can check the contents
> +	open our $tmpstderr2, ">&STDERR" or die "cannot save STDERR";
> +	my $tmperr = "unsafeerr.tmp";
> +	open STDERR, ">", "$tmperr" or die "cannot redirect STDERR to $tmperr";
> +	my $failed = eval { Git->repository(Directory => "$abs_repo_dir/bare.git") };
> +	ok(!$failed, "reject unsafe repository");
> +	like($@, qr/not a git repository/i, "unsafe error message");
> +	open TEMPFILE, "<", "$tmperr" or die "Can't open $tmperr $!";
> +	my $errcontents;
> +	{ local $/; $errcontents = <TEMPFILE>; }
> +	like($errcontents, qr/dubious ownership/, "dubious ownership message");
> +	close STDERR or die "cannot close temp stderr";
> +	open STDERR, ">&", $tmpstderr2 or die "cannot restore STDERR";
> +}
> +
>  printf "1..%d\n", Test::More->builder->current_test;
>  
>  my $is_passing = eval { Test::More->is_passing };
