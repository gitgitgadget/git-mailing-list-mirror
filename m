Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 588211F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 20:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbeJKETD (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 00:19:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:36040 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725769AbeJKETB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 00:19:01 -0400
Received: (qmail 7632 invoked by uid 109); 10 Oct 2018 20:55:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 10 Oct 2018 20:55:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21691 invoked by uid 111); 10 Oct 2018 20:54:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 10 Oct 2018 16:54:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Oct 2018 16:55:06 -0400
Date:   Wed, 10 Oct 2018 16:55:06 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] push: add an advice on unqualified <dst> push
Message-ID: <20181010205505.GB12949@sigill.intra.peff.net>
References: <20181010104145.25610-1-avarab@gmail.com>
 <20181010104145.25610-3-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181010104145.25610-3-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 10, 2018 at 10:41:45AM +0000, Ævar Arnfjörð Bjarmason wrote:

> Improve the error message added in f8aae12034 ("push: allow
> unqualified dest refspecs to DWIM", 2008-04-23), which before this
> change looks like this:
> 
>     $ git push avar v2.19.0^{commit}:newbranch -n
>     error: unable to push to unqualified destination: newbranch
>     The destination refspec neither matches an existing ref on the remote nor
>     begins with refs/, and we are unable to guess a prefix based on the source ref.
>     error: failed to push some refs to 'git@github.com:avar/git.git'

Thanks for looking into this. Despite being largely responsible for that
message myself, I always cringe when I see it because it's so opaque.

> This message needed to be read very carefully to spot how to fix the
> error, i.e. to push to refs/heads/newbranch, and it didn't use the
> advice system (since initial addition of the error predated it).
> 
> Fix both of those, now the message will look like this instead:
> 
>     $ ./git-push avar v2.19.0^{commit}:newbranch -n
>     error: unable to push to unqualified destination: newbranch
>     hint: The destination refspec neither matches an existing
>     hint: ref on the remote nor begins with refs/, and we are
>     hint: unable to guess a prefix based on the source ref.
>     hint:
>     hint: The <src> part of the refspec is a commit object.
>     hint: Did you mean to create a new branch by pushing to
>     hint: 'v2.19.0^{commit}:refs/heads/newbranch'?
>     error: failed to push some refs to 'git@github.com:avar/git.git'
> 
> When trying to push a tag, tree or a blob we suggest that perhaps the
> user meant to push them to refs/tags/ instead.

This is much better, and I love the customized behavior based on the
object type.

I wonder if we could reword the first paragraph to be a little less
confusing, and spell out what we tried already. E.g., something like:

  The destination you provided is not a full refname (i.e., starting
  with "ref"). Git tried to guess what you meant by:

    - looking for a matching branch or tag on the remote side

    - looking at the refname of the local source

  but neither worked.

  The <src> part of the refspec is a commit object.
  Did you mean...

I'm not sure about saying "branch or tag" in the first bullet. It's
friendlier to most users, but less technically correct (if you said
"notes/foo", I believe we'd match an existing "refs/notes/foo", because
it's really just using the normal lookup rules).

Also, as an aside, I wonder if we should allow "heads/foo" to work as
"refs/heads/foo" (even when no such ref already exists). But that is
totally orthogonal to changing the message.

> The if/else duplication for all of OBJ_{COMMIT,TAG,TREE,BLOB} is
> unfortunate, but is required to correctly mark the messages for
> translation.

I think it would probably be OK to put the first paragraph in its own
variable. I know we try to avoid translation lego, but I'd think
paragraphs are separate units. Or are you worried about how to get them
into the same advise() call? I don't know that we need to, but we could
also plug one into the other with a "%s" (and leave a translator note).

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 1546833213..fd455e2739 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -320,6 +320,13 @@ advice.*::
>  		tries to overwrite a remote ref that points at an
>  		object that is not a commit-ish, or make the remote
>  		ref point at an object that is not a commit-ish.
> +	pushAmbigiousRefName::
> +		Shown when linkgit:git-push[1] gives up trying to
> +		guess based on the source and destination refs what
> +		remote ref namespace the source belongs in, but where
> +		we can still suggest that the user push to either
> +		refs/heads/* or refs/tags/* based on the type of the
> +		source object.

I guess you could argue that this is "ambiguous", but usually we'd use
that term to mean "there were two branches that matched on the other
side". But here it's actually "no branches matched" (actually, it makes
me wonder what we'd do pushing "foo" when that name is ambiguous on the
other side).

So I wonder if this ought to be pushUnqualifiedRefname or something.

> @@ -1046,13 +1047,60 @@ static int match_explicit(struct ref *src, struct ref *dst,
>  		else if ((dst_guess = guess_ref(dst_value, matched_src))) {
>  			matched_dst = make_linked_ref(dst_guess, dst_tail);
>  			free(dst_guess);
> -		} else
> -			error(_("unable to push to unqualified destination: %s\n"
> -				"The destination refspec neither matches an "
> -				"existing ref on the remote nor\n"
> -				"begins with refs/, and we are unable to "
> -				"guess a prefix based on the source ref."),
> -			      dst_value);
> +		} else {
> +			struct object_id oid;
> +			enum object_type type;
> +
> +			error("unable to push to unqualified destination: %s", dst_value);
> +			if (!advice_push_ambiguous_ref_name)
> +				break;

This break feels funny, because it controls flow much larger than this
if/else. It does the right thing now, but it must remain in sync with
what comes at the end of that long string of advise() messages.

Can we just do it as:

  if (advice_push_ambiguous_ref_name) {
	struct object_id oid;
	enum object_type type;

	if (get_oid(...))
	   etc...
  }

instead? That pushes your indentation one level in, but I think the
whole conditional body might be cleaner in a helper function anyway.

-Peff
