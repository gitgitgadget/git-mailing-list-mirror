From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 04/18] Offer a function to demote fsck errors to
 warnings
Date: Mon, 22 Dec 2014 23:55:16 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412222348040.21312@s15462909.onlinehome-server.info>
References: <cover.1418055173.git.johannes.schindelin@gmx.de> <2a0c4cd4c5d3aaceff8a6ffa49d2f3597d26086d.1418055173.git.johannes.schindelin@gmx.de> <xmqqoarbidv7.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412222232270.21312@s15462909.onlinehome-server.info>
 <xmqqfvc78hwq.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412222330080.21312@s15462909.onlinehome-server.info> <xmqqy4pz71g7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1784107012-1446231408-1419288917=:21312"
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 23:55:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3Bss-0003oo-TL
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 23:55:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbaLVWzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 17:55:23 -0500
Received: from mout.gmx.net ([212.227.15.18]:54237 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751024AbaLVWzW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 17:55:22 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx002) with ESMTPSA (Nemesis) id 0LwJFG-1XpN3z0bYk-017zgf;
 Mon, 22 Dec 2014 23:55:17 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqy4pz71g7.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:PLcqXNh0V2H5JrUPoPMmA5UAx3KG3PSUk9893yGCvm/SAz3bW6k
 0Syubpw+hVjlOZArHpYLuwimsbuEbkFwJ4uHm90Hy0+Z6X7gky67NIf8LqpQ1OTMmmpBFt/
 Xt0it0afjOM+kwtSVpU6TzQcNq9A3iRRtI0KpD2tpJq8raKkHdiBNsmLGh2796q5y0Kyhtw
 nBHA+KUnAq1wdAc0lgG2w==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261693>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1784107012-1446231408-1419288917=:21312
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Junio,

On Mon, 22 Dec 2014, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
> > On Mon, 22 Dec 2014, Junio C Hamano wrote:
> >
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >>=20
> >> >> In other words, at some point wouldn't we be better off with
> >> >> something like this
> >> >>=20
> >> >> =09struct {
> >> >>         =09enum id;
> >> >>                 const char *id_string;
> >> >>                 enum error_level { FSCK_PASS, FSCK_WARN, FSCK_ERROR=
 };
> >> >> =09} possible_fsck_errors[];
> >> >
> >> > I considered that, and Michael Haggerty also suggested that in a pri=
vate
> >> > mail. However, I find that there is a clear hierarchy in the default
> >> > messages: fatal errors, errors, warnings and infos.
> >>=20
> >> I am glad I am not alone ;-)
> >> ...
> > Oh, but please understand that this hierarchy only applies to the defau=
lt
> > settings. All of these settings can be overridden individually =E2=80=
=93 and the
> > first override will initialize a full array with the default settings.
>=20
> But that means that the runtime needs to switch between two code
> with and without override, no?
>=20
> > =09if (options->strict_mode)
> > =09=09return options->strict_mode[msg_id];
>=20
> In other words, I think this is misleading and unnecessary
> optimization for the "full array" allocation.  A code that uses an
> array of a struct like the above that Michael and I independently
> suggested would initialize once with or without an override and then
> at the runtime there is no "if the array is there use it"
> conditional.
>=20
> I do not know why Michael suggested the same thing, but the reason
> why I prefer that arrangement is because I think it would be easier
> to read and maintain.

Well, I disagree that it would be easier to maintain, because it appears
to me that the clear hierarchy keeps things simple. For example if some
clearly fatal error is clustered with non-fatal ones due to alphabetical
ordering, it is much harder to spot when it is marked as a demoteable
error by mistake.

For example, try to spot the error here:

=09...
=09F(ALMOST_HAPPY, INFO) \
=09F(CANNOT_RECOVER, ERROR) \
=09F(COFFEE_IS_EMPTY, WARN) \
=09F(JUST_BEING_CHATTY, INFO) \
=09F(LIFE_IS_GOOD, INFO) \
=09F(MISSING_SOMETHING_VITAL, FATAL_ERROR) \
=09F(NEED_TO_SLEEP, WARN) \
=09F(SOMETHING_WENT_WRONG, ERROR) \
=09...

Personally, I find it very, very hard to spot that CANNOT_RECOVER is
marked as a mere ERROR instead of a FATAL_ERROR. Even if it is nicely
alphabetically ordered.

I will sleep over this, though. Maybe I can come up with a solution that
makes all three of us happy.

Ciao,
Dscho
--1784107012-1446231408-1419288917=:21312--
