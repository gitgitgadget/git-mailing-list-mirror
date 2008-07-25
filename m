From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 7/9] builtin-checkout-index.c: use parse_options()
Date: Fri, 25 Jul 2008 11:01:11 +0200
Message-ID: <48899657.5090209@lsrfire.ath.cx>
References: <1216849332-26813-1-git-send-email-barra_cuda@katamail.com>	 <1216849332-26813-8-git-send-email-barra_cuda@katamail.com>	 <alpine.DEB.1.00.0807241543190.8986@racer>	 <200807242208.37192.barra_cuda@katamail.com> <bd6139dc0807241335i3ab5280aq6a46325428ccc70f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michele Ballabio <barra_cuda@katamail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Fri Jul 25 11:02:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMJBy-0006nV-01
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 11:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752912AbYGYJBV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jul 2008 05:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752639AbYGYJBU
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 05:01:20 -0400
Received: from india601.server4you.de ([85.25.151.105]:36538 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912AbYGYJBT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 05:01:19 -0400
Received: from [10.0.1.200] (p57B7EC0C.dip.t-dialin.net [87.183.236.12])
	by india601.server4you.de (Postfix) with ESMTPSA id 932C72F8028;
	Fri, 25 Jul 2008 11:01:17 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <bd6139dc0807241335i3ab5280aq6a46325428ccc70f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90019>

Sverre Rabbelier schrieb:
> On Thu, Jul 24, 2008 at 10:08 PM, Michele Ballabio
> <barra_cuda@katamail.com> wrote:
>> On Thursday 24 July 2008, Johannes Schindelin wrote:
>>> On Wed, 23 Jul 2008, Michele Ballabio wrote:
>>>
>>>> +           { OPTION_CALLBACK, 'f', "force", &state, NULL,
>>>> +             "force overwrite of existing files",
>>>> +             PARSE_OPT_NOARG, parse_state_force_cb, 0 },
>>> I wonder if this could not be written as
>>>
>>>               OPT_BOOLEAN('f', "force", &state.force,
>>>                       "force overwrite of existing files"),
>> I did it that way because 'force' is a bitfield.
>=20
> I thought there is an OPT_BIT?

OPT_BIT is for flags and bitmasks, not for bitfields.

Since you can't get the address of a bitfield member, a function that
wants to change its value needs to know its name.  Switching to bitmask=
s
would make the option parsing code look cleaner, but you'd have to
change all those bitfield accesses to explicit bitmask operations, e.g.=
:

	if (state.force)
		state.force =3D 0;

vs.

	if (state.flags & CHECKOUT_FORCE)
		state.flags &=3D ~CHECKOUT_FORCE;

In the case of struct checkout, though, we could simply make the
bitfield members full ints, because there are only a few instances of
this structure in memory at any given time.  Wasting a few bytes of RAM
in order to gain much simpler code is OK in this case, I think.
OPT_BOOLEAN looks a lot nicer than a callback.

Ren=E9
