Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FBAC001E0
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 14:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbjHJObz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 10:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235582AbjHJOby (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 10:31:54 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B48AE4B
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 07:31:52 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BA9121BE8D;
        Thu, 10 Aug 2023 10:31:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=7m0X47KDF4ZZ9att6WOg9kI4thrrRWlZDJ8DpfsPJfo=; b=P8MG
        +Hw8WX1gxaMiy/NfctQBUt8maCe8mTbJlCv5B3Da3padNurtn+uziBJBM0D7zMDy
        y/e6woVcEmY4KsiODLXtzTAZa7MyyNOLjZWvNvIYg9Zcg8AeQvMfidtwGFlQYDOU
        TfLF+9DIJRTWE0LfLdvMobtxZwAoWVvOSq4seLE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B1C9A1BE8C;
        Thu, 10 Aug 2023 10:31:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3AB4B1BE8B;
        Thu, 10 Aug 2023 10:31:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Wesley Schwengle <wesleys@opperschaap.net>
Cc:     git@vger.kernel.org
Subject: Re: [[PATCH v2]] Fix bug when more than one readline instance is used
References: <20230810004956.GA816605@coredump.intra.peff.net>
        <20230810011831.1423208-1-wesleys@opperschaap.net>
Date:   Thu, 10 Aug 2023 07:31:47 -0700
Message-ID: <xmqqmsyzhsto.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A376DB62-378A-11EE-B116-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wesley Schwengle <wesleys@opperschaap.net> writes:

> Subject: Re: [[PATCH v2]] Fix bug when more than one readline instance is used

Thanks.  Again, our convention is to make sure that, even only with
the title, readers would know what the commit is about.  The above
does not even hint which part of the system the bug was about.  By
stealing from what Peff already has done, we can call this

    Subject: [PATCH v2] git-svn: avoid creating more than one Term::ReadLine object

to mimic c016726c (send-email: avoid creating more than one
Term::ReadLine object, 2023-08-08).  Also, please do not double the
[brackets] around the "PATCH".

> A followup[^1] for git-svn.perl on d42e4ca9f8 where this bug was solved
> for git-send-email.perl
>
> [^1]: https://lore.kernel.org/git/20230810004956.GA816605@coredump.intra.peff.net/T/#t

Once a commit is in 'next', its commit object name will generally be
stable, hence, taken as a whole, something like:

    git-svn: avoid creating more than one than one Term::ReadLine object

    Newer (v1.46) Term::ReadLine::Gnu would not like us to ask it to
    create multiple readline instances.  c016726c (send-email: avoid
    creating more than one Term::ReadLine object, 2023-08-08)
    adjusted git-send-email to this change.  Make the same
    adjustment to git-svn.

    While at it, drop the same FakeTerm hack, just like dfd46bae
    (send-email: drop FakeTerm hack, 2023-08-08) did, for exactly
    the same reason.

I'll queue the patch with the above commit log message for tonight,
so unless you have improvements over it, there is no need to resend.

Thanks.

> Signed-off-by: Wesley Schwengle <wesleys@opperschaap.net>
> ---
>  git-svn.perl | 27 +++++++++------------------
>  1 file changed, 9 insertions(+), 18 deletions(-)
>
> diff --git a/git-svn.perl b/git-svn.perl
> index be987e316f..93f6538d61 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -297,27 +297,18 @@ sub _req_svn {
>  		{} ],
>  );
>  
> -package FakeTerm;
> -sub new {
> -	my ($class, $reason) = @_;
> -	return bless \$reason, shift;
> -}
> -sub readline {
> -	my $self = shift;
> -	die "Cannot use readline on FakeTerm: $$self";
> -}
>  package main;
>  
> -my $term;
> -sub term_init {
> -	$term = eval {
> +{
> +	my $term;
> +	sub term_init {
> +		return $term if $term;
>  		require Term::ReadLine;
> -		$ENV{"GIT_SVN_NOTTY"}
> -			? new Term::ReadLine 'git-svn', \*STDIN, \*STDOUT
> -			: new Term::ReadLine 'git-svn';
> -	};
> -	if ($@) {
> -		$term = new FakeTerm "$@: going non-interactive";
> +		$term = $ENV{"GIT_SVN_NOTTY"}
> +				? new Term::ReadLine 'git-svn', \*STDIN, \*STDOUT
> +				: new Term::ReadLine 'git-svn';
> +		};
> +		return $term;
>  	}
>  }
