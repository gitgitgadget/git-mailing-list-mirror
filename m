From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 08/10] commit: add for_each_mergetag()
Date: Mon, 07 Jul 2014 15:30:54 -0700
Message-ID: <xmqqegxwby3l.fsf@gitster.dls.corp.google.com>
References: <20140707063342.3708.83493.chriscool@tuxfamily.org>
	<20140707063540.3708.39506.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Jul 08 00:31:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4HRF-0005CF-3Z
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 00:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbaGGWbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 18:31:04 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59146 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751566AbaGGWbC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2014 18:31:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E3A0F27329;
	Mon,  7 Jul 2014 18:30:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yDmGiziC5lb32iEMIfEYq9HFje0=; b=X0xuhI
	EDPMHytXF2kzn8gaw8E1dHtfzOocXbKvozkXSHXM6ynzCQ4igC570bZjC96vtLf8
	epM6bQyBnQYYI/Ute72//DsCJEVTp1SSfipeC6jFpyf0rnLZwUbD1VkxlUnhRCZK
	Yv1s5kn+UK7Waj281XapZdkgbP/0vnpEmIzbk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EOCGq6apF93hoxUzToR5ayM1+sSWe7cM
	4WLk9YDAcNqcQpD190ZgVOSULnUUOPaG2ETf464IBoIg83eZ3fXvPyaFJo44UQZj
	Nx01vqlEAhEKVA2n386YOTg6hVOsnCymDhjop13KPXP2Xtd5JPmG8q/fDcR06cdA
	XXyIMQv9Wj4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D9CC427328;
	Mon,  7 Jul 2014 18:30:48 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EF39827321;
	Mon,  7 Jul 2014 18:30:42 -0400 (EDT)
In-Reply-To: <20140707063540.3708.39506.chriscool@tuxfamily.org> (Christian
	Couder's message of "Mon, 07 Jul 2014 08:35:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 54D8311C-0626-11E4-83B6-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252995>

Christian Couder <chriscool@tuxfamily.org> writes:

> In the same way as there is for_each_ref() to
> iterate on refs, it might be useful to have
> for_each_mergetag() to iterate on the mergetags
> of a given commit.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---

Heh, "might be useful" is an understatement ;-) We won't apply a
change that "might be useful" very lightly, but this refactoring
already uses the helper in existing code, showing that it *is*
useful, no?

Let's have this early in the series, or perhaps even independent of
the "replace" series.

Thanks.

>  commit.c   | 13 +++++++++++++
>  commit.h   |  5 +++++
>  log-tree.c | 15 ++++-----------
>  3 files changed, 22 insertions(+), 11 deletions(-)
>
> diff --git a/commit.c b/commit.c
> index 54e157d..0f83ff7 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1348,6 +1348,19 @@ struct commit_extra_header *read_commit_extra_headers(struct commit *commit,
>  	return extra;
>  }
>  
> +void for_each_mergetag(each_mergetag_fn fn, struct commit *commit, void *data)
> +{
> +	struct commit_extra_header *extra, *to_free;
> +
> +	to_free = read_commit_extra_headers(commit, NULL);
> +	for (extra = to_free; extra; extra = extra->next) {
> +		if (strcmp(extra->key, "mergetag"))
> +			continue; /* not a merge tag */
> +		fn(commit, extra, data);
> +	}
> +	free_commit_extra_headers(to_free);
> +}
> +
>  static inline int standard_header_field(const char *field, size_t len)
>  {
>  	return ((len == 4 && !memcmp(field, "tree ", 5)) ||
> diff --git a/commit.h b/commit.h
> index 4234dae..c81ba85 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -312,6 +312,11 @@ extern struct commit_extra_header *read_commit_extra_headers(struct commit *, co
>  
>  extern void free_commit_extra_headers(struct commit_extra_header *extra);
>  
> +typedef void (*each_mergetag_fn)(struct commit *commit, struct commit_extra_header *extra,
> +				 void *cb_data);
> +
> +extern void for_each_mergetag(each_mergetag_fn fn, struct commit *commit, void *data);
> +
>  struct merge_remote_desc {
>  	struct object *obj; /* the named object, could be a tag */
>  	const char *name;
> diff --git a/log-tree.c b/log-tree.c
> index 10e6844..706ed4c 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -413,10 +413,11 @@ static int is_common_merge(const struct commit *commit)
>  		&& !commit->parents->next->next);
>  }
>  
> -static void show_one_mergetag(struct rev_info *opt,
> +static void show_one_mergetag(struct commit *commit,
>  			      struct commit_extra_header *extra,
> -			      struct commit *commit)
> +			      void *data)
>  {
> +	struct rev_info *opt = (struct rev_info *)data;
>  	unsigned char sha1[20];
>  	struct tag *tag;
>  	struct strbuf verify_message;
> @@ -463,15 +464,7 @@ static void show_one_mergetag(struct rev_info *opt,
>  
>  static void show_mergetag(struct rev_info *opt, struct commit *commit)
>  {
> -	struct commit_extra_header *extra, *to_free;
> -
> -	to_free = read_commit_extra_headers(commit, NULL);
> -	for (extra = to_free; extra; extra = extra->next) {
> -		if (strcmp(extra->key, "mergetag"))
> -			continue; /* not a merge tag */
> -		show_one_mergetag(opt, extra, commit);
> -	}
> -	free_commit_extra_headers(to_free);
> +	for_each_mergetag(show_one_mergetag, commit, opt);
>  }
>  
>  void show_log(struct rev_info *opt)
