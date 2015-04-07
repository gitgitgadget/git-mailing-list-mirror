From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 1/4] sha1_file.c: support reading from a loose object
 of unknown type
Date: Tue, 7 Apr 2015 16:46:33 -0400
Message-ID: <CAPig+cQfdvyscUoMxCk7JrvzqaKRGTg=6E+YUCLtciHr7Zq9SA@mail.gmail.com>
References: <1428126162-18987-1-git-send-email-karthik.188@gmail.com>
	<1428258505-25223-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 22:46:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfaOO-0000yY-OL
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 22:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753790AbbDGUqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2015 16:46:37 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:36281 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328AbbDGUqf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2015 16:46:35 -0400
Received: by lagv1 with SMTP id v1so51516181lag.3
        for <git@vger.kernel.org>; Tue, 07 Apr 2015 13:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=WIcN9xIMKffM8m1LhzPhDKqbgokqpt7JQPtMrwqiBMI=;
        b=FLBkHcs0HECIw/sD/DrnceyByygmaK64D7MSxuEco6EeiBUsbcDtHIbgyx71nBkCZX
         Pr/3Ngp+zIhDUD6+HpKv0m3UddYpBrbV/xoBeXnfFXyDpj5yTanfKQM9NNmXlExOc0Ol
         kkBpm+XOiU7gySb8zsosaZVj2JGERKmBYxmsraPQAqB804zjvRb9UWi20QyO2342i+nY
         4L0qlAgOUDT9pUSA0H5vUG9xMBzT4WwRJbQmC4YFlbqX0NOEKVuMh0M1c4gA41Hkk/sX
         +gU1bvbDigmUDgnlRte/IunrWWVAXaSD/CeG6yghSWiyKIXbYiFRIEktU5oOBZcbOifx
         SNjw==
X-Received: by 10.112.151.211 with SMTP id us19mr19552447lbb.120.1428439593835;
 Tue, 07 Apr 2015 13:46:33 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Tue, 7 Apr 2015 13:46:33 -0700 (PDT)
In-Reply-To: <1428258505-25223-1-git-send-email-karthik.188@gmail.com>
X-Google-Sender-Auth: u-vcMT2K5oRKNgFAmZddryJH9qo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266939>

On Sun, Apr 5, 2015 at 2:28 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Update sha1_loose_object_info() to optionally allow it to read
> from a loose object file of unknown/bogus type; as the function
> usually returns the type of the object it read in the form of enum
> for known types, add an optional "typename" field to receive the
> name of the type in textual form and a flag to indicate the reading
> of a loose object file of unknown/bogus type.
>
> Add parse_sha1_header_extended() which acts as a wrapper around
> parse_sha1_header() allowing more information to be obtained.
>
> Add unpack_sha1_header_to_strbuf() to unpack sha1 headers of
> unknown/corrupt objects which have a unknown sha1 header size to
> a strbuf structure. This was written by Junio C Hamano but tested
> by me.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/sha1_file.c b/sha1_file.c
> index 980ce6b..ac8fffc 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1614,27 +1642,24 @@ static void *unpack_sha1_rest(git_zstream *stream, void *buffer, unsigned long s
>   * too permissive for what we want to check. So do an anal
>   * object header parse by hand.
>   */
> -int parse_sha1_header(const char *hdr, unsigned long *sizep)
> +int parse_sha1_header_extended(const char *hdr, struct object_info *oi,
> +                              unsigned int flags)
>  {
> -       char type[10];
> -       int i;
> +       struct strbuf typename = STRBUF_INIT;
>         unsigned long size;
> +       int type;
>
>         /*
>          * The type can be at most ten bytes (including the
>          * terminating '\0' that we add), and is followed by
>          * a space.
>          */
> -       i = 0;
>         for (;;) {
>                 char c = *hdr++;
>                 if (c == ' ')
>                         break;
> -               type[i++] = c;
> -               if (i >= sizeof(type))
> -                       return -1;
> +               strbuf_addch(&typename, c);
>         }
> -       type[i] = 0;
>
>         /*
>          * The length must follow immediately, and be in canonical
> @@ -1652,12 +1677,39 @@ int parse_sha1_header(const char *hdr, unsigned long *sizep)
>                         size = size * 10 + c;
>                 }
>         }
> -       *sizep = size;
> +
> +       type = type_from_string_gently(typename.buf, typename.len, 1);
> +       if (oi->sizep)
> +               *oi->sizep = size;
> +       if (oi->typename)
> +               strbuf_addbuf(oi->typename, &typename);
> +       strbuf_release(&typename);
>
>         /*
> +        * Set type to 0 if its an unknown object and
> +        * we're obtaining the type using '--literally'
> +        * option.
> +        */
> +       if ((flags & LOOKUP_LITERALLY) && (type == -1))
> +               type = 0;
> +       else if (type == -1)
> +               die("invalid object type");
> +       if (oi->typep)
> +               *oi->typep = type;

This unnecessary intermixing of 'type'/'typename' and 'size'
processing makes the code more confusing than it ought to be. Why not
do all the processing related to 'type'/'typename' before the
processing of 'size'?

> +       /*
>          * The length must be followed by a zero byte
>          */
> -       return *hdr ? -1 : type_from_string(type);
> +       return *hdr ? -1 : type;
> +}
> +
> +int parse_sha1_header(const char *hdr, unsigned long *sizep)
> +{
> +       struct object_info oi;
> +
> +       oi.sizep = sizep;
> +       oi.typename = NULL;
> +       oi.typep = NULL;
> +       return parse_sha1_header_extended(hdr, &oi, LOOKUP_REPLACE_OBJECT);
>  }
>
>  static void *unpack_sha1_file(void *map, unsigned long mapsize, enum object_type *type, unsigned long *size, const unsigned char *sha1)
