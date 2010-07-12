From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 10/13] map/print ranges along traversing the history
 topologically
Date: Mon, 12 Jul 2010 14:52:23 -0700
Message-ID: <7vmxtw8j1k.fsf@alter.siamese.dyndns.org>
References: <1278829141-11900-1-git-send-email-struggleyb.nku@gmail.com>
 <1278829141-11900-10-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 12 23:52:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYQvS-0000lR-5t
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 23:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754397Ab0GLVwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 17:52:32 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60990 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754361Ab0GLVwb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 17:52:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E6F3C3326;
	Mon, 12 Jul 2010 17:52:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=qMa8fYFybdNPAaKQSu3ElX2/mCw=; b=JJ1mjRXqveLfDkCGbd4Sme0
	vNfMFaoYqGZ1zhd1iRObsCzAFnZDCe74G8cHfQj1/qqGcE5GNjCzKTIrQ5ncMDe/
	7X/C8tzwG3qFO7MbCn3+5oYMWGE9NEwH0fNUbLe4UkE8nyYgPYuHqBJaSWIDnMQT
	D4AYJ3yALONFU/l1+7YI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=PRiKf50q44/nyock8HpMW7ygXWgeu86m96hJhjS6CUOI6vK9S
	3c4IqLuGp6CzPuftyuGrd96SNlD9D1JSP6VcWRB9mjM1ZFZPlHDnihQseWgj0d1y
	TQu14KewS8un4+7I0a1oiSPfBvTIb66FCGRBvUx7sdCcHtDA44OhqexFoM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 601ACC3325;
	Mon, 12 Jul 2010 17:52:28 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 64FF7C3323; Mon, 12 Jul
 2010 17:52:24 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C3B01774-8DFF-11DF-BB27-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150850>

Bo Yang <struggleyb.nku@gmail.com> writes:

> Since ranges may change in different branches, we should
> make sure we do not pass range to parent until all the
> ranges get 'combined' at the commit which is a split commit.
> So, topological traversing is necessary.

Without explaining what a "split commit" is, "So, ... is necessary"
doesn't really justify this.

>
> Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
> ---
>  builtin/log.c |    5 ++++-
>  line.c        |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  line.h        |    2 ++
>  3 files changed, 60 insertions(+), 1 deletions(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index 1e90b03..47b386d 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -615,7 +615,10 @@ int cmd_log(int argc, const char **argv, const char *prefix)
>  	memset(&opt, 0, sizeof(opt));
>  	opt.def = "HEAD";
>  	cmd_log_init(argc, argv, prefix, &rev, &opt);
> -	return cmd_log_walk(&rev);
> +	if (rev.line)
> +		return cmd_line_log_walk(&rev);
> +	else
> +		return cmd_log_walk(&rev);
>  }
>  
>  /* format-patch */
> diff --git a/line.c b/line.c
> index 8813376..5c8f77a 100644
> --- a/line.c
> +++ b/line.c
> @@ -1196,3 +1196,57 @@ static void line_log_flush(struct rev_info *rev, struct commit *c)
>  	}
>  }
>  
> +int cmd_line_log_walk(struct rev_info *rev)
> +{
> +	struct commit *commit;
> +	struct commit_list *list = NULL;
> +	struct diff_line_range *r = NULL;
> +
> +	if (prepare_revision_walk(rev))
> +		die("revision walk prepare failed");
> +
> +	list = rev->commits;
> +	if (list) {
> +		list->item->object.flags |= RANGE_UPDATE;
> +		list = list->next;
> +	}
> +	/* Clear the flags */
> +	while (list) {
> +		list->item->object.flags &= 0x0;

Just assign "= 0" instead, please.

But more importantly, why is it safe to clear all the flags?  Even if your
traversal is limited (i.e. prepare_revision_walk() already walked
everything), at least wouldn't you need to keep flags like SYMMETRIC_LEFT,
UNINTERESTING, BOUNDARY etc. depending on what the end user asked from the
command line?

If you ask prepare_revison_walk()->limit_list() callchain to run a
limited and topo-sorted traversal, wouldn't the resulting revs->list
have commits in the order you need already?  Why do you need to have a
custom walker here?

I am not suggesting to roll this logic into prepare_revision_walk() and
limit_list(); there are a lot more than "we need topological order" going
on in this function, and the log message needs to explain what they are.
