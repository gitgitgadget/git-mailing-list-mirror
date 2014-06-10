From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/15] do not create "struct commit" with xcalloc
Date: Tue, 10 Jun 2014 14:35:48 -0700
Message-ID: <xmqqbnu08n2j.fsf@gitster.dls.corp.google.com>
References: <20140609180236.GA24644@sigill.intra.peff.net>
	<20140609181008.GC20315@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 10 23:36:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuTiD-0001Ra-O9
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 23:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754032AbaFJVgB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 17:36:01 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59184 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753247AbaFJVf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 17:35:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DDB1F1EF7F;
	Tue, 10 Jun 2014 17:35:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q83kBHNttlNy/QzBX41bDojk8nM=; b=UPLJVw
	VBSs8pAhiLYgM3AL+Q7rjTWUP9pJE0aFPPgM7oCV3OVYzJFgRgDxaQ2oyxV3JnAb
	yNCmYI4kbta3xsoDEjaM1r7x+rUZnxMm1VSF5FJXnRubjgUl7HSI6uG145skftOL
	mZLbxa3go1jf4ORuh7CAHsiH1VdghMCc1mxGA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KAEX19AurByhjPwh36EqldJYX9M4zdA0
	qSxRc+rsvZVfaYG0LKyUhG5NOejgJhqga0Zivv92eSprAtRw6ggAw5TCBK/yl8P6
	mE24wY9Go/GjGEMiabuX8nrhZ142GBMla5M/PkrlgWj/5F5wxNVWz17+1TQMynR2
	1xDlB5tDpzU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D51891EF79;
	Tue, 10 Jun 2014 17:35:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E32AB1EF6E;
	Tue, 10 Jun 2014 17:35:54 -0400 (EDT)
In-Reply-To: <20140609181008.GC20315@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 9 Jun 2014 14:10:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 33DC456A-F0E7-11E3-AE41-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251243>

Jeff King <peff@peff.net> writes:

> In both blame and merge-recursive, we sometimes create a
> "fake" commit struct for convenience (e.g., to represent the
> HEAD state as if we would commit it). By allocating
> ourselves rather than using alloc_commit_node, we do not
> properly set the "index" field of the commit. This can
> produce subtle bugs if we then use commit-slab on the
> resulting commit, as we will share the "0" index with
> another commit.

The change I see here is all good, but I wonder if it is too late to
start the real index from 1 and catch anything that has 0 index with
a BUG("do not hand-allocate a commit").

> We can fix this by using alloc_commit_node() to allocate.
> Note that we cannot free the result, as it is part of our
> commit allocator. However, both cases were already leaking
> the allocated commit anyway, so there's nothing to fix up.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/blame.c   | 2 +-
>  merge-recursive.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index a52a279..d6056a5 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -2286,7 +2286,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
>  	struct strbuf msg = STRBUF_INIT;
>  
>  	time(&now);
> -	commit = xcalloc(1, sizeof(*commit));
> +	commit = alloc_commit_node();
>  	commit->object.parsed = 1;
>  	commit->date = now;
>  	commit->object.type = OBJ_COMMIT;
> diff --git a/merge-recursive.c b/merge-recursive.c
> index cab16fa..2b37d42 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -40,7 +40,7 @@ static struct tree *shift_tree_object(struct tree *one, struct tree *two,
>  
>  static struct commit *make_virtual_commit(struct tree *tree, const char *comment)
>  {
> -	struct commit *commit = xcalloc(1, sizeof(struct commit));
> +	struct commit *commit = alloc_commit_node();
>  	struct merge_remote_desc *desc = xmalloc(sizeof(*desc));
>  
>  	desc->name = comment;
