From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] extent setup_revisions() so it works with
 submodules
Date: Tue, 06 Jul 2010 22:28:20 -0700
Message-ID: <7veiff274b.fsf@alter.siamese.dyndns.org>
References: <cover.1278444110.git.hvoigt@hvoigt.net>
 <cover.1278444110.git.hvoigt@hvoigt.net>
 <ab9c0f88b30060401d99735cb78eec7cc1e95b86.1278444110.git.hvoigt@hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jens.lehmann@web.de, jherland@gmail.com
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Jul 07 07:28:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWNBX-0008QV-Mf
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 07:28:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016Ab0GGF2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 01:28:33 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41185 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877Ab0GGF2c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 01:28:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 49E8CC2422;
	Wed,  7 Jul 2010 01:28:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=omlIaVyALGn6MeK7w/BNzZ9q9SM=; b=mXpB/gxiQdo+kuA+SY4MgSm
	ci7kMorMrf6zi8zb40WW7GLZG8+X6viSEXEjJ0FZm86OFfaEwSj6sww6wjjy07Jl
	e8OyKSi1nS4glW9hG4IEK3E1YhkPBvo7GA6IGewQ/SoXhxQziWrjUaKQsMmaVaOO
	7H6L3x1Re9EI7XiMN/ws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=QpfiQt6wt3S1wCgsRUesZmREangzp6i3gA/jiau+pNRH/37v+
	00SHlvCDRrhpSUzSRmWBLiOd8HBS59McEJ1qADqDM8DHbplpD+177C7Fl7MSj9Gk
	lBWoXIAA++Qq1nvuCvB/nEOphiY4JIt5GGalCYv6l8YuYR3l5cT14AA+u4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A388BC2420;
	Wed,  7 Jul 2010 01:28:27 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 39F99C241B; Wed,  7 Jul
 2010 01:28:22 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 789A45E6-8988-11DF-A953-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150447>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>

This needs a bit more explanation.  "Exten_d_ setup_revisions()" is fine,
but "works with submodules"???  How? and what do the caller need to do?

Something like...

    Subject: setup_revisions(): allow walking history in a submodule

    By passing the path to a submodule in opt->submodule, the function can
    be used to walk history in the named submodule repository, instead of
    the toplevel repository.



