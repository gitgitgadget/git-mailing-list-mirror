Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DD5C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 22:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4FDC6109F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 22:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234848AbhHDWFF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 18:05:05 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:37194 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhHDWFE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 18:05:04 -0400
Date:   Wed, 04 Aug 2021 22:04:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eagain.st;
        s=protonmail; t=1628114657;
        bh=54ciCG3WhZCZVh0ny4omvuVe+acYQoUzC/+46S8JZfA=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=TmgfF/ckjDcAjSOqVlIhU1a6oE7Yu0ocrDHZUay1beAqHkRhzq63aCVEBAZfVu9Zv
         cwHoYUjAG2PHdBA+QjU6sqnM84PtdHGVLbJDdyRWANWgdvpHWwPhiO8XhVYSGx8PIt
         8WbZoAH6IW6zWEW+Djw5YYaU96W+IvRqlaV9PXhlspKbQHWIAnPUDhr9I2SZ3tkW9h
         MnUtAMkG/6JqI6O9PLrlEmdhi/qpG7vvDo5xmM2qBLGXaTjEY2f4y1BFcH2ra4xK6I
         ONX7q6HdjH0r1zZktBjTLSLdOMNpa+okFxtQOtPHsOYDhCTEfXuXhjv/UJ4uWiAqzc
         hF8WvA6H0RLlA==
To:     Junio C Hamano <gitster@pobox.com>
From:   Kim Altintop <kim@eagain.st>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bwilliams.eng@gmail.com>
Reply-To: Kim Altintop <kim@eagain.st>
Subject: Re: [PATCH v3] upload-pack.c: treat want-ref relative to namespace
Message-ID: <CDB2GX6ICZMC.1FDRFIKZU9GU6@schmidt>
In-Reply-To: <xmqq35rooqr5.fsf@gitster.g>
References: <20210730135845.633234-1-kim@eagain.st> <20210731203415.618641-1-kim@eagain.st> <20210804203829.661565-1-kim@eagain.st> <xmqq35rooqr5.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed Aug 4, 2021 at 11:15 PM CEST, Junio C Hamano wrote:
>
> Kim Altintop <kim@eagain.st> writes:
>
> > diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-r=
ef-in-want.sh
> > index e9e471621d..4a828042bb 100755
> > --- a/t/t5703-upload-pack-ref-in-want.sh
> > +++ b/t/t5703-upload-pack-ref-in-want.sh
> > @@ -298,6 +298,134 @@ test_expect_success 'fetching with wildcard that =
matches multiple refs' '
> >  =09grep "want-ref refs/heads/o/bar" log
> >  '
> >
> > +REPO=3D"$(pwd)/repo-ns"
> > +
> > +write_fetch_want_ref() {
>
> Style; missing SP before ().
>
> > +=09local wanted_ref=3D"$1"
> > +
> > +=09write_command fetch
> > +=09echo "0001"
> > +=09echo "no-progress"
> > +=09echo "want-ref $1"
> > +=09echo "done"
> > +=09echo "0000"
> > +}
>
> All other helper shell functions in this file are defined near the
> top. If we compare them with this, we notice that this does not
> check for any errors. We should string these steps together with
> "&&".
>
> Also, having this in the middle looks a bit out of place. If this
> helper is useful only in the tests that are being added by this
> patch, that may be OK, but we may want to have a preliminary
> clean-up step before the main patch that adds this helper function
> near the top (perhaps after "write_command" is defined), and use it
> in existing tests. It seems that 'invalid want-ref line', 'basic
> want-ref', and 'multiple want-ref lines' tests among others may
> benefit from a slightly expanded variant, something along the lines
> of ...
>
> write_fetch_command () {
> write_command fetch &&
> echo "0001" &&
> echo "no-progress" || return
> # want-ref ...
> # --
> # want ...
> # --
> # have ...
> # --
> while :
> do
> case $# in 0) break ;; esac &&
> case "$1" in --) shift; break ;; esac &&
> echo "want-ref $1" &&
> shift || return
> done &&
> while :
> do
> case $# in 0) break ;; esac &&
> case "$1" in --) shift; break ;; esac &&
> echo "want $1" &&
> shift || return
> done &&
> while :
> do
> case $# in 0) break ;; esac &&
> case "$1" in --) shift; break ;; esac &&
> echo "have $1" &&
> shift || return
> done &&
> echo "done" &&
> echo "0000"
> }
>
> and with something like that, an existing test like this one:
>
> test_expect_success 'mix want and want-ref' '
> oid=3D$(git rev-parse f) &&
> cat >expected_refs <<-EOF &&
> $oid refs/heads/main
> EOF
> git rev-parse e f >expected_commits &&
>
> test-tool pkt-line pack >in <<-EOF &&
> $(write_command fetch)
> 0001
> no-progress
> want-ref refs/heads/main
> want $(git rev-parse e)
> have $(git rev-parse a)
> done
> 0000
> EOF
>
> test-tool serve-v2 --stateless-rpc >out <in &&
> check_output
> '
>
> may become
>
> test_expect_success 'mix want and want-ref' '
> oid=3D$(git rev-parse f) &&
> cat >expected_refs <<-EOF &&
> $oid refs/heads/main
> EOF
> git rev-parse e f >expected_commits &&
>
> test-tool pkt-line pack >in <<-EOF &&
> $(write_fetch_command
> refs/heads/main
> --
> $(git rev-parse e)
> --
> $(git rev-parse a)
> )
> EOF
>
> test-tool serve-v2 --stateless-rpc >out <in &&
> check_output
> '
>
> And after preparing a reusable helper like that, we can add
> namespace tests using the same helper in the main patch (so it would
> become an at least 2-patch series).


