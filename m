From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] use local cloning if insteadOf makes a local URL
Date: Thu, 17 Jul 2014 10:23:24 -0700
Message-ID: <xmqqwqbbq4qb.fsf@gitster.dls.corp.google.com>
References: <1405580972-26078-1-git-send-email-michael.barabanov@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Michael Barabanov <michael.barabanov@windriver.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 19:23:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7pP7-0004MY-Hd
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 19:23:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752025AbaGQRXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2014 13:23:33 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54013 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751389AbaGQRXc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2014 13:23:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 521F229AA9;
	Thu, 17 Jul 2014 13:23:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3Rq3sceiIv6Iv6E55PUyr5/qCK0=; b=aHankG
	fr+0n0oQon/GH3nkpSRZcUjf5Xvmbk7/5Ey0vvxp5Z765Op4y99YSmrzBZCU9lgt
	Vm0G1yOMFc7MX8Lyfn0mKtfHL4RopqEDalDznBGTQCAIVMAFqFT/UgX0j3lB0DdR
	VOfqgn2NZxQn0X77RsQ25UVYt0kZ5J3cCfxgg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sJwPkid+BAMIzYqdpX1q3/7myrT7+4GO
	aIe+dcXzKgfzR08tGJT3qB2yYv7HQ/zD2f8gWCJ9pQJOpejIRrOFJeDoNhlrEeVE
	Oj+XCsll/r5Y6rOOde8KPrGh3BwjpAVLck0eglB5csFGGBw6l8ABOeLr8ul3HAkJ
	HhYF4rwd3rA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 469FB29AA8;
	Thu, 17 Jul 2014 13:23:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AA15C29A96;
	Thu, 17 Jul 2014 13:23:25 -0400 (EDT)
In-Reply-To: <1405580972-26078-1-git-send-email-michael.barabanov@windriver.com>
	(Michael Barabanov's message of "Thu, 17 Jul 2014 00:09:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0F7ED7AC-0DD7-11E4-A7DD-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253762>

Michael Barabanov <michael.barabanov@windriver.com> writes:
> Move the is_local logic to the place where origin remote has been setup and
> check if the remote url can be used to do local cloning.
>
> This saves a lot of space (and time) in some of the mirroring scenarios that
> involve insteadOf rewrites.
>
> Signed-off-by: Michael Barabanov <michael.barabanov@windriver.com>
> ---

Strictly speaking, this change introduces a regression to those who
would rather use --no-local if they knew the are cloning from a
local copy, but they can rewrite their insteadOf to use file:// URL
as a workaround.

The code change looked OK from a cursory read, modulo possibly
introducing a new memory leak on the old value of "path" (I didn't
check carefully).

Thanks.

>  builtin/clone.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index f0dabec..bbd169c 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -799,18 +799,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  		die(_("repository '%s' does not exist"), repo_name);
>  	else
>  		repo = repo_name;
> -	is_local = option_local != 0 && path && !is_bundle;
> -	if (is_local) {
> -		if (option_depth)
> -			warning(_("--depth is ignored in local clones; use file:// instead."));
> -		if (!access(mkpath("%s/shallow", path), F_OK)) {
> -			if (option_local > 0)
> -				warning(_("source repository is shallow, ignoring --local"));
> -			is_local = 0;
> -		}
> -	}
> -	if (option_local > 0 && !is_local)
> -		warning(_("--local is ignored"));
>  
>  	/* no need to be strict, transport_set_option() will validate it again */
>  	if (option_depth && atoi(option_depth) < 1)
> @@ -903,6 +891,19 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  
>  	remote = remote_get(option_origin);
>  	transport = transport_get(remote, remote->url[0]);
> +	path = get_repo_path(remote->url[0], &is_bundle);
> +	is_local = option_local != 0 && path && !is_bundle;
> +	if (is_local) {
> +		if (option_depth)
> +			warning(_("--depth is ignored in local clones; use file:// instead."));
> +		if (!access(mkpath("%s/shallow", path), F_OK)) {
> +			if (option_local > 0)
> +				warning(_("source repository is shallow, ignoring --local"));
> +			is_local = 0;
> +		}
> +	}
> +	if (option_local > 0 && !is_local)
> +		warning(_("--local is ignored"));
>  	transport->cloning = 1;
>  
>  	if (!transport->get_refs_list || (!is_local && !transport->fetch))
