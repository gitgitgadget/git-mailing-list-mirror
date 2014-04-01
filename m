From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH 1/2] date: recognize bogus FreeBSD gmtime output
Date: Tue, 01 Apr 2014 23:17:14 +0200
Message-ID: <533B2CDA.30307@web.de>
References: <20140401073848.GA22023@sigill.intra.peff.net>	<20140401074251.GA22550@sigill.intra.peff.net>	<533AFA86.2090905@web.de> <xmqq7g7827h8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Charles Bailey <cbailey32@bloomberg.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 23:17:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV63z-0006Hk-AS
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 23:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbaDAVRj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Apr 2014 17:17:39 -0400
Received: from mout.web.de ([212.227.15.14]:64924 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751366AbaDAVRi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 17:17:38 -0400
Received: from [192.168.178.27] ([79.253.130.66]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0M4I79-1XLHEy3m0R-00rt6N; Tue, 01 Apr 2014 23:17:36
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <xmqq7g7827h8.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:/UeoDGoyKThZlVy6HcQWcF5UZiqvoglemQnro0mJPmAu7nbplz+
 4E5HYUM95korP7IngT5b7fbRbETYZYh2rkR9JLnVORjGP1c+R/rw1HWNM4MGDXquMa9PFtX
 4nN9OQD8fVJZAoPSLEZwVDPNVlTE/7b8fkaZkccpC1cIpFvtX+YYdnv9z9le70LyYIm9HI4
 GgVISQDiKhwyJEXLA58DQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245659>

Am 01.04.2014 21:08, schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Am 01.04.2014 09:42, schrieb Jeff King:
>>> diff --git a/compat/gmtime.c b/compat/gmtime.c
>>> new file mode 100644
>>> index 0000000..ffcabf4
>>> --- /dev/null
>>> +++ b/compat/gmtime.c
>>> @@ -0,0 +1,26 @@
>>> +#include "../git-compat-util.h"
>>> +#undef gmtime
>>> +#undef gmtime_r
>>> +
>>> +struct tm *git_gmtime(const time_t *timep)
>>> +{
>>> +	static struct tm result;
>>> +	return git_gmtime_r(timep, &result);
>>> +}
>>> +
>>> +struct tm *git_gmtime_r(const time_t *timep, struct tm *result)
>>> +{
>>> +	struct tm *ret;
>>> +
>>> +	ret =3D gmtime_r(timep, result);
>>> +
>>> +	/*
>>> +	 * Rather than NULL, FreeBSD gmtime will return a "struct tm" wit=
h all
>>> +	 * fields zeroed. Since "mday" cannot otherwise be zero, we can t=
est
>>> +	 * this very quickly.
>>> +	 */
>>> +	if (ret && !ret->tm_mday)
>>> +		ret =3D NULL;
>>> +
>>> +	return ret;
>>> +}
>>
>> http://pubs.opengroup.org/onlinepubs/009695399/functions/gmtime.html
>> says that errno shall be set on error and only mentions EOVERFLOW as=
 a
>> possible error code.
>
> So are you saying we should set EOVERFLOW ourselves, or does FreeBSD
> set EOVERFLOW for us in this case and we do not have to worry?

If we correct the return value then we should correct errno as well.=20
gmtime() on FreeBSD 10 leaves errno untouched when it encounters an=20
overflow.

While testing this again I just noticed that FreeBSD doesn't strictly=20
return a pointer to a cleared struct tm.  It simply leaves its static=20
buffer untouched.  We should probably clear it (memset in git_gmtime_r)=
=2E

Demo program:

-- >8 --
#include <stdio.h>
#include <time.h>

const static time_t epoch;

int main(int argc, char **argv)
{
         time_t t =3D 99999999999999999;

         printf("%s", ctime(&t));
         printf("%s", asctime(gmtime(&t)));

         printf("%s", ctime(&t));
         gmtime(&epoch);
         printf("%s", asctime(gmtime(&t)));

         return 0;
}
-- 8< --

Results on FreeBSD 10:

	Wed Sep  6 11:46:39     -1126091476
	Wed Sep  6 11:46:39     -1126091476
	Wed Sep  6 11:46:39     -1126091476
	Thu Jan  1 00:00:00 1970

Ren=C3=A9
