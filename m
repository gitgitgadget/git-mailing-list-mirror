From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v13 05/12] ref-filter: add option to filter out tags, branches and remotes
Date: Mon, 24 Aug 2015 15:24:42 -0700
Message-ID: <xmqqbndw2ul1.fsf@gitster.dls.corp.google.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
	<1440214788-1309-6-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Aug 25 00:24:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZU0Ab-0007c4-7S
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 00:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754428AbbHXWYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 18:24:44 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35246 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753970AbbHXWYo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 18:24:44 -0400
Received: by pacdd16 with SMTP id dd16so106523456pac.2
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 15:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=lK+aYCU+w9vXr1759GSHImMfuFPA6n9GT9p0hdjf3Zs=;
        b=LeSsXOZBCLxbc+7MYfjEtebWOJo8s2GAH2xZCtKrn2iKXgeeZO6AKbrHQwRrLr+nJu
         jTlgaPtQTy8NjqJtq4OuWcrPY1JfI88a6n/XK+i0mX/6DfgcecxGbKDb5Gc70o1k0wuA
         NScg0HeJPSYSaqxEB3RG9fs6xqlopteKSFpIoymkt4A0bpw+DvdIrSH0efb2GbHoYO42
         Lbz9zsbVCJL8tPtUyevjtkHpSC2Dj6CsmNB9LopuXm1Jfvozgre1JSp1EUNIDK727Dfj
         DEcMnJJcwEvaiXOcfRbsVlyZP3WGrTcOIEraryU0VKcuZAEHAbrjvM5aULmHMJldvrZs
         Ikvw==
X-Received: by 10.67.22.99 with SMTP id hr3mr47089955pad.41.1440455083498;
        Mon, 24 Aug 2015 15:24:43 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:813d:881a:159:a8e7])
        by smtp.gmail.com with ESMTPSA id fm3sm18561925pdb.49.2015.08.24.15.24.42
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 24 Aug 2015 15:24:42 -0700 (PDT)
In-Reply-To: <1440214788-1309-6-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Sat, 22 Aug 2015 09:09:41 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276493>

Karthik Nayak <karthik.188@gmail.com> writes:

> From: Karthik Nayak <karthik.188@gmail.com>
>
> Add a function called 'for_each_reftype_fullpath()' to refs.{c,h}
> which iterates through each ref for the given path without trimming
> the path and also accounting for broken refs, if mentioned.

For this part, I think you would want to borrow an extra pair of
eyes from Michael.

