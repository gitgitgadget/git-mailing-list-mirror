From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: RLIMIT_NOFILE fallback
Date: Thu, 19 Dec 2013 18:30:00 +0100
Message-ID: <52B32D18.80400@web.de>
References: <20131218171446.GA19657@kitenet.net> <xmqqy53ihwe4.fsf@gitster.dls.corp.google.com> <20131218191702.GA9083@sigill.intra.peff.net> <xmqq61qmhrb3.fsf@gitster.dls.corp.google.com> <20131218212847.GA13685@sigill.intra.peff.net> <xmqqd2kthmcr.fsf@gitster.dls.corp.google.com> <20131218214001.GA14354@sigill.intra.peff.net> <xmqqzjnxg3zz.fsf@gitster.dls.corp.google.com> <20131219001519.GB17420@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joey Hess <joey@kitenet.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 19 18:30:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VthQW-0002JJ-VY
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 18:30:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754704Ab3LSRaN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Dec 2013 12:30:13 -0500
Received: from mout.web.de ([212.227.15.14]:53104 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754591Ab3LSRaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Dec 2013 12:30:09 -0500
Received: from [192.168.37.101] ([87.146.157.58]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MduaT-1W9zmM0euj-00Pd3E for <git@vger.kernel.org>;
 Thu, 19 Dec 2013 18:30:07 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20131219001519.GB17420@sigill.intra.peff.net>
X-Provags-ID: V03:K0:oAlgIOUyX7g1znitmmF2Cq/p7OJSMpfGvvWOpN+KgBlq3Olbj6N
 7fxnJcOU8Dc0ml+yM693CI5WJ1hakoTGhLAra6RzJylKuV2WN9zcbFsXpTrOs3Q9FEBBE+1
 wmlEX7Ejdg59hhq8SHr7PvUaU9QC/mQz6ifBd6WR3E7BNJCDH6akosCiK21sMtL7QAA9LGS
 5ItFsFPeH6Cxh/zMRvMdA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239526>

On 2013-12-19 01.15, Jeff King wrote:
> On Wed, Dec 18, 2013 at 02:59:12PM -0800, Junio C Hamano wrote:
>=20
>> Jeff King <peff@peff.net> writes:
>>
>>>> Yes, that is locally OK, but depending on how the caller behaves, =
we
>>>> might need to have an extra saved_errno dance here, which I didn't
>>>> want to get into...
>>>
>>> I think we are fine. The only caller is about to clobber errno by
>>> closing packs anyway.
>=20
> Also, I do not think we would be any worse off than the current code.
> getrlimit almost certainly just clobbered errno anyway. Either it is
> worth saving for the whole function, or not at all (and I think not a=
t
> all).
>=20
>> diff --git a/sha1_file.c b/sha1_file.c
>> index 760dd60..288badd 100644
>> --- a/sha1_file.c
>> +++ b/sha1_file.c
>> @@ -807,15 +807,38 @@ void free_pack_by_name(const char *pack_name)
>>  static unsigned int get_max_fd_limit(void)
>>  {
>>  #ifdef RLIMIT_NOFILE
>> -	struct rlimit lim;
>> +	{
>> +		struct rlimit lim;
>> =20
>> -	if (getrlimit(RLIMIT_NOFILE, &lim))
>> -		die_errno("cannot get RLIMIT_NOFILE");
>> +		if (!getrlimit(RLIMIT_NOFILE, &lim))
>> +			return lim.rlim_cur;
>> +	}
>> +#endif
>=20
> Yeah, I think pulling the variable into its own block makes this more
> readable.
>=20
>> +#ifdef _SC_OPEN_MAX
>> +	{
>> +		long open_max =3D sysconf(_SC_OPEN_MAX);
>> +		if (0 < open_max)
>> +			return open_max;
>> +		/*
>> +		 * Otherwise, we got -1 for one of the two
>> +		 * reasons:
>> +		 *
>> +		 * (1) sysconf() did not understand _SC_OPEN_MAX
>> +		 *     and signaled an error with -1; or
>> +		 * (2) sysconf() said there is no limit.
>> +		 *
>> +		 * We _could_ clear errno before calling sysconf() to
>> +		 * tell these two cases apart and return a huge number
>> +		 * in the latter case to let the caller cap it to a
>> +		 * value that is not so selfish, but letting the
>> +		 * fallback OPEN_MAX codepath take care of these cases
>> +		 * is a lot simpler.
>> +		 */
>> +	}
>> +#endif
>=20
> This is probably OK. I assume sane systems actually provide OPEN_MAX,
> and/or have a working getrlimit in the first place.
>=20
> The fallback of "1" is actually quite low and can have an impact. Bot=
h
> for performance, but also for concurrent use. We used to run into a
> problem at GitHub where pack-objects serving a clone would have its
> packfile removed from under it (by a concurrent repack), and then wou=
ld
> die. The normal code paths are able to just retry the object lookup a=
nd
> find the new pack, but the pack-objects code is a bit more intimate w=
ith
> the particular packfile and cannot (currently) do so. With a large
> enough mmap window and descriptor limit, we just keep the packfiles
> open. But if we have to close them for resource limits (like a too-lo=
w
> descriptor limit), then we can end up in the die() situation above.
>=20
> -Peff

Thanks for an interesting reading,
please allow a side question:
Could it be, that "-1 =3D=3D unlimited" is Linux specific?
And therefore not 100% portable ?

And doesn't "unlimited" number of files call for trouble,
having the risk to starve the machine ?

BTW: cygwin returns 256.

------------
http://pubs.opengroup.org/onlinepubs/007908799/xsh/sysconf.html
RETURN VALUE

    If name is an invalid value, sysconf() returns -1 and sets errno to=
 indicate the error. If the variable corresponding to name is associate=
d with functionality that is not supported by the system, sysconf() ret=
urns -1 without changing the value of errno.=20

---------- Mac OS, based on BSD (?): ----------=20
RETURN VALUES
     If the call to sysconf() is not successful, -1 is returned and err=
no is
     set appropriately.  Otherwise, if the variable is associated with =
func-
     tionality that is not supported, -1 is returned and errno is not m=
odi-
     fied.  Otherwise, the current variable value is returned.

ERRORS
     The sysconf() function may fail and set errno for any of the error=
s spec-
     ified for the library function sysctl(3).  In addition, the follow=
ing
     error may be reported:

     [EINVAL]           The value of the name argument is invalid.
[snip]
     The sysconf() function first appeared in 4.4BSD.

-----------
Linux, Debian:
      OPEN_MAX - _SC_OPEN_MAX
              The  maximum number of files that a process can have open=
 at any
              time.  Must not be less than _POSIX_OPEN_MAX (20).
[snip]
RETURN VALUE
       If name is invalid, -1 is returned, and errno is set to EINVAL. =
 Other=E2=80=90
       wise, the value returned is the value of the system resource and=
  errno
       is  not  changed.  In the case of options, a positive value is r=
eturned
       if a queried option is available, and -1 if it is not.  In the c=
ase  of
       limits, -1 means that there is no definite limit.