Ok got it. I did not want to come forward with a grand refactoring of that =
test
in my very first patch, but since reviewers seem to think it's in order I'l=
l
give it a spin.


> > +
> > +test_expect_success 'setup namespaced repo' '
> > +=09(
> > +=09=09git init -b main "$REPO" &&
> > +=09=09cd "$REPO" &&
> > +=09=09test_commit a &&
> > +=09=09test_commit b &&
> > +=09=09git checkout a &&
> > +=09=09test_commit c &&
> > +=09=09git checkout a &&
> > +=09=09test_commit d &&
> > +=09=09git update-ref refs/heads/ns-no b &&
> > +=09=09git update-ref refs/namespaces/ns/refs/heads/ns-yes c &&
> > +=09=09git update-ref refs/namespaces/ns/refs/heads/hidden d
> > +=09) &&
> > +=09git -C "$REPO" config uploadpack.allowRefInWant true
>
> I do not see a reason why the last step wants to be done outside the
> subshell, which we would be using anyway. Does it clarify something?

I agree, but was sticking to the style that was already there. I'll then re=
vise
the other setup steps as part of the refactor.


> > +test_expect_success 'with namespace: want-ref is considered relative t=
o namespace' '
> > +=09wanted_ref=3Drefs/heads/ns-yes &&
> > +
> > +=09oid=3D$(git -C "$REPO" rev-parse $wanted_ref) &&
> > +=09cat >expected_refs <<-EOF &&
> > +=09$oid $wanted_ref
> > +=09EOF
> > +=09git -C "$REPO" rev-parse a $wanted_ref >expected_commits &&
> > +
> > +=09test-tool pkt-line pack >in <<-EOF &&
> > +=09$(write_fetch_want_ref $wanted_ref)
> > +=09EOF
> > +
> > +=09env GIT_NAMESPACE=3Dns test-tool -C "$REPO" serve-v2 --stateless-rp=
c >out <in &&
>
> I am not sure why we want "env" in front (it does not hurt, but it
> should be unnecessary, as test-tool is a plain-vanilla binary
> executable, not a shell function). Is this a workaround for a buggy
> test linter or something?

The linter did indeed ask me to write `GIT_NAMESPACE=3Dns && export GIT_NAM=
ESPACE
&& test-tool ...` in v1 of the patch, but now it doesn't... nevermind, I mu=
st
have held something the wrong way.

