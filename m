Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D0AC433F5
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 14:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345638AbiBKO4z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 09:56:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242929AbiBKO4y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 09:56:54 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BF8131
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 06:56:51 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id t36so5890948pfg.0
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 06:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=coup.net.nz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zpMAH3uy0TKW8B8F4XA3YHVybRXw8DijFr2Fc238zXg=;
        b=P5Gqi+DR3iLB3DyeK8QPufd5z//O1MHilq86VpZt4nMfuh6bUNpTYOMj7xtPUgkTFq
         ilVybm+shW6ukozvCqPBKFLHpj/sMAKs/YivSysahr6mMi6Ate36xd3RgYSuvEdYzExZ
         UA9ipqbh2my8B0FYPNEZewIt8svvHOmM2BBbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zpMAH3uy0TKW8B8F4XA3YHVybRXw8DijFr2Fc238zXg=;
        b=Aldom+vbIWoNb6KMTFNSllw36VRa/wyoxo/q1rFDsIJnsREg7ORolpYgNGim8tVOug
         y/p1zyvAll06zSKpAnLqTvprAojMx4Ppo/4He2I2svdK7okIJqMH9ql0s5Wf/IDQnyQO
         l6uF7ixShEbiiO8l3LxAfiRCm4ufmhfXPdPFv66XktRZaDX5CV5cKp3C6KW3viF5STWk
         vAFr/8YXvoIfMssOHex9AxcO3n6UoPIp3MyPwsphlMys2JGLiyCovEgYu7GQy7ARrm1H
         1zUaTHhSOIgDQeSKNQpnP+JAH2yPKxKkOSdHi9EexywFCZV3ukJu9fR3v2R+7dyrUVOx
         jgUQ==
X-Gm-Message-State: AOAM531DA2mw+hZYF5pJ1LVqupeEw7eZcbU3c4trg5XV4Ka8krC2PEKj
        fpPJdoRhacUh69bXwuOFzspXomVg7V0MkrImjluoUyjdiCn6KA==
X-Google-Smtp-Source: ABdhPJxjF9RKtu0GDvULbaX4ApCA0ogESfTMgd7lSvhHeQTxB1AqKHvwAJH9hsDtsq1G8IrRdfa4xcCIJtRXE9fj1qc=
X-Received: by 2002:a05:6a00:1345:: with SMTP id k5mr1997748pfu.29.1644591411203;
 Fri, 11 Feb 2022 06:56:51 -0800 (PST)
MIME-Version: 1.0
References: <a3c1999936d241fdec2a958cd5a4ebc21f4c7aec.1643730593.git.gitgitgadget@gmail.com>
 <20220204180230.2346654-1-jonathantanmy@google.com>
In-Reply-To: <20220204180230.2346654-1-jonathantanmy@google.com>
From:   Robert Coup <robert@coup.net.nz>
Date:   Fri, 11 Feb 2022 14:56:40 +0000
Message-ID: <CACf-nVePhtm_HAzAKzcap0E8kiyyEJPY_+N+bbPcYPVUkjweFg@mail.gmail.com>
Subject: Re: [PATCH 2/6] fetch-pack: add partial clone refiltering
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     gitgitgadget@gmail.com, git@vger.kernel.org, stolee@gmail.com,
        me@ttaylorr.com, christian.couder@gmail.com, johncai86@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

Thanks for taking a look at this.

On Fri, 4 Feb 2022 at 18:02, Jonathan Tan <jonathantanmy@google.com> wrote:
>
> The approach that I would have expected is to not call
> mark_complete_and_common_ref(), filter_refs(), everything_local(), and
> find_common(), but your approach here is to ensure that
> mark_complete_and_common_ref() and find_common() do not do anything.

v0: find_common() definitely still does something: during refiltering it sk=
ips
checking the local object db, but it's still responsible for sending
the "wants".

filter_refs() is necessary under v0 & v2 so the remote refs all get marked =
as
matched, otherwise we end up erroring after the transfer with
"error: no such remote ref refs/heads/main" etc.

> Comparing the two approaches, the advantage of yours is that we only
> need to make the change once to support both protocol v0 and v2
> (although the change looks more substantial than just skipping function
> calls), but it makes the code more difficult to read in that we now have
> function calls that do nothing. What do you think about my approach?

My original approach was to leave the negotiator in place, and just conditi=
onal
around it in do_fetch_pack_v2 =E2=80=94 this worked ok for protocol v2 but =
the v0
implementation didn't work. After that I switched to forcing noop in [1/6]
which made both implementations match (& tidier imo).

To make the test pass and skip those calls I need a patch like the below
=E2=80=94 filter_refs() is still required during refiltering for the ref-ma=
tching. To me
this looks more complicated, but I'm happy to defer to your thinking.

Thanks,

Rob :)


diff --git a/fetch-pack.c b/fetch-pack.c
index dd67044165..870bfba267 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1125,15 +1125,16 @@ static struct ref *do_fetch_pack(struct
fetch_pack_args *args,
        negotiator =3D &negotiator_alloc;
        if (is_refiltering) {
                fetch_negotiator_init_noop(negotiator);
+               filter_refs(args, &ref, sought, nr_sought);
        } else {
                fetch_negotiator_init(r, negotiator);
-       }

-       mark_complete_and_common_ref(negotiator, args, &ref);
-       filter_refs(args, &ref, sought, nr_sought);
-       if (!is_refiltering && everything_local(args, &ref)) {
-               packet_flush(fd[1]);
-               goto all_done;
+               mark_complete_and_common_ref(negotiator, args, &ref);
+               filter_refs(args, &ref, sought, nr_sought);
+               if (everything_local(args, &ref)) {
+                       packet_flush(fd[1]);
+                       goto all_done;
+               }
        }
        if (find_common(negotiator, args, fd, &oid, ref) < 0)
                if (!args->keep_pack)
@@ -1615,13 +1616,18 @@ static struct ref *do_fetch_pack_v2(struct
fetch_pack_args *args,
                        if (args->depth > 0 || args->deepen_since ||
args->deepen_not)
                                args->deepen =3D 1;

-                       /* Filter 'ref' by 'sought' and those that
aren't local */
-                       mark_complete_and_common_ref(negotiator, args, &ref=
);
-                       filter_refs(args, &ref, sought, nr_sought);
-                       if (!args->refilter && everything_local(args, &ref)=
)
-                               state =3D FETCH_DONE;
-                       else
+                       if (args->refilter) {
+                               filter_refs(args, &ref, sought, nr_sought);
                                state =3D FETCH_SEND_REQUEST;
+                       } else {
+                               /* Filter 'ref' by 'sought' and those
that aren't local */
+
mark_complete_and_common_ref(negotiator, args, &ref);
+                               filter_refs(args, &ref, sought, nr_sought);
+                               if (everything_local(args, &ref))
+                                       state =3D FETCH_DONE;
+                               else
+                                       state =3D FETCH_SEND_REQUEST;
+                       }

                        mark_tips(negotiator, args->negotiation_tips);
                        for_each_cached_alternate(negotiator,
