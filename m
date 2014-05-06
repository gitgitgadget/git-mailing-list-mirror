From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] After chdir to run grep, return to old directory
Date: Tue, 06 May 2014 15:24:08 -0700
Message-ID: <xmqqtx92czqv.fsf@gitster.dls.corp.google.com>
References: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
	<1399072451-15561-2-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: dturner@twopensource.com
X-From: git-owner@vger.kernel.org Wed May 07 00:24:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whnmm-0006Ah-F2
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 00:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754324AbaEFWYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 18:24:23 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53226 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752519AbaEFWYN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 18:24:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D427115FB0;
	Tue,  6 May 2014 18:24:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9UvtwsOgj2Ut+Ake4sUA7xAb0lY=; b=fVYR01
	eKWiX+t5mP4ItJoz0rbihpQFpF3XrkTkLxaHvBKbbZYAnEAh2utpyaVywl0eu3nh
	gwLJtgIjFQ15NjWQBwI53umVmB/YmQJFNuD50XIvE0uJxeHG8gA9CK1lst19J9Eq
	5QdqIOuFbP1h0DWuRn09MZDj0OgvRLhz3pn1A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hVEkAxlmmzvHY8iasNqFKWXLmnB2LIUO
	SmDXX7zJP5AowbbLnCGn5CUtHuZp04pPdzMkZiPBPvnTNXLLFNUlHgVWPLZX2sG9
	w4hRw91xD+qkXfHveg1bGuPwG6sgw3cipNEW1MfS9O5wvoZdpru8BoMtGivNh1Em
	Oqht1EYCXB4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C9A5515FAF;
	Tue,  6 May 2014 18:24:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 781ED15FA9;
	Tue,  6 May 2014 18:24:10 -0400 (EDT)
In-Reply-To: <1399072451-15561-2-git-send-email-dturner@twopensource.com>
	(dturner@twopensource.com's message of "Fri, 2 May 2014 19:14:09
	-0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 254A3AEC-D56D-11E3-BF3A-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248259>

dturner@twopensource.com writes:

> From: David Turner <dturner@twitter.com>
>
> Signed-off-by: David Turner <dturner@twitter.com>

Ehh, why?

> ---
>  builtin/grep.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 69ac2d8..e9fe040 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -355,15 +355,25 @@ static void run_pager(struct grep_opt *opt, const char *prefix)
>  {
>  	struct string_list *path_list = opt->output_priv;
>  	const char **argv = xmalloc(sizeof(const char *) * (path_list->nr + 1));
> +	static char old_directory[PATH_MAX+1];
>  	int i, status;
>  
>  	for (i = 0; i < path_list->nr; i++)
>  		argv[i] = path_list->items[i].string;
>  	argv[path_list->nr] = NULL;
>  
> -	if (prefix && chdir(prefix))
> -		die(_("Failed to chdir: %s"), prefix);
> +
> +	if (prefix) {
> +		if (!getcwd(old_directory, PATH_MAX+1))
> +			die(_("Failed to get cwd: %s"), prefix);
> +		if (chdir(prefix))
> +			die(_("Failed to chdir: %s"), prefix);
> +	}
>  	status = run_command_v_opt(argv, RUN_USING_SHELL);
> +	if (prefix)
> +		if (chdir(old_directory))
> +			die(_("Failed to chdir: %s"), old_directory);
> +
>  	if (status)
>  		exit(status);
>  	free(argv);
