From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: write memoized data explicitly to avoid
	Storable bug
Date: Tue, 20 Jul 2010 12:02:23 -0700
Message-ID: <20100720190223.GB2732@dcvr.yhbt.net>
References: <1279455469-6384-1-git-send-email-vsu@altlinux.ru> <AANLkTime7QQZGLXmXg_X3W7CsbyLe5NbPKcqs9dp0oaa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sergey Vlasov <vsu@altlinux.ru>, git@vger.kernel.org,
	A Large Angry SCM <gitzilla@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 20 21:02:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObI5H-0000p9-Fj
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 21:02:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757700Ab0GTTCZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jul 2010 15:02:25 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:34962 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752488Ab0GTTCY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 15:02:24 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEA411F744;
	Tue, 20 Jul 2010 19:02:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <AANLkTime7QQZGLXmXg_X3W7CsbyLe5NbPKcqs9dp0oaa@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151350>

=C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> wrote:
> On Sun, Jul 18, 2010 at 12:17, Sergey Vlasov <vsu@altlinux.ru> wrote:
> > Apparently using the Storable module during global destruction is
> > unsafe - there is a bug which can cause segmentation faults:
> >
> > =A0http://rt.cpan.org/Public/Bug/Display.html?id=3D36087
> > =A0http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D482355
>=20
> I did some investigation into the upstream issue:
> https://rt.cpan.org/Ticket/Display.html?id=3D36087#txn-806832
>=20
> > The persistent memoization support introduced in commit 8bff7c538
> > relied on global destruction to write cached data, which was leadin=
g
> > to segfaults in some Perl configurations. =A0Calling Memoize::unmem=
oize
> > in the END block forces the cache writeout to be performed earlier,
> > thus avoiding the bug.
>=20
> Maybe I'm missing something obvious, but this seems like the wrong
> solution. The core issue is that we don't want to clean up during
> global destruction, but then we should just do:
>=20
>        sub DESTROY {
>                return if not $memoized;
>                $memoized =3D 0;
>=20
>                Memoize::unmemoize 'lookup_svn_merge';
>                Memoize::unmemoize 'check_cherry_pick';
>                Memoize::unmemoize 'has_no_changes';
>        }

I haven't looked at this issue in-depth, but I believe the problem is
triggered due to Memoize::Storable trying to use Storable::nstore
in its own DESTROY function.  So trying to do the same in our own
DESTROY would be just as bad.

> That should work since memoize_svn_mergeinfo_functions(); is being
> called in find_extra_svn_parents, which is a Git::SVN object
> method. Can you try this and confirm/deny? I can't because I can't ge=
t
> the original to segfault on my box when run within git-svn.

I wasn't able to reproduce the segfault on my systems, either, but
it seems plausible it would only happen on some systems.

--=20
Eric Wong
