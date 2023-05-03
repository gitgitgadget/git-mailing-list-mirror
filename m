Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662FEC77B75
	for <git@archiver.kernel.org>; Wed,  3 May 2023 19:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjECT7M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 15:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjECT7J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 15:59:09 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866FE13A
        for <git@vger.kernel.org>; Wed,  3 May 2023 12:59:07 -0700 (PDT)
Received: (qmail 13223 invoked by uid 109); 3 May 2023 19:59:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 May 2023 19:59:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30745 invoked by uid 111); 3 May 2023 19:59:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 03 May 2023 15:59:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 3 May 2023 15:59:06 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2] builtin/pack-objects.c: introduce
 `pack.extraCruftTips`
Message-ID: <20230503195906.GA1796816@coredump.intra.peff.net>
References: <8af478ebe34539b68ffb9b353bbb1372dfca3871.1682011600.git.me@ttaylorr.com>
 <73ad7b90e1fe6c15f41ff828651f7ab06076ffd8.1683072587.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <73ad7b90e1fe6c15f41ff828651f7ab06076ffd8.1683072587.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 02, 2023 at 08:09:47PM -0400, Taylor Blau wrote:

> However, there is no option to be able to keep around certain objects
> that have otherwise aged out of the grace period. The only way to retain
> those objects is:
> 
>   - to point a reference at them, which may be undesirable or
>     infeasible,
>   - to track them via the reflog, which may be undesirable since the
>     reflog's lifetime is limited to that of the reference it's tracking
>     (and callers may want to keep those unreachable objects around for
>     longer)
>   - to extend the grace period, which may keep around other objects that
>     the caller *does* want to discard,
>   - or, to force the caller to construct the pack of objects they want
>     to keep themselves, and then mark the pack as kept by adding a
>     ".keep" file.

OK, I understand the use case you're trying to support, and your
approach mostly makes sense. But there are two things I was surprised by
in the implementation:

  1. Does this need to be tied to cruft packs? The same logic would
     apply to "repack -A" which turns objects loose (of course you
     probably don't want to do that in the long term for performance
     reasons, but it's conceptually the same thing; see below).

  2. Why is there a separate walk distinct from the one that rescues
     recent-but-unreachable objects?

Conceptually it seems to me that the simplest and most flexible way to
think of this new feature is: pretend these objects are recent enough to
be kept in the grace period, even though their mtimes do not qualify".

And then everything else would just fall out naturally. Am I missing
something?

In a pre-cruft-pack world, I'd have just expected the patch to look like
this:

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index bd6ad016d6..1d655dc758 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4077,6 +4077,7 @@ static void get_object_list(struct rev_info *revs, int ac, const char **av)
 		if (add_unseen_recent_objects_to_traversal(revs,
 				unpack_unreachable_expiration, NULL, 0))
 			die(_("unable to add recent objects"));
+		add_tips_from_program(revs);
 		if (prepare_revision_walk(revs))
 			die(_("revision walk setup failed"));
 		traverse_commit_list(revs, record_recent_commit,

Sadly the cruft-pack feature doesn't really share this code, but I think
it does something similar, and could just consider those synthetic tips
as "recent" for this run.

> +static int enumerate_extra_cruft_tips_1(struct rev_info *revs, const char *args)
> +{
> +	struct child_process cmd = CHILD_PROCESS_INIT;
> +	struct strbuf buf = STRBUF_INIT;
> +	FILE *out = NULL;
> +	int ret = 0;
> +
> +	cmd.use_shell = 1;
> +	cmd.out = -1;
> +
> +	strvec_push(&cmd.args, args);
> +	strvec_pushv(&cmd.env, (const char **)local_repo_env);

Why does this clear the environment of local-repo variables? That seems
unlike most other hooks we have, and would cause confusion if $GIT_DIR
or various config variables are important (e.g., should "git -c foo.bar
gc" persist foo.bar when running the hook? It usually does).

I know that some hooks that try to change repositories by changing
directories have the opposite confusion ($GIT_DIR is set, but they did
not want it). But it makes more sense to me to remain consistent with
how other hooks behave.

> +	if (start_command(&cmd)) {
> +		ret = -1;
> +		goto done;
> +	}

This may be a matter of taste, but you can "return -1" directly here, as
nothing has been allocated (and a failed start_command() will call
child_process_clear() for you). This would mean "out" is always set in
the "done:" label, so it wouldn't need a NULL-check (nor an
initialization).

> +
> +	out = xfdopen(cmd.out, "r");
> +	while (strbuf_getline_lf(&buf, out) != EOF) {

is there any reason to be a stickler for LF versus CRLF here? I.e.,
wouldn't strbuf_getline() be more friendly, with little chance that we
misinterpret the result?

> +		struct object_id oid;
> +		struct object *obj;
> +		const char *rest;
> +
> +		if (parse_oid_hex(buf.buf, &oid, &rest) || *rest) {
> +			ret = error(_("invalid extra cruft tip: '%s'"), buf.buf);
> +			goto done;
> +		}
> +
> +		obj = parse_object(the_repository, &oid);
> +		if (!obj)
> +			continue;

This parse_object() can be pretty expensive, especially if you are
rescuing a lot of objects (or if your program directly references large
blobs). Can we use oid_object_info() here in combination with
lookup_object_by_type()?

-Peff
