From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] gc: reject if another gc is running, unless --force
 is given
Date: Sat, 03 Aug 2013 12:40:37 +0200
Message-ID: <51FCDE25.9080805@kdbg.org>
References: <1375503605-32480-1-git-send-email-pclouds@gmail.com> <1375510890-4728-1-git-send-email-pclouds@gmail.com> <51FCD20E.8070406@kdbg.org> <20130803100113.GA8239@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 03 12:40:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5ZGN-0008JF-BD
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 12:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469Ab3HCKkj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Aug 2013 06:40:39 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:36376 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751344Ab3HCKkj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 06:40:39 -0400
X-Greylist: delayed 3092 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 Aug 2013 06:40:39 EDT
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id DE4D0CDF89;
	Sat,  3 Aug 2013 12:40:37 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 46C1319F5DD;
	Sat,  3 Aug 2013 12:40:37 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <20130803100113.GA8239@lanh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231578>

Am 03.08.2013 12:01, schrieb Duy Nguyen:
> On Sat, Aug 03, 2013 at 11:49:02AM +0200, Johannes Sixt wrote:
>> Am 03.08.2013 08:21, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy:
>>>  I changed mingw.h to add a stub uname() because I don't think MinG=
W
>>>  port has that function, but that's totally untested.
>>
>> Thanks, but we don't have kill(pid, 0), either :-(
>=20
> Yeah, I should have checked. Will this work?
>=20
> -- 8< --
> diff --git a/compat/mingw.c b/compat/mingw.c
> index bb92c43..14d92df 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1086,6 +1086,12 @@ int mingw_kill(pid_t pid, int sig)
>  		errno =3D err_win_to_posix(GetLastError());
>  		CloseHandle(h);
>  		return -1;
> +	} else if (pid > 0 && sig =3D=3D 0) {
> +		HANDLE h =3D OpenProcess(PROCESS_TERMINATE, FALSE, pid);
> +		if (h) {
> +			CloseHandle(h);
> +			return 0;
> +		}
>  	}
> =20
>  	errno =3D EINVAL;
> -- 8< --
>=20

Looks reasonable. PROCESS_QUERY_INFORMATION instead of PROCESS_TERMINAT=
E
should be sufficient, and errno =3D ESRCH; return -1; is missing.

-- Hannes
