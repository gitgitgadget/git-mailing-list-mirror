Return-Path: <SRS0=BQqG=A5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391C8C433E2
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 20:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12AD72073A
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 20:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="M7pqtCe4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgGRUid (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jul 2020 16:38:33 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56779 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgGRUic (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jul 2020 16:38:32 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5CB0BD9336;
        Sat, 18 Jul 2020 16:38:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zEJi2Hz4LTggGiHKf/6kl8YSMj8=; b=M7pqtC
        e4NENFwXMJWAzzWG7go2yDOvpKZsSIniw+wnepsP6fHQjiWl23O3ETX0ufHjXvIh
        Hb3P/m74YxGQaNzf1ql7xFfu51iKPAnwOMMPrzB+1eg5F/aREqG0SS+gSJeyGMrw
        SE6s0pIMsCUzqHEbzpatWnIOxngQCz7IVpSDI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sj9XYzhLtAXuQVf6/w+Qy3qLPsgI5ET/
        mxl/5fdPlMUXpcmRcFqo0deL1v5z9jb3oHMVhdhLllAvNQfmdSph6Oo+Cd3QyZSD
        ZeErJzsCxg2Ix0WqPUq3z3E/W4TwJGwlGVfWI7jet5ZGmFprP6Q5kO81b4C2F6Rr
        NuvZ5MJ8zXI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 55827D9335;
        Sat, 18 Jul 2020 16:38:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 983EAD9333;
        Sat, 18 Jul 2020 16:38:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] git-send-email: die if sendmail.* config is set
References: <20200718202142.111015-1-sir@cmpwn.com>
Date:   Sat, 18 Jul 2020 13:38:25 -0700
In-Reply-To: <20200718202142.111015-1-sir@cmpwn.com> (Drew DeVault's message
        of "Sat, 18 Jul 2020 16:21:42 -0400")
Message-ID: <xmqq8sfgbltq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A1B1214A-C936-11EA-86EE-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Drew DeVault <sir@cmpwn.com> writes:

> I've seen several people mis-configure git send-email on their first
> attempt because they set the sendmail.* config options - not
> sendemail.*. This patch detects this mistake and bails out with a
> friendly warning.
>
> Signed-off-by: Drew DeVault <sir@cmpwn.com>
> ---
>  Documentation/config/sendemail.txt |  5 +++++
>  git-send-email.perl                |  8 ++++++++
>  perl/Git.pm                        | 26 ++++++++++++++++++++++++++
>  3 files changed, 39 insertions(+)
>
> diff --git a/Documentation/config/sendemail.txt b/Documentation/config/sendemail.txt
> index 0006faf800..1726d5f85e 100644
> --- a/Documentation/config/sendemail.txt
> +++ b/Documentation/config/sendemail.txt
> @@ -61,3 +61,8 @@ sendemail.smtpBatchSize::
>  sendemail.smtpReloginDelay::
>  	Seconds wait before reconnecting to smtp server.
>  	See also the `--relogin-delay` option of linkgit:git-send-email[1].
> +
> +sendemail.forceSendmailVariables::
> +	To avoid common misconfiguration mistakes, linkgit:git-send-email[1]
> +	will abort with a warning if any configuration options for "sendmail"
> +	exist. Set this variable to bypass the check.

I am not sure if it is clear to readers what kind of forcing this
refers to.  At least it is not clear to me.

> diff --git a/git-send-email.perl b/git-send-email.perl
> index 36c47bae1d..1b186bc058 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -250,6 +250,7 @@ sub do_edit {
>  my $use_xmailer = 1;
>  my $validate = 1;
>  my $target_xfer_encoding = 'auto';
> +my $forbid_sendmail_variables = 1;

Ah, probably s/force/forbid/ in the documentation above?  OK, then
it makes sense.

>  
>  my %config_bool_settings = (
>      "thread" => \$thread,
> @@ -263,6 +264,7 @@ sub do_edit {
>      "multiedit" => \$multiedit,
>      "annotate" => \$annotate,
>      "xmailer" => \$use_xmailer,
> +    "forbidsendmailvariables" => \$forbid_sendmail_variables,
>  );
>  
>  my %config_settings = (
> @@ -478,6 +480,12 @@ sub read_config {
>      usage();
>  }
>  
> +if ($forbid_sendmail_variables && (scalar Git::config_regexp("sendmail.*")) != 0) {

Judging from the way you wrote the "config_regexp" helper function,
the above regexp matches "sendmailer.foo", "sendmailed.bar", etc., I
would think, which probably is not what you intended.  

I guess we can write "sendmail[.].*" or "sendmail\\..*" to ensure
that we are talking about (literally) "sendmail." followed by
anything?

> +	die __("fatal: found configuration options for 'sendmail'\n" .
> +		"git-send-email is configured with the sendemail.* options - note the 'e'.\n" .
> +		"Set sendemail.forbidSendmailVariables to false to disable this check.\n");
> +}

OK.

Other than the two minor nits, looking quite good.

Thanks.

>  die __("Cannot run git format-patch from outside a repository\n")
>  	if $format_patch and not $repo;
>  
> diff --git a/perl/Git.pm b/perl/Git.pm
> index 54c9ed0dde..10df990959 100644
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -723,6 +723,32 @@ sub config_int {
>  	return scalar _config_common({'kind' => '--int'}, @_);
>  }
>  
> +=item config_regexp ( RE )
> +
> +Retrieve the list of configuration key names matching the regular
> +expression C<RE>. The return value is a list of strings matching
> +this regex.
> +
> +=cut
> +
> +sub config_regexp {
> +	my ($self, $regex) = _maybe_self(@_);
> +	try {
> +		my @cmd = ('config', '--name-only', '--get-regexp', $regex);
> +		unshift @cmd, $self if $self;
> +		my @matches = command(@cmd);
> +		return @matches;
> +	} catch Git::Error::Command with {
> +		my $E = shift;
> +		if ($E->value() == 1) {
> +			my @matches = ();
> +			return @matches;
> +		} else {
> +			throw $E;
> +		}
> +	};
> +}
> +
>  # Common subroutine to implement bulk of what the config* family of methods
>  # do. This currently wraps command('config') so it is not so fast.
>  sub _config_common {
