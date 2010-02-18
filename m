From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Teach "git add" and friends to be paranoid
Date: Thu, 18 Feb 2010 08:27:28 +0100
Message-ID: <5DDD89A9-900F-40AD-8F3F-F756D6E0AD6C@wincent.com>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org> <20100213121238.GA2559@progeny.tock> <20100213133951.GA14352@Knoppix> <201002131539.54142.trast@student.ethz.ch> <20100213162924.GA14623@Knoppix> <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com> <20100213223733.GP24809@gibbs.hungrycats.org> <20100214011812.GA2175@dpotapov.dyndns.org> <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org> <20100218013822.GB15870@coredump.intra.peff.net> <alpine.LFD.2.00.1002172350080.1946@xanadu.home> <7vocjnqf5c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>, Jeff King <peff@peff.net>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 08:27:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni0nc-0002MJ-BJ
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 08:27:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802Ab0BRH1n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Feb 2010 02:27:43 -0500
Received: from outmail128067.authsmtp.com ([62.13.128.67]:56162 "EHLO
	outmail128067.authsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752607Ab0BRH1m convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 02:27:42 -0500
Received: from mail-c187.authsmtp.com (mail-c187.authsmtp.com [62.13.128.33])
	by punt10.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o1I7Rdjp031056;
	Thu, 18 Feb 2010 07:27:39 GMT
Received: from wincent1.inetu.net (wincent1.inetu.net [209.235.192.161])
	(authenticated bits=128)
	by mail.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o1I7RaSR041448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Feb 2010 07:27:37 GMT
Received: from [192.168.1.2] (185.Red-83-60-142.dynamicIP.rima-tde.net [83.60.142.185] (may be forged))
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id o1I7RUaQ031685
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 18 Feb 2010 02:27:32 -0500
In-Reply-To: <7vocjnqf5c.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1077)
X-Server-Quench: 1736dd03-1c5f-11df-ab46-001185d377ca
X-AuthReport-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd3ZggRAFZKTQIy FSICByJGVUMuIRha BAIHMQpCJFdJBEVH axYdAFdZdwdEHAkR A2EBWVNeU1U/W2N8 dQhSaBtca0hQXgNr T0pMXVMcSwQRBn5Q ZXweVhh2cw0Ienh3 Z0YsX3dYWhAudUVg Qx1RQ3AHZDM2dTFN VEZFdwNVcQtPKhxC bQMuGhFYa3VsBgsE NC8Gdww8ND5fYG5a Qx1FJF4eCw4CGDJ0 SQoDEDMjBgUZQG05 IlQ+I0QVGkEQPi0o 
X-Authentic-SMTP: 61633436303433.1000:706/Kp
X-AuthFastPath: 255
X-Virus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140301>

El 18/02/2010, a las 06:36, Junio C Hamano escribi=F3:

> Nicolas Pitre <nico@fluxnic.net> writes:
>=20
>> It is likely to have better performance if the buffer is small enoug=
h to=20
>> fit in the CPU L1 cache.  There are two sequencial passes over the=20
>> buffer: one for the SHA1 computation, and another for the compressio=
n,=20
>> and currently they're sure to trash the L1 cache on each pass.
>=20
> I did a very unscientific test to hash about 14k paths (arch/ and fs/=
 from
> the kernel source) using "git-hash-object -w --stdin-paths" into an e=
mpty
> repository with varying sizes of paranoia buffer (quarter, 1, 4, 8 an=
d
> 256kB) and saw 8-30% overhead.  256kB did hurt and around 4kB seemed =
to be
> optimal for my this small sample load.
>=20
> In any case, with any size of paranoia, this hurts the sane use case,=
 so
> I'd introduce an expert switch to disable it, like this.

Shouldn't a switch that hurts performance and is only needed for insane=
 use cases default to off rather than on?

Cheers,
Wincent
