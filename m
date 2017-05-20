Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0F0B201CF
	for <e@80x24.org>; Sat, 20 May 2017 06:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752411AbdETGyG (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 02:54:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:55120 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750814AbdETGyF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 02:54:05 -0400
Received: (qmail 12330 invoked by uid 109); 20 May 2017 06:54:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 20 May 2017 06:54:03 +0000
Received: (qmail 32563 invoked by uid 111); 20 May 2017 06:54:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 20 May 2017 02:54:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 20 May 2017 02:54:01 -0400
Date:   Sat, 20 May 2017 02:54:01 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
        <git-dpa@aegee.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Remove useless assignments
Message-ID: <20170520065401.oqavzqh4szxoyqvl@sigill.intra.peff.net>
References: <20170520055216.30470-1-git-dpa@aegee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170520055216.30470-1-git-dpa@aegee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 20, 2017 at 05:52:16AM +0000, Дилян Палаузов wrote:

> Signed-off-by: Дилян Палаузов <git-dpa@aegee.org>

I assume this is just going through the results of clang's static
analyzer and quieting it. I think most of these are not the right fix,
though, as I discussed in

  http://public-inbox.org/git/20170225223146.ixubnwqkfol5q2gn@sigill.intra.peff.net/

For instance:

> diff --git a/archive.c b/archive.c
> index 60b889198..e2534d186 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -503,7 +503,7 @@ int write_archive(int argc, const char **argv, const char *prefix,
>  	init_tar_archiver();
>  	init_zip_archiver();
>  
> -	argc = parse_archive_args(argc, argv, &ar, &args, name_hint, remote);
> +	parse_archive_args(argc, argv, &ar, &args, name_hint, remote);
>  	if (!startup_info->have_repository) {
>  		/*
>  		 * We know this will die() with an error, so we could just

It's true that nobody accesses argc after this, so the assignment is
dead. But if we _don't_ assign to argc, we're leaving a maintenance trap
for somebody who later does want to access it. Its value must match that
what is in argv, and after your patch that invariant no longer holds.

Ditto for all of the argc hunks in this patch.

> diff --git a/builtin/merge.c b/builtin/merge.c
> index 703827f00..337efef6f 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -795,7 +795,7 @@ static int merge_trivial(struct commit *head, struct commit_list *remoteheads)
>  	write_tree_trivial(&result_tree);
>  	printf(_("Wonderful.\n"));
>  	pptr = commit_list_append(head, pptr);
> -	pptr = commit_list_append(remoteheads->item, pptr);
> +	commit_list_append(remoteheads->item, pptr);
>  	prepare_to_commit(remoteheads);
>  	if (commit_tree(merge_msg.buf, merge_msg.len, result_tree.hash, parents,
>  			result_commit.hash, NULL, sign_commit))

This one is similar. The return value of the append function updates the
tail pointer. Nobody appends to the list, so we never look at the tail
pointer again. But it has violated the tail-pointer invariant, and is
setting a trap for somebody who tries to append to the list later.

> diff --git a/builtin/notes.c b/builtin/notes.c
> index 7b891471c..6ec753383 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -1015,7 +1015,7 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
>  	else if (!strcmp(argv[0], "get-ref"))
>  		result = get_ref(argc, argv, prefix);
>  	else {
> -		result = error(_("unknown subcommand: %s"), argv[0]);
> +		error(_("unknown subcommand: %s"), argv[0]);
>  		usage_with_options(git_notes_usage, options);
>  	}
>  

This one actually seems reasonable (usage_with_options exits, so we
don't need to bother setting result).

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 0bb36d584..0fa779103 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -498,7 +498,7 @@ static const char *check_nonce(const char *buf, size_t len)
>  	char *nonce = find_header(buf, len, "nonce");
>  	timestamp_t stamp, ostamp;
>  	char *bohmac, *expect = NULL;
> -	const char *retval = NONCE_BAD;
> +	const char *retval;
>  
>  	if (!nonce) {
>  		retval = NONCE_MISSING;

I have mixed feeling on this one. It's true that the NONCE_BAD value is
never used. But it's a defensive programming measure to set the default
in case we add code paths that do not set retval. If we could trust the
compiler to tell us when the uninitialized value was used, that would
let us avoid that situation. But the maybe-uninitialized warnings have
historically been one of the least trustworthy warnings we've seen (most
of the compiler-warning workarounds we've done have been for that).

> diff --git a/fsck.c b/fsck.c
> index d589341cd..35d421c08 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -703,7 +703,6 @@ static int fsck_ident(const char **ident, struct object *obj, struct fsck_option
>  	    !isdigit(p[4]) ||
>  	    (p[5] != '\n'))
>  		return report(options, obj, FSCK_MSG_BAD_TIMEZONE, "invalid author/committer line - bad time zone");
> -	p += 6;
>  	return 0;
>  }

Another "invariant" one. Anybody adding more fsck checks would be
surprised when "p" is not updated past the last check.

> diff --git a/ref-filter.c b/ref-filter.c
> index 1fc5e9970..2d06b98ce 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1634,10 +1634,6 @@ static int match_name_as_path(const struct ref_filter *filter, const char *refna
>  {
>  	const char **pattern = filter->name_patterns;
>  	int namelen = strlen(refname);
> -	unsigned flags = WM_PATHNAME;
> -
> -	if (filter->ignore_case)
> -		flags |= WM_CASEFOLD;
>  
>  	for (; *pattern; pattern++) {
>  		const char *p = *pattern;

I think this one is a real bug, but your fix is going in the wrong
direction. Those lines were added by 3bb16a8bf (tag, branch,
for-each-ref: add --ignore-case for sorting and filtering, 2016-12-04),
and it was probably a mistake that it did not update the call to
wildmatch(). IOW, the fix is probably:

diff --git a/ref-filter.c b/ref-filter.c
index 8f48e0dc4..f4306793b 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1533,7 +1533,7 @@ static int match_name_as_path(const struct ref_filter *filter, const char *refna
 		     refname[plen] == '/' ||
 		     p[plen-1] == '/'))
 			return 1;
-		if (!wildmatch(p, refname, WM_PATHNAME, NULL))
+		if (!wildmatch(p, refname, flags, NULL))
 			return 1;
 	}
 	return 0;

-Peff
