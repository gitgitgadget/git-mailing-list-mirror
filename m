From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 1/2] color: make it easier for non-config to parse	color
 specs
Date: Sun, 18 Jan 2009 18:45:00 +0100
Message-ID: <49736A9C.1040601@lsrfire.ath.cx>
References: <20090117152108.GA24899@coredump.intra.peff.net> <20090117153229.GA27071@coredump.intra.peff.net> <4973628C.8080501@lsrfire.ath.cx> <20090118172802.GA17434@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 18 18:46:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LObjC-0007f7-Vy
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 18:46:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933732AbZARRpH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Jan 2009 12:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933670AbZARRpG
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 12:45:06 -0500
Received: from india601.server4you.de ([85.25.151.105]:42719 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932907AbZARRpF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 12:45:05 -0500
Received: from [10.0.1.101] (p57B7E094.dip.t-dialin.net [87.183.224.148])
	by india601.server4you.de (Postfix) with ESMTPSA id B1D182F8046;
	Sun, 18 Jan 2009 18:45:01 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <20090118172802.GA17434@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106252>

Jeff King schrieb:
> On Sun, Jan 18, 2009 at 06:10:36PM +0100, Ren=C3=A9 Scharfe wrote:
>=20
>>>  - right now, it is implemented in terms of color_parse().
>>>    But it would be more efficient to reverse this and
>>>    implement color_parse in terms of color_parse_mem.
>> Thusly?
>=20
> Yes, except for the bugs you introduced. :)

Eeek! :)

>> +void color_parse_mem(const char *value, int len, const char *var, c=
har *dst)
>> +{
>>  	const char *ptr =3D value;
>>  	int attr =3D -1;
>>  	int fg =3D -2;
>=20
> What's missing in the context here (because it wasn't changed) is:
>=20
>> 	if (!strcasecmp(value, "reset")) {
>> 		strcpy(dst, "\033[m");
>> 		return;
>> 	}
>=20
> which doesn't work, since our string is actually something like
> "reset)\0" or even "reset)some totally unrelated string". So we would
> need a "memcasecmp" here.

	if (!strncasecmp(value, "reset", len)) {

> And then in the error case, we call:
>=20
>> die("bad color value '%s' for variable '%s'", value, var);
>=20
> which is also bogus.

   die("bad color value '%.*s' for variable '%s', len, value, var);

> I don't know if this is really even worth it. The timing difference i=
s
> pretty minimal:
>=20
>   $ time ./git log --pretty=3Dtformat:'%Credfoo%Creset' >/dev/null
>   real    0m0.673s
>   user    0m0.652s
>   sys     0m0.016s
>   $ time ./git log --pretty=3Dtformat:'%C(red)foo%C(reset)' >/dev/nul=
l
>   real    0m0.692s
>   user    0m0.660s
>   sys     0m0.032s
>=20
> That's about 1 microsecond per commit.

Hmm, not too much overhead, agreed, but it would still be nice to avoid=
 it.

Ren=C3=A9
