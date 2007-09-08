From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 3/3] Rework pretty_print_commit to use strbufs instead of custom buffers.
Date: Sat, 08 Sep 2007 14:17:48 +0200
Message-ID: <20070908121748.GA21864@artemis.corp>
References: <20070902224213.GB431@artemis.corp> <11892523992761-git-send-email-madcoder@debian.org> <1189252399433-git-send-email-madcoder@debian.org> <1189252399316-git-send-email-madcoder@debian.org> <11892523992038-git-send-email-madcoder@debian.org> <851wd9xt98.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="6TrnltStXW4iwmi0";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Sep 08 14:18:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITzG8-0003Zu-3D
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 14:17:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbXIHMRv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 08:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbXIHMRv
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 08:17:51 -0400
Received: from pan.madism.org ([88.191.52.104]:45421 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758AbXIHMRu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 08:17:50 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 1BF8D1E9D6;
	Sat,  8 Sep 2007 14:17:49 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id C615D7C95; Sat,  8 Sep 2007 14:17:48 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	David Kastrup <dak@gnu.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <851wd9xt98.fsf@lola.goethe.zz>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58124>


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 08, 2007 at 11:59:31AM +0000, David Kastrup wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> >   Also remove the "len" parameter, as:
> >   (1) it was used as a max boundary, and every caller used ~0u
> >   (2) we check for final NUL no matter what, so it doesn't help for spe=
ed.
>=20
> That sounds like a change that makes improvement of callers impossible
> when it is found out that it leads to a performance issue.  Is it only
> the pretty-print that is affected?

  I removed the "len" argument of pretty_print_commit and all the sub
pp_* functions it uses. This argument was supposed to tell which size
the commit message you want to read to format the pretty printing.

  It leads to a lot of code that works like this:

  if (position < len || *msg) /* test if len is overflowed or if we are
                                 at the end of the string */
    break;

  This impose us to maintain the len of the message while we make the
"msg" pointer progress, and so on. And it's a limit of what to read in the
commit message.

Seeing where pretty_print_commit is used:

builtin-branch.c:			pretty_print_commit(CMIT_FMT_ONELINE, commit,
builtin-log.c:			pretty_print_commit(CMIT_FMT_ONELINE, commit,
builtin-rev-list.c:		pretty_print_commit(revs.commit_format, commit,
builtin-show-branch.c:		pretty_print_commit(CMIT_FMT_ONELINE, commit,
commit.c:void pretty_print_commit(enum cmit_fmt fmt, const struct commit *c=
ommit,
log-tree.c:	pretty_print_commit(opt->commit_format, commit, &msgbuf,


  I assume that the user would not be very pleased if we decide to crop
his commits logs when he uses git-log. And given that git log in the
linux repository on my laptop takes:

  2,13s user 0,06s system 99% cpu 2,213 total

when the repo is hot ... I hardly think it can ever be a performance
issue :)

  But if people disagree I can refactor a patch with the "len" argument
kept.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG4pLsvGr7W6HudhwRAmjsAKCPccoIQ2ZvSZP2mLek2KJ3OKpUkQCgg+jo
16wreHBZ+ZBVedKnucYbpN0=
=+txd
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
