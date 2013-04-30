From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/8] sha1_file: allow to select pack origin when
 looking up an object
Date: Tue, 30 Apr 2013 02:01:19 -0400
Message-ID: <CAPig+cTiSAzusYmh6YrtZH_FB3Ap8Xrg-+Od-y_Jjj84MMW1og@mail.gmail.com>
References: <1367293372-1958-1-git-send-email-pclouds@gmail.com>
	<1367293372-1958-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 08:01:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UX3d1-0006Fm-Fm
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 08:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441Ab3D3GBW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Apr 2013 02:01:22 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:46825 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752180Ab3D3GBW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Apr 2013 02:01:22 -0400
Received: by mail-la0-f50.google.com with SMTP id fl20so135600lab.37
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 23:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uOfsEd29pTUnxhnl15WsX6mDzeyFIBI3SLtehZLg9+M=;
        b=X7ZuKSml5CQtg/BcsBQ09QoTla7zvYqHXjugG5suQuKhP+mOV3t0DNtX75m44JI8YT
         vRSm4ihyeoO2IoNnkLmfWewi3/ZqeGaWYk/MhKonOMYvr5ngfPn+8trhuGM3/33z/1Qk
         HBqD6A95ZxfJG5WpjMf8Uf1gbRHT/Un0gI4ej9XsVPeITUTHrpERxkFkj4TsXT79Rq9L
         hm7Asrw+0ET7O9d+6fi7laPJ+vZro8CsochGL/TXVt5ddVU0/prFdXuihyEeKxsfZ2QA
         +cJlAbp+eLT/wTOIz/jUs/MfqxMEps79kE1oojhxLAqrW/PkZ+3BBzCDvoDdcDjwbOV3
         TLzA==
X-Received: by 10.112.172.68 with SMTP id ba4mr28219743lbc.11.1367301679963;
 Mon, 29 Apr 2013 23:01:19 -0700 (PDT)
Received: by 10.114.199.11 with HTTP; Mon, 29 Apr 2013 23:01:19 -0700 (PDT)
In-Reply-To: <1367293372-1958-2-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: cAaxAPBHQoq39WKzHDO0WLLNcOI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222906>

On Mon, Apr 29, 2013 at 11:42 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy
<pclouds@gmail.com> wrote:
> diff --git a/cache.h b/cache.h
> index 94ca1ac..bed403a 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -744,12 +744,33 @@ char *strip_path_suffix(const char *path, const=
 char *suffix);
>  int daemon_avoid_alias(const char *path);
>  int offset_1st_component(const char *path);
>
> +/*
> + * odb origin bit mask:
> + * - 8 low bits are for requested objects
> + * - 8 high bits are for their base objects
> + */
> +#define ODB_LOCAL      1
> +#define ODB_ALT                2
> +#define ODB_CACHED     4
> +/*
> + * This flag is used to track if the origin selection is from
> + * "odb_default" below. Not a real source, not to be passed to any
> + * function cals explicitly.

s/cals/calls/

> + */
> +#define ODB_DEFAULT    8
> +
> +extern unsigned int odb_default;
> +
>  /* object replacement */
>  #define READ_SHA1_FILE_REPLACE 1
> -extern void *read_sha1_file_extended(const unsigned char *sha1, enum=
 object_type *type, unsigned long *size, unsigned flag);
> +extern void *read_sha1_file_extended(const unsigned char *sha1,
> +                                    unsigned int origin,
> +                                    enum object_type *type,
> +                                    unsigned long *size,
> +                                    unsigned flag);
>  static inline void *read_sha1_file(const unsigned char *sha1, enum o=
bject_type *type, unsigned long *size)
>  {
> -       return read_sha1_file_extended(sha1, type, size, READ_SHA1_FI=
LE_REPLACE);
> +       return read_sha1_file_extended(sha1, odb_default, type, size,=
 READ_SHA1_FILE_REPLACE);
>  }
>  extern const unsigned char *do_lookup_replace_object(const unsigned =
char *sha1);
>  static inline const unsigned char *lookup_replace_object(const unsig=
ned char *sha1)
