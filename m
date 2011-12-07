From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v2 3/3] grep: disable threading in all but worktree case
Date: Wed, 07 Dec 2011 17:52:10 +0100
Message-ID: <4EDF99BA.3040006@lsrfire.ath.cx>
References: <cover.1322830368.git.trast@student.ethz.ch> <5328add8b32f83b4cdbd2e66283f77c125ec127a.1322830368.git.trast@student.ethz.ch> <4ED8F9AE.8030605@lsrfire.ath.cx> <4EDE9BBA.2010409@lsrfire.ath.cx> <20111207042431.GA10765@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Herman <eric@freesa.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 07 17:52:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYKjU-0001Jl-Gy
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 17:52:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754348Ab1LGQw3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Dec 2011 11:52:29 -0500
Received: from india601.server4you.de ([85.25.151.105]:39089 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754291Ab1LGQw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 11:52:26 -0500
Received: from [192.168.2.104] (p4FFD9BF7.dip.t-dialin.net [79.253.155.247])
	by india601.server4you.de (Postfix) with ESMTPSA id 740272F8032;
	Wed,  7 Dec 2011 17:52:24 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <20111207042431.GA10765@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186470>

Am 07.12.2011 05:24, schrieb Jeff King:
> On Tue, Dec 06, 2011 at 11:48:26PM +0100, Ren=C3=A9 Scharfe wrote:
>=20
>>  #ifndef NO_PTHREADS
>> -	if (use_threads) {
>> +	if (nr_threads > 0) {
>>  		grep_sha1_async(opt, name, sha1);
>>  		return 0;
>>  	} else
>=20
> Should this be "if (nr_threads > 1)"?
>=20
> As a user, I would do:
>=20
>   git grep --threads=3D1 ...
>=20
> if I wanted a single-threaded process. Instead, we actually spawn a
> sub-thread and do all of the locking, which has a measurable cost:

Yes, the difference is measurable, and that's exactly how I like it to
be. :)  A user can turn off threading with --threads=3D0 or (more
intuitively) --no-threads.  And we can quantify the overhead.

>   $ time git grep --threads=3D0 SIMPLE HEAD >/dev/null
>   real    0m2.994s
>   user    0m2.932s
>   sys     0m0.060s
>=20
>   $ time git grep --threads=3D1 SIMPLE HEAD >/dev/null
>   real    0m3.407s
>   user    0m3.392s
>   sys     0m0.140s
>=20
> Should --threads=3D1 be equivalent to --threads=3D0?

We can do that if there's another way to calculate this difference, or
if it is not useful to know.  I find your results interesting at least,
though. :)

Ren=C3=A9
