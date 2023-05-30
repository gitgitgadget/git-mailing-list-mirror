Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA9AC77B7A
	for <git@archiver.kernel.org>; Tue, 30 May 2023 09:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjE3JX5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 May 2023 05:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjE3JXW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2023 05:23:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C50185
        for <git@vger.kernel.org>; Tue, 30 May 2023 02:22:27 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3vYC-0001Ka-Se; Tue, 30 May 2023 11:21:56 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3vYC-003qAk-8Z; Tue, 30 May 2023 11:21:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3vYB-009QQM-ES; Tue, 30 May 2023 11:21:55 +0200
Date:   Tue, 30 May 2023 11:21:55 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     git@vger.kernel.org
Cc:     entwicklung@pengutronix.de
Subject: notes handling broken on rebase
Message-ID: <20230530092155.3zbb5uxa7eisdzxb@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l7nh2fqsekb76vq7"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--l7nh2fqsekb76vq7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I found a bug in git rebase and how notes are retained using

	uwe@taurus:~/tmp/gittest$ git version
	git version 2.41.0.rc2.161.g9c6817b8e7dd

, it also happens with 2.39.2.

Here comes a reproducer:

 - Create some initial git history, just three commits A, B and C:

	uwe@taurus:~/tmp/gittest$ git init
	Initialized empty Git repository in /home/uwe/tmp/gittest/.git/

	uwe@taurus:~/tmp/gittest$ for i in A B C; do echo content $i >> file ; git=
 add file ; git commit -m "$i" ; git notes add -m "notes for $i" ; git tag =
$i ; done
	[main (root-commit) db2548de5a3c] A
	 1 file changed, 1 insertion(+)
	 create mode 100644 file
	[main 2b8fa82afb3c] B
	 1 file changed, 1 insertion(+)
	[main 3dd5e4a2037e] C
	 1 file changed, 1 insertion(+)

 - Pick C on top of A:

	uwe@taurus:~/tmp/gittest$ git checkout A
	HEAD is now at db2548de5a3c A
	uwe@taurus:~/tmp/gittest$ git cherry-pick C
	Auto-merging file
	CONFLICT (content): Merge conflict in file
	error: could not apply 3dd5e4a2037e... C
	hint: After resolving the conflicts, mark them with
	hint: "git add/rm <pathspec>", then run
	hint: "git cherry-pick --continue".
	hint: You can instead skip this commit with "git cherry-pick --skip".
	hint: To abort and get back to the state before "git cherry-pick",
	hint: run "git cherry-pick --abort".
	Recorded preimage for 'file'
	uwe@taurus:~/tmp/gittest$ { echo content A; echo content C; } > file
	uwe@taurus:~/tmp/gittest$ git add file
	uwe@taurus:~/tmp/gittest$ git cherry-pick --continue
	Recorded resolution for 'file'.
	[detached HEAD 6cfc9b7bd437] C
	 Date: Tue May 30 11:02:13 2023 +0200
	 1 file changed, 1 insertion(+)

 - Rebase {B, C} on top of A + C' (which results in skipping C):

	uwe@taurus:~/tmp/gittest$ git rebase HEAD C
	Auto-merging file
	CONFLICT (content): Merge conflict in file
	error: could not apply 2b8fa82afb3c... B
	hint: Resolve all conflicts manually, mark them as resolved with
	hint: "git add/rm <conflicted_files>", then run "git rebase --continue".
	hint: You can instead skip this commit: run "git rebase --skip".
	hint: To abort and get back to the state before "git rebase", run "git reb=
ase --abort".
	Recorded preimage for 'file'
	Could not apply 2b8fa82afb3c... B
	uwe@taurus:~/tmp/gittest$ { echo content A; echo content B; echo content C=
; } > file
	uwe@taurus:~/tmp/gittest$ git add file
	uwe@taurus:~/tmp/gittest$ git rebase --continue
	Recorded resolution for 'file'.
	[detached HEAD e5b3e28216f2] B
	 1 file changed, 1 insertion(+)
	dropping 3dd5e4a2037ecd31f5470561638cb065434eabbc C -- patch contents alre=
ady upstream
	Successfully rebased and updated detached HEAD.

Now I have:

	uwe@taurus:~/tmp/gittest$ git log --pretty=3Doneline --abbrev-commit --not=
es
	e5b3e28216f2 (HEAD) B
	Notes:
	    notes for B
	   =20
	    notes for C

	6cfc9b7bd437 C
	db2548de5a3c (tag: A) A
	Notes:
	    notes for A

The surprising part here is that (the new) B also has C's note. I would
have expected that it only has its own one. I quickly looked into the
source code, but didn't find an easy fix because the code that notices
that C should be dropped (in do_pick_commit()) isn't where the note is
copied (which I didn't find).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--l7nh2fqsekb76vq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmR1wDIACgkQj4D7WH0S
/k75Cgf/RzAOkB0ALKAG5FanrYmO9BF6POjrVLFjK6aQiZpeKDO1W1LpsPy5R362
bvK9YDGil2TUGsOubRPFr1O4G9wIfq2HZ2E9cCQGEugTUMahNTvowLbNnTJPb+xX
xAAatu81Lyh9VIXJ/LFuxkXy469Csxg6uwzxncWqkMjbStV2WhLw+mtsplCuHBjA
wr9HeylrJ7RgXjbAN4LgzYxeHN3JKAC/pgDKLfvc01LGzml0BVZM3m/jKcASq65l
RNxDrtTGBquVgx7SpF7Vr/CMBsrq7jSHvhWjaPKmEEgmYuUEdM4F4+LRXYVipoiA
e94Bt5UGAPW0YCV3ftEQtcXYQrnEhw==
=Tu2Y
-----END PGP SIGNATURE-----

--l7nh2fqsekb76vq7--
