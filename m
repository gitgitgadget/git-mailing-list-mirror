Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9326C433EF
	for <git@archiver.kernel.org>; Tue, 10 May 2022 17:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347591AbiEJRY7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 13:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347967AbiEJRYy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 13:24:54 -0400
Received: from mail1.pdinc.us (mail.pdinc.us [67.90.184.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB8E1C910
        for <git@vger.kernel.org>; Tue, 10 May 2022 10:20:47 -0700 (PDT)
Received: from blackfat (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail1.pdinc.us (8.14.4/8.14.4) with ESMTP id 24AHKfcB025380
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 10 May 2022 13:20:42 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mail1.pdinc.us 24AHKfcB025380
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1652203242; bh=rSBqftJwpU9vK0WjsNinxA5e3De1Ju85ZTTVKy1pL+8=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=IdWO30XAxViOay5byMJyCk/kjk0CihdHCaTNG5e0MSwih4Ic0RpDCKMofdRHIsyzY
         IG2Kg32tQqHyVUQfBXu3JaWBKFv/GMvZmzvkZWabL10Ec6LJQxhGouBfFt+YIO1eYl
         2cWNgz+vXPg0ZJPxthMAclZTPBOZ+zxE0Swh62ROnv/B+ZpB5GKRMIaL9VjlKMUL+h
         mW9eLO901wb0rAnGedDpjL1/l8g8f8sNQ+QCTi5lbCUCcGJZsrQdH3utoFONRqfbVp
         kLiHRA2MGXdkNlr+FumvkogOZCI4ILoHpYvfm5FqPhSPSzqk9Mbfng6fDonLQnn5/U
         Qh+Ecq6OBSvBg==
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Addison Klinke'" <addison@baller.tv>
Cc:     <git@vger.kernel.org>, "'Addison Klinke'" <agk38@case.edu>
References: <CAE9CXuhvqfhARrqz2=oS1=9BF=iNhGbJv7y3HmYs1tddn8ndiQ@mail.gmail.com> <xmqq4k1x8gqj.fsf@gitster.g>
In-Reply-To: <xmqq4k1x8gqj.fsf@gitster.g>
Subject: RE: [FR] supporting submodules with alternate version control systems (new contributor)
Date:   Tue, 10 May 2022 13:20:36 -0400
Organization: PD Inc
Message-ID: <01e601d86492$43bb70b0$cb325210$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMmAUfbvsYWpozP57O9QeLcqWKlogGoVhkBqm/bhiA=
Content-Language: en-us
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Junio C Hamano
> Sent: Tuesday, May 10, 2022 1:01 PM
> To: Addison Klinke <addison@baller.tv>
>=20
> Addison Klinke <addison@baller.tv> writes:
>=20
> > Is something along these lines feasible?
>=20
> Offhand, I only think of one thing that could make it fundamentally
> infeasible.
>=20
> When you bind an external repository (be it stored in Git or
> somebody else's system) as a submodule, each commit in the
> superproject records which exact commit in the submodule is used
> with the rest of the superproject tree.  And that is done by
> recording the object name of the commit in the submodule.
>=20
> What it means for the foreign system that wants to "plug into" a
> superproject in Git as a submodule?  It is required to do two
> things:
>=20
>  * At the time "git commit" is run at the superproject level, the
>    foreign system has to be able to say "the version I have to be
>    used in the context of this superproject commit is X", with X
>    that somehow can be stored in the superproject's tree object
>    (which is sized 20-byte for SHA-1 repositories; in SHA-256
>    repositories, it is a bit wider).
>=20
>  * At the time "git chekcout" is run at the superproject level, the
>    superproject will learn the above X (i.e. the version of the
>    submodule that goes with the version of the superproject being
>    checked out).  The foreign system has to be able to perform a
>    "checkout" given that X.
>=20
> If a foreign system cannot do the above two, then it fundamentally
> would be incapable of participating in such a "superproject and
> submodule" relationship.

The submodule "type" could create an object (hashed and stored) that =
contains the needed "translation" details. The object would be hashed =
using SHA1 or SHA256 depending on the git config. The format of the =
object's contents would be defined by the submodule's "code".


--
Jason Pyeron  | Architect
PD Inc        | Certified SBA 8(a)
10 w 24th St  | Certified SBA HUBZone
Baltimore, MD | CAGE Code: 1WVR6
=20
.mil: jason.j.pyeron.ctr@mail.mil
.com: jpyeron@pdinc.us
tel : 202-741-9397



