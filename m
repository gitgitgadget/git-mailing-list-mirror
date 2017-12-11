Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3AF71F404
	for <e@80x24.org>; Mon, 11 Dec 2017 20:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752161AbdLKUf3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 15:35:29 -0500
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:53312 "EHLO
        homiemail-a11.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752126AbdLKUf1 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2017 15:35:27 -0500
Received: from homiemail-a11.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a11.g.dreamhost.com (Postfix) with ESMTP id 6F7A8314C069;
        Mon, 11 Dec 2017 12:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:cc:date:in-reply-to:references:content-type
        :mime-version:content-transfer-encoding; s=novalis.org; bh=lFuvP
        jOTyvBN35Qfj4zF72xVMzY=; b=bPGbIBfHZbM4+GduWGI3geplM1nkjVkvcXZoj
        5wXiS+0u5gtOZcKvOkOxXQIlaikD4IAyHgrzaEhao70Rqlxpm0i7/6293kDpIsqQ
        s1srhn991veXsWSIpiU4kRWcoXr9PFJAujBwf64wKbBbWgBNZeRIPVjSfRWySunX
        o6KdEw=
Received: from corey (unknown [38.27.161.17])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a11.g.dreamhost.com (Postfix) with ESMTPSA id DB91F314C066;
        Mon, 11 Dec 2017 12:35:25 -0800 (PST)
Message-ID: <1513024524.10716.8.camel@novalis.org>
Subject: Re: submodule modify/delete wrong message
From:   David Turner <novalis@novalis.org>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, brock.peabody@gmail.com
Date:   Mon, 11 Dec 2017 15:35:24 -0500
In-Reply-To: <CAGZ79kZVm7ZgnqBFnKd8L51Uy+5_7DOttUMAU=qofN3XXD94nQ@mail.gmail.com>
References: <1512423580.9882.405.camel@novalis.org>
         <CAGZ79kZVm7ZgnqBFnKd8L51Uy+5_7DOttUMAU=qofN3XXD94nQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2017-12-11 at 12:27 -0800, Stefan Beller wrote:
> On Mon, Dec 4, 2017 at 1:39 PM, David Turner <novalis@novalis.org>
> wrote:
> > When merging with a submodule modify/delete conflict (i.e. I've
> > deleted
> > the submodule, and I'm merging in a branch that modified it), git
> > lies
> > about what it is doing:
> >=20
> > "CONFLICT (modify/delete): submodule deleted in HEAD and modified
> > in
> > submodules.
>=20
> Up to here the error message sounds correct, still?

Yep!

> > Version submodules of submodule left in tree at
> > submodule~submodules.
> > Automatic merge failed; fix conflicts and then commit the result."
>=20
> This sounds as if the code assumed to handle only files.

This assumption is unfortunately very common -- I just filed a PR to
fix an instance of this in libgit2.

> > In fact, the working tree does not contain anything named
> > 'submodule~submodules'.
> >=20
> > In addition, I would ordinarily resolve a conflict like this by
> > using
> > 'git rm'. Here, this gives a warning:
> >=20
> > $ git rm submodule
> > submodule: needs merge
>=20
> (Regarding submodule merges in general:)
>=20
> Uh. We cannot add merge markers to a submodule or such.
> More importantly we'd have to ask the question if the merge conflict
> is on the superproject level (Choose one of the commits of the
> submodule)
> or on the submodule level (perform a merge in the submodule between
> the
> two commits) or some hybrid approach thereof.

Yeah, that's a tricky thing in general.  In this case, tho, the
submodule is being removed, so git rm should work.

> > rm 'submodule'
> > warning: Could not find section in .gitmodules where path=3Dsubmodule
>=20
> The deletion of the submodule removed the .gitmodules entry, and the
> merge of the .gitmodules file presumably went fine. :/

Indeed.

> I assume we need a special merge driver for the .gitmodules file to
> keep
> the submodule around when it is in at least one side.
>=20
> > Git's behavior here is significantly better than liggit2's (which
> > tries
> > to check out 'submodule' as if it were a blob, and fails to do so),
> > but
> > it's still confusing.
> >=20
> > It's not clear to me what the correct behavior is here.=C2=A0=C2=A0Ma=
ybe it's
> > sufficient to just fix the message?
>=20
> I think the first step is to fix the message to reflect reality.
>=20
> As alluded to above, I don't know what the correct merge
> behavior is (and where to put 'conflict markers').

The only case we need 'conflict markers' is in the
{add,modify}/{add,modify} case (with different versions on each side).=20
The delete/* and */delete case can be handled more simply.  We might
not want to do this until we can handle all cases -- but personally, I
think a half-solution is better than a non-solution.

