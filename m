From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] prompt: respect GIT_TERMINAL_PROMPT to disable terminal prompts
Date: Thu, 04 Dec 2014 10:24:09 -0800
Message-ID: <xmqqy4qntgs6.fsf@gitster.dls.corp.google.com>
References: <20141204034206.GA1493@peff.net> <20141204035228.GB21492@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 04 19:24:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwb4a-0003Y4-5B
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 19:24:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbaLDSYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 13:24:12 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50438 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754672AbaLDSYL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 13:24:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5830621F05;
	Thu,  4 Dec 2014 13:24:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Hfehf/4bkMjzJGXJSZLEZxpIqpU=; b=d6/KNC
	7bD1w9nO+sfsWo9erc3jPPsbdy9bx0dfxmrqBJDsxok5h8zOzPL3d18LB34tvswn
	YheGLLeJA+ZCiciQgMLwwjTAslS9eoLP71+Jcn9O27+3G2/K/vx/0Ox/sgPgx7CZ
	QJML2nSod6KBygY26qdQVnsYvZGXK/WUlKM2k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TA+/V0ZacZbOy2227Dxjy0nGij6FCJqi
	Lnlp7XABhnsKPs8jeH0MAaJBIfvxBxS06wWXM5kVUs5lbWRKsk0qVFx7u7luf7ba
	QlE61qgImqxMuF0H8WbkaI7aGhW3MjzfCgxXwCweHMz/p5Rfn974xgO/5gzaHqor
	4xJRpUgVLPo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 42D7B21F04;
	Thu,  4 Dec 2014 13:24:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B385821F03;
	Thu,  4 Dec 2014 13:24:10 -0500 (EST)
In-Reply-To: <20141204035228.GB21492@peff.net> (Jeff King's message of "Wed, 3
	Dec 2014 22:52:29 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BDFB499A-7BE2-11E4-8AAE-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260776>

Jeff King <peff@peff.net> writes:

> diff --git a/prompt.c b/prompt.c
> index e5b4938..8181eeb 100644
> --- a/prompt.c
> +++ b/prompt.c
> @@ -57,11 +57,19 @@ char *git_prompt(const char *prompt, int flags)
>  			r = do_askpass(askpass, prompt);
>  	}
>  
> -	if (!r)
> -		r = git_terminal_prompt(prompt, flags & PROMPT_ECHO);
>  	if (!r) {
> -		/* prompts already contain ": " at the end */
> -		die("could not read %s%s", prompt, strerror(errno));
> +		const char *err;
> +
> +		if (git_env_bool("GIT_TERMINAL_PROMPT", 1)) {
> +			r = git_terminal_prompt(prompt, flags & PROMPT_ECHO);
> +			err = strerror(errno);
> +		} else {
> +			err = "terminal prompts disabled";
> +		}
> +		if (!r) {
> +			/* prompts already contain ": " at the end */
> +			die("could not read %s%s", prompt, err);
> +		}
>  	}
>  	return r;
>  }

I wish this covered a lot more than just this part from an
end-user's point of view, but this is definitely one of the most
important code paths the mechanism should cover.

Thanks, will queue.
