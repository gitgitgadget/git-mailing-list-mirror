From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] remote: fix trivial memory leak
Date: Tue, 15 Oct 2013 14:50:45 -0700
Message-ID: <xmqqob6qcife.fsf@gitster.dls.corp.google.com>
References: <1379772563-11000-1-git-send-email-felipe.contreras@gmail.com>
	<1379772563-11000-3-git-send-email-felipe.contreras@gmail.com>
	<20130924051908.GG2766@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 15 23:50:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWCVw-0003fj-1D
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 23:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933768Ab3JOVus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 17:50:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47558 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933524Ab3JOVur (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 17:50:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 565BE4AC83;
	Tue, 15 Oct 2013 21:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ISjLO3A4hUJ04TdmA55rew8Jmto=; b=TBt2LL
	rFDCND5jUX8jE2c4lGyRTSCZEMPzcv0Zj6u6u/KHABRBPobeWK2BTmzB7PfFJlEf
	EAQKYcib+/q24322ajOurR3i8HZ2zUcB9vODddcOj2BMODzfU26YOCCFmHNaGg8R
	INTCwTvjDMtVo4wnnS/nfuTpM/uRxz9smpDa0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rcSmVEoLUjdDjdgBSrlbomtIAz4Lm0ss
	co2kAgkcLkNhRkfNn6nm7DFSxnqZCXQ1uz+QkZydCW8qLhihY7h91NtRxAoTlG8X
	8xppJKSzX4Qy/I21HwPlofwLvv1kd8W4cyAjxUcPxK8dHNgXsAYqTwH4RD1AJIyj
	RwwHZjmBNGo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 479604AC82;
	Tue, 15 Oct 2013 21:50:47 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A38814AC7F;
	Tue, 15 Oct 2013 21:50:46 +0000 (UTC)
In-Reply-To: <20130924051908.GG2766@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 24 Sep 2013 01:19:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D9102E9E-35E3-11E3-8E80-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236200>

Jeff King <peff@peff.net> writes:

> I wondered if we might also leak when seeing duplicate config options
> (i.e., leaking the old one when replacing it with the new). But we don't
> actually strdup() the configured remote names, but instead just point
> into the "struct branch", which owns the data.

In addition, we do not copy this string to remote->name in make_remote(),
so even if we start allowing destruction of existing remote[], the
resulting code will stay safe.

> So I think an even better fix would be:
>
> -- >8 --
> Subject: remote: do not copy "origin" string literal
>
> Our default_remote_name starts at "origin", but may be
> overridden by the config file. In the former case, we
> allocate a new string, but in the latter case, we point to
> the remote name in an existing "struct branch".
>
> This gives the variable inconsistent free() semantics (we
> are sometimes responsible for freeing the string and
> sometimes pointing to somebody else's storage), and causes a
> small leak when the allocated string is overridden by
> config.
>
> We can fix both by simply dropping the extra copy and
> pointing to the string literal.
>
> Noticed-by: Felipe Contreras <felipe.contreras@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>

Sounds sensible. Thanks.

> ---
>  remote.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/remote.c b/remote.c
> index e9fedfa..9f1a8aa 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -483,7 +483,7 @@ static void read_config(void)
>  	int flag;
>  	if (default_remote_name) /* did this already */
>  		return;
> -	default_remote_name = xstrdup("origin");
> +	default_remote_name = "origin";
>  	current_branch = NULL;
>  	head_ref = resolve_ref_unsafe("HEAD", sha1, 0, &flag);
>  	if (head_ref && (flag & REF_ISSYMREF) &&
