Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D293BC2D0BF
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 19:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED8320836
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 19:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kth.se header.i=@kth.se header.b="k8/9jdri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfLJT4L (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 14:56:11 -0500
Received: from smtp-4.sys.kth.se ([130.237.48.193]:49034 "EHLO
        smtp-4.sys.kth.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfLJT4L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 14:56:11 -0500
X-Greylist: delayed 482 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Dec 2019 14:56:09 EST
Received: from smtp-4.sys.kth.se (localhost.localdomain [127.0.0.1])
        by smtp-4.sys.kth.se (Postfix) with ESMTP id 712ED2A90
        for <git@vger.kernel.org>; Tue, 10 Dec 2019 20:48:05 +0100 (CET)
X-Virus-Scanned: by amavisd-new at kth.se
Received: from smtp-4.sys.kth.se ([127.0.0.1])
        by smtp-4.sys.kth.se (smtp-4.sys.kth.se [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id l8vqXTajsKEF for <git@vger.kernel.org>;
        Tue, 10 Dec 2019 20:48:04 +0100 (CET)
X-KTH-Auth: dbosk [158.174.118.36]
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kth.se; s=default;
        t=1576007284; bh=GH9Ncta3RZD/hW9XKerFldK7Z+RfFqeBFdY0f1W3gnk=;
        h=Date:From:To:Subject;
        b=k8/9jdriAFCiwKBCSDxsxhgVrnmQDFFtIlEhBNdmzLBF90YQ3mUWGqFPA4u3BORex
         h3MFVmL9uEJ7jthb93zQYAIZcV1RhJwabemRTBteigeYA4f8LWpxx5D2eqkP9yyIIB
         SelJwaXpThkCsH9ag4H5vNRioqfoMSvKBhpzlMb8=
X-KTH-mail-from: dbosk@kth.se
X-KTH-rcpt-to: git@vger.kernel.org
Received: from t440s (h-118-36.A465.priv.bahnhof.se [158.174.118.36])
        by smtp-4.sys.kth.se (Postfix) with ESMTPSA id 768EF45A
        for <git@vger.kernel.org>; Tue, 10 Dec 2019 20:48:04 +0100 (CET)
Date:   Tue, 10 Dec 2019 20:48:03 +0100
From:   Daniel Bosk <dbosk@kth.se>
To:     git@vger.kernel.org
Subject: merge branch with updated submodule leaves repo in modified state
Message-ID: <20191210194803.emsvjibq3jyjkjrx@t440s>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w3srcgzq6wowg5cy"
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--w3srcgzq6wowg5cy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all!

`git merge`: if a submodule is updated in the merged branch, the new=20
version is not checked out after the merge. Is this correct behaviour?

`git switch` correctly updates the submodules when switching between the=20
branches. I would expect `git merge` to leave the things in the most=20
up-to-date state.

I tested this with the following settings.

  $ git version
  git version 2.24.0

  $ git config -l
  push.default=3Dmatching
  diff.submodule=3Dlog
  diff.colorwords=3Dtrue
  diff.algorithm=3Dminimal
  diff.exit-code=3Dtrue
  commit.gpgsign=3Dtrue
  submodule.fetchjobs=3D0
  submodule.recurse=3Dtrue
  log.follow=3Dtrue
  =20
MWE:

```
mkdir repoA repoB

# init repos with READMEs
cd repoA
git init
echo "A" > README
git add README
git commit -m "Adds repoA README" README

cd ../repoB
git init
echo "B" > README
git add README
git commit -m "Adds repoB README" README

# construct nested structure: repoA/repoB
cd ../repoA
git submodule add ../repoB/.git
git commit -m "Adds repoB submodule"

# update repoB in branch
git switch -c update-repoB-submodule
cd repoB
echo "B updated" > README
git commit -m "Updates repoB README" README
cd ..
git commit -m "Updates repoB submodule" repoB
```

Now, doing `git switch master` will have the correct version of repoB,=20
where `cat repoB/README` outputs "B". A `git switch update-repoB-submodule`
=66rom there will yield `cat repoB/README` output "B updated".

However, switching to master and then merging will leave repoB at the=20
old commit:
```
git switch master
git merge update-repoB-submodule
```
A `git status` says there are new commits in repoB, it's actually a=20
rewind which excludes the new commit (changing `repoB/README`), so `cat=20
repoB/README` outputs "B" instead of "B updated". It feels unintended to=20
get a repo which is in a modified state after a clean merge. Bug?

Cheers,
Daniel

--w3srcgzq6wowg5cy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE2vhBQThLHLiJRRDR8X4wAqLXj8gFAl3v9nMACgkQ8X4wAqLX
j8gMPw//ekVKy+WI29aIuK36dYQ6IRBIZtkxSUa8ojsRINL9ClwHvNJc3QQcpvZo
BWWhXDmDx8yndx/I/6l9pkL2T1/WVGJfP1WjZvs59nmqYOTSfog566jLL+gGrs5x
9hscDa12pEGZhW+MQqflubYG+kGwY06s9QA4AfeZW7E6T7nN2F3HIPo31BLvb+G4
zArGEQabZ6qMQT8pJx/XdWFjya2afvJGVDPMsDjDjTfzo4vTHbk+teb2dLyoRAK9
97x2fSi9vBlm56681pZniD1Uf20MWygQbvwyxFnK113bxVA0EiKvZVQGyFblOGuL
elhZwzYPjY5RNKSf5NYtSa4SCUEr2a0I2qb6/HItEWaZixxeMhtHd4rJefn5hjbF
uq/bgzDRZiNHCOol+NfIWqocm66lTFnQJbcl8Ch7rwwBuFO8fIbvYHnBHTmbMWex
1PYAneh4o1jMPW90IXo/Ydhu/QcfaZWqMaTvcZz8KBYY2spGhRiqMggxI8Etb8kw
Q+xuDuUnAqmTudHD+oUvnLv6g8eqLmmR7U7YW3TRnmL0QICGSTb714oKINjaKTCw
oXNxJ7hqTlHeJMDeh19TzPUPdiHqZ4fPFgNSGJCGZooRUKyEW10p+IU93srcSTzD
ICQCA4J0xIFigSEl7azcAA/M1jWeeqj0zzq5BnBPDNLlqBbmxTY=
=xJJF
-----END PGP SIGNATURE-----

--w3srcgzq6wowg5cy--