>
> Add 'filter_ref_kind()' in ref-filter.c to check the kind of ref being
> handled and return the kind to 'ref_filter_handler()', where we
> discard refs which we do not need and assign the kind to needed refs.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  ref-filter.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
>  ref-filter.h | 12 ++++++++++--
>  refs.c       |  9 +++++++++
>  refs.h       |  1 +
>  4 files changed, 74 insertions(+), 7 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index ffec10a..d5fae1a 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1123,6 +1123,36 @@ static struct ref_array_item *new_ref_array_item(const char *refname,
>  	return ref;
>  }
>  
> +static int filter_ref_kind(struct ref_filter *filter, const char *refname)
> +{
> +	unsigned int i;
> +
> +	static struct {
> +		const char *prefix;
> +		unsigned int kind;
> +	} ref_kind[] = {
> +		{ "refs/heads/" , FILTER_REFS_BRANCHES },
> +		{ "refs/remotes/" , FILTER_REFS_REMOTES },
> +		{ "refs/tags/", FILTER_REFS_TAGS}
> +	};
> +
> +	if (filter->kind == FILTER_REFS_BRANCHES)
> +		return FILTER_REFS_BRANCHES;
> +	else if (filter->kind == FILTER_REFS_REMOTES)
> +		return FILTER_REFS_REMOTES;
> +	else if (filter->kind == FILTER_REFS_TAGS)
> +		return FILTER_REFS_TAGS;
> +	else if (!strcmp(refname, "HEAD"))
> +		return FILTER_REFS_DETACHED_HEAD;
> +
> +	for (i = 0; i < ARRAY_SIZE(ref_kind); i++) {
> +		if (starts_with(refname, ref_kind[i].prefix))
> +			return ref_kind[i].kind;
> +	}
> +
> +	return FILTER_REFS_OTHERS;
> +}
> +
>  /*
>   * A call-back given to for_each_ref().  Filter refs and keep them for
>   * later object processing.
> @@ -1133,6 +1163,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
>  	struct ref_filter *filter = ref_cbdata->filter;
>  	struct ref_array_item *ref;
>  	struct commit *commit = NULL;
> +	unsigned int kind;
>  
>  	if (flag & REF_BAD_NAME) {
>  		warning("ignoring ref with broken name %s", refname);
> @@ -1144,6 +1175,10 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
>  		return 0;
>  	}
>  
> +	kind = filter_ref_kind(filter, refname);
> +	if (!(kind & filter->kind))
> +		return 0;
> +

When filter->kind is set to some single-bit thing (e.g.
FILTER_REFS_BRANCHES) by the caller of ref_filter_handler(), then
this call of filter_ref_kind() will just parrot that without even
looking at refname.  And then the if statement says "yes, they have
common bit(s)".  Even when refname is "refs/tags/v1.0" or "HEAD".

And if this code knows that "refs/tags/v1.0" or "HEAD" will never
come when filter->kind is exactly FILTER_REFS_BRANCHES, then I do
not see the point of calling filter_ref_kind().

I am not sure what this is trying to do.  Can you clarify the
thinking behind this as a comment to filter_ref_kind()?

> @@ -1175,6 +1210,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
>  
>  	REALLOC_ARRAY(ref_cbdata->array->items, ref_cbdata->array->nr + 1);
>  	ref_cbdata->array->items[ref_cbdata->array->nr++] = ref;
> +	ref->kind = kind;
>  	return 0;
>  }
>  
> @@ -1251,16 +1287,29 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
>  {
>  	struct ref_filter_cbdata ref_cbdata;
>  	int ret = 0;
> +	unsigned int broken = 0;
>  
>  	ref_cbdata.array = array;
>  	ref_cbdata.filter = filter;
>  
>  	/*  Simple per-ref filtering */
> -	if (type & (FILTER_REFS_ALL | FILTER_REFS_INCLUDE_BROKEN))
> -		ret = for_each_rawref(ref_filter_handler, &ref_cbdata);
> -	else if (type & FILTER_REFS_ALL)
> -		ret = for_each_ref(ref_filter_handler, &ref_cbdata);
> -	else if (type)
> +	if (type & FILTER_REFS_INCLUDE_BROKEN) {
> +		type &= ~FILTER_REFS_INCLUDE_BROKEN;
> +		broken = 1;
> +	}
> +
> +	filter->kind = type;
> +	if (type == FILTER_REFS_BRANCHES)
> +		ret = for_each_reftype_fullpath(ref_filter_handler, "refs/heads/", broken, &ref_cbdata);
> +	else if (type == FILTER_REFS_REMOTES)
> +		ret = for_each_reftype_fullpath(ref_filter_handler, "refs/remotes/", broken, &ref_cbdata);
> +	else if (type == FILTER_REFS_TAGS)
> +		ret = for_each_reftype_fullpath(ref_filter_handler, "refs/tags/", broken, &ref_cbdata);
> +	else if (type & FILTER_REFS_ALL) {
> +		ret = for_each_reftype_fullpath(ref_filter_handler, "", broken, &ref_cbdata);
> +		if (type & FILTER_REFS_DETACHED_HEAD)
> +			head_ref(ref_filter_handler, &ref_cbdata);
> +	} else
>  		die("filter_refs: invalid type");
>  
>  	/*  Filters that need revision walking */
> diff --git a/ref-filter.h b/ref-filter.h
> index 45026d0..99f081b 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -13,8 +13,14 @@
>  #define QUOTE_PYTHON 4
>  #define QUOTE_TCL 8
>  
> -#define FILTER_REFS_INCLUDE_BROKEN 0x1
> -#define FILTER_REFS_ALL 0x2
> +#define FILTER_REFS_INCLUDE_BROKEN 0x0001
> +#define FILTER_REFS_TAGS           0x0002
> +#define FILTER_REFS_BRANCHES       0x0004
> +#define FILTER_REFS_REMOTES        0x0008
> +#define FILTER_REFS_OTHERS         0x0010
> +#define FILTER_REFS_ALL            (FILTER_REFS_TAGS | FILTER_REFS_BRANCHES | \
> +				    FILTER_REFS_REMOTES | FILTER_REFS_OTHERS)
> +#define FILTER_REFS_DETACHED_HEAD  0x0020
>  
>  struct atom_value;
>  
> @@ -27,6 +33,7 @@ struct ref_sorting {
>  struct ref_array_item {
>  	unsigned char objectname[20];
>  	int flag;
> +	unsigned int kind;
>  	const char *symref;
>  	struct commit *commit;
>  	struct atom_value *value;
> @@ -51,6 +58,7 @@ struct ref_filter {
>  	struct commit *merge_commit;
>  
>  	unsigned int with_commit_tag_algo : 1;
> +	unsigned int kind;
>  };
>  
>  struct ref_filter_cbdata {
> diff --git a/refs.c b/refs.c
> index 4e15f60..3266617 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2150,6 +2150,15 @@ int for_each_replace_ref(each_ref_fn fn, void *cb_data)
>  			       strlen(git_replace_ref_base), 0, cb_data);
>  }
>  
> +int for_each_reftype_fullpath(each_ref_fn fn, char *type, unsigned int broken, void *cb_data)
> +{
> +	unsigned int flag = 0;
> +
> +	if (broken)
> +		flag = DO_FOR_EACH_INCLUDE_BROKEN;
> +	return do_for_each_ref(&ref_cache, type, fn, 0, flag, cb_data);
> +}
> +
>  int head_ref_namespaced(each_ref_fn fn, void *cb_data)
>  {
>  	struct strbuf buf = STRBUF_INIT;
> diff --git a/refs.h b/refs.h
> index e9a5f32..6e913ee 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -179,6 +179,7 @@ extern int for_each_remote_ref(each_ref_fn fn, void *cb_data);
>  extern int for_each_replace_ref(each_ref_fn fn, void *cb_data);
>  extern int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data);
>  extern int for_each_glob_ref_in(each_ref_fn fn, const char *pattern, const char *prefix, void *cb_data);
> +extern int for_each_reftype_fullpath(each_ref_fn fn, char *type, unsigned int broken, void *cb_data);
>  
>  extern int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
>  extern int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
