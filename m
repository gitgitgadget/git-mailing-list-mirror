Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C86CC43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 19:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975A7206F6
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 19:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="gIbTIj1S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732337AbgDATMf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 15:12:35 -0400
Received: from forward501o.mail.yandex.net ([37.140.190.203]:34466 "EHLO
        forward501o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732148AbgDATMf (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 1 Apr 2020 15:12:35 -0400
Received: from mxback25j.mail.yandex.net (mxback25j.mail.yandex.net [IPv6:2a02:6b8:0:1619::225])
        by forward501o.mail.yandex.net (Yandex) with ESMTP id ED8CA1E80219;
        Wed,  1 Apr 2020 22:12:30 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback25j.mail.yandex.net (mxback/Yandex) with ESMTP id 3q0Jcsppa2-CUvSgGe1;
        Wed, 01 Apr 2020 22:12:30 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1585768350;
        bh=KROICxqPEy4hq4vYDbw78SWuZmBt0zYqqieeV8uk1vo=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=gIbTIj1S6RZik37ygP5PC23Iw39texZN/GUV+lVkx2GvtbPyMWf+Qp5B8jdA9HDu3
         zuNkxyhm19YjVIchQY8qiGiwmpucaf0T2r1EjDQS6lB2S/iBr27N58AL5Jj98txcCG
         BxHswucx/56SRKPtwzRL100q+K4alK//0/Ps/c/o=
Authentication-Results: mxback25j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas8-7ec005b03c91.qloud-c.yandex.net with HTTP;
        Wed, 01 Apr 2020 22:12:30 +0300
From:   Konstantin Tokarev <annulen@yandex.ru>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <20200401121537.GA1916590@coredump.intra.peff.net>
References: <2814631585342072@sas8-da6d7485e0c7.qloud-c.yandex.net>
         <20200328144023.GB1198080@coredump.intra.peff.net> <20200401121537.GA1916590@coredump.intra.peff.net>
Subject: Re: [PATCH] clone: use "quick" lookup while following tags
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Wed, 01 Apr 2020 22:12:30 +0300
Message-Id: <111951585768302@iva8-bad53723c646.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



01.04.2020, 15:15, "Jeff King" <peff@peff.net>:
> On Sat, Mar 28, 2020 at 10:40:23AM -0400, Jeff King wrote:
>
>>  So I guess the problem is not with shallow clones specifically, but they
>>  lead us to not having fetched the commits pointed to by tags, which
>>  leads to us trying to fault in those commits (and their trees) rather
>>  than realizing that we weren't meant to have them. And the size of the
>>  local repo balloons because you're fetching all those commits one by
>>  one, and not getting the benefit of the deltas you would when you do a
>>  single --filter=blob:none fetch.
>>
>>  I guess we need something like this:
>
> The issue is actually with --single-branch, which is implied by --depth.
> But the fix is the same either way.
>
> Here it is with a commit message and test.
>
> -- >8 --
> Subject: [PATCH] clone: use "quick" lookup while following tags
>
> When cloning with --single-branch, we implement git-fetch's usual
> tag-following behavior, grabbing any tag objects that point to objects
> we have locally.
>
> When we're a partial clone, though, our has_object_file() check will
> actually lazy-fetch each tag. That not only defeats the purpose of
> --single-branch, but it does it incredibly slowly, potentially kicking
> off a new fetch for each tag. This is even worse for a shallow clone,
> which implies --single-branch, because even tags which are supersets of
> each other will be fetched individually.
>
> We can fix this by passing OBJECT_INFO_SKIP_FETCH_OBJECT to the call,
> which is what git-fetch does in this case.
>
> Likewise, let's include OBJECT_INFO_QUICK, as that's what git-fetch
> does. The rationale is discussed in 5827a03545 (fetch: use "quick"
> has_sha1_file for tag following, 2016-10-13), but here the tradeoff
> would apply even more so because clone is very unlikely to be racing
> with another process repacking our newly-created repository.
>
> This may provide a very small speedup even in the non-partial case case,
> as we'd avoid calling reprepare_packed_git() for each tag (though in
> practice, we'd only have a single packfile, so that reprepare should be
> quite cheap).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/clone.c | 4 +++-
>  t/t5616-partial-clone.sh | 8 ++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index d8b1f413aa..9da6459f1d 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -643,7 +643,9 @@ static void write_followtags(const struct ref *refs, const char *msg)
>                          continue;
>                  if (ends_with(ref->name, "^{}"))
>                          continue;
> - if (!has_object_file(&ref->old_oid))
> + if (!has_object_file_with_flags(&ref->old_oid,
> + OBJECT_INFO_QUICK |
> + OBJECT_INFO_SKIP_FETCH_OBJECT))
>                          continue;
>                  update_ref(msg, ref->name, &ref->old_oid, NULL, 0,
>                             UPDATE_REFS_DIE_ON_ERR);
> diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
> index 77bb91e976..8f0d81a27e 100755
> --- a/t/t5616-partial-clone.sh
> +++ b/t/t5616-partial-clone.sh
> @@ -415,6 +415,14 @@ test_expect_success 'verify fetch downloads only one pack when updating refs' '
>          test_line_count = 3 pack-list
>  '
>
> +test_expect_success 'single-branch tag following respects partial clone' '
> + git clone --single-branch -b B --filter=blob:none \
> + "file://$(pwd)/srv.bare" single &&
> + git -C single rev-parse --verify refs/tags/B &&
> + git -C single rev-parse --verify refs/tags/A &&
> + test_must_fail git -C single rev-parse --verify refs/tags/C
> +'
> +
>  . "$TEST_DIRECTORY"/lib-httpd.sh
>  start_httpd
>
> --
> 2.26.0.408.gebd8a4413c

Would you recommend using this patch in production, or is it better to wait for reviews?

-- 
Regards,
Konstantin

