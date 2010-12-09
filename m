From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/3] fetch/pull: Add the --recurse-submodules option
Date: Thu, 09 Dec 2010 13:16:17 -0800
Message-ID: <7vei9qfxzy.fsf@alter.siamese.dyndns.org>
References: <4CDB3063.5010801@web.de> <20101111000538.GB14189@burratino>
 <4CDD391C.2000905@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Kevin Ballard <kevin@sb.org>,
	Jon Seymour <jon.seymour@gmail.com>,
	Chris Packham <judge.packham@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Dec 09 22:16:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQnr0-00028Y-Pc
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 22:16:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756783Ab0LIVQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 16:16:38 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52337 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752883Ab0LIVQh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 16:16:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CF52A36CA;
	Thu,  9 Dec 2010 16:16:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CE0Hi22sKeaBh609ctmOHkL0YBs=; b=vDUxEl
	aVL0bT6WAHgDV5ps5EtLzgmnOFdpa+3ZI1si1jqs+UbSDDKC5S3gTiL97t7jm6I+
	ellGG0IMiuOk0nnsaZ3nDiwzxAMT4XyeKJFY58uMcGnV6yiN9yPSNPJrjQhawlND
	tVSK6Z5hLTSFYO67Y76xcAVFJX7H5gSdo/xKE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BZNfXJk8qhJ6oZ4opwhCjRN7l66gmcpZ
	KCdqCgfgIlDsTwHrOXfOl5mro9kM1kQVu397zdBKLAV2006vHviTqIz0hNSbi7eN
	E+5KJFnLcnIDpy/T0FsVyCuhouNTo725qprdbUAsKEYgWuOnUw+QkhGydGlaC5eG
	rytAJIVDuQs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5C37936C6;
	Thu,  9 Dec 2010 16:16:52 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0FCF136C5; Thu,  9 Dec 2010
 16:16:42 -0500 (EST)
In-Reply-To: <4CDD391C.2000905@web.de> (Jens Lehmann's message of "Fri\, 12
 Nov 2010 13\:54\:52 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A47A5C70-03D9-11E0-A6AD-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163323>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Until now you had to call "git submodule update" (without -N|--no-fetch
> option) or something like "git submodule foreach git fetch" to fetch
> new commits in populated submodules from their remote.
> ...
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index d35f000..db3fba3 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> ...
> @@ -784,28 +790,36 @@ static int add_remote_or_group(const char *name, struct string_list *list)
>  	return 1;
>  }
>
> -static int fetch_multiple(struct string_list *list)
> +static void add_options_to_argv(int *argc, const char **argv)
>  {
> -	int i, result = 0;
> -	const char *argv[11] = { "fetch", "--append" };
> -...
> +static int fetch_multiple(struct string_list *list)
> +{
> +	int i, result = 0;
> +	const char *argv[12] = { "fetch", "--append" };

This used to be 11; are we adding something new?  Ahh, possibly
"--recurse_submodules".

> diff --git a/submodule.c b/submodule.c
> index 91a4758..4d9b774 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -63,7 +63,7 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
>  	}
>  }
>
> -static int submodule_config(const char *var, const char *value, void *cb)
> +int submodule_config(const char *var, const char *value, void *cb)
>  {
>  	if (!prefixcmp(var, "submodule."))
>  		return parse_submodule_config_option(var, value);
> @@ -229,6 +229,70 @@ void show_submodule_summary(FILE *f, const char *path,
>  	strbuf_release(&sb);
>  }
>
> +int fetch_populated_submodules(int num_options, const char **options,
> +			       const char *prefix, int quiet)
> +{
> +	int i, result = 0, argc = 0;
> +	struct child_process cp;
> +	const char **argv;
> +	struct string_list_item *name_for_path;
> +	const char *work_tree = get_git_work_tree();
> +	if (!work_tree)
> +		return 0;
> +
> +	if (!the_index.initialized)
> +		if (read_cache() < 0)
> +			die("index file corrupt");
> +
> +	argv = xcalloc(num_options + 5, sizeof(const char *));

Where is this '5' coming from?  "fetch" "--submodule-prefix", the prefix,
and the terminating NULL?  What did I miss?
