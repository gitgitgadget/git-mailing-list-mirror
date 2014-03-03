From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 01/27] path.c: make get_pathname() return strbuf
 instead of static buffer
Date: Mon, 3 Mar 2014 07:14:56 +0700
Message-ID: <CACsJy8DEkMJ+RD8ekLWRCy_d4Zm1x18ELg7fyndEt+zcynZ5XA@mail.gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
 <1393675983-3232-1-git-send-email-pclouds@gmail.com> <1393675983-3232-2-git-send-email-pclouds@gmail.com>
 <CAPig+cQubZByK3rNPOJy8rfLZpALpW0dOMz55gnFWRPppTAApg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 01:15:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKGXc-0008Nl-Mv
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 01:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752927AbaCCAP2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Mar 2014 19:15:28 -0500
Received: from mail-qc0-f173.google.com ([209.85.216.173]:34125 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbaCCAP1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Mar 2014 19:15:27 -0500
Received: by mail-qc0-f173.google.com with SMTP id r5so1834417qcx.4
        for <git@vger.kernel.org>; Sun, 02 Mar 2014 16:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=VAaD5WPesHqFZQyUMsHfgfxXxjQ+em349OoipM3SW7Y=;
        b=IebWgunMLKLSKo7HkbvKIeUy9GfM5aexB2atwNXKDrJxTtdkAZc8/wimklniC71WcB
         4RNtIWIXlaVQfOvoY4ICsAfX3X/1bA5cwz2ZiUBNzAKo6HLA1jAPMX93o20iRq0+xlvO
         u0L0xzo87dn31O431JEErunDh9Hyt/yWVliBUNHulEkj0vOj1IR1fu3T6HBXhm0mRf5Q
         MoD+LtwasGMcBhFpNRD8IOSzFv631fUSDGRd1pu96JCRz59by4rQ4ThZyMEcJoSIl2we
         y+0ZR0sr/7L6hAXsCZdyCiz/3WXwqYnzOusVg/TOZMEntDr7cZDn6OP4+4uADlIGDJxL
         kDkg==
X-Received: by 10.140.51.109 with SMTP id t100mr18864938qga.50.1393805726653;
 Sun, 02 Mar 2014 16:15:26 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Sun, 2 Mar 2014 16:14:56 -0800 (PST)
In-Reply-To: <CAPig+cQubZByK3rNPOJy8rfLZpALpW0dOMz55gnFWRPppTAApg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243167>

On Mon, Mar 3, 2014 at 2:51 AM, Eric Sunshine <sunshine@sunshineco.com>=
 wrote:
> On Sat, Mar 1, 2014 at 7:12 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy <pclouds@gmail.com> wrote:
>> We've been avoiding PATH_MAX whenever possible. This patch makes
>> get_pathname() return a strbuf and updates the callers to take
>> advantage of this. The code is simplified as we no longer need to
>> worry about buffer overflow.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>> diff --git a/path.c b/path.c
>> index 24594c4..5346700 100644
>> --- a/path.c
>> +++ b/path.c
>> @@ -49,85 +60,70 @@ char *mksnpath(char *buf, size_t n, const char *=
fmt, ...)
>>         return cleanup_path(buf);
>>  }
>>
>> -static char *vsnpath(char *buf, size_t n, const char *fmt, va_list =
args)
>> +static void vsnpath(struct strbuf *buf, const char *fmt, va_list ar=
gs)
>>  {
>>         const char *git_dir =3D get_git_dir();
>> -       size_t len;
>> -
>> -       len =3D strlen(git_dir);
>> -       if (n < len + 1)
>> -               goto bad;
>> -       memcpy(buf, git_dir, len);
>> -       if (len && !is_dir_sep(git_dir[len-1]))
>> -               buf[len++] =3D '/';
>> -       len +=3D vsnprintf(buf + len, n - len, fmt, args);
>> -       if (len >=3D n)
>> -               goto bad;
>> -       return cleanup_path(buf);
>> -bad:
>> -       strlcpy(buf, bad_path, n);
>> -       return buf;
>> +       strbuf_addstr(buf, git_dir);
>> +       if (buf->len && !is_dir_sep(buf->buf[buf->len - 1]))
>> +               strbuf_addch(buf, '/');
>> +       strbuf_vaddf(buf, fmt, args);
>> +       strbuf_cleanup_path(buf);
>>  }
>
> There's a slight semantic change here. The old code overwrote 'buf',
> but the new code appends to 'buf'. For someone familiar with
> sprintf(), or typical va_list or variadic functions there may be an
> intuitive expectation that 'buf' will be overwritten. Should this cod=
e
> be doing strbuf_reset() as its first action (or should that be the
> responsibility of the caller who is reusing 'buff')?

those callers that use get_pathname() already have strbuf reset, so
I'd say let the remaining callers reset the buffer.

>
>>  char *mkpath(const char *fmt, ...)
>>  {
>>         va_list args;
>> -       unsigned len;
>> -       char *pathname =3D get_pathname();
>> -
>> +       struct strbuf *pathname =3D get_pathname();
>>         va_start(args, fmt);
>> -       len =3D vsnprintf(pathname, PATH_MAX, fmt, args);
>> +       strbuf_vaddf(pathname, fmt, args);
>>         va_end(args);
>> -       if (len >=3D PATH_MAX)
>> -               return bad_path;
>> -       return cleanup_path(pathname);
>> +       return cleanup_path(pathname->buf);
>>  }
>
> Prior to this change, it was possible (though probably not
> recommended) for a caller to append gunk to the returned path up to
> PATH_MAX without worrying about stomping memory. With the change, thi=
s
> is no longer true. Should the function be changed to return 'const
> char *' to enforce this restriction?

Sure. Will do (same for below)
--=20
Duy
