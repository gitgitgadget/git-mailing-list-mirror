From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH 05/11] branch: fix width computation
Date: Tue, 28 Jul 2015 11:47:15 +0200
Message-ID: <vpq6154zk9o.fsf@anie.imag.fr>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
	<1438066594-5620-1-git-send-email-Karthik.188@gmail.com>
	<1438066594-5620-5-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 11:47:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK1UA-00065r-4k
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 11:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755572AbbG1Jrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 05:47:41 -0400
Received: from mx1.imag.fr ([129.88.30.5]:55977 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754237AbbG1JrY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 05:47:24 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t6S9lFN6018831
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 28 Jul 2015 11:47:15 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6S9lFUV028099;
	Tue, 28 Jul 2015 11:47:15 +0200
In-Reply-To: <1438066594-5620-5-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Tue, 28 Jul 2015 12:26:30 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 28 Jul 2015 11:47:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6S9lFN6018831
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438681638.45212@Wi9t/UvLRInsoVnOlG6Ilw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274762>

Karthik Nayak <karthik.188@gmail.com> writes:

> From: Karthik Nayak <karthik.188@gmail.com>

Why did send-email add this From: header? Strange, it has the same
content as your actual From: field.

> Remove unnecessary variables from ref_list and ref_item
> which were used for width computation. Make other changes
> accordingly. This patch is a precursor for porting branch.c
> to use ref-filter APIs.

You can explain better why this is needed. I guess something like "we're
making struct ref_item similar to ref-filter's ref_array_item", but the
reader shouldn't have to guess.

You should adujst the subject like BTW, I don't think you are "fixing"
anything.

On a side note: on the "tag" series, see how explaining better and
splitting patches led not only to a better history, but also to better
final code, and to finding a actual bugs (the %(color) thing and the
absence of reset on the state variable) even after sereval rounds of
review? I'm being picky and demanding, but don't see that as a complain
from me, just hints on getting even better ;-).

> @@ -386,15 +386,8 @@ static int append_ref(const char *refname, const struct object_id *oid, int flag
>  	newitem->name = xstrdup(refname);
>  	newitem->kind = kind;
>  	newitem->commit = commit;
> -	newitem->width = utf8_strwidth(refname);
>  	newitem->dest = resolve_symref(orig_refname, prefix);
>  	newitem->ignore = 0;
> -	/* adjust for "remotes/" */
> -	if (newitem->kind == REF_REMOTE_BRANCH &&
> -	    ref_list->kinds != REF_REMOTE_BRANCH)
> -		newitem->width += 8;
> -	if (newitem->width > ref_list->maxwidth)
> -		ref_list->maxwidth = newitem->width;
>  
>  	return 0;
>  }

OK, in the old code, the width computation is done when inserting the
ref into the array. In the new code, you build the array and then do the
width computation. You can explain this better in the commit message I
think (instead of "Make other changes accordingly" which doesn't bring
much).

> @@ -505,11 +498,12 @@ static void add_verbose_info(struct strbuf *out, struct ref_item *item,
>  }
>  
>  static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
> -			   int abbrev, int current, char *prefix)
> +			   int abbrev, int current, const char *remote_prefix)
>  {
>  	char c;
>  	int color;
>  	struct strbuf out = STRBUF_INIT, name = STRBUF_INIT;
> +	const char *prefix = "";
>  
>  	if (item->ignore)
>  		return;
> @@ -520,6 +514,7 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
>  		break;
>  	case REF_REMOTE_BRANCH:
>  		color = BRANCH_COLOR_REMOTE;
> +		prefix = remote_prefix;
>  		break;

Why do you need these two hunks? I did not investigate in details, but
it seems you're calling print_ref_item either with prefix="" or with
prefix=remote_prefix so it would seem that keeping "prefix" as argument
would work. I guess I missed something.

> -static int calc_maxwidth(struct ref_list *refs)
> +static int calc_maxwidth(struct ref_list *refs, int remote_bonus)
>  {
> -	int i, w = 0;
> +	int i, max = 0;
>  	for (i = 0; i < refs->index; i++) {
> +		struct ref_item *it = &refs->list[i];
> +		int w = utf8_strwidth(it->name);
> +
>  		if (refs->list[i].ignore)
>  			continue;
> -		if (refs->list[i].width > w)
> -			w = refs->list[i].width;
> +		if (it->kind == REF_REMOTE_BRANCH)
> +			w += remote_bonus;
> +		if (w > max)
> +			max = w;
>  	}
> -	return w;
> +	return max;
>  }

The old code was using 'w' for the max and no variable for the value at
the current iteration. You're using 'max' for the max and 'w' at the
current iteration. Using the same name 'w' for different things in the
pre- and post-image of the patch distracts the reader.

It may make sense to s/w/max/ in a separate preparatory patch. Or maybe
it's overkill.

> @@ -600,21 +600,18 @@ static char *get_head_description(void)
>  	return strbuf_detach(&desc, NULL);
>  }
>  
> -static void show_detached(struct ref_list *ref_list)
> +static void show_detached(struct ref_list *ref_list, int maxwidth)
>  {
>  	struct commit *head_commit = lookup_commit_reference_gently(head_sha1, 1);
>  
>  	if (head_commit && is_descendant_of(head_commit, ref_list->with_commit)) {
>  		struct ref_item item;
>  		item.name = get_head_description();
> -		item.width = utf8_strwidth(item.name);
>  		item.kind = REF_LOCAL_BRANCH;
>  		item.dest = NULL;
>  		item.commit = head_commit;
>  		item.ignore = 0;
> -		if (item.width > ref_list->maxwidth)
> -			ref_list->maxwidth = item.width;
> -		print_ref_item(&item, ref_list->maxwidth, ref_list->verbose, ref_list->abbrev, 1, "");
> +		print_ref_item(&item, maxwidth, ref_list->verbose, ref_list->abbrev, 1, "");
>  		free(item.name);
>  	}
>  }
...
> +	int maxwidth = 0;
...
> +	if (verbose)
> +		maxwidth = calc_maxwidth(&ref_list, strlen(remote_prefix));
>  
>  	qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp);
>  
>  	detached = (detached && (kinds & REF_LOCAL_BRANCH));
>  	if (detached && match_patterns(pattern, "HEAD"))
> -		show_detached(&ref_list);
> +		show_detached(&ref_list, maxwidth);

This hunks could ideally go in a preparatory patch that would just move
the place where maxwidth is computed. This preparatory patch would just
say

	maxwidth = ref_list->maxwidth;

and then you would do the actual change to

	if (verbose)
		maxwidth = calc_maxwidth(...)

without the distracting changes in the function's argument list.

I won't insist on that, again it may be overkill. But reading the patch,
I found it both rather trivial and hard to read, so there's room for
improvement.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
