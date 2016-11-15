Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B62142021E
	for <e@80x24.org>; Tue, 15 Nov 2016 17:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933399AbcKORdK (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 12:33:10 -0500
Received: from homie.mail.dreamhost.com ([208.97.132.208]:41145 "EHLO
        homiemail-a14.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753175AbcKORdI (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 15 Nov 2016 12:33:08 -0500
Received: from homiemail-a14.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a14.g.dreamhost.com (Postfix) with ESMTP id 07D0C392078;
        Tue, 15 Nov 2016 09:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version; s=mattmccutchen.net; bh=w2g+rdUTY4zT
        jypv/Vx0dZg0jqw=; b=lgD46pdCPLjzBpJkEhtOomMV2XOHm0QGUzdOu9KrXnzf
        ZnLmNN8OT5/Usqt8Wb0Yoml9BnXSr4vg3HQR2/ZKHTEXgo2Utmto10NZwGbAwxWb
        rWzWJQYNW3M5QqcvelFI0ELdgCWF9YMRDeSa54uEiayfK4g1ARlwySdrq2n2JYk=
Received: from main (30-10-119.wireless.csail.mit.edu [128.30.10.119])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: matt@mattmccutchen.net)
        by homiemail-a14.g.dreamhost.com (Postfix) with ESMTPSA id AE407392077;
        Tue, 15 Nov 2016 09:33:07 -0800 (PST)
Message-ID: <1479231184.2406.88.camel@mattmccutchen.net>
Subject: Re: Protecting old temporary objects being reused from concurrent
 "git gc"?
From:   Matt McCutchen <matt@mattmccutchen.net>
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Date:   Tue, 15 Nov 2016 12:33:04 -0500
In-Reply-To: <20161115170634.ichqrqbhmpv2dsiw@sigill.intra.peff.net>
References: <1479219194.2406.73.camel@mattmccutchen.net>
         <20161115170634.ichqrqbhmpv2dsiw@sigill.intra.peff.net>
Content-Type: multipart/mixed; boundary="=-A62Pv5gZSTYjVqzwBUrZ"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--=-A62Pv5gZSTYjVqzwBUrZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2016-11-15 at 12:06 -0500, Jeff King wrote:
> =C2=A0- when an object write is optimized out because we already have t=
he
> =C2=A0=C2=A0=C2=A0object, git will update the mtime on the file (loose =
object or
> =C2=A0=C2=A0=C2=A0packfile) to freshen it

FWIW, I am not seeing this happen when I do "git read-tree --prefix"
followed by "git write-tree" using the current master (3ab2281). =C2=A0Se=
e
the attached test script.

> If you have long-running data (like, a temporary index file that might
> literally sit around for days or weeks) I think that is a potential
> problem. And the solution is probably to use refs in some way to point
> to your objects.

Agreed. =C2=A0This is not my current scenario.

> If you're worried about a short-term operation where
> somebody happens to run git-gc concurrently, I agree it's a possible
> problem, but I suspect something you can ignore in practice.
>=20
> For the most part, a lot of the client-side git tools assume that one
> operation is happening at a time in the repository. And I think that
> largely holds for a developer working on a single clone, and things jus=
t
> work in practice.
>=20
> Auto-gc makes that a little sketchier, but historically does not seem t=
o
> have really caused problems in practice.

OK. =C2=A0I'll write a patch to add a summary of this information to the
git-gc man page.

Matt
--=-A62Pv5gZSTYjVqzwBUrZ
Content-Type: application/x-shellscript;
	name="test-git-read-tree-write-tree-touch-object.sh"
Content-Disposition: attachment; filename="test-git-read-tree-write-tree-touch-object.sh"
Content-Transfer-Encoding: base64

IyEvYmluL2Jhc2gKc2V0IC1lIC14CgpybSAtcmYgdGVzdC1yZXBvCmdpdCBpbml0IHRlc3QtcmVw
bwpjZCB0ZXN0LXJlcG8KZWNobyBmb28gPmZvbwpnaXQgYWRkIGZvbwpnaXQgY29tbWl0IC1tICdz
dWJwcm9qZWN0JwpnaXQgYnJhbmNoIC1tIHN1YgoKZ2l0IGNoZWNrb3V0IC0tb3JwaGFuIG1hc3Rl
cgpnaXQgcm0gLXJmIC4KZ2l0IHJlYWQtdHJlZSAtLXByZWZpeD1zdWIvIHN1Ygp0cmVlX2lkPSIk
KGdpdCB3cml0ZS10cmVlKSIKb2JqX3BhdGg9LmdpdC9vYmplY3RzLyR7dHJlZV9pZDowOjJ9LyR7
dHJlZV9pZDoyOjM4fQpzdGF0IC0tZm9ybWF0PSclbiAleScgIiRvYmpfcGF0aCIKCnNsZWVwIDIK
Z2l0IHJtIC1yZiAuCmdpdCByZWFkLXRyZWUgLS1wcmVmaXg9c3ViLyBzdWIKdHJlZV9pZD0iJChn
aXQgd3JpdGUtdHJlZSkiCm9ial9wYXRoPS5naXQvb2JqZWN0cy8ke3RyZWVfaWQ6MDoyfS8ke3Ry
ZWVfaWQ6MjozOH0Kc3RhdCAtLWZvcm1hdD0nJW4gJXknICIkb2JqX3BhdGgiCg==


--=-A62Pv5gZSTYjVqzwBUrZ--

