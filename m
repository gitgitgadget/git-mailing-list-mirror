Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABBF31F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 07:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbeKKQ6t (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 11:58:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:47672 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727334AbeKKQ6t (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 11:58:49 -0500
Received: (qmail 1084 invoked by uid 109); 11 Nov 2018 07:11:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 11 Nov 2018 07:11:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31940 invoked by uid 111); 11 Nov 2018 07:10:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 11 Nov 2018 02:10:24 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Nov 2018 02:11:03 -0500
Date:   Sun, 11 Nov 2018 02:11:03 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, larsxschneider@gmail.com,
        sandals@crustytoothpaste.net, me@ttaylorr.com, jrnieder@gmail.com
Subject: Re: [PATCH 08/10] fast-export: add --reference-excluded-parents
 option
Message-ID: <20181111071102.GH30850@sigill.intra.peff.net>
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com>
 <20181111062312.16342-9-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181111062312.16342-9-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 10, 2018 at 10:23:10PM -0800, Elijah Newren wrote:

> git filter-branch has a nifty feature allowing you to rewrite, e.g. just
> the last 8 commits of a linear history
>   git filter-branch $OPTIONS HEAD~8..HEAD
> 
> If you try the same with git fast-export, you instead get a history of
> only 8 commits, with HEAD~7 being rewritten into a root commit.  There
> are two alternatives:

Ah, I think this maybe answers some of my earlier questions, too. You
cannot use fast-import as it stands to do a partial rewrite.

>   1) Don't use the negative revision specification, and when you're
>      filtering the output to make modifications to the last 8 commits,
>      just be careful to not modify any earlier commits somehow.
> 
>   2) First run 'git fast-export --export-marks=somefile HEAD~8', then
>      run 'git fast-export --import-marks=somefile HEAD~8..HEAD'.
> 
> Both are more error prone than I'd like (the first for obvious reasons;
> with the second option I have sometimes accidentally included too many
> revisions in the first command and then found that the corresponding
> extra revisions were not exported by the second command and thus were
> not modified as I expected).  Also, both are poor from a performance
> perspective.

Yeah, this should be O(commits you're touching), and it the current code
does not allow that at all. So I think this feature makes a lot of sense
(it probably _should_ have been the default, but it's a bit late for
that now).

> @@ -638,13 +640,21 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
>  	unuse_commit_buffer(commit, commit_buffer);
>  
>  	for (i = 0, p = commit->parents; p; p = p->next) {
> -		int mark = get_object_mark(&p->item->object);
> -		if (!mark)
> +		struct object *obj = &p->item->object;
> +		int mark = get_object_mark(obj);
> +
> +		if (!mark && !reference_excluded_commits)
>  			continue;
>  		if (i == 0)
> -			printf("from :%d\n", mark);
> +			printf("from ");
> +		else
> +			printf("merge ");
> +		if (mark)
> +			printf(":%d\n", mark);
>  		else
> -			printf("merge :%d\n", mark);
> +			printf("%s\n", sha1_to_hex(anonymize ?
> +						   anonymize_sha1(&obj->oid) :
> +						   obj->oid.hash));
>  		i++;
>  	}

OK, so this just teaches us to start with the sensible "from" directive.
I think we might be able to do a little more optimization here. If we're
exporting HEAD^..HEAD and there's an object in HEAD^ which is unchanged
in HEAD, I think we'd still print it (because it would not be marked
SHOWN), but we could omit it (by walking the tree of the boundary
commits and marking them shown).

I don't think it's a blocker for what you're doing here, but just a
possible future optimization.

> @@ -925,13 +935,22 @@ static void handle_tags_and_duplicates(struct string_list *extras)
>  				/*
>  				 * Getting here means we have a commit which
>  				 * was excluded by a negative refspec (e.g.
> -				 * fast-export ^master master).  If the user
> +				 * fast-export ^master master).  If we are
> +				 * referencing excluded commits, set the ref
> +				 * to the exact commit.  Otherwise, the user
>  				 * wants the branch exported but every commit
> -				 * in its history to be deleted, that sounds
> -				 * like a ref deletion to me.
> +				 * in its history to be deleted, which basically
> +				 * just means deletion of the ref.
>  				 */
> -				printf("reset %s\nfrom %s\n\n",
> -				       name, sha1_to_hex(null_sha1));
> +				if (!reference_excluded_commits) {
> +					/* delete the ref */
> +					printf("reset %s\nfrom %s\n\n",
> +					       name, sha1_to_hex(null_sha1));
> +					continue;
> +				}
> +				/* set ref to commit using oid, not mark */
> +				printf("reset %s\nfrom %s\n\n", name,
> +				       sha1_to_hex(commit->object.oid.hash));

OK, and this is basically answering my earlier questions again: yes, you
_would_ want to keep old tags pointing at their commits. But only in
this much more sensible mode.

-Peff
