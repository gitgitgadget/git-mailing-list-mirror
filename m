From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git remote add: allow re-adding remotes with the same URL
Date: Mon, 22 Dec 2014 09:49:22 -0800
Message-ID: <xmqq1tnrbmn1.fsf@gitster.dls.corp.google.com>
References: <20141216021900.50095.24877@random.io>
	<cover.1419267895.git.johannes.schindelin@gmx.de>
	<9c0c693efe68b1c0b080c14104bb6c5f7bf74097.1419267895.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: anapsix@random.io, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 22 18:49:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y376n-0001c9-PM
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 18:49:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755111AbaLVRtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 12:49:25 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63013 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754621AbaLVRtY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 12:49:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E4AC228608;
	Mon, 22 Dec 2014 12:49:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iqc7Ss0lFzAF9rdxeiTOYCbPPi4=; b=mFB6rF
	sx4OYRPzacBq6LphHCx7zd/QnJlmZ3cJSElS2/p/y7zXr6f1cY7A+AX3D5QA4mVC
	cfqNYVpJ0Bx0vMsAmAwwOMHpGs2UgNLk3MzyeASyvb/sSc5pmnNAblHmnXklMwMZ
	AoZwabl2wwQQGWsglgAOeswpFX6CFiD0lbuPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f8+ygiW7q97ifpYTkOhRbWfuMnrzQxoE
	X/cjUFWLoqjxgvicEaA8jitXATTGZjYZCfwdbQ0p/8bvOh/ldEjyumRmYlMUtbKs
	PxGwUuF7djoQxCYueIG8AJM+onSlgyzb6mMOSv0SagCxiI/0Plawd63A0jTcYWMm
	ZU165KQLDoY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D9FB328607;
	Mon, 22 Dec 2014 12:49:23 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5C52B28606;
	Mon, 22 Dec 2014 12:49:23 -0500 (EST)
In-Reply-To: <9c0c693efe68b1c0b080c14104bb6c5f7bf74097.1419267895.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Mon, 22 Dec 2014 18:06:50 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DD36B50A-8A02-11E4-959F-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261656>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> When adding a remote, we make sure that the remote does not exist
> already.
>
> For convenience, we allow re-adding remotes with the same URLs.
> This also handles the case that there is an "[url ...] insteadOf"
> setting in the config.
>
> It might seem like a mistake to compare against remote->url[0] without
> verifying that remote->url_nr >=1, but at this point a missing URL has
> been filled by the name already, therefore url_nr cannot be zero.
>
> Noticed by Anastas Dancha.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/remote.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/remote.c b/builtin/remote.c
> index 46ecfd9..9168c83 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -180,7 +180,8 @@ static int add(int argc, const char **argv)
>  	url = argv[1];
>  
>  	remote = remote_get(name);
> -	if (remote && (remote->url_nr > 1 || strcmp(name, remote->url[0]) ||
> +	if (remote && (remote->url_nr > 1 || (strcmp(name, remote->url[0]) &&
> +				strcmp(url, remote->url[0])) ||
>  			remote->fetch_refspec_nr))
>  		die(_("remote %s already exists."), name);

When we need to fold an overlong line, it is easier to read if the
line is folded at an operator with higher precedence, i.e. this line

        if (A && (B || (C && D) || E))

folded like this

        if (A && (B || (C &&
                   D) ||
            E))

is harder to read than when folded like this

        if (A && (B ||
                  (C && D) ||
                   E))

So, it is an error if we have "remote" and if

 (1) URL for the remote is defined already twice or more; or
 (2) we are adding a nickname (i.e. not a URL) and it is different
     from what we already have; or
 (3) we already have fetch_refspec

The way I read the log message's rationale was that this is to allow
replacing an existing remote's URL; wouldn't checking the existence
of fetch_refspec go against that goal?

Puzzled.  Either the code is wrong or I am mislead by the
explanation in the log.
