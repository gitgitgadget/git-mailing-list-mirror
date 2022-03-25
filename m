Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693B3C433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 01:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357684AbiCYBqe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 21:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357762AbiCYBpu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 21:45:50 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E86515BB
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 18:41:18 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 99C5212F3B1;
        Thu, 24 Mar 2022 21:41:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=drpvhbccMetb
        1VFdEuJH9giZtBTObcXviTWSnp9dXEY=; b=cNbnrmcyvrllWgX6AwguBLVd7LZw
        P2tgClYRXDzbkeLHffyOQZfS62ZSo25i3eb2+eXJPtxQC9Z+tKof1TKAJCD+7dQG
        GvItUP4qgneZBMKPgNAme9ln23APHuzrDIePAN8tp3lQFXaniEwhoXeSmNS/Nmmi
        1d5sTtWAH9M8rWU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 90D2812F3B0;
        Thu, 24 Mar 2022 21:41:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0013A12F3AF;
        Thu, 24 Mar 2022 21:41:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 00/27] revision.[ch]: add and use release_revisions()
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
        <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
Date:   Thu, 24 Mar 2022 18:41:15 -0700
In-Reply-To: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 23 Mar
 2022 21:31:50
        +0100")
Message-ID: <xmqqa6dedd1g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A9B7B356-ABDC-11EC-B300-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This is a re-roll of the v1 of [1] now that 7391ecd338e (Merge branch
> 'ds/partial-bundles', 2022-03-21) has landed, which it had a conflict
> with. I believe this v2 addresses all the feedback brought up on v1.

Thanks.  It was mostly a pleasant read but with a huge caveat---I
have no confidence in the code that would not try to release what it
did not allocate (simply because I do not have time to audit all
allocations to various members of rev-info structure).  But at least
if we try to free something we borrowed from say command line, we'd
immediately get a crash so with enough cooking and guinea-pig testing,
such a bug would be easy to catch.

I suspect cmd_show() still is leaky when fed a few commits.

    int cmd_show(int argc, const char **argv, const char *prefix)
    {
            struct rev_info rev;
            struct object_array_entry *objects;
            struct setup_revision_opt opt;
            struct pathspec match_all;
            int i, count, ret =3D 0;

            init_log_defaults();
            git_config(git_log_config, NULL);

            memset(&match_all, 0, sizeof(match_all));
            repo_init_revisions(the_repository, &rev, prefix);
            ...
            cmd_log_init(argc, argv, prefix, &rev, &opt);

            if (!rev.no_walk)
                    return cmd_log_deinit(cmd_log_walk(&rev), &rev);

At this point, we only have positive objects in pending and rev.no_walk
is set.

            count =3D rev.pending.nr;
            objects =3D rev.pending.objects;

We grab .objects and we "show" each one of them.

            for (i =3D 0; i < count && !ret; i++) {
                    struct object *o =3D objects[i].item;
                    const char *name =3D objects[i].name;
                    switch (o->type) {
                    ...

There are ways to show different types of objects, but what we are
interested in is what happens to commits.

                    case OBJ_COMMIT:
                            rev.pending.nr =3D rev.pending.alloc =3D 0;
                            rev.pending.objects =3D NULL;

We clear pending.objects because we want to reuse the rev_info we
already have here (things like "git show -U8 master maint" is harder
to do if we do not allow the reuse), and push this single commit to
the pending array, and let log_walk() machinery to "show" it (note
that we do not "walk", as we have the .no_walk bit set).

                            add_object_array(o, name, &rev.pending);
                            ret =3D cmd_log_walk(&rev);

After we are done with this "traversal" of a single object, we
process another element in the original "objects" list, which was
taken from the original rev.pending.objects[] array, and we can keep
going, because nobody else has access to objects[] array.

I do not offhand recall what other members of rev_info
cmd_log_walk() touches, but we are not clearing them.  Not clearing
rev.pending.objects here means we can be leaking the newly created
one-element object array to hold this single object 'o', UNLESS it
is the last object in the original objects[] array.

                            break;
                    default:
                            ret =3D error(_("unknown type: %d"), o->type)=
;
                    }
            }

And even worse, we used to free objects[] here, but we no longer do.
Instead we let cmd_log_deinit() clear rev.pending.objects[], which
is the same as objects[] if and only if there are NO commit objects
on the command line.  If there is even one commit object on the
command line, we would have cleared rev.pending.objects and created
a new one, which is what is cleared by the call to cmd_log_deinit().
The original one, pointed by the local variable objects[], is no
longer freed.

            return cmd_log_deinit(ret, &rev);
    }
