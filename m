Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9419834167B
	for <git@vger.kernel.org>; Wed,  6 May 2026 06:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778049952; cv=none; b=H+GgnXvsUgEbrZ/tsFMmAorHK93QbA2b0qzPPL1n0wrLofI88OKkVbFbnF2cUWo421FC5LknOoGxi0+dfS9+fg2+dlsPdrZXL0W26m2zs1ap8g02DqFZ6RngoLBPX7LwaHZntaeHlv9yZGKwdG+L6GeBPR2QW8eQMPIXptaaAQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778049952; c=relaxed/simple;
	bh=ynftvlWj2K9G8PRQ2GidgfqKwiizGMzDObjB8aafDR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IU+asDQFNOYo8nKnGiYKlv10dmN86Bw2EmT0o472moL3oQT/SFbyvxMFXFF/VaBXYx0OutjB8adWFpkSB+zTY0x0j3Dg8mwogugv3bMFYeU+9wc/S964Nb9nOPg7Q+bO9sNhkOM25sOre52zkQ3a2PsO7czO1lGFodjvkdV1vBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4g9Qr12nBqzRqqB;
	Wed,  6 May 2026 08:45:37 +0200 (CEST)
Message-ID: <7250e6c1-633e-417b-aacb-94e35d240d3f@kdbg.org>
Date: Wed, 6 May 2026 08:45:36 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] revision.c: implement --max-count-oldest
To: Mirko Faina <mroik@delayed.space>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
 =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>,
 Patrick Steinhardt <ps@pks.im>, Tian Yuchen <cat@malon.dev>,
 Ben Knoble <ben.knoble@gmail.com>, Chris Torek <chris.torek@gmail.com>,
 git@vger.kernel.org
References: <2f71a00b035e25b971641b77a6fa7626f1e2459c.1777578676.git.mroik@delayed.space>
 <ce8d1ff49ef418ae3720265a124ef53a959d289e.1778017966.git.mroik@delayed.space>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <ce8d1ff49ef418ae3720265a124ef53a959d289e.1778017966.git.mroik@delayed.space>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 05.05.26 um 23:54 schrieb Mirko Faina:
> --max-count is a commit limiting option sets a maximum amount of commits
> to be shown. If a user wants to see only the first N commits of the
> history (the oldest commits) they'd have to do something like
> 
>     git log $(git rev-list HEAD | tail -n N | head -n 1)
> 
> This is not very user-friendly.
> 
> Teach get_revision() the --max-count-oldest option.
> 
> Signed-off-by: Mirko Faina <mroik@delayed.space>
> ---
> Since v5 I've reworded the commit message and rewrote the docs for
> --max-count-oldest to be clearer on its functionality.
> 
>  Documentation/rev-list-options.adoc |  5 ++
>  revision.c                          | 77 +++++++++++++++++++++++++++--
>  revision.h                          |  2 +
>  t/t4202-log.sh                      | 14 ++++++
>  4 files changed, 95 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
> index 2d195a1474..9f857cabcc 100644
> --- a/Documentation/rev-list-options.adoc
> +++ b/Documentation/rev-list-options.adoc
> @@ -18,6 +18,11 @@ ordering and formatting options, such as `--reverse`.
>  `--max-count=<number>`::
>     Limit the output to _<number>_ commits.
>  
> +`--max-count-oldest=<number>`::
> +   Just like `--max-count=<number>`, it limits the output to _<number>_
> +   commits. But instead of limiting to the first _<number>_ commits it
> +   limits to the last _<number>_ commits.
> +

"Just like --max-count" is a surprising addendum in this sentence,
because the only thing they have in common is the limiting of commits,
which it repeats anyway. It's more like "Unlike --max-count, limits the
output to _<number>_ last commits."

BTW, this makes me think whether this kind of limiting could be
triggered by a negative argument to --max-count.