> ---
>  refs.c     |   31 +++++++++++++++++++++++++++++++
>  refs.h     |    8 ++++++++
>  revision.c |   32 ++++++++++++++++++--------------
>  revision.h |    1 +
>  4 files changed, 58 insertions(+), 14 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index c8649b1..37e2794 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -721,31 +721,62 @@ int head_ref(each_ref_fn fn, void *cb_data)
>  	return do_head_ref(NULL, fn, cb_data);
>  }
>  
> +int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
> +{
> +	return do_head_ref(submodule, fn, cb_data);
> +}
> +
>  int for_each_ref(each_ref_fn fn, void *cb_data)
>  {
>  	return do_for_each_ref(NULL, "refs/", fn, 0, 0, cb_data);
>  }
>  
> +int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
> +{
> +	return do_for_each_ref(submodule, "refs/", fn, 0, 0, cb_data);
> +}
> +
>  int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
>  {
>  	return do_for_each_ref(NULL, prefix, fn, strlen(prefix), 0, cb_data);
>  }
>  
> +int for_each_ref_in_submodule(const char *submodule, const char *prefix,
> +		each_ref_fn fn, void *cb_data)
> +{
> +	return do_for_each_ref(submodule, prefix, fn, strlen(prefix), 0, cb_data);
> +}
> +
>  int for_each_tag_ref(each_ref_fn fn, void *cb_data)
>  {
>  	return for_each_ref_in("refs/tags/", fn, cb_data);
>  }
>  
> +int for_each_tag_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
> +{
> +	return for_each_ref_in_submodule(submodule, "refs/tags/", fn, cb_data);
> +}
> +
>  int for_each_branch_ref(each_ref_fn fn, void *cb_data)
>  {
>  	return for_each_ref_in("refs/heads/", fn, cb_data);
>  }
>  
> +int for_each_branch_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
> +{
> +	return for_each_ref_in_submodule(submodule, "refs/heads/", fn, cb_data);
> +}
> +
>  int for_each_remote_ref(each_ref_fn fn, void *cb_data)
>  {
>  	return for_each_ref_in("refs/remotes/", fn, cb_data);
>  }
>  
> +int for_each_remote_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
> +{
> +	return for_each_ref_in_submodule(submodule, "refs/remotes/", fn, cb_data);
> +}
> +
>  int for_each_replace_ref(each_ref_fn fn, void *cb_data)
>  {
>  	return do_for_each_ref(NULL, "refs/replace/", fn, 13, 0, cb_data);
> diff --git a/refs.h b/refs.h
> index 762ce50..5e7a9a5 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -28,6 +28,14 @@ extern int for_each_replace_ref(each_ref_fn, void *);
>  extern int for_each_glob_ref(each_ref_fn, const char *pattern, void *);
>  extern int for_each_glob_ref_in(each_ref_fn, const char *pattern, const char* prefix, void *);
>  
> +extern int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
> +extern int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
> +extern int for_each_ref_in_submodule(const char *submodule, const char *prefix,
> +		each_ref_fn fn, void *cb_data);
> +extern int for_each_tag_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
> +extern int for_each_branch_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
> +extern int for_each_remote_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
> +
>  static inline const char *has_glob_specials(const char *pattern)
>  {
>  	return strpbrk(pattern, "?*[");
> diff --git a/revision.c b/revision.c
> index 7e82efd..5f2cf1e 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -820,12 +820,12 @@ static void init_all_refs_cb(struct all_refs_cb *cb, struct rev_info *revs,
>  	cb->all_flags = flags;
>  }
>  
> -static void handle_refs(struct rev_info *revs, unsigned flags,
> -		int (*for_each)(each_ref_fn, void *))
> +static void handle_refs(const char *submodule, struct rev_info *revs, unsigned flags,
> +		int (*for_each)(const char *, each_ref_fn, void *))
>  {
>  	struct all_refs_cb cb;
>  	init_all_refs_cb(&cb, revs, flags);
> -	for_each(handle_one_ref, &cb);
> +	for_each(submodule, handle_one_ref, &cb);
>  }
>  
>  static void handle_one_reflog_commit(unsigned char *sha1, void *cb_data)
> @@ -1417,14 +1417,14 @@ void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
>  	ctx->argc -= n;
>  }
>  
> -static int for_each_bad_bisect_ref(each_ref_fn fn, void *cb_data)
> +static int for_each_bad_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data)
>  {
> -	return for_each_ref_in("refs/bisect/bad", fn, cb_data);
> +	return for_each_ref_in_submodule(submodule, "refs/bisect/bad", fn, cb_data);
>  }
>  
> -static int for_each_good_bisect_ref(each_ref_fn fn, void *cb_data)
> +static int for_each_good_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data)
>  {
> -	return for_each_ref_in("refs/bisect/good", fn, cb_data);
> +	return for_each_ref_in_submodule(submodule, "refs/bisect/good", fn, cb_data);
>  }
>  
>  static void append_prune_data(const char ***prune_data, const char **av)
> @@ -1466,6 +1466,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>  {
>  	int i, flags, left, seen_dashdash, read_from_stdin, got_rev_arg = 0;
>  	const char **prune_data = NULL;
> +	const char *submodule = NULL;
> +
> +	if (opt)
> +		submodule = opt->submodule;
>  
>  	/* First, search for "--" */
>  	seen_dashdash = 0;
> @@ -1490,26 +1494,26 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>  			int opts;
>  
>  			if (!strcmp(arg, "--all")) {
> -				handle_refs(revs, flags, for_each_ref);
> -				handle_refs(revs, flags, head_ref);
> +				handle_refs(submodule, revs, flags, for_each_ref_submodule);
> +				handle_refs(submodule, revs, flags, head_ref_submodule);
>  				continue;
>  			}
>  			if (!strcmp(arg, "--branches")) {
> -				handle_refs(revs, flags, for_each_branch_ref);
> +				handle_refs(submodule, revs, flags, for_each_branch_ref_submodule);
>  				continue;
>  			}
>  			if (!strcmp(arg, "--bisect")) {
> -				handle_refs(revs, flags, for_each_bad_bisect_ref);
> -				handle_refs(revs, flags ^ UNINTERESTING, for_each_good_bisect_ref);
> +				handle_refs(submodule, revs, flags, for_each_bad_bisect_ref);
> +				handle_refs(submodule, revs, flags ^ UNINTERESTING, for_each_good_bisect_ref);
>  				revs->bisect = 1;
>  				continue;
>  			}
>  			if (!strcmp(arg, "--tags")) {
> -				handle_refs(revs, flags, for_each_tag_ref);
> +				handle_refs(submodule, revs, flags, for_each_tag_ref_submodule);
>  				continue;
>  			}
>  			if (!strcmp(arg, "--remotes")) {
> -				handle_refs(revs, flags, for_each_remote_ref);
> +				handle_refs(submodule, revs, flags, for_each_remote_ref_submodule);
>  				continue;
>  			}
>  			if (!prefixcmp(arg, "--glob=")) {
> diff --git a/revision.h b/revision.h
> index 36fdf22..05659c6 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -151,6 +151,7 @@ extern volatile show_early_output_fn_t show_early_output;
>  struct setup_revision_opt {
>  	const char *def;
>  	void (*tweak)(struct rev_info *, struct setup_revision_opt *);
> +	const char *submodule;
>  };
>  
>  extern void init_revisions(struct rev_info *revs, const char *prefix);
> -- 
> 1.7.2.rc1.217.g7dc0db.dirty
