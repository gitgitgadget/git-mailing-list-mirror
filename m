From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 04/18] Offer a function to demote fsck errors to
 warnings
Date: Mon, 22 Dec 2014 23:32:44 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412222330080.21312@s15462909.onlinehome-server.info>
References: <cover.1418055173.git.johannes.schindelin@gmx.de> <2a0c4cd4c5d3aaceff8a6ffa49d2f3597d26086d.1418055173.git.johannes.schindelin@gmx.de> <xmqqoarbidv7.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412222232270.21312@s15462909.onlinehome-server.info>
 <xmqqfvc78hwq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1784107012-326887847-1419287564=:21312"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 23:33:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3BXC-0003je-3U
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 23:33:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753681AbaLVWc6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 17:32:58 -0500
Received: from mout.gmx.net ([212.227.15.18]:49718 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753473AbaLVWc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 17:32:56 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0M9JYE-1YBST42JnK-00CidA;
 Mon, 22 Dec 2014 23:32:44 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqfvc78hwq.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:TOBIEu8aoWWvwZNfNqXLzwoneMwlbJr0R/+C2klbn9zCNo9rzc8
 evwksGcXpCV7L3PS6UK26lETmWhDJ05g4p/WUMMskw2jV8UbTBCyAfyR54Upv5R75WeebFS
 4pR5lO70ugXJXBi7qYDfF7fZnSLG+zUnjRUkhcjKS1TXrIluDCSeLrGOxmNzM4JbFMLd1/7
 fuQKF7cGT4cznZD+5DqwA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261686>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1784107012-326887847-1419287564=:21312
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Junio,

On Mon, 22 Dec 2014, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
> >> In other words, at some point wouldn't we be better off with
> >> something like this
> >>=20
> >> =09struct {
> >>         =09enum id;
> >>                 const char *id_string;
> >>                 enum error_level { FSCK_PASS, FSCK_WARN, FSCK_ERROR };
> >> =09} possible_fsck_errors[];
> >
> > I considered that, and Michael Haggerty also suggested that in a privat=
e
> > mail. However, I find that there is a clear hierarchy in the default
> > messages: fatal errors, errors, warnings and infos.
>=20
> I am glad I am not alone ;-)
>=20
> These classes are ordered from more severe to less, but I do not
> think it makes much sense to force the default view of "if you
> customize to demote a questionable Q that is classified as an error
> by default as an warning, you must demote all the other ones that we
> deem less serious than Q, which come earlier (or later---I do not
> remember which) in our predefined list".  So in that sense, I do not
> consider that various kinds of questionables fsck can detect are
> hierarchical at all.

Oh, but please understand that this hierarchy only applies to the default
settings. All of these settings can be overridden individually =E2=80=93 an=
d the
first override will initialize a full array with the default settings.

So the order really only plays a role for the defaults, no more.

> I do agree that it makes it easier to code the initialization of
> such an array to have "up to this point we assign the level 'fatal
> error' by default" constants.  Then the initialization can become
>=20
> =09for (i =3D 0; i < FIRST_WARN; i++)
>         =09possible_fsck_errors[i].error_level =3D FSCK_INFO;
> =09while (i < FIRST_ERROR)
>         =09possible_fsck_errors[i++].error_level =3D FSCK_WARN;
> =09while (i < ARRAY_SIZE(possible_fsck_errors))
>         =09possible_fsck_errors[i++].error_level =3D FSCK_ERROR;
>=20
> or something.  So I am not against the FIRST_WARNING constant at
> all, but I find it very questionable in a fully customizable system
> to use such a constant anywhere other than the initialization time.

This is indeed the case. The code we are discussing comes after the

=09if (options->strict_mode)
=09=09return options->strict_mode[msg_id];

In other words, once the overrides are in place, the default settings are
skipped entirely.

Ciao,
Dscho
--1784107012-326887847-1419287564=:21312--
