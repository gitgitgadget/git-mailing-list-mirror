From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 08/21] checkout-index: there are only two possible line terminations
Date: Fri, 15 Jan 2016 13:22:00 -0800
Message-ID: <xmqq1t9ih72f.fsf@gitster.mtv.corp.google.com>
References: <1452740590-16827-1-git-send-email-gitster@pobox.com>
	<1452815916-6447-1-git-send-email-gitster@pobox.com>
	<1452815916-6447-9-git-send-email-gitster@pobox.com>
	<20160115200856.GC11301@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 15 22:22:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKBoy-0007pA-Lh
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 22:22:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbcAOVWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 16:22:04 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53716 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751314AbcAOVWD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 16:22:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 507983BB52;
	Fri, 15 Jan 2016 16:22:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gdB2qk9sidoCsoykqP9YDmYrsZQ=; b=DDKfKG
	TpfgnVRk9NVwxiNQ3sruJpOgrMHIZ3WRH7Oi0soQMAkGl+bj1XshoQ7dUbMI5+Lu
	ytAKoc4JgNfAsqcAZww6ljwR9ImIxqIQsXoXhL0+44AVRS67W/jr8/LdQc4iZPzi
	Mk+eYeoEvE7BWHYh23NxCle9kG71I6qYpGo2o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BcW1QcIaUkUGEa1Zi+IwMjnolhsDfM6Q
	NPyOYStds99sY8Fa2xnjQdqu5nEGowKSvUnYLGPSu12bjZVbBh9IVvKQ9xMCQkH+
	oJeT6RagYusprQ+/A0dAOg3Q4aK8klxrmr9wnZFNsC9ME7MHjnSN5ndUvRtekhz3
	LVc5ohW9uCs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4975B3BB51;
	Fri, 15 Jan 2016 16:22:02 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AFBCA3BB4E;
	Fri, 15 Jan 2016 16:22:01 -0500 (EST)
In-Reply-To: <20160115200856.GC11301@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 15 Jan 2016 15:08:56 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0478DF50-BBCE-11E5-A36C-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284218>

Jeff King <peff@peff.net> writes:

> On Thu, Jan 14, 2016 at 03:58:23PM -0800, Junio C Hamano wrote:
>
>> @@ -144,10 +145,7 @@ static int option_parse_u(const struct option *opt,
>>  static int option_parse_z(const struct option *opt,
>>  			  const char *arg, int unset)
>>  {
>> -	if (unset)
>> -		line_termination = '\n';
>> -	else
>> -		line_termination = 0;
>> +	nul_term_line = !unset;
>>  	return 0;
>>  }
>
> Is it worth doing this on top?

Yes.

To be bluntly honest, the above callback has no right to exist.  I
should have turned it from OPTION_CALLBACK to OPT_BOOL from the
start.

>
> -- >8 --
> Subject: [PATCH] checkout-index: simplify "-z" option parsing
>
> Now that we act as a simple bool, there's no need to use a
> custom callback.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---



>  builtin/checkout-index.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
> index d8d7bd3..3b913d1 100644
> --- a/builtin/checkout-index.c
> +++ b/builtin/checkout-index.c
> @@ -142,13 +142,6 @@ static int option_parse_u(const struct option *opt,
>  	return 0;
>  }
>  
> -static int option_parse_z(const struct option *opt,
> -			  const char *arg, int unset)
> -{
> -	nul_term_line = !unset;
> -	return 0;
> -}
> -
>  static int option_parse_prefix(const struct option *opt,
>  			       const char *arg, int unset)
>  {
> @@ -192,9 +185,8 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
>  		{ OPTION_CALLBACK, 'u', "index", &newfd, NULL,
>  			N_("update stat information in the index file"),
>  			PARSE_OPT_NOARG, option_parse_u },
> -		{ OPTION_CALLBACK, 'z', NULL, NULL, NULL,
> -			N_("paths are separated with NUL character"),
> -			PARSE_OPT_NOARG, option_parse_z },
> +		OPT_BOOL('z', NULL, &nul_term_line,
> +			N_("paths are separated with NUL character")),
>  		OPT_BOOL(0, "stdin", &read_from_stdin,
>  			N_("read list of paths from the standard input")),
>  		OPT_BOOL(0, "temp", &to_tempfile,
