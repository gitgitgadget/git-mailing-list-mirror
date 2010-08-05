From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Submodules: Add the new config option "ignore"
Date: Thu, 05 Aug 2010 09:49:08 -0700
Message-ID: <7vlj8ldmyj.fsf@alter.siamese.dyndns.org>
References: <4C4DD33F.4020104@web.de>
 <alpine.DEB.1.00.1008051025451.2983@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 05 18:49:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh3dF-0001Rv-Ii
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 18:49:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758863Ab0HEQtV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 12:49:21 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55760 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491Ab0HEQtT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 12:49:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 952C1CAB33;
	Thu,  5 Aug 2010 12:49:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FiN4iko5H04bOXbAwreE03cjeMg=; b=JxkbAW
	1DRKrCtvaoFk7+K6/pI+hdLT53QQyEz8CAn2bWWPQQz8gHtn6uUtT1MHFkuD0ISf
	ZyWOjeJOlhXRxslNNiFO0q8+JRHztyZspUaftLZT6YZC3CG+I2MwTIh5PPF+S4o4
	vLnmB7GL2CJcdyX0v9pg6hyPUwTSVcjj4CdJk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s7AA+Zi9PpfvFNn/I6YwnYXqzho4xJzk
	UYcy4AznucL57oz05lhqlBwlGDCbgNzDxQv5/EF3EJYHGltaxSaSXMCI1QL4YyGl
	jz7HJUcHUzdAAF9Wva2gO0yajJYoWjbBi6kGzoEY3inn3mP915xSqJadp/shxMzt
	tlORHGp2X/U=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 56DE5CAB32;
	Thu,  5 Aug 2010 12:49:14 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 684F2CAB28; Thu,  5 Aug
 2010 12:49:10 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.1008051025451.2983@bonsai2> (Johannes
 Schindelin's message of "Thu\, 5 Aug 2010 11\:21\:36 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 611BB1BC-A0B1-11DF-9709-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152688>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Thu, 5 Aug 2010 10:49:55 +0200
> Subject: [PATCH] Add the 'diff.ignoreSubmodules' config setting
> ...
> This commit introduces a global config setting to set a default
> (porcelain) value for the --ignore-submodules option, keeping the
> default at 'none'. It can be overridden by the submodule.*.ignore
> setting and by the --ignore-submodules option.
> ...
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Nice, at least from a cursory look.  

diff_setup() is shared by everybody both plumbing and Porcelain that use
diff and log, but you placed the smudging of the default based on config
is in diff_ui_config(), so this patch looks safe.

And the default setting can be overriden with --ignore-submodules from the
command line during diff_opt_parse(), which is also safe and sane.

Thanks; will queue.

> diff --git a/diff.c b/diff.c
> index 8206047..1ddfdfb 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -31,6 +31,7 @@ static const char *external_diff_cmd_cfg;
>  int diff_auto_refresh_index = 1;
>  static int diff_mnemonic_prefix;
>  static int diff_no_prefix;
> +static struct diff_options default_diff_options;
>  
>  static char diff_colors[][COLOR_MAXLEN] = {
>  	GIT_COLOR_RESET,
> @@ -107,6 +108,9 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
>  	if (!strcmp(var, "diff.wordregex"))
>  		return git_config_string(&diff_word_regex_cfg, var, value);
>  
> +	if (!strcmp(var, "diff.ignoresubmodules"))
> +		handle_ignore_submodules_arg(&default_diff_options, value);
> +
>  	return git_diff_basic_config(var, value, cb);
>  }
>  
> @@ -2816,7 +2820,7 @@ static void run_checkdiff(struct diff_filepair *p, struct diff_options *o)
>  
>  void diff_setup(struct diff_options *options)
>  {
> -	memset(options, 0, sizeof(*options));
> +	memcpy(options, &default_diff_options, sizeof(*options));
>  	memset(&diff_queued_diff, 0, sizeof(diff_queued_diff));
>  
>  	options->file = stdout;
> diff --git a/submodule.c b/submodule.c
> index 1bcb0e9..75f3368 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -110,6 +110,10 @@ int parse_submodule_config_option(const char *var, const char *value)
>  void handle_ignore_submodules_arg(struct diff_options *diffopt,
>  				  const char *arg)
>  {
> +	DIFF_OPT_CLR(diffopt, IGNORE_SUBMODULES);
> +	DIFF_OPT_CLR(diffopt, IGNORE_UNTRACKED_IN_SUBMODULES);
> +	DIFF_OPT_CLR(diffopt, IGNORE_DIRTY_SUBMODULES);
> +
>  	if (!strcmp(arg, "all"))
>  		DIFF_OPT_SET(diffopt, IGNORE_SUBMODULES);
>  	else if (!strcmp(arg, "untracked"))
> -- 
> 1.7.2.1.2240.gde5dd
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
