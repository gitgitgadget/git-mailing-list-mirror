From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 19/27] wrapper.c: wrapper to open a file, fprintf then close
Date: Mon, 3 Mar 2014 21:47:05 -0500
Message-ID: <CAPig+cQT33-h2nmRDD8FC7KrCH-1UPqK39Vb3qHKSKz8nhtndQ@mail.gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1393675983-3232-1-git-send-email-pclouds@gmail.com>
	<1393675983-3232-20-git-send-email-pclouds@gmail.com>
	<531214BC.3070704@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 04 03:47:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKfNv-0001bh-O8
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 03:47:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756081AbaCDCrH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Mar 2014 21:47:07 -0500
Received: from mail-yk0-f177.google.com ([209.85.160.177]:36372 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755980AbaCDCrG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Mar 2014 21:47:06 -0500
Received: by mail-yk0-f177.google.com with SMTP id q200so12850605ykb.8
        for <git@vger.kernel.org>; Mon, 03 Mar 2014 18:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=kzg3hBSyhc3yeTzROJFaJA6/qjXn6Yfa2zyuj23O72Q=;
        b=EcJZbXSsXyog6D0tsqm7cUnYE7TniNMilGWPk+CDOP+z540r4CSUUbwNTUrbMgtn3E
         CwnHQH9R1szTm32Ta6RNuRGIZpfP4x0omNGr7NAlLu1SZh+3QcAMogztjLtjZnsSrMH/
         Mxmicj8A5EMF5NiL8siIZegyLM9cqVYHejEloNjtASO/nB3sr8HJvAsI0RfMtt3QI+P5
         1kLQfM6pjHdas/mRAd5z0g+sJ3W/82f0Zh+0AD0ReuBqZLs8WWkAZoI5XWhdihd7jtgz
         U2Hu0l7TgGj7s7x0mTgr1SOxWEP/4MAsznPfPRAztgwTYin1LAmpJKRK2+s5X4GRskll
         Cpnw==
X-Received: by 10.236.147.129 with SMTP id t1mr5695985yhj.91.1393901225297;
 Mon, 03 Mar 2014 18:47:05 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Mon, 3 Mar 2014 18:47:05 -0800 (PST)
In-Reply-To: <531214BC.3070704@web.de>
X-Google-Sender-Auth: CtZFDqfQUH5Yw0PxEb_f5gV2iFs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243324>

On Sat, Mar 1, 2014 at 12:11 PM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> On 2014-03-01 13.12, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  cache.h   |  2 ++
>>  wrapper.c | 31 +++++++++++++++++++++++++++++++
>>  2 files changed, 33 insertions(+)
>>
>> diff --git a/cache.h b/cache.h
>> index 98b5dd3..99b86d9 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -1239,6 +1239,8 @@ static inline ssize_t write_str_in_full(int fd=
, const char *str)
>>  {
>>       return write_in_full(fd, str, strlen(str));
>>  }
>> +__attribute__((format (printf,3,4)))
>> +extern int write_file(const char *path, int fatal, const char *fmt,=
 ...);
>>
>>  /* pager.c */
>>  extern void setup_pager(void);
>> diff --git a/wrapper.c b/wrapper.c
>> index 0cc5636..5ced50d 100644
>> --- a/wrapper.c
>> +++ b/wrapper.c
>> @@ -455,3 +455,34 @@ struct passwd *xgetpwuid_self(void)
>>                   errno ? strerror(errno) : _("no such user"));
>>       return pw;
>>  }
>> +
>> +int write_file(const char *path, int fatal, const char *fmt, ...)
>> +{
>> +     struct strbuf sb =3D STRBUF_INIT;
>> +     int fd =3D open(path, O_RDWR | O_CREAT | O_TRUNC, 0666);
>> +     va_list params;
>> +     if (fd < 0) {

Micro nit atop Torsten's micro nit:

It is 3% easier to understand the code if the check for open() failure
immediately follows the open() attempt:

    va_list params;
    int fd =3D open(...);
    if (fd < 0) {

>> +             if (fatal)
>> +                     die_errno(_("could not open %s for writing"), =
path);
>> +             return -1;
>> +     }
>> +     va_start(params, fmt);
>> +     strbuf_vaddf(&sb, fmt, params);
>> +     va_end(params);
>> +     if (write_in_full(fd, sb.buf, sb.len) !=3D sb.len) {
>> +             int err =3D errno;
>> +             close(fd);
>> +             errno =3D err;
>> +             strbuf_release(&sb);
> Micro nit:
> Today we now what strbuf_release() is doing, but if we ever change th=
e
> implementation, it is 3% safer to keep err a little bit longer like t=
his:
>> +             strbuf_release(&sb);
>> +             errno =3D err;
