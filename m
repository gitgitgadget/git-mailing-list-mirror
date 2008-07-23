From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH] Rename ".dotest/" to ".git/rebase" and ".dotest-merge"
 to "rebase-merge"
Date: Wed, 23 Jul 2008 16:54:15 +0200
Message-ID: <48874617.3010108@free.fr>
References: <73fd69b50807151408i6a916da6p7b89fe81e65fc717@mail.gmail.com> <20080715212211.GL6244@leksak.fem-net> <487D1B3D.70500@lsrfire.ath.cx> <alpine.DEB.1.00.0807160245440.2841@eeepc-johanness> <20080716012619.GM8185@mit.edu> <7viqv5r637.fsf@gitster.siamese.dyndns.org> <4882350B.6020003@free.fr> <7v3am5zfea.fsf@gitster.siamese.dyndns.org> <20080722234703.GD5904@leksak.fem-net> <7vbq0pifwq.fsf@gitster.siamese.dyndns.org> <20080723011341.GE5904@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Theodore Tso <tytso@mit.edu>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-8859-1?Q?Ren=E9_?= =?ISO-8859-1?Q?Scharfe?= 
	<rene.scharfe@lsrfire.ath.cx>, Joe Fiorini <joe@faithfulgeek.org>,
	git@vger.kernel.org, Jari Aalto <jari.aalto@cante.net>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Wed Jul 23 16:55:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLfkM-0001OE-C8
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 16:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbYGWOyT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2008 10:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbYGWOyS
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 10:54:18 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:49405 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750868AbYGWOyS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 10:54:18 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 1A96F12B6E8;
	Wed, 23 Jul 2008 16:54:17 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 4045A12B6F4;
	Wed, 23 Jul 2008 16:54:16 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <20080723011341.GE5904@leksak.fem-net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89666>

Stephan Beyer a =E9crit :
>=20
>>> Perhaps I am confused, but ...

I can understand. ;-)

>>> Why is there "HEAD" and "ORIG_HEAD" and not only "ORIG_HEAD"?
>> Just being a bit defensive -- in this case I think it might be Ok to=
 say
>> "read-tree --reset -u ORIG_HEAD", but I haven't checked in a conflic=
ted
>> case.

git read-tree --reset -u ORIG_HEAD clears local changes which is not go=
od.

> Well, the test suite fails:
> * FAIL 4: am --abort goes back after failed am
>=20
>                         git-am --abort &&
>                         git rev-parse HEAD >actual &&
>                         git rev-parse initial >expect &&
>                         test_cmp expect actual &&
>   here>                 test_cmp file-2-expect file-2 &&

Local changes have been lost.

> The reason of my question was that I *blindly* incorporated the chang=
e into
> sequencer to make it able to work on a dirty working tree and thus to=
 be
> able to migrate am onto it without losing the ability to apply patche=
s
> on a dirty working tree....

Are you talking about your seq-proto-dev3 branch?

> All am tests applied afterwards, but the sequencer and the rebase-i
> test suite failed in a place where I didn't expect it. I *then* had
> a deeper look at the read-tree line and I was wondering what the "HEA=
D"
> should achieve.
> I removed it and all tests passed. (I didn't have t4151 in my branch
> at that point.)
>=20
> Now, because t4151 does not pass, I am wondering what's the best thin=
g
> I could do...

I looked at your code. You use reset_almost_hard() instead of "reset --=
hard",
it's fine but you does not update require_clean_work_tree() to be less
restrictive and let the sequencer work with local modifications. Those =
two
lines must be removed, I think:
  git update-index --ignore-submodules --refresh &&
  git diff-files --quiet --ignore-submodules &&

Try that with the original read-tree line and t4151 should pass.

Ah, you should change "Applying 6" with "Applying \"6\"" in t4151-am-ab=
ort.sh
too.

Olivier.
