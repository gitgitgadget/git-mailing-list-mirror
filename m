Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3092C433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 19:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbiKVTkk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 14:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbiKVTkh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 14:40:37 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47296F36C
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 11:40:36 -0800 (PST)
Received: (qmail 18905 invoked by uid 109); 22 Nov 2022 19:40:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 22 Nov 2022 19:40:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6115 invoked by uid 111); 22 Nov 2022 19:40:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Nov 2022 14:40:36 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 22 Nov 2022 14:40:35 -0500
From:   Jeff King <peff@peff.net>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v2] object-file: use real paths when adding alternates
Message-ID: <Y30ls8yD7WES0pq9@coredump.intra.peff.net>
References: <pull.1382.git.git.1668706274099.gitgitgadget@gmail.com>
 <pull.1382.v2.git.git.1669074557348.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1382.v2.git.git.1669074557348.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 21, 2022 at 11:49:17PM +0000, Glen Choo via GitGitGadget wrote:

>     Thanks for the feedback on v1. This version takes nearly all of Peff's
>     patch [1] except for the comment about making an exception for relative
>     paths in the environment. My reading of the commit [2] is that it was a
>     workaround for strbuf_normalize_path() not being able to handle relative
>     paths, so the only reason to special-case the environment is to preserve
>     the behavior of respecting broken paths, which (unlike relative paths) I
>     don't think will be missed.

Yeah, that makes sense. If realpath fails because a path isn't present,
then we would throw it away anyway. So we don't need to quietly
tolerate, unless we really care about the difference between reporting
"this directory doesn't seem to exist" versus "I couldn't run realpath
on this directory". One is a subset of the other.

> diff --git a/object-file.c b/object-file.c
> index 957790098fa..ef2b762234d 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -508,6 +508,7 @@ static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
>  {
>  	struct object_directory *ent;
>  	struct strbuf pathbuf = STRBUF_INIT;
> +	struct strbuf tmp = STRBUF_INIT;
>  	khiter_t pos;
>  
>  	if (!is_absolute_path(entry->buf) && relative_base) {
> @@ -516,12 +517,14 @@ static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
>  	}
>  	strbuf_addbuf(&pathbuf, entry);
>  
> -	if (strbuf_normalize_path(&pathbuf) < 0 && relative_base) {
> +	if (!strbuf_realpath(&tmp, pathbuf.buf, 0)) {
>  		error(_("unable to normalize alternate object path: %s"),
> -		      pathbuf.buf);
> +			pathbuf.buf);
>  		strbuf_release(&pathbuf);
>  		return -1;
>  	}
> +	strbuf_swap(&pathbuf, &tmp);
> +	strbuf_release(&tmp);

So here we are looking at an alternates entry (either from a file or
from the environment). We do note all errors, even in relative ones from
the environment, but we don't die, so we'll just ignore the failed
alternate. Good.

> @@ -596,10 +599,7 @@ static void link_alt_odb_entries(struct repository *r, const char *alt,
>  		return;
>  	}
>  
> -	strbuf_add_absolute_path(&objdirbuf, r->objects->odb->path);
> -	if (strbuf_normalize_path(&objdirbuf) < 0)
> -		die(_("unable to normalize object directory: %s"),
> -		    objdirbuf.buf);
> +	strbuf_realpath(&objdirbuf, r->objects->odb->path, 1);

And here we are resolving the actual object directory, and we always
died if that couldn't be normalized. And we'll continue to do so by
realpath. Good.

> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh

And then that's all we needed in the C code, since we already do
duplicate checks. Good. :)

> index 5be483bf887..ce1954d0977 100755
> --- a/t/t7700-repack.sh
> +++ b/t/t7700-repack.sh
> @@ -90,6 +90,24 @@ test_expect_success 'loose objects in alternate ODB are not repacked' '
>  	test_has_duplicate_object false
>  '
>  
> +test_expect_success '--local keeps packs when alternate is objectdir ' '
> +	git init alt_symlink &&
> +	(
> +		cd alt_symlink &&
> +		git init &&
> +		echo content >file4 &&
> +		git add file4 &&
> +		git commit -m commit_file4 &&
> +		git repack -a &&
> +		ls .git/objects/pack/*.pack >../expect &&
> +		ln -s objects .git/alt_objects &&
> +		echo "$(pwd)/.git/alt_objects" >.git/objects/info/alternates &&
> +		git repack -a -d -l &&
> +		ls .git/objects/pack/*.pack >../actual
> +	) &&
> +	test_cmp expect actual
> +'

This probably needs to be protected with a SYMLINKS prereq.

-Peff