>  `--skip=<number>`::
>     Skip _<number>_ commits before starting to show the commit output.
>  
> diff --git a/revision.c b/revision.c
> index 599b3a66c3..3aaa77ced5 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2339,10 +2339,24 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>     }
>  
>     if ((argcount = parse_long_opt("max-count", argv, &optarg))) {
> +       if (revs->max_count_type == 1)
> +           die(_("can't use --max-count with --max-count-oldest"));

To help translators, the usual pattern is to say (here and later)

	die(_("options '%s' and '%s' cannot be used together"),
		"--max-count", "--max-count-oldest");

>         revs->max_count = parse_count(optarg);
>         revs->no_walk = 0;
> +       revs->max_count_type = 0;
>         return argcount;
> +   } else if ((argcount = parse_long_opt("max-count-oldest", argv, &optarg))) {
> +       if (revs->max_count_type == 0 && revs->max_count != -1)
> +           die(_("can't use --max-count with --max-count-oldest"));
> +       if (revs->skip_count > 0)
> +           die(_("con't use --max-count-oldest with --skip"));
> +       revs->max_count = parse_count(optarg);
> +       revs->no_walk = 0;
> +       revs->max_count_type = 1;
> +       revs->max_count_stage = 0;
>     } else if ((argcount = parse_long_opt("skip", argv, &optarg))) {
> +       if (revs->max_count_type == 1)
> +           die(_("con't use --max-count-oldest with --skip"));
>         revs->skip_count = parse_count(optarg);
>         return argcount;
>     } else if ((*arg == '-') && isdigit(arg[1])) {
> @@ -4521,15 +4535,68 @@ static struct commit *get_revision_internal(struct rev_info *revs)
>     return c;
>  }
>  
> +static void retrieve_oldest_commits(struct rev_info *revs,
> +                   struct commit_list **queue)
> +{
> +   struct commit *c;
> +   int max_count = revs->max_count;
> +   int queuei_count = 0;
> +   int queueo_count = 0;
> +   struct commit_list *queueo = NULL;
> +   struct commit_list *queuei = NULL;
> +   struct commit_list *reversed_queue = NULL;
> +
> +   revs->max_count = -1;
> +   while ((c = get_revision_internal(revs))) {
> +       c->object.flags &= ~SHOWN;
> +       commit_list_insert(c, &queuei);
> +       queuei_count++;
> +       while (queuei_count + queueo_count > max_count) {
> +           if (!queueo_count) {
> +               while (queuei_count > 0) {
> +                   c = pop_commit(&queuei);
> +                   queuei_count--;
> +                   commit_list_insert(c, &queueo);
> +                   queueo_count++;
> +               }
> +           }
> +           pop_commit(&queueo);
> +           queueo_count--;
> +       }
> +   }
> +
> +   while ((c = pop_commit(&queueo)))
> +       commit_list_insert(c, &reversed_queue);
> +   while ((c = pop_commit(&queuei)))
> +       commit_list_insert(c, &queueo);
> +   while ((c = pop_commit(&queueo)))
> +       commit_list_insert(c, &reversed_queue);
> +
> +   while ((c = pop_commit(&reversed_queue)))
> +       commit_list_insert(c, queue);
> +}
> +
>  struct commit *get_revision(struct rev_info *revs)
>  {
>     struct commit *c;
>     struct commit_list *reversed;
> +   struct commit_list *queue = NULL;
> +
> +   if (revs->max_count_type == 1 && !revs->max_count_stage) {
> +       retrieve_oldest_commits(revs, &queue);
> +       commit_list_free(revs->commits);
> +       revs->commits = queue;
> +       revs->max_count_stage = 1;
> +   }
>  
>     if (revs->reverse) {
>         reversed = NULL;
> -       while ((c = get_revision_internal(revs)))
> -           commit_list_insert(c, &reversed);
> +       if (revs->max_count_type == 1)
> +           while ((c = pop_commit(&revs->commits)))
> +               commit_list_insert(c, &reversed);
> +       else
> +           while ((c = get_revision_internal(revs)))
> +               commit_list_insert(c, &reversed);
>         commit_list_free(revs->commits);
>         revs->commits = reversed;
>         revs->reverse = 0;

I would have expected that this kind of commit counting is handled at
the same spot where --max-count is handled, i.e., in
get_revision_internal(). It could make a difference in combination with
sorting options, --boundary, and --graph. The goal is that --max-count
and --max-count-oldest behave the same in this regard. (But I am in no
way an expert of the revision walker.)

> @@ -4543,7 +4610,11 @@ struct commit *get_revision(struct rev_info *revs)
>         return c;
>     }
>  
> -   c = get_revision_internal(revs);
> +   if (revs->max_count_stage)
> +       c = pop_commit(&revs->commits);
> +   else
> +       c = get_revision_internal(revs);
> +
>     if (c && revs->graph)
>         graph_update(revs->graph, c);
>     if (!c) {
> diff --git a/revision.h b/revision.h
> index 584f1338b5..e157463cb1 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -309,6 +309,8 @@ struct rev_info {
>     /* special limits */
>     int skip_count;
>     int max_count;
> +   unsigned int max_count_type:1;
> +   unsigned int max_count_stage:1;
>     timestamp_t max_age;
>     timestamp_t max_age_as_filter;
>     timestamp_t min_age;
-- Hannes

