From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH 04/15] Add new test to ensure git-merge handles pull.twohead
 and pull.octopus
Date: Sun, 29 Jun 2008 15:30:56 +0200
Message-ID: <48678E90.1030608@free.fr>
References: <cover.1214581610.git.vmiklos@frugalware.org> <58b2c36de6a6f51a562da303695482bea567f4bf.1214581610.git.vmiklos@frugalware.org> <4a9a3a34d8c42b60f002acb20083cb9e187c262f.1214581610.git.vmiklos@frugalware.org> <876e733753999f116bfd975d9a262a5c1b3855a1.1214581610.git.vmiklos@frugalware.org> <99b931de28ab3017269d15c334c83e242d025489.1214581610.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Jun 29 15:31:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCx0N-00064H-03
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 15:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755748AbYF2Naw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Jun 2008 09:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755384AbYF2Nav
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 09:30:51 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:41296 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755294AbYF2Nav (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 09:30:51 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id A7F5812B708;
	Sun, 29 Jun 2008 15:30:49 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 3F3A312B704;
	Sun, 29 Jun 2008 15:30:49 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <99b931de28ab3017269d15c334c83e242d025489.1214581610.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86799>

Miklos Vajna a =E9crit :
>=20

[...]

> +test_expect_success 'setup' '
> +	echo c0 >c0.c &&
> +	git add c0.c &&
> +	git commit -m c0 &&
> +	git tag c0 &&
> +	echo c1 >c1.c &&
> +	git add c1.c &&
> +	git commit -m c1 &&
> +	git tag c1 &&
> +	git reset --hard c0 &&
> +	echo c2 >c2.c &&
> +	git add c2.c &&
> +	git commit -m c2 &&
> +	git tag c2

Missing &&?

> +	git reset --hard c0 &&
> +	echo c3 >c3.c &&
> +	git add c3.c &&
> +	git commit -m c3 &&
> +	git tag c3
> +'

[...]

> +test_expect_success 'merge c1 with c2 and c3 (recursive and octopus =
in pull.octopus)' '
> +	git reset --hard c1 &&
> +	git config pull.octopus "recursive octopus" &&
> +	git merge c2 c3 &&
> +	test "$(git rev-parse c1)" !=3D "$(git rev-parse HEAD)" &&
> +	test "$(git rev-parse c1)" =3D "$(git rev-parse HEAD^1)" &&
> +	test "$(git rev-parse c2)" =3D "$(git rev-parse HEAD^2)" &&
> +	test "$(git rev-parse c3)" =3D "$(git rev-parse HEAD^3)"

Duplicate the next line?

> +	test "$(git rev-parse c3)" =3D "$(git rev-parse HEAD^3)" &&
> +	git diff --exit-code &&
> +	test -f c0.c &&
> +	test -f c1.c &&
> +	test -f c2.c &&
> +	test -f c3.c
> +'
> +
> +conflict_count()
> +{
> +	eval $1=3D`{
> +		git diff-files --name-only
> +		git ls-files --unmerged
> +	} | wc -l`
> +}
> +
> +# c4 - c5
> +#    \ c6
> +#
> +# There are two conflicts here:
> +#
> +# 1) Because foo.c is renamed to bar.c, recursive will handle this,
> +# resolve won't.
> +#
> +# 2) One in conflict.c and that will always fail.
> +
> +test_expect_success 'setup conflicted merge' '
> +	git reset --hard c0 &&
> +	echo A >conflict.c &&
> +	git add conflict.c &&
> +	echo contents >foo.c &&
> +	git add foo.c &&
> +	git commit -m c4 &&
> +	git tag c4 &&
> +	echo B >conflict.c &&
> +	git add conflict.c &&
> +	git mv foo.c bar.c &&
> +	git commit -m c5 &&
> +	git tag c5 &&
> +	git reset --hard c4 &&
> +	echo C >conflict.c &&
> +	git add conflict.c &&
> +	echo secondline >> foo.c &&
> +	git add foo.c &&
> +	git commit -m c6 &&
> +	git tag c6
> +'
> +
> +# First do the merge with resolve and recursive then verify that
> +# recusive is choosen.
> +
> +test_expect_success 'merge picks up the best result' '
> +	git config pull.twohead "recursive resolve" &&
> +	git reset --hard c5 &&
> +	git merge -s resolve c6
> +	conflict_count resolve_count &&
> +	git reset --hard c5 &&
> +	git merge -s recursive c6
> +	conflict_count recursive_count &&
> +	git reset --hard c5 &&
> +	git merge c6
> +	conflict_count auto_count &&
> +	test "$auto_count" =3D "$recursive_count"
> +'

Should not "$auto_count" !=3D "$resolve_count" also be tested to be
sure that recursive has been choosen?

Olivier.
