From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] Clean stale environment pointer in finish_command()
Date: Mon, 10 Nov 2014 13:44:24 -0800
Message-ID: <xmqqbnoe91dz.fsf@gitster.dls.corp.google.com>
References: <cover.1415368490.git.johannes.schindelin@gmx.de>
	<cover.1415630072.git.johannes.schindelin@gmx.de>
	<df1b16208e443416f7185c8c8c110e637ea97ac4.1415630072.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 10 22:44:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnwlF-000340-Gm
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 22:44:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506AbaKJVo3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 16:44:29 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58670 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752100AbaKJVo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 16:44:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 579DF1DDC6;
	Mon, 10 Nov 2014 16:44:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sfImZzm7rJATkiLbSLIuk6BL2/Y=; b=kzKL4s
	8NOd9SoCcnbydtqleae/fVypONcLA/r6/uUTaSjNq5YCEuae/2JXzD6Wa3XS5Zlp
	PaWJ5XHB8Fd+WQ9oRj0UGPohkjeoU+qq8BrtU5iBj8YZ6Ca/NRblEFGOh/lTLe8K
	0nRigD3k2++DAVyw8TUxa55c0Y+p2C1R17XiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xc3Z7ydQ5QOhjElbdqgYXNcphMVjnPW6
	WnRZu2x9oumhUxTv7KQhIM2vDtLIAfNuiuwoZOZ8qLpSKwEyjIcjizsVS4FzKhMw
	/voKgKyoEFOEbBjGw33W0KDNrUi4cZH7USbAqAVYs4gKR3sER5wAOEdIOkobA8hG
	M44ah1b4goc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E8B91DDC5;
	Mon, 10 Nov 2014 16:44:27 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B8A511DDC3;
	Mon, 10 Nov 2014 16:44:25 -0500 (EST)
In-Reply-To: <df1b16208e443416f7185c8c8c110e637ea97ac4.1415630072.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Mon, 10 Nov 2014 15:38:36 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BD896212-6922-11E4-A3E8-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> In start_command(), unset "env" fields are initialized via "env_array". In
> finish_command(), the "env_array" is cleared, therefore the "env" field
> will point to free()d data.
>
> However, start_command() will set "env" to env_array.argv only if "env"
> was unset to begin with, and if it was already set, the caller will need
> the original value. Therefore, we need to be very careful only to reset
> "env" in finish_command() when it has been initialized in start_command().

Hmph.  Does the same observation apply to cmd->argv that is
initialied to point to cmd->args.argv only when it is unset?

These managed argv/env arrays originate from c460c0ec (run-command:
store an optional argv_array, 2014-05-15), so I am CC'ing Peff.  I
think this change makes sense but I suspect we should do the same
for args.

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  run-command.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/run-command.c b/run-command.c
> index 79a0a76..85578da 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -555,6 +555,9 @@ int finish_command(struct child_process *cmd)
>  {
>  	int ret = wait_or_whine(cmd->pid, cmd->argv[0]);
>  	argv_array_clear(&cmd->args);
> +	/* Avoid pointing to a stale environment */
> +	if (cmd->env == cmd->env_array.argv)
> +		cmd->env = NULL;
>  	argv_array_clear(&cmd->env_array);
>  	return ret;
>  }
