From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 4/2] grep: turn off threading for non-worktree
Date: Wed, 07 Dec 2011 18:11:47 +0100
Message-ID: <4EDF9E53.7090702@lsrfire.ath.cx>
References: <cover.1322830368.git.trast@student.ethz.ch> <5328add8b32f83b4cdbd2e66283f77c125ec127a.1322830368.git.trast@student.ethz.ch> <4ED8F9AE.8030605@lsrfire.ath.cx> <4EDE9BBA.2010409@lsrfire.ath.cx> <4EDE9ED1.8010502@lsrfire.ath.cx> <20111207044242.GB10765@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Eric Herman <eric@freesa.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 07 18:12:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYL2X-0002ec-JN
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 18:12:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757272Ab1LGRMI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Dec 2011 12:12:08 -0500
Received: from india601.server4you.de ([85.25.151.105]:39105 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756687Ab1LGRME (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 12:12:04 -0500
Received: from [192.168.2.104] (p4FFD9BF7.dip.t-dialin.net [79.253.155.247])
	by india601.server4you.de (Postfix) with ESMTPSA id C97852F8032;
	Wed,  7 Dec 2011 18:12:01 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <20111207044242.GB10765@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186474>

Am 07.12.2011 05:42, schrieb Jeff King:
> On Wed, Dec 07, 2011 at 12:01:37AM +0100, Ren=C3=A9 Scharfe wrote:
>=20
>> Reading of git objects needs to be protected by an exclusive lock
>> and cannot be parallelized.  Searching the read buffers can be done
>> in parallel, but for simple expressions threading is a net loss due
>> to its overhead, as measured by Thomas.  Turn it off unless we're
>> searching in the worktree.
>=20
> Based on my earlier numbers, I was going to complain that we should
> also be checking the "simple expressions" assumption here, as time sp=
ent
> in the actual regex might be important.
>=20
> However, after trying to repeat my experiment, I think the numbers I
> posted earlier were misleading. For example, using my "more complex"
> regex of 'a.*b':
>=20
>   $ time git grep --threads=3D8 'a.*b' HEAD >/dev/null
>   real    0m8.655s
>   user    0m23.817s
>   sys     0m0.480s
>=20
> Look at that sweet, sweet parallelism. It's a quad-core with
> hyperthreading, so we're not getting the 8x speedup we might hope for
> (presumably due to lock contention on extracting blobs), but hey, 3x
> isn't bad. Except, wait:
>=20
>   $ time git grep --threads=3D0 'a.*b' HEAD >/dev/null
>   real    0m7.651s
>   user    0m7.600s
>   sys     0m0.048s
>=20
> We can get 1x on a single core, but the total time is lower! This
> processor is an i7 with "turbo boost", which means it clocks higher i=
n
> single-core mode than when multiple cores are active. So the numbers =
I
> posted earlier were misleading. Yes, we got parallelism, but at the c=
ost
> of knocking the clock speed down for a net loss.

Ugh, right, Turbo Boost complicates matters.

I don't understand the multiplied user time in the threaded case,
though.  Is it caused by busy-waiting?  Thomas reported similar numbers
earlier.

> The sweet spot for me seems to be:
>=20
>   $ time git grep --threads=3D2 'a.*b' HEAD >/dev/null
>   real    0m6.303s
>   user    0m11.129s
>   sys     0m0.220s
>=20
> I'd be curious to see results from somebody with a quad-core (or more=
)
> without turbo boost; I suspect that threading may have more benefit
> there, even though we have some lock contention for blobs.

It would be nice if we could come up with simple rules to calculate
defaults for the number of threads on a given run.  Users shouldn't hav=
e
to specify this option normally.  And it would be good if these rules
didn't require a list of all CPUs known to git. :)

>> --- a/builtin/grep.c
>> +++ b/builtin/grep.c
>> @@ -1048,7 +1048,7 @@ int cmd_grep(int argc, const char **argv, cons=
t char *prefix)
>>  	nr_threads =3D 0;
>>  #else
>>  	if (nr_threads =3D=3D -1)
>> -		nr_threads =3D (online_cpus() > 1) ? THREADS : 0;
>> +		nr_threads =3D (online_cpus() > 1 && !list.nr) ? THREADS : 0;
>> =20
>>  	if (nr_threads > 0) {
>>  		opt.use_threads =3D 1;
>=20
> This doesn't kick in for "--cached", which has the same performance
> characteristics as grepping a tree. I think you want to add "&& !cach=
ed" to
> the conditional.

Oh, yes.

Ren=C3=A9
