From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: 64-bit support.
Date: Thu, 14 Nov 2013 19:11:31 +0400
Message-ID: <20131114191131.dd568689c8a2ac5f0dd7b04c@domain007.com>
References: <CAJc7Lbr9Ej8JHo6m4HFwdo9GE2tBQCkypEMxMW+jEXKB1Lry=g@mail.gmail.com>
	<27C8BBEE-128F-4CC1-AACE-248CA0CD8FBE@acm.org>
	<CAJc7Lbp2gF18xAM1z-NCo8cp73px_-RTqGcB1MiPup9iGn+uRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Kent R. Spillner" <kspillner@acm.org>,
	Git Mailing List <git@vger.kernel.org>
To: =?KOI8-R?Q?=EC=C5=D6=C1=CE=CB=C9=CE_=E9=D7=C1=CE?= 
	<abyss.7@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 14 16:11:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vgya7-0000BM-CM
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 16:11:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782Ab3KNPLk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Nov 2013 10:11:40 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:38058 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289Ab3KNPLj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 10:11:39 -0500
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id rAEFBVSn008565;
	Thu, 14 Nov 2013 19:11:32 +0400
In-Reply-To: <CAJc7Lbp2gF18xAM1z-NCo8cp73px_-RTqGcB1MiPup9iGn+uRw@mail.gmail.com>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237853>

On Thu, 14 Nov 2013 18:55:52 +0400
=EC=C5=D6=C1=CE=CB=C9=CE =E9=D7=C1=CE  <abyss.7@gmail.com> wrote:

> I hit this limit in file 'diffcore-rename.c':
>=20
> if (rename_limit <=3D 0 || rename_limit > 32767)
>         rename_limit =3D 32767;
>=20
> I just guess, that this limit comes from the O(N^2) complexity of the
> comparison algorithm. Since the max 32-bit signed value is 2^31, then
> the 2^15 =3D 32768 is somehow correlated with its square root, maybe,
> like 2^(32/2 - 1) - to prevent overflow.
> I'm trying to prepare the patch right now, that changes the `int
> rename_limit` =3D> `long rename_limit` and all intermediate variable
> types. Is it a correct way to do?

I beleive rename_limit comes from reading the diff.renameLimit
configuration variable.  The gitconfig(1) manual page hints to look at
the "-l" command-line option of `git diff` which is described this way:

  -l<num>

    The -M and -C options require O(n^2) processing time where n is the
  number of potential rename/copy targets. This option prevents
  rename/copy detection from running if the number of rename/copy
  targets exceeds the specified number.

This description is not too clear, I admit.

Looks like you're on the right track but the patch appears to require a
more wide impact:
* 32767 should be a default limit, applied in the case the user did not
  specify neither diff.renameLimit nor "-l".
* If whatever value read from those sources is less than 0, an error
  should be thrown--it looks strange to just revert it to the default
  value in this case.
* If the user-supplied value is >=3D 0, then just use it, assume the us=
er
  knows what they are doing.
