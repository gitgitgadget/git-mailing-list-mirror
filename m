From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/8] fetching submodules: respect `submodule.fetchJobs` config option
Date: Wed, 03 Feb 2016 15:09:29 -0800
Message-ID: <xmqq60y5l7bq.fsf@gitster.mtv.corp.google.com>
References: <1454435497-26429-1-git-send-email-sbeller@google.com>
	<1454435497-26429-6-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 00:09:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aR6YO-0005YV-PR
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 00:09:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753280AbcBCXJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2016 18:09:36 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51320 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755724AbcBCXJb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 18:09:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 258B140EAD;
	Wed,  3 Feb 2016 18:09:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=+OGrmdtehc6mo71RdAOSDWreNsA=; b=x/KaBdkvsApyPTNubqai
	VM9CaSuzGUfGaBv+MQXjiy7tW4zBXm+tY2JmuFbqVrgYzUV2ka4p/TUifMm2bs8H
	E0IWLaCnAgglM0g/WI/Bn3+7bmjja8QgZWoImU7x4tMSWgVkXLYx4Xsfu0J0JuUR
	avk1KP4b2v5dDj5YNARGqnc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=UbYTTAZEHgC+NvWUNq4s50BBicBS3lX1MZ92KSWkJaNMP3
	xpilcbbCRW2GEJWWO57+vr0Q5lRgwUgGNbUn6qp2bCdV5IZcpOrYpTlbao+/bIAK
	bTkQssmUk3oj1wJnIZlf/xO4Hh8cojUCsBk+Defj0cCDQSxRyvzsRD6DnTGFw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1D08F40EAC;
	Wed,  3 Feb 2016 18:09:31 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8B9B340EAA;
	Wed,  3 Feb 2016 18:09:30 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2E22B2DE-CACB-11E5-B43B-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285381>

Stefan Beller <sbeller@google.com> writes:

> This allows to configure fetching and updating in parallel
> without having the command line option.
>
> This moved the responsibility to determine how many parallel processes
> to start from builtin/fetch to submodule.c as we need a way to communicate
> "The user did not specify the number of parallel processes in the command
> line options" in the builtin fetch. The submodule code takes care of
> the precedence (CLI > config > default)
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/config.txt    |  7 +++++++
>  builtin/fetch.c             |  2 +-
>  submodule-config.c          | 15 +++++++++++++++
>  submodule-config.h          |  2 ++
>  submodule.c                 |  5 +++++
>  t/t5526-fetch-submodules.sh | 14 ++++++++++++++
>  6 files changed, 44 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 2d06b11..eda3276 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2646,6 +2646,13 @@ submodule.<name>.ignore::
>  	"--ignore-submodules" option. The 'git submodule' commands are not
>  	affected by this setting.
>  
> +submodule.fetchJobs::
> +	This is used to determine how many submodules will be
> +	fetched/cloned at the same time. Specifying a positive integer
> +	allows up to that number of submodules being fetched in parallel.

s/being //?  Either would be fine, but shorter might be better?  I
dunno.

s/is used to determine/specifies/?  That may shorten the whole
thing.

	Specifies how many submodules are fetched/cloned at the same
	time.  A positive integer allows up to that number of ...

> +	This is used in fetch and clone operations only. A value of 0 will
> +	give some reasonable configuration. It defaults to 1.

s/used/respected/, perhaps?
s/reasonable configuration/reasonable default/, perhaps?

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
>  static const char *depth;
>  static const char *upload_pack;
>  static struct strbuf default_rla = STRBUF_INIT;
> diff --git a/submodule-config.c b/submodule-config.c
> index 29e21b2..a32259e 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -32,6 +32,7 @@ enum lookup_type {
>  
>  static struct submodule_cache cache;
>  static int is_cache_init;
> +static int parallel_jobs = -1;
>  
>  static int config_path_cmp(const struct submodule_entry *a,
>  			   const struct submodule_entry *b,
> @@ -239,6 +240,15 @@ static int parse_generic_submodule_config(const char *key,
>  					  const char *value,
>  					  struct parse_config_parameter *me)
>  {
> +	if (!strcmp(key, "fetchjobs")) {
> +		parallel_jobs = strtol(value, NULL, 10);

We do not notice trailing 'x' in "[submodule] fetchjobs = 10x";
intended?  I am wondering this is a good excuse to invent
git_parse_long() and git_config_long() that do not exist yet.
In general, I'd personally prefer to reduce the number of calls to
strto[u]l that does not check trailing garbage, not increase it.

If we reject negatives anyway, we might be able to just use
git_parse_ulong() without adding new "signed" variants.
