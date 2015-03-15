From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git.c: two memory leak fixes
Date: Sat, 14 Mar 2015 19:18:24 -0700
Message-ID: <xmqq3857vw9b.fsf@gitster.dls.corp.google.com>
References: <1426358613-30180-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 03:18:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWy8P-0001PR-US
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 03:18:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbbCOCS1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2015 22:18:27 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53469 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751133AbbCOCS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2015 22:18:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E2D9541454;
	Sat, 14 Mar 2015 22:18:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+0NS7tzLCRqF3t5gw/pXC323UkI=; b=Wpt/Y7
	WbmPzeZl8LFMqLlsABMvBiBLdUHXeyWRmF1VKZp4zBJIe+Ja+1SWY9Ixd0sM/wBi
	nArdmMRkZBh79hYt1O0ZmuLdXpeRGawhqMYKZa2XQqHKtATyOC7a8ASjXx1E1Qdt
	DGHqzDQFR4kvKm2gXA8rfrfBg2ljvqfy3xwJI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MHpG+v0L0W82V/8rvnXJNvUHs9MKvRKu
	cbVnm+bTCTvinaf52t5G8S7HEcE23mVLI1iiSu25kEqyQTzTVwKM7WqZPVdFam5O
	34oLncEkyzF1ahMrTw+R7HyNgFP0fv2lZizu8F62jRaf1Po176DFxrbzxBJGKCpj
	HsZ0QOJo+mA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DBD0841452;
	Sat, 14 Mar 2015 22:18:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5AACB41451;
	Sat, 14 Mar 2015 22:18:25 -0400 (EDT)
In-Reply-To: <1426358613-30180-1-git-send-email-kuleshovmail@gmail.com>
	(Alexander Kuleshov's message of "Sun, 15 Mar 2015 00:43:33 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8F894370-CAB9-11E4-A98D-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265477>

Alexander Kuleshov <kuleshovmail@gmail.com> writes:

> This patch provides fixes for two minor memory leaks in the
> handle_alias function:
>
> 1. We allocate memory for alias_argv with the xmalloc function call,
> after run_command_v_opt function will be executed we no need in this
> variable anymore, so let's free it.

This is technically correct, but do we really care about it?

We have finished running the command and all that is left is either
to exit(ret) or to die(); either will let the operating system clear
the memory together with the entire process for us.

The "normal exit" codepath still holds a live "alias_string" when it
calls exist(ret), but you do not free it even after this patch,
which is an inconsistent stance to take.  I think it is OK not to
bother freeing alias_string just before exit(), and I would apply
the same reasoning to alias_argv[], too.

> 2. Memory allocated for alias_string variable in the alias_lookup function,
> need to free it.

I think it is wrong to free alias_string after passing it to
split_cmdline() and while you still need to use the new_argv.

Reading the split_cmdline() implementation again, the new argv which
is an array of pointers is newly allocated, but I think the pointers
in the array point into the cmdline parameter.  From the caller's
point of view, new_argv[0] points at the beginning of alias_string,
new_argv[1] points at the beginning of the second "word" of
alias_string, etc., all of which will become invalid if you free
alias_string, no?

> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---
>  git.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/git.c b/git.c
> index 086fac1..501e5bd 100644
> --- a/git.c
> +++ b/git.c
> @@ -252,6 +252,7 @@ static int handle_alias(int *argcp, const char ***argv)
>  			alias_argv[argc] = NULL;
>  
>  			ret = run_command_v_opt(alias_argv, RUN_USING_SHELL);
> +			free(alias_argv);
>  			if (ret >= 0)   /* normal exit */
>  				exit(ret);
>  
> @@ -259,6 +260,7 @@ static int handle_alias(int *argcp, const char ***argv)
>  			    alias_command, alias_string + 1);
>  		}
>  		count = split_cmdline(alias_string, &new_argv);
> +		free(alias_string);
>  		if (count < 0)
>  			die("Bad alias.%s string: %s", alias_command,
>  			    split_cmdline_strerror(count));
