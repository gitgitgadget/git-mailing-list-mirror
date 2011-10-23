From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: a bug when execute "git status" in git version 1.7.7.431.g89633
Date: Sun, 23 Oct 2011 19:50:11 +0200
Message-ID: <4EA453D3.7080002@lsrfire.ath.cx>
References: <4EA20C5B.3090808@gmail.com> <vpqfwiknmh3.fsf@bauges.imag.fr> <4EA3D1BB.2010802@gmail.com> <4EA415BD.1040109@lsrfire.ath.cx> <20111023162944.GB28156@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Hsing <tsyj2007@gmail.com>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 23 19:50:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RI2Bm-0008Ac-JE
	for gcvg-git-2@lo.gmane.org; Sun, 23 Oct 2011 19:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754792Ab1JWRuT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Oct 2011 13:50:19 -0400
Received: from india601.server4you.de ([85.25.151.105]:60094 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754713Ab1JWRuS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Oct 2011 13:50:18 -0400
Received: from [192.168.2.104] (p4FFD9D8D.dip.t-dialin.net [79.253.157.141])
	by india601.server4you.de (Postfix) with ESMTPSA id 40F812F8042;
	Sun, 23 Oct 2011 19:50:16 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <20111023162944.GB28156@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184145>

Am 23.10.2011 18:29, schrieb Jeff King:
> On Sun, Oct 23, 2011 at 03:25:17PM +0200, Ren=C3=A9 Scharfe wrote:
>=20
>> I can reproduce the malloc crash on Ubuntu 11.10 with these simple s=
teps:
>> [...]
>> Bisect points to 2548183ba, "fix phantom untracked files when
>> core.ignorecase is set" from Jeff (cc:d).  If I revert that patch fr=
om
>> master (8963314c), git status works fine.
>=20
> Hmm. Interesting. I can't reproduce here. And I've been running with
> this patch for over a year, and never seen that. Given your fix, I gu=
ess
> it's related to pointer size. Are you on a 32-bit machine, by any
> chance?

Yes, it's a 32-bit VM.  I think it's a case of unlucky filename lengths=
,
combined with the rounding up to the next multiple of 8.  The following
table lists the actual size needed for entries based on the length of
their name entry.  Length calculation uses these offsets:

	offsetof(struct cache_entry, name) =3D=3D 72
	offsetof(struct ondisk_cache_entry, name) =3D=3D 62

	len  ce_size                 ondisk_ce_size          delta
	  1  (72 + 1 + 8) & ~7 =3D 80  (62 + 1 + 8) & ~7 =3D 64     16
	  2  (72 + 2 + 8) & ~7 =3D 80  (62 + 2 + 8) & ~7 =3D 72      8
	  3  (72 + 3 + 8) & ~7 =3D 80  (62 + 3 + 8) & ~7 =3D 72      8
	  4  (72 + 4 + 8) & ~7 =3D 80  (62 + 4 + 8) & ~7 =3D 72      8
	  5  (72 + 5 + 8) & ~7 =3D 80  (62 + 5 + 8) & ~7 =3D 72      8
	  6  (72 + 6 + 8) & ~7 =3D 80  (62 + 6 + 8) & ~7 =3D 72      8
	  7  (72 + 7 + 8) & ~7 =3D 80  (62 + 7 + 8) & ~7 =3D 72      8
	  8  (72 + 8 + 8) & ~7 =3D 88  (62 + 8 + 8) & ~7 =3D 72     16

So in 25% of the cases an entry needs 16 bytes more in memory than on
disk and the rest needs 8 bytes more.

estimate_cache_size() calculates the amount of memory needed for the
index, based on its on-disk representation.  It simply adds the
difference of the sizes of the two structs and the size of a pointer fo=
r
each entry to its total size and returns that number.  I have:

	sizeof(void *) =3D=3D 4
	sizeof(struct cache_entry) =3D=3D 72
	sizeof(struct ondisk_cache_entry) =3D=3D 64

So each entry gets 72 - 64 + 4 =3D 12 bytes extra.  If you happen to ha=
ve
a lot of filenames with a delta of 16 then the resulting size won't be
enough to hold the in-memory index.

Is there a nice way to derive that we need 16 bytes per entry in the
worst case, preferably without trying all eight possibilities as I did
in the table above?  My modular math is rusty..

Ren=C3=A9
