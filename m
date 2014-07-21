From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH v2 2/4] use strbuf_getcwd() to get the current working
 directory without fixed-sized buffers
Date: Mon, 21 Jul 2014 19:10:13 +0200
Message-ID: <53CD4975.8050002@web.de>
References: <53CBF277.3090101@web.de> <53CBF332.2050301@web.de> <20140721023312.GC22750@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTg==?= =?UTF-8?B?Z+G7jWMgRHV5?= 
	<pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 21 19:11:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9H7Y-0004VO-VJ
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 19:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933022AbaGURLY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jul 2014 13:11:24 -0400
Received: from mout.web.de ([212.227.17.12]:49390 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932883AbaGURLX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2014 13:11:23 -0400
Received: from [192.168.178.27] ([79.250.189.35]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0Lx7Mz-1WTJTN0gcT-016eoZ; Mon, 21 Jul 2014 19:10:48
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140721023312.GC22750@peff.net>
X-Provags-ID: V03:K0:xDcOoSSsXHoN36aKWIjXt2P+/9JnrUvg65JLgXVMp3Lqd92yrjF
 /QikEftyoaWVN/jZEBza+X5qc7YIEIxTge4uYD02WOsmIEPiZ5we3a9b3k++v8tEGDNLafB
 NGoV9bVVSZHMEUWD5J+iP+9GyLTAVqz3JLi7g+UOxRtgxt7EuQVRisu7tZEnVF9XJpoa6wA
 h2e5vOCnJMrjovcRfhsqA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253978>

Am 21.07.2014 04:33, schrieb Jeff King:
> On Sun, Jul 20, 2014 at 06:49:54PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> diff --git a/builtin/init-db.c b/builtin/init-db.c
>> index 56f85e2..c4958b6 100644
>> --- a/builtin/init-db.c
>> +++ b/builtin/init-db.c
>> @@ -535,10 +535,10 @@ int cmd_init_db(int argc, const char **argv, c=
onst char *prefix)
>>   		usage(init_db_usage[0]);
>>   	}
>>   	if (is_bare_repository_cfg =3D=3D 1) {
>> -		static char git_dir[PATH_MAX+1];
>> -
>> -		setenv(GIT_DIR_ENVIRONMENT,
>> -			getcwd(git_dir, sizeof(git_dir)), argc > 0);
>> +		struct strbuf cwd =3D STRBUF_INIT;
>> +		strbuf_getcwd(&cwd);
>> +		setenv(GIT_DIR_ENVIRONMENT, cwd.buf, argc > 0);
>> +		strbuf_release(&cwd);
>
> Hmm. You are not making anything worse here, as we already do not che=
ck
> the return value of getcwd. But what happens if it fails? Looks like =
we
> currently get a segfault, and the new code will silently set the
> variable to the empty string. Neither is particularly helpful.
>
> Should we be using the xgetcwd helper that you add in the next patch?

Probably.  And I was so glad to have found an example case for getcwd=20
without dying and without touching the get-there-and-back cases. :)=20
Guess I'll have to look closer at setup.c and perhaps unix-socket.c for=
=20
a replacement.

By the way: Simply setting $GIT_DIR to "." probably won't work in the=20
two cases, I guess?

>
>> -			setenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir, sizeof(git_dir)), 0)=
;
>> +			strbuf_getcwd(&cwd);
>> +			setenv(GIT_DIR_ENVIRONMENT, cwd.buf, 0);
>> +			strbuf_release(&cwd);
>
> Ditto here.
>
> -Peff
>
