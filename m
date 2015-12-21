From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] do_compare_entry: use already-computed path
Date: Mon, 21 Dec 2015 09:17:23 -0800
Message-ID: <xmqqmvt3hgbg.fsf@gitster.mtv.corp.google.com>
References: <1450489227-4771-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Dec 21 18:17:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aB45X-0003tE-Ke
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 18:17:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbbLURR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2015 12:17:29 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63371 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751208AbbLURR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2015 12:17:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 22FCA32436;
	Mon, 21 Dec 2015 12:17:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Hp/+ehA7TdXyIHMORTgB4mLjSd4=; b=cQMqDa
	kCyKKIITqjjE8js8hYrV0YIZYUlbtjtsgRfywdqvf+0jNTQYCZpUx9c7SaLQn+iL
	lBO2FJt0jK/9WxrP/g9jj79e14cF7d6hjEDPdCF6Q6q5IHUak/TyJaXsvrhyojaV
	NS68OrMsL6y8bZuWtaUPqAezfjmGDh2GsP3nA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=odyTg7CboK8JMJ1luVyf3Wf1issjDHkj
	cJ3asaPJ/mPRG7Bvz5DRVoBexo+w6HMvNZi8p2PpdJiNudCyBzgf4xMDP826oV78
	SizurgUQvKxioGYonPYHhPjoG4uORMy6Na+eB3lkFN7C8DVyPZVj1n8YGnlXueux
	qXh3CMat8pw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1A26B32435;
	Mon, 21 Dec 2015 12:17:26 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 857E132433;
	Mon, 21 Dec 2015 12:17:25 -0500 (EST)
In-Reply-To: <1450489227-4771-1-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Fri, 18 Dec 2015 20:40:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B4763410-A806-11E5-BD3C-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282799>

David Turner <dturner@twopensource.com> writes:

> In traverse_trees, we generate the complete traverse path for a
> traverse_info.  Later, in do_compare_entry, we used to go do a bunch
> of work to compare the traverse_info to a cache_entry's name without
> computing that path.  But since we already have that path, we don't
> need to do all that work.  Instead, we can just stuff the generated
> path into the traverse_info, and do the comparison more directly.
> This makes git checkout much faster -- about 25% on Twitter's
> monorepo.  Deeper directory trees are likely to benefit more than
> shallower ones.

Great work.

IIRC, very early incarnation of the code avoided hard to build the
full path and that was why the path-component-wise comparison was
used heavily in this codepath; at some point we just gave up, I
think.  If we can pass this flattened representation around to
callees that can make good use of it, that makes tons of sense.  I
like the basic idea of this change.

I am bit worried that &base is passed to some function from here,
and they do not take "const struct strbuf *", but a non-const one,
allowing them to potentially modify its contents while this new
field in info struct wants to have the original base.buf, but I
trust you traced the callchain to make sure nothing wrong happens?
Even if that is the case, I feel that this change is setting up a
trap somebody else would easily trigger unknowingly--I wonder how
we can avoid future breakages.


> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  tree-walk.c    |  4 ++++
>  tree-walk.h    |  1 +
>  unpack-trees.c | 41 +++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 44 insertions(+), 2 deletions(-)
>
> diff --git a/tree-walk.c b/tree-walk.c
> index 6dccd2d..4cab3e1 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -329,6 +329,9 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
>  		make_traverse_path(base.buf, info->prev, &info->name);
>  		base.buf[info->pathlen-1] = '/';
>  		strbuf_setlen(&base, info->pathlen);
> +		info->traverse_path = base.buf;
> +	} else {
> +		info->traverse_path = info->name.path;
>  	}
>  	for (;;) {
>  		int trees_used;
> @@ -411,6 +414,7 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
>  	for (i = 0; i < n; i++)
>  		free_extended_entry(tx + i);
>  	free(tx);
> +	info->traverse_path = NULL;
>  	strbuf_release(&base);
>  	return error;
>  }
> diff --git a/tree-walk.h b/tree-walk.h
> index 3b2f7bf..174eb61 100644
> --- a/tree-walk.h
> +++ b/tree-walk.h
> @@ -59,6 +59,7 @@ enum follow_symlinks_result {
>  enum follow_symlinks_result get_tree_entry_follow_symlinks(unsigned char *tree_sha1, const char *name, unsigned char *result, struct strbuf *result_path, unsigned *mode);
>  
>  struct traverse_info {
> +	const char *traverse_path;
>  	struct traverse_info *prev;
>  	struct name_entry name;
>  	int pathlen;
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 8e2032f..127dd4d 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -498,13 +498,14 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
>   * itself - the caller needs to do the final check for the cache
>   * entry having more data at the end!
>   */
> -static int do_compare_entry(const struct cache_entry *ce, const struct traverse_info *info, const struct name_entry *n)
> +static int do_compare_entry_piecewise(const struct cache_entry *ce, const struct traverse_info *info, const struct name_entry *n)
>  {
>  	int len, pathlen, ce_len;
>  	const char *ce_name;
>  
>  	if (info->prev) {
> -		int cmp = do_compare_entry(ce, info->prev, &info->name);
> +		int cmp = do_compare_entry_piecewise(ce, info->prev,
> +						     &info->name);
>  		if (cmp)
>  			return cmp;
>  	}
> @@ -522,6 +523,42 @@ static int do_compare_entry(const struct cache_entry *ce, const struct traverse_
>  	return df_name_compare(ce_name, ce_len, S_IFREG, n->path, len, n->mode);
>  }
>  
> +static int do_compare_entry(const struct cache_entry *ce,
> +			    const struct traverse_info *info,
> +			    const struct name_entry *n)
> +{
> +	int len, pathlen, ce_len;
> +	const char *ce_name;
> +	int cmp;
> +
> +	/*
> +	 * If we have not precomputed the traverse path, it is quicker
> +	 * to avoid doing so.  But if we have precomputed it,
> +	 * it is quicker to use the precomputed version.
> +	 */
> +	if (!info->traverse_path)
> +		return do_compare_entry_piecewise(ce, info, n);
> +
> +	cmp = strncmp(ce->name, info->traverse_path, info->pathlen);
> +	if (cmp)
> +		return cmp;
> +
> +	pathlen = info->pathlen;
> +	ce_len = ce_namelen(ce);
> +
> +	if (ce_len < pathlen) {
> +		if (do_compare_entry_piecewise(ce, info, n) >= 0)
> +			die("pathlen");
> +		return -1;
> +	}
> +
> +	ce_len -= pathlen;
> +	ce_name = ce->name + pathlen;
> +
> +	len = tree_entry_len(n);
> +	return df_name_compare(ce_name, ce_len, S_IFREG, n->path, len, n->mode);
> +}
> +
>  static int compare_entry(const struct cache_entry *ce, const struct traverse_info *info, const struct name_entry *n)
>  {
>  	int cmp = do_compare_entry(ce, info, n);
