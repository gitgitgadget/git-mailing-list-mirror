Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F31CC4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 21:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4764D60F4A
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 21:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbhG3VId (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 17:08:33 -0400
Received: from mail-40131.protonmail.ch ([185.70.40.131]:55131 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbhG3VIa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 17:08:30 -0400
Date:   Fri, 30 Jul 2021 21:08:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eagain.st;
        s=protonmail; t=1627679302;
        bh=rvi927yGMQv/8/zevaKkexuBFi++nQOs0usc/zwU+D8=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=fh7hSc2kbuVBnk94KvWnwt4z55BnhpDqpJjMopKEzqB2RDyWcOFoCXAOjG9qwnmx6
         yxyw3ktfbzef6CSlcWY79WAVZoGsMQMz2i3r+u5M9FrTX096nrvgheA9lgx+V3VDY9
         W6S3sATLAEhAiBCyJsyt31gnLK0+46tILdtG+fNm4kT+jdS0KiqwmdVxJiBv9xLWjJ
         0exe6nkAYkxnCwPmExEbIm1eUZ/K7RkS+GqWy1yrToGZOrOgttgr0y4jBep0u5/cxl
         ee5AQgmX7NNzvnGnJ1OBgOEc2DXBj3NhzLE6knZQjovgFS0gxc1vvs+kzvY66onswu
         FwKB5WndFziUw==
To:     Junio C Hamano <gitster@pobox.com>
From:   Kim Altintop <kim@eagain.st>
Cc:     git@vger.kernel.org, Brandon Williams <bwilliams.eng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Reply-To: Kim Altintop <kim@eagain.st>
Subject: Re: [PATCH] upload-pack.c: treat want-ref relative to namespace
Message-ID: <CD6S5MUMEIW3.3ULMDKKSQ92UW@schmidt>
In-Reply-To: <xmqqbl6j1vgh.fsf@gitster.g>
References: <20210730135845.633234-1-kim@eagain.st> <xmqqbl6j1vgh.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri Jul 30, 2021 at 8:57 PM CEST, Junio C Hamano wrote:
>
> Kim Altintop <kim@eagain.st> writes:
[..]
> > Also check if the wanted ref is hidden via 'hideRefs', and respond with
> > an error otherwise. It was previously possible to request any ref, but
> > note that this is still the case unless 'hideRefs' is in effect.
[..]
> Nicely described. I have a question on the last sentence, though.
> Do you mean that any ref can be requested when a namespace is in
> use, as long as 'hideRefs' is not in effect? What does "any ref"
> exactly mean---even thouse outside the given namespace (and if so
> how?)

Thank you. It seems like I got confused for a moment when writing the commi=
t
message. It's not possible to get a ref outside the namespace anymore. I re=
moved
that sentence.

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
> > +    git -C "$REPO" config uploadpack.allowRefInWant true &&
> > +    git -C "$REPO" config transfer.hideRefs refs/heads/hidden
> > +'
>
> I wonder why the last two are outside the subshell? IOW, you could
> have configured the newly created repository while you were still in
> there.

To be honest, I don't know. I did that because the other repo setups in tha=
t
file follow the same pattern, I suppose that qualifies as "cargo culting". =
Happy
to remove the subshell, unless others point out that there is some specific
reason for it.

> Unless you mean to make all subsequent tests to be done inside the
> 'ns' namespace, and even when you do, you do not want to do this
> in order to keep each test as independent as possible (iow, make
> some of them skippable without affecting the later tests). Run the
> final test in a subshell, e.g.
>
> oid=3D$(git -C "$REPO" rev-parse c) &&
> test-tool pkt-line pack >in <<-EOF &&
> ...
> EOF
>
> (
> export GIT_NAMESPACE=3Dns &&
> test-tool ... >out <in
> ) &&
> check_output
>
> or if the command you want to run with a custom environment variable
> is a single external executable like this case, do
>
> oid=3D$(git -C "$REPO" rev-parse c) &&
> test-tool pkt-line pack >in <<-EOF &&
> ...
> EOF
> GIT_NAMESPACE=3Dns test-tool ... >out <in &&
> check_output
>
> That way, the environment will be kept clean without GIT_NAMESPACE
> outside the invocation of test-tool.
>
> Note that you cannot use this technique directly with test_must_fail
> which is *not* an external executable but is a shell function.
>
> test_must_fail env GIT_NAMESPACE=3Dns test-tool ...
>
> would be the way to write a step that must fail.


Ah thanks! I had tried

...
GIT_NAMESPACE=3Dns test-tool ... >out <in


but the linter complained about this without giving a hint as to what the f=
ix
would be. It turns out that "env" works, ie.

...
env GIT_NAMESPACE=3Dns test-tool ...
test_must_fail env GIT_NAMESPACE=3Dns test-tool ...


>
> > diff --git a/upload-pack.c b/upload-pack.c
> > index 297b76fcb4..008ac75125 100644
> > --- a/upload-pack.c
> > +++ b/upload-pack.c
> > @@ -1417,21 +1417,24 @@ static int parse_want_ref(struct packet_writer =
*writer, const char *line,
> >  =09=09=09  struct string_list *wanted_refs,
> >  =09=09=09  struct object_array *want_obj)
> >  {
> > -=09const char *arg;
> > +=09const char *refname_nons;
> >  =09if (skip_prefix(line, "want-ref ", &arg)) {
>
> Don't you receive the result in refname_nons here, as arg is no
> longer there?

Ouch. Will fix.

>
> >  =09=09struct object_id oid;
> >  =09=09struct string_list_item *item;
> >  =09=09struct object *o;
> > +=09=09struct strbuf refname =3D STRBUF_INIT;
> >
> > -=09=09if (read_ref(arg, &oid)) {
> > -=09=09=09packet_writer_error(writer, "unknown ref %s", arg);
> > -=09=09=09die("unknown ref %s", arg);
> > +=09=09strbuf_addf(&refname, "%s%s", get_git_namespace(), refname_nons)=
;
> > +=09=09if (ref_is_hidden(refname_nons, refname.buf) ||
> > +=09=09    read_ref(refname.buf, &oid)) {
> > +=09=09=09packet_writer_error(writer, "unknown ref %s", refname_nons);
> > +=09=09=09die("unknown ref %s", refname.buf);
> >  =09=09}
>
> OK. Assuming that it makes sense for the hideRefs mechanism to kick
> in here (which I would prefer to hear from others who've worked with
> this code, say Jonathan Tan?), the updated code makes sense.

I have also updated the code for the v2 to use refname_nons for any die() c=
alls,
as I realised that this may be transmitted to the client via sideband (is t=
hat
correct?).

