Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01F2320C11
	for <e@80x24.org>; Tue, 28 Nov 2017 01:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752709AbdK1BNr (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 20:13:47 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60532 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752452AbdK1BNq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 20:13:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2455EC0215;
        Mon, 27 Nov 2017 20:13:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UmnMQuAHef7zKUVdaQtGpoGMwxo=; b=It3OMY
        xQGkY4516zbntrkmql7Q2hO0lbWR0dagggrMFlHKjoAtY4U0KwLo/Z/veMYLFShJ
        6HBZxEoGPVaPwGBBg09y7zhtaOhxy3pfqDwLLzDy79kPPz1FsBv+OPwBlx5+wv7e
        UsN2PiZG6eRqpRMyRIiZsGn8MCw+o4XHqE7Zw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gb+GXoD30EPfkmNJNnKrxOc2LVycXIM5
        XlMvzd76qJpoR75gKQb+vk+HLOYCwkPFDPEbkHc3OZ7hazOs1hb868HlY9VhB7qS
        yYxSpjyRsyVIkk1ImSq62uectxrkRNDreCFRR2UtVGZFPc6z0BhoA8DbuQT6UBk9
        hc9bYcGWiyY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1AFBDC0214;
        Mon, 27 Nov 2017 20:13:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 42CCEC0213;
        Mon, 27 Nov 2017 20:13:43 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Florian Klink <flokli@flokli.de>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net
Subject: Re: [PATCH v3] git-send-email: honor $PATH for sendmail binary
References: <20171119123511.pck5aqak4yyc6367@tp.flokli.de>
        <20171128004904.13978-1-flokli@flokli.de>
Date:   Tue, 28 Nov 2017 10:13:41 +0900
In-Reply-To: <20171128004904.13978-1-flokli@flokli.de> (Florian Klink's
        message of "Tue, 28 Nov 2017 01:49:04 +0100")
Message-ID: <xmqq609v9pdm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 602B6ED8-D3D9-11E7-9C1B-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Florian Klink <flokli@flokli.de> writes:

> This extends git-send-email to also consider sendmail binaries in $PATH
> after checking the (fixed) list of /usr/sbin and /usr/lib, and before
> falling back to localhost.
>
> Signed-off-by: Florian Klink <flokli@flokli.de>
> ---

Thanks for an update.

In an ideal world where we were introducing git-send-email for the
first time without any existing users, we would certainly prefer
things on directories listed in $PATH, and use the two traditional
hardcoded places merely as fallback, but because we do have existing
users who have been relying on the code finding /usr/lib/sendmail
(even when they have something called 'sendmail' that they do not
want to use on their $PATH) and doing that ideal implementation
would break things for them.  Those who have /usr/lib/sendmail
installed that they do not want to use can continue to use
sendemail.smtpserver---if $PATH were searched first, they could
instead list the path that has their faviourite sendmail on it
without setting the configuration, but it does not change the fact
that they need to do _something_ anyway, so it is not too huge a
deal.

>  Documentation/git-send-email.txt | 6 +++---
>  git-send-email.perl              | 4 +++-
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index bac9014ac..44db25567 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -203,9 +203,9 @@ a password is obtained using 'git-credential'.
>  	specify a full pathname of a sendmail-like program instead;
>  	the program must support the `-i` option.  Default value can
>  	be specified by the `sendemail.smtpServer` configuration
> -	option; the built-in default is `/usr/sbin/sendmail` or
> -	`/usr/lib/sendmail` if such program is available, or
> -	`localhost` otherwise.
> +	option; the built-in default is to search for `sendmail` in
> +	`/usr/sbin`, `/usr/lib/sendmail` and $PATH if such program is
> +	available, falling back to `localhost` otherwise.

"search for `sendmail` in `/usr/sbin`, `/usr/lib/sendmail`" would
mean we would not be happy with /usr/lib/sendmail but would be with
either /usr/sbin/sendmail or /usr/lib/sendmail/sendmail, which is
not what you wanted to say.  I'd do 's|/usr/lib/sendmail|/usr/lib|'
while queueing.

Thanks again.

>  --smtp-server-port=<port>::
>  	Specifies a port different from the default port (SMTP
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 2208dcc21..edcc6d346 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -885,7 +885,9 @@ if (defined $initial_reply_to) {
>  }
>  
>  if (!defined $smtp_server) {
> -	foreach (qw( /usr/sbin/sendmail /usr/lib/sendmail )) {
> +	my @sendmail_paths = qw( /usr/sbin/sendmail /usr/lib/sendmail );
> +	push @sendmail_paths, map {"$_/sendmail"} split /:/, $ENV{PATH};
> +	foreach (@sendmail_paths) {
>  		if (-x $_) {
>  			$smtp_server = $_;
>  			last;
