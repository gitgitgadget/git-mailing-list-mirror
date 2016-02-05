From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv8 6/9] fetching submodules: respect `submodule.fetchJobs` config option
Date: Thu, 04 Feb 2016 19:29:48 -0800
Message-ID: <xmqqa8nfeswj.fsf@gitster.mtv.corp.google.com>
References: <1454623776-3347-1-git-send-email-sbeller@google.com>
	<1454623776-3347-7-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 04:31:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRX74-00084F-Jb
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 04:31:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbcBEDa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 22:30:57 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50973 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750722AbcBEDaz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 22:30:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D356242D3B;
	Thu,  4 Feb 2016 22:30:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VzjLTgLw/cRKeLEQAnirmhEJR6Y=; b=MZNXSu
	Boea7/zEpz20hnn2pjPoMzfaHKMy72rP9IicoQ1FOMDkSAy5Xkwdl//owENEFwxV
	5sbpVsgXGFsBA+gS9UaPtCbp4LNOCPjIlac/U0LT4pmsW3v8vWZHLWe6D5Nyp+GM
	tO7W2EwJ5CXY44LThJq6OV3LFw35+/5xOF+VM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J1AxpJjO5y0fVISuDK4JSlZdOzSLHIOK
	04J+DlBlCP7Q2iDrt5FYNwsXKqsUmRK/TB3GykXvd7n09FW2l49ob6izLhBacPiH
	sJBXUjKMfleARXb4tGNX0pCKu1RikvgzQuhHrfOyxd2yJqcq8oUm72bcWiTaIxVW
	NETUYcriQew=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CAE3C42D3A;
	Thu,  4 Feb 2016 22:30:53 -0500 (EST)
Received: from pobox.com (unknown [104.133.3.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3C90242D39;
	Thu,  4 Feb 2016 22:30:53 -0500 (EST)
In-Reply-To: <1454623776-3347-7-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Thu, 4 Feb 2016 14:09:33 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DC26C0BC-CBB8-11E5-8A02-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285535>

Stefan Beller <sbeller@google.com> writes:

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 586840d..5aa1c2d 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -37,7 +37,7 @@ static int prune = -1; /* unspecified */
>  static int all, append, dry_run, force, keep, multiple, update_head_ok, verbosity;
>  static int progress = -1, recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
>  static int tags = TAGS_DEFAULT, unshallow, update_shallow;
> -static int max_children = 1;
> +static int max_children = -1;

This makes sense as you would later be doing "If left unspecified,
i.e. -1, then fall back to blah" ...

g> diff --git a/submodule-config.c b/submodule-config.c
> index 2841c5e..339b59d 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -32,6 +32,7 @@ enum lookup_type {
>  
>  static struct submodule_cache cache;
>  static int is_cache_init;
> +static unsigned long parallel_jobs = -1;

... but I do not think this does.  For one thing, you would not be
doing "If parallel_jobs < -1, then that is unspecified yet" for the
unsigned long variable, and for another, I do not think you would be
behaving differently for the first time (i.e. "unspecified yet" case).

I think you want to initialize this to 1, if your "not configured at
all" default is supposed to be 1.

> @@ -233,6 +234,13 @@ static int parse_generic_submodule_config(const char *key,
>  					  const char *value,
>  					  struct parse_config_parameter *me)
>  {
> +	if (!strcmp(key, "fetchjobs")) {
> +		if (!git_parse_ulong(value, &parallel_jobs)) {
> +			warning(_("Error parsing submodule.fetchJobs; Defaulting to 1."));
> +			parallel_jobs = 1;

Hmph, this is not a die() because...?  Not a rhetorical question.

> +unsigned long config_parallel_submodules(void)
> +{
> +	return parallel_jobs;
> +}

It is not a crime to make this return "int", as the code that
eventually uses it will assign it to a variable that will be
passed to run_processes_parallel() that takes an "int".

In fact, returning "int" would be preferrable.  You are causing
truncation somewhere in the callchain anyway.  If the truncation
bothers you, this function or immediately after calling
git_parse_ulong() would be a good place to do a range check.  The
variable parallel_jobs has to stay "unsigned long" in any case as
you are calling git_parse_ulong().

> diff --git a/submodule.c b/submodule.c
> index b83939c..eb7d54b 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -751,6 +751,11 @@ int fetch_populated_submodules(const struct argv_array *options,
>  	argv_array_push(&spf.args, "--recurse-submodules-default");
>  	/* default value, "--submodule-prefix" and its value are added later */
>  
> +	if (max_parallel_jobs < 0)
> +		max_parallel_jobs = config_parallel_submodules();
> +	if (max_parallel_jobs < 0)
> +		max_parallel_jobs = 1;
> +
>  	calculate_changed_submodule_paths();
>  	run_processes_parallel(max_parallel_jobs,
>  			       get_next_submodule,
