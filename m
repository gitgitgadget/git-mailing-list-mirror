Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1CEC433F5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 06:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AB3C63219
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 06:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhKOG5A (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 01:57:00 -0500
Received: from woodpecker.gentoo.org ([140.211.166.183]:55120 "EHLO
        smtp.gentoo.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhKOG42 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 01:56:28 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id B2720343250
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 06:53:21 +0000 (UTC)
Received: (qmail 18438 invoked by uid 10000); 15 Nov 2021 06:53:21 -0000
Date:   Mon, 15 Nov 2021 06:53:21 +0000
From:   "Robin H. Johnson" <robbat2@gentoo.org>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [BUG] git push --mirror ignores refs outside head & tags
Message-ID: <robbat2-20211115T063838-612792475Z@orbis-terrarum.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="el2C0KVlvSdzzYTT"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--el2C0KVlvSdzzYTT
Content-Type: multipart/mixed; boundary="+pyn4tnQwIEzicSq"
Content-Disposition: inline


--+pyn4tnQwIEzicSq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

TL;DR: "git push --mirror" does not in fact push all refs, despite
documentation stating it does. It ONLY pushes refs in refs/heads/ and
refs/tags/.

I ran into this while preparing to migrate Gentoo's primary Git server
(which uses Gitolite).

Gitolite ships a post-receive hook, "save-push-signatures" [1] that save
Push certificates into refs/push-certs.

Gitolite mirroring invokes 'git push --mirror' to mirror from the
primary location to replicas.

I was surprised to find, on the new server presently configured as
replica, but intended to take over as the primary, that the
refs/push-certs was missing on every single repo.

```
# git push -h |grep -e mirror -e all
    --all                 push all refs
	--mirror              mirror all refs
```
git-push(1):
```
--mirror
    Instead of naming each ref to push, specifies that all refs under refs/=
 (which includes
    but is not limited to refs/heads/, refs/remotes/, and refs/tags/) be mi=
rrored to the
    remote repository. ...
```

git --version: 2.32.0

Attached I also include the trace ref & trace packet output as well that sh=
ows
it on a sample repo.
```
GIT_TRACE_REFS=3D/tmp/trace-refs \
GIT_TRACE_PACKET=3D/tmp/trace-packet \
git push --mirror $REPLICA:$REPO
```

The repo's gitconfig does not contain any remotes, because that's the way g=
itolite is built.

[1] https://github.com/sitaramc/gitolite/blob/master/contrib/hooks/repo-spe=
cific/save-push-signatures

--=20
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136

--+pyn4tnQwIEzicSq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=trace-packet

23:07:49.011947 pkt-line.c:80           packet:         push< bd7bd3a513c8ddc554e211316c990b5f98110982 refs/heads/bug450326\0report-status report-status-v2 delete-refs side-band-64k quiet atomic ofs-delta push-cert=1636931268-40bfd0dc11027620d3ea77024b5aa5aa90ed2342 object-format=sha1 agent=git/2.32.0
23:07:49.011987 pkt-line.c:80           packet:         push< 65c923b603247af68f1b4405363d92c1c19009eb refs/heads/bug504458
23:07:49.011993 pkt-line.c:80           packet:         push< 6e81ff9f85736180516941e630b1db78bd9bf2a2 refs/heads/iw
23:07:49.011998 pkt-line.c:80           packet:         push< e860f40ffd07a41e47a6b49d9400ad20e6a8b7ca refs/heads/master
23:07:49.012002 pkt-line.c:80           packet:         push< 56dd91ee7737dd3d4ebc57185632f407a2cdf3c1 refs/heads/remove-bash-arrays
23:07:49.012007 pkt-line.c:80           packet:         push< 09c6d951fe3c4419317fcd9488df907bd11ac02c refs/tags/0.1
23:07:49.012012 pkt-line.c:80           packet:         push< cb257cea980b74aa7dff4b7bfcfb66b82565bb01 refs/tags/0.2
23:07:49.012016 pkt-line.c:80           packet:         push< 22b3841561b0b686919be466f1caeae6833e30ba refs/tags/0.2.1
23:07:49.012021 pkt-line.c:80           packet:         push< 47d23f5abdac4a2bd95bcbbaadacf994773cbf51 refs/tags/0.2.2
23:07:49.012025 pkt-line.c:80           packet:         push< e2e76bb9c2a7bee77e29faf8f9afb2a89fe19e11 refs/tags/0.2.3
23:07:49.012030 pkt-line.c:80           packet:         push< 986029121ae49984c98a76efa83d4e48d5c9f650 refs/tags/0.3.0
23:07:49.012035 pkt-line.c:80           packet:         push< 904d1b04cb0a147fe39f9952a281563faeb19d48 refs/tags/0.3.1
23:07:49.012039 pkt-line.c:80           packet:         push< a143c1b3a6896cdfe62dd24a0e95ee442c5469e2 refs/tags/0.4.0
23:07:49.012044 pkt-line.c:80           packet:         push< edd52106d7c868c86c396e0c2f486e58a6132d3c refs/tags/0.5.0
23:07:49.012048 pkt-line.c:80           packet:         push< c1b5722fe2dd9aee540cc08b73e7ac59c2f22c4d refs/tags/0.5.1
23:07:49.012055 pkt-line.c:80           packet:         push< 8ec196c7c708340e888573f66e34f9c5171efabf refs/tags/0.6.0
23:07:49.012060 pkt-line.c:80           packet:         push< 7ba81c3198da28101290eed259aef6645d258ebc refs/tags/0.6.1
23:07:49.012064 pkt-line.c:80           packet:         push< 8cdfc30e5cca5da9ea12b7e275f044d452e6894d refs/tags/0.7.0
23:07:49.012069 pkt-line.c:80           packet:         push< 646886f098efddd62162bebb655e413fd99c214e refs/tags/0.7.1
23:07:49.012073 pkt-line.c:80           packet:         push< 93a79ef4b89ee383cdfb5e4be5f07c2ce4e61c90 refs/tags/0.7.2
23:07:49.012078 pkt-line.c:80           packet:         push< 3067e568abbf803e8f47a6e16bc39412a4539b1c refs/tags/0.7.3
23:07:49.012082 pkt-line.c:80           packet:         push< 0000
23:07:49.012126 pkt-line.c:80           packet:         push> 0000

--+pyn4tnQwIEzicSq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=trace-refs

23:07:48.501620 refs/debug.c:27         ref_store for .
23:07:48.501670 refs/debug.c:252        read_raw_ref: HEAD: 0000000000000000000000000000000000000000 (=> refs/heads/master) type 1: 0
23:07:48.501687 refs/debug.c:252        read_raw_ref: refs/heads/master: e860f40ffd07a41e47a6b49d9400ad20e6a8b7ca (=> refs/heads/master) type 2: 0
23:07:48.501738 refs/debug.c:235        ref_iterator_begin:  (0x0)
23:07:48.501790 refs/debug.c:191        iterator_advance: refs/heads/bug450326 (0)
23:07:48.501797 refs/debug.c:191        iterator_advance: refs/heads/bug504458 (0)
23:07:48.501801 refs/debug.c:191        iterator_advance: refs/heads/iw (0)
23:07:48.501805 refs/debug.c:191        iterator_advance: refs/heads/master (0)
23:07:48.501809 refs/debug.c:191        iterator_advance: refs/heads/remove-bash-arrays (0)
23:07:48.501812 refs/debug.c:191        iterator_advance: refs/push-certs (0)
23:07:48.501816 refs/debug.c:191        iterator_advance: refs/tags/0.1 (0)
23:07:48.501820 refs/debug.c:191        iterator_advance: refs/tags/0.2 (0)
23:07:48.501823 refs/debug.c:191        iterator_advance: refs/tags/0.2.1 (0)
23:07:48.501827 refs/debug.c:191        iterator_advance: refs/tags/0.2.2 (0)
23:07:48.501831 refs/debug.c:191        iterator_advance: refs/tags/0.2.3 (0)
23:07:48.501834 refs/debug.c:191        iterator_advance: refs/tags/0.3.0 (0)
23:07:48.501838 refs/debug.c:191        iterator_advance: refs/tags/0.3.1 (0)
23:07:48.501841 refs/debug.c:191        iterator_advance: refs/tags/0.4.0 (0)
23:07:48.501845 refs/debug.c:191        iterator_advance: refs/tags/0.5.0 (0)
23:07:48.501848 refs/debug.c:191        iterator_advance: refs/tags/0.5.1 (0)
23:07:48.501852 refs/debug.c:191        iterator_advance: refs/tags/0.6.0 (0)
23:07:48.501855 refs/debug.c:191        iterator_advance: refs/tags/0.6.1 (0)
23:07:48.501861 refs/debug.c:191        iterator_advance: refs/tags/0.7.0 (0)
23:07:48.501865 refs/debug.c:191        iterator_advance: refs/tags/0.7.1 (0)
23:07:48.501868 refs/debug.c:191        iterator_advance: refs/tags/0.7.2 (0)
23:07:48.501872 refs/debug.c:191        iterator_advance: refs/tags/0.7.3 (0)
23:07:48.501875 refs/debug.c:189        iterator_advance: (-1)
23:07:49.042542 refs/debug.c:252        read_raw_ref: HEAD: 0000000000000000000000000000000000000000 (=> refs/heads/master) type 1: 0
23:07:49.042563 refs/debug.c:252        read_raw_ref: refs/heads/master: e860f40ffd07a41e47a6b49d9400ad20e6a8b7ca (=> refs/heads/master) type 2: 0

--+pyn4tnQwIEzicSq--

--el2C0KVlvSdzzYTT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iQKTBAABCgB9FiEEveu2pS8Vb98xaNkRGTlfI8WIJsQFAmGSA99fFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJE
RUJCNkE1MkYxNTZGREYzMTY4RDkxMTE5Mzk1RjIzQzU4ODI2QzQACgkQGTlfI8WI
JsSOww/+J/wqrA7yhj3nvGfy7bu6+nUXH3TGeJgvVRxQH8gsqBFfLG2GOI/vzXhj
YCEHuqKQ8RUkmoCiKVf0bIhbD97O2QLwH0FL12D/xMO0/9+7/vTzmXsS8/jaBQzM
d4miPD5vvayujETBxybyxZYoCnGFRD4a2eisJXSMbcQ1S2zc01scWxJGtu3iKhfg
wG5UoWn2dReLFeBUwMqdgI75a61wRq/TxVyUY52v5dEVnVLF7CkAVtICFc0GvUfg
8wooSXt1fZBUXK7liTn+ZbZjYF62rv1D9r/Jyz4xPisO3BDXNA+nvRO++G420C4o
LRI06463xAA3iZlEKYacct6+ztokC3gus48GwE6XUNQ/NPZtkyP1nxXZ+Bz1joqr
AaPPYbjnjdTOjkbjAARS9xwn+LJh/97VUJq22E2Yk8GXxc0g9sUMszllMlp0PvcW
px86htyyX15+MpmQTa01H6AE/mfGTQpyM5sTpehBXwfUF/R7UDYxJaN5JWxZU/L7
IcdSFZQmeR0ZZTTiZImvvzV9uLk8hUENAckO6lZuJ799Pj6iOHPUzsnhDOFjmvmD
KpfwRaX8r64kQymHWqm8o3pGefImboG9U9oOZTIua/3MS4wn8CZjHhCn6b1Y+vpe
clOkAQ4xZwYNrgv5zVPxuYVm8YRNOsI8RavpOwewuWoK9O18w1Q=
=Bw7Z
-----END PGP SIGNATURE-----

--el2C0KVlvSdzzYTT--
