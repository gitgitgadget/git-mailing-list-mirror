Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A313E2022A
	for <e@80x24.org>; Thu, 27 Oct 2016 02:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933981AbcJ0CmO (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 22:42:14 -0400
Received: from homie.mail.dreamhost.com ([208.97.132.208]:57830 "EHLO
        homiemail-a9.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933903AbcJ0CmN (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 26 Oct 2016 22:42:13 -0400
Received: from homiemail-a9.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a9.g.dreamhost.com (Postfix) with ESMTP id 17E695BE066;
        Wed, 26 Oct 2016 19:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=
        mattmccutchen.net; bh=TVXrhm2EDTXGKQfT55xV1vAyiyA=; b=qasuz/ZyJ5
        istMz5hfQSUOH1Fbax45DNvWg5lpyLsNVAKgmTjAbtQmfzb3NmVa5/y6P2e2DTUI
        scCPmenZmyM7ZS3G1rOF3daj0vVv1lNBnCegDhB9vUooa83AhkYZ1dGnxnCrS1QN
        CqIuMFFqeVoO5MBUtTtU6PwVSpu1UF2Sg=
Received: from main (c-50-177-20-184.hsd1.ma.comcast.net [50.177.20.184])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: matt@mattmccutchen.net)
        by homiemail-a9.g.dreamhost.com (Postfix) with ESMTPSA id 929545BE064;
        Wed, 26 Oct 2016 19:42:12 -0700 (PDT)
Message-ID: <1477536130.1570.10.camel@mattmccutchen.net>
Subject: Re: "git subtree --squash" interacts poorly with revert, merge, and
 rebase
From:   Matt McCutchen <matt@mattmccutchen.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Date:   Wed, 26 Oct 2016 22:42:10 -0400
In-Reply-To: <CAGZ79kb1bb5e5hKpnkFqLOsPow5xt8zczWmZNxMMt5nA84tf-w@mail.gmail.com>
References: <1477523244.2764.114.camel@mattmccutchen.net>
         <CAGZ79kaw0s_PC2AstRVwFT8N1CJVC_7yQfC19zPzRjAqkSpMDg@mail.gmail.com>
         <1477533150.2764.147.camel@mattmccutchen.net>
         <CAGZ79kb1bb5e5hKpnkFqLOsPow5xt8zczWmZNxMMt5nA84tf-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2016-10-26 at 19:03 -0700, Stefan Beller wrote:
> On Wed, Oct 26, 2016 at 6:52 PM, Matt McCutchen <matt@mattmccutchen.net=
> wrote:
> > 4. I pushed several dangling submodule pointers before I learned I
> > could set push.recurseSubmodules =3D check.=C2=A0=C2=A0This isn't the=
 default; each
> > developer has to do it manually.=C2=A0=C2=A0(In theory, I could put s=
uch things
> > in a setup script for them to run if they trust me.)
>=20
> There is a current series in flight/for review that makes "check" defau=
lt.
> (It is blocked as check has some performance issues when having lots
> of commits to be pushed, so it may take a while and not show up in the
> next release)

Great! =C2=A0One other thing: IIRC, "check" does not distinguish between
different remotes. =C2=A0For example, suppose I fork a project that alrea=
dy
has a submodule and I have a pair of repositories that pull from the
"upstream" repositories and push to "origin" repositories for my
project. =C2=A0Suppose I upgrade to a new upstream version and find that =
I'm
(temporarily) able to use the upstream submodule without modifications.
=C2=A0The "check" feature won't stop me from pushing a pointer into the
"origin" superproject that points to a commit that exists in the
"upstream" subproject but not the "origin" subproject.

> > 5. Stashing changes to both the superproject and the subproject takes
> > more steps.
>=20
> True, so you'd want to have a `git stash --recurse-submodules=3D{yes,no=
}`
> where the command line option is configurable, so you don't have to typ=
e
> it all the time?

Sounds good. =C2=A0I'm sure you realize this is not just a matter of runn=
ing
"git stash" in each submodule because there are many ways the stash
stacks could get out of lockstep. =C2=A0The submodule content needs to be
incorporated into the superproject stash.

> Thanks for pointing out the issues though. they align to what
> we plan on doing for submodules, so ... the plan actually makes
> sense :)

Again, I'm thrilled you're working on this, even if I don't use it on
my current project.

Matt
