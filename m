Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2BEC4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 20:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6D1F61002
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 20:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239908AbhHDUhn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 16:37:43 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:41129 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbhHDUhm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 16:37:42 -0400
Date:   Wed, 04 Aug 2021 20:36:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eagain.st;
        s=protonmail; t=1628109417;
        bh=kREOeGD2dxJSUVOo9mj0H2kcJVBGaSb+wfvLqJydGpM=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=y+3IB9edjJvhwO8OIRZ4yvpwsDK8hrOdVdhRhDHDAD3rmG/Cw9Wd0crqZeEp0g8PC
         l5VsuHiph3iKve/sTVMjbfZil/TYf0fHky5l54eX1GnnQeHDgzBjGqbw/PQI6HqzPq
         rb77wFEdbThYTiz1DgR1nEPcOyTJXw4ymLvNBBKCsng+mfjmjJxsAZZEUAiRaHBEpP
         q+1TpeIfKqk50mSewbjC7f0pYvf7rFvUGoThOo814MHS5q08ATE97pGZ9+k5UIfec8
         1U6ZZY4IrUbU9MVvokfp/vZVEdNB0bbCeiumbiP+pdaqA6qNczDn7ePYi2Me/K8uH1
         I7TN7HOps6VaQ==
To:     Jonathan Tan <jonathantanmy@google.com>
From:   Kim Altintop <kim@eagain.st>
Cc:     git@vger.kernel.org, bwilliams.eng@gmail.com, gitster@pobox.com
Reply-To: Kim Altintop <kim@eagain.st>
Subject: Re: [PATCH v2] upload-pack.c: treat want-ref relative to namespace
Message-ID: <CDB0M5IP0WNJ.3I09ZETKF0VXS@schmidt>
In-Reply-To: <20210802210644.3432544-1-jonathantanmy@google.com>
References: <20210731203415.618641-1-kim@eagain.st> <20210802210644.3432544-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon Aug 2, 2021 at 11:06 PM CEST, Jonathan Tan wrote:
> > +test_expect_success 'setup namespaced repo' '
> > +=09git init -b main "$REPO" &&
> > +=09cd "$REPO" &&
> > +=09test_commit a &&
> > +=09test_commit b &&
> > +=09git checkout a &&
> > +=09test_commit c &&
> > +=09git checkout a &&
> > +=09test_commit d &&
> > +=09git update-ref refs/heads/ns-no b &&
> > +=09git update-ref refs/namespaces/ns/refs/heads/ns-yes c &&
> > +=09git update-ref refs/namespaces/ns/refs/heads/hidden d &&
> > +=09git -C "$REPO" config uploadpack.allowRefInWant true &&
> > +=09git -C "$REPO" config transfer.hideRefs refs/heads/hidden
> > +'
>
> If you're not using a subshell to set up the repo, you should add '-C
> "$REPO"' to all the "git" commands (like you do in the last 2 lines)
> instead of "cd"-ing halfway through the test. The helper function
> test_commit also has that facility ('test_commit -C "$REPO" a', for
> example).

Ah, that answers the question raised by Junio in the first review. I'll rev=
ert
to using a subshell, as that seems clearer and is used throughout the file.

> > +test_expect_success 'want-ref with namespaces' '
> > +=09oid=3D$(git -C "$REPO" rev-parse c) &&
> > +=09cat >expected_refs <<-EOF &&
> > +=09$oid refs/heads/ns-yes
> > +=09EOF
> > +=09>expected_commits &&
> > +
> > +=09oid=3D$(git -C "$REPO" rev-parse c) &&
> > +=09test-tool pkt-line pack >in <<-EOF &&
> > +=09$(write_command fetch)
> > +=090001
> > +=09no-progress
> > +=09want-ref refs/heads/ns-yes
> > +=09have $oid
>
> Do we need this "have" line? I think we can just omit it, since what the
> client has is irrelevant to the test. (Same for the other tests.)

Hm no. I think I misread how this works.

> > +test_expect_success 'want-ref outside namespace' '
> > +=09oid=3D$(git -C "$REPO" rev-parse c) &&
> > +=09test-tool pkt-line pack >in <<-EOF &&
> > +=09$(write_command fetch)
> > +=090001
> > +=09no-progress
> > +=09want-ref refs/heads/ns-no
> > +=09have $oid
> > +=09done
> > +=090000
> > +=09EOF
> > +
> > +=09test_must_fail env GIT_NAMESPACE=3Dns test-tool -C "$REPO" serve-v2=
 --stateless-rpc >out <in &&
> > +=09grep "unknown ref" out
> > +'
>
> For the failure tests, it's safer to write them in pairs - one that
> succeeds and one that fails. Here, a typo in "ns-no" (e.g. if I wrote
> "ns-noo" instead) would cause the exact same result, but if we were to
> write a pair of tests, we wouldn't have this problem.

That's a good suggestion. However, I'm having some difficulties finding jus=
t the
right amount of common code to extract due to

a. having to pass the namespace via env instead of --namespace (and the
   different position for the success / test_must_fail cases), and
b. having to rely on _persistent_ config for hideRefs, as opposed to being =
able
   to pass it via -c to upload-pack (ie. I'm worried about tests breaking i=
f
   they get reordered)

So I'm not exactly happy with what I came up with for v3, but I'd also be
reluctant to add --namespace / -c support to test-tool as part of this patc=
h.
Let me know what you think.


> > diff --git a/upload-pack.c b/upload-pack.c
> > index 297b76fcb4..c897802f1c 100644
> > --- a/upload-pack.c
> > +++ b/upload-pack.c
> > @@ -1417,21 +1417,24 @@ static int parse_want_ref(struct packet_writer =
*writer, const char *line,
> >  =09=09=09  struct string_list *wanted_refs,
> >  =09=09=09  struct object_array *want_obj)
> >  {
> > -=09const char *arg;
> > -=09if (skip_prefix(line, "want-ref ", &arg)) {
> > +=09const char *refname_nons;
> > +=09if (skip_prefix(line, "want-ref ", &refname_nons)) {
> >  =09=09struct object_id oid;
> >  =09=09struct string_list_item *item;
> >  =09=09struct object *o;
> > +=09=09struct strbuf refname =3D STRBUF_INIT;
>
> "refname" needs to be released somewhere.

Yeap :/

