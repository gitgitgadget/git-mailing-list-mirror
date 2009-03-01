From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 3/4] diffcore-pickaxe: further refactor count_match()
Date: Sun, 01 Mar 2009 11:53:47 +0100
Message-ID: <49AA693B.5060108@lsrfire.ath.cx>
References: <cover.1235629933.git.gitster@pobox.com> <cd73512d11e63554396983ed4e9556b2d18b3e4a.1235629933.git.gitster@pobox.com> <49A88FA7.1020402@lsrfire.ath.cx> <7vy6vrgxnn.fsf@gitster.siamese.dyndns.org> <7v8wnrgkjw.fsf@gitster.siamese.dyndns.org> <49A937B8.1030205@lsrfire.ath.cx> <7viqmtaec4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 11:59:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdjOM-0002UW-S1
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 11:59:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265AbZCAKx6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Mar 2009 05:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753023AbZCAKx6
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 05:53:58 -0500
Received: from india601.server4you.de ([85.25.151.105]:51566 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836AbZCAKx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 05:53:57 -0500
Received: from [10.0.1.101] (p57B7F2B0.dip.t-dialin.net [87.183.242.176])
	by india601.server4you.de (Postfix) with ESMTPSA id D69D92F8037;
	Sun,  1 Mar 2009 11:53:53 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <7viqmtaec4.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111837>

Junio C Hamano schrieb:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> I get this (Ubuntu 8.10 x64, Fedora 10 x64 using the same Linux repo=
,
>> Windows Vista x64 using a different Linux repo with the same HEAD on
>> NTFS and msysgit, numbers are the elapsed time in seconds, best of f=
ive
>> runs):
>>
>>                            Ubuntu  Fedora  Windows
>>    v1.6.2-rc2                8.14    8.16    9.236
>>    v1.6.2-rc2+[1-4]          2.43    2.45    2.995
>>    v1.6.2-rc2+[1-4]+memmem   1.31    1.25    2.917
>>    v1.6.2-rc2+[1-3]+memmem   1.51    1.16    8.455
>>
>> Ubuntu has glibc 2.8, while Fedora 10 has glibc 2.9, with a new and =
more
>> efficient memmem() implementation.  On Windows, we use our own naive
>> memmem() implementation.

Correction: On Windows, we use the previous, quadratic, naive memmem()
implementation from glibc, not anything we came up with.

>> So using memmem() is worthwhile.  And providing a better fall-back
>> version in compat/ can speed up this particular case to the point wh=
ere
>> the fourth patch becomes moot.
>=20
> Are these numbers telling me that with a good memmem() implementation=
,
> patch 4/4 is not just moot but actively detrimental?
>=20
> With a long enough needle, it entirely is possible that scanning the =
whole
> image with sublinear string search algorithm would perform much bette=
r
> than the preprocessing patch 4/4 does which has to scan all the bytes=
 in
> the common parts.

Yes, patch 4 makes it go slower than using memmem() alone, in this test=
=2E

Here are a few more numbers, all measured on Windows.  The topmost four
times in the column "long" should be the same as in the Windows column
above, yet they are slightly bigger.  Some background process must've
decided to do some work.

  git log -S"$STRING" HEAD -- kernel/sched.c >/dev/null

  short: STRING=3D'e'
  long:  STRING=3D'Ensure that the real time constraints are schedulabl=
e.'

                                  short  long
  v1.6.2-rc2                      9.120  9.266
  v1.6.2-rc2+[1-4]                3.037  3.048
  v1.6.2-rc2+[1-4]+memmem         2.994  2.964
  v1.6.2-rc2+[1-3]+memmem         8.514  8.528
  v1.6.2-rc2+[1-4]+memmem+linear  1.939  1.759
  v1.6.2-rc2+[1-3]+memmem+linear  2.315  1.559

So patch 4 helps significantly with short needles, while it hurts a bit
with long needles.  Linear memmem() is faster than the quadratic one we
currently have in compat/ in all cases.

Ren=C3=A9
