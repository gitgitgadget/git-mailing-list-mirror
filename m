From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3] gettext.c: detect the vsnprintf bug at runtime
Date: Mon, 2 Dec 2013 12:57:36 +0700
Message-ID: <CACsJy8B5aBGnm=04y60W1XVovHVryP1Co0_mmgV0f7Ox13aGjw@mail.gmail.com>
References: <1385812884-23776-1-git-send-email-pclouds@gmail.com>
 <1385865938-16392-1-git-send-email-pclouds@gmail.com> <529BD4E1.8040408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Niedier <jrnieder@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 02 06:58:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnMWM-0002Jf-Ey
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 06:58:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323Ab3LBF6I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Dec 2013 00:58:08 -0500
Received: from mail-qa0-f51.google.com ([209.85.216.51]:33022 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094Ab3LBF6G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Dec 2013 00:58:06 -0500
Received: by mail-qa0-f51.google.com with SMTP id o15so4007671qap.3
        for <git@vger.kernel.org>; Sun, 01 Dec 2013 21:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=yXIs9uATHxOc9N8j3OXDVqD4y5fUYP0j9oNo4sc/I4g=;
        b=hGwqQ8C/Qx4OSEjRrSl/opQ83ujFCFac9bn8Re7wGRMqkNp+RwAzcKLE6AhdIN7hG7
         bKSryCT7vsbDHDZBtYdUqptp0IClkUaAQspWbZw53VVV9d+Rex/gjm7GDGUqavT9u8qx
         IVwSL2Q4En3P6ZlyTCw010/4mTQhN7xGHAiGVc7euK12aPi/As2QQNodxWpfSoEG4HwX
         bo22+o5c0slxrx5Uk4SpDeemWISkU+JEYtARqFo52dim3rVqTrObkd6jmKXoyRgSUeIQ
         eDfjZHjAIpHFzDUetJL6Qo11mHTQbZABIFHzyn/A2SJ1cNkFcm0X/JVspq/GkDduxm9N
         Psdw==
X-Received: by 10.229.137.135 with SMTP id w7mr110023937qct.14.1385963886115;
 Sun, 01 Dec 2013 21:58:06 -0800 (PST)
Received: by 10.96.124.101 with HTTP; Sun, 1 Dec 2013 21:57:36 -0800 (PST)
In-Reply-To: <529BD4E1.8040408@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238610>

On Mon, Dec 2, 2013 at 7:31 AM, Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n <vn=
wildman@gmail.com> wrote:
>> --- a/gettext.c
>> +++ b/gettext.c
>> @@ -29,6 +29,17 @@ int use_gettext_poison(void)
>>  #endif
>>
>>  #ifndef NO_GETTEXT
>> +static int test_vsnprintf(const char *fmt, ...)
>> +{
>> +     char buf[26];
>> +     int ret;
>> +     va_list ap;
>> +     va_start(ap, fmt);
>> +     ret =3D vsnprintf(buf, sizeof(buf), fmt, ap);
>> +     va_end(ap);
>> +     return ret;
>> +}
>> +
> this function alway run each time we run git commad while libc is
> static. It is waste.
>> +     /* the string is taken from v0.99.6~1 */
>> +     if (test_vsnprintf("%.*s", 13, "David_K\345gedal") < 0)
>> +             setlocale(LC_CTYPE, "C");
>>  }
>>
>>  void git_setup_gettext(void)
>
> I suggest use C preprocessor instead. The person who complete git (ma=
ke debian, rpm etc. package) decide  enable it or not (disable by defau=
lt). Most of people use git from distribution instead of complete it fr=
om source.
>
> #ifndef VSNPRINTF_OK
>         setlocale(LC_CTYPE, "C");
> #endif
>

A single vsnprintf is cheap enough that I would not worry about
performance impact. Given a choice between this and distro
maintainers, some of them do check release notes, some not so much,
I'd rather go with this.
--=20
Duy
