From: Greg Troxel <gdt@ir.bbn.com>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Thu, 05 Sep 2013 09:31:51 -0400
Message-ID: <rmi8uzbz96g.fsf@fnord.ir.bbn.com>
References: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com>
	<xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
	<CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
	<xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
	<20130904081047.GB2582@serenity.lan>
	<xmqqa9jso69u.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 05 15:32:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHZfD-0004JU-08
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 15:31:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753170Ab3IENbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 09:31:55 -0400
Received: from fnord.ir.bbn.com ([192.1.100.210]:61926 "EHLO fnord.ir.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752200Ab3IENby (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 09:31:54 -0400
Received: by fnord.ir.bbn.com (Postfix, from userid 10853)
	id BCFC5C1B9; Thu,  5 Sep 2013 09:31:51 -0400 (EDT)
OpenPGP: id=32611E25
X-Hashcash: 1:20:130905:john@keeping.me.uk::/9XrbMaFKvWqGNcS:00000000000000000000000000000000000000000000B8+
X-Hashcash: 1:20:130905:git@vger.kernel.org::F7hQk3uGy8wf2vrc:0000000000000000000000000000000000000000005IOH
X-Hashcash: 1:20:130905:felipe.contreras@gmail.com::2vTa/Uprai3sowBO:0000000000000000000000000000000000083k0
X-Hashcash: 1:20:130905:a.krey@gmx.de::EfqKoovfPVCkuSPO:00005GNl
X-Hashcash: 1:20:130905:gitster@pobox.com::KMylNndRL66MYcsw:000000000000000000000000000000000000000000007b7i
In-Reply-To: <xmqqa9jso69u.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 04 Sep 2013 10:17:49 -0700")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/23.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233958>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Junio C Hamano <gitster@pobox.com> writes:

> Peff already covered (1)---it is highly doubtful that a merge is
> "almost always wrong".  In fact, if that _were_ the case, we should
> simply be defaulting to rebase, not failing the command and asking
> between merge and rebase like jc/pull-training-wheel topic did.
>
> We simply do not know what the user wants, as it heavily depends on
> the project, so we ask the user to choose one (and stick to it).

From=20my experience leading the first large project using git at BBN,
evolving a workflow (most work on topic branches, which are rebased,
banning 'git pull'-created merge commits, and explicit merge commits to
preserve --first-parent, basically), and seeing many people struggle to
learn all this, my take is that a user who does not understand non-ff
merge vs ff-merge vs rebase will end up doing the wrong thing.  So two
thoughts:

  In the glorious future, perhaps git could have a way to express a
  machine-parseable representation of the workflow and rules for a repo,
  so that these choices could be made accordingly.

  In the current world, I think it makes sense to error out when there
  are multiple reasonable choices depending on workflow.

One of my team members, Richard Hansen, has argued to us that 'git pull'
is harmful, essentially because it creates non-ff merges sometimes,
while our rules say those should be rebased out.  So we use

[alias]
	up =3D !git remote update -p && git merge --ff-only @{u}

which acts like pull if ff merge works, and otherwise errors out.

I think the key question is: can a user who doesn't really understand
the implications of ff vs non-ff merges and the local workflow rules
actually function ok, or do they need to stop and go back and
understand.  I'm in the "you just have to take the time to understand"
camp, which led to us having a semi-custom syllabus from github training
covering rebase, explicit vs ff merges and the consequences for
first-parent history, etc.

Therefore, I think "git pull" should do the update (perhaps of just the
remote corresponding to @{u}, perhaps without -p) and a --ff-only merge,
absent a configuration asking for non-ff merge or rebase.  (Arguably, an
ff merge is a degenerate case of rebase and also of the ff/non-ff merge,
so it's safe with either policy.)

Greg

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (NetBSD)

iEYEARECAAYFAlIoh8cACgkQ+vesoDJhHiUHuQCfUARDPyV10UTXgwSstY5UXV/5
z+MAoI+U70tn42kkCln0Vip7yWWcrgqa
=k9qD
-----END PGP SIGNATURE-----
--=-=-=--
