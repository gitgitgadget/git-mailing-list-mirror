From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v10 1/4] sha1_file: support reading from a loose object of
 unknown type
Date: Mon, 4 May 2015 19:34:02 -0400
Message-ID: <CAPig+cTitnC7zvWJEwdo2cMWNE+3ODjd++81bYdg-qTc0bzgog@mail.gmail.com>
References: <55463094.9040204@gmail.com>
	<1430663402-26717-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 05 01:34:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpPsG-0006gj-E1
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 01:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbbEDXeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 19:34:06 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:36701 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887AbbEDXeD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 19:34:03 -0400
Received: by igblo3 with SMTP id lo3so97865589igb.1
        for <git@vger.kernel.org>; Mon, 04 May 2015 16:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=lfi0d3OEV7qLfiiq+BFW5nycpZ7XMvf7wWJlC8CaLdE=;
        b=GPQvbZPtnFP+kl/iVbZ8y2V+oDu9Prl+zFjYlLClCSy2zEUrpYO5gj5LYbYULylLcV
         jkB3uNJY/S+CX4T2pXs70yv8kxbWc8iUaxUQKNXukIU8akCI3FbAvRDRoCZ/7z/NwkVj
         MMJTj3TR6iwiXwPOUoTWQ3NbrTAEpd4bdrBcCV+nUI6B13A9gwsz5r/Ypa7PSqT0HULZ
         GzdKLTxieiBqlESRWunniaSV0mrxfYauy1JZwzuwy3vffX7r5PeAFOWInYWiGaSQS344
         vnZ5qOBI4WTXujw/gYBZGvqoT75z2kTgrWSJWwisWdBcBtdtgxjsBDCCyJeeCdqfcQVk
         K8iA==
X-Received: by 10.50.61.200 with SMTP id s8mr169482igr.7.1430782442418; Mon,
 04 May 2015 16:34:02 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Mon, 4 May 2015 16:34:02 -0700 (PDT)
In-Reply-To: <1430663402-26717-1-git-send-email-karthik.188@gmail.com>
X-Google-Sender-Auth: xv4IkOtjB8gJ_zNMXMRidlyP1mw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268372>

On Sun, May 3, 2015 at 10:29 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
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
> ---
> diff --git a/cache.h b/cache.h
> index 3d3244b..38419c3 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1564,6 +1564,33 @@ int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long ma
> +static int unpack_sha1_header_to_strbuf(git_zstream *stream, unsigned char *map,
> +                                       unsigned long mapsize, void *buffer,
> +                                       unsigned long bufsiz, struct strbuf *header)
> +{
> +       unsigned char *cp;
> +       int status;
> +
> +       status = unpack_sha1_header(stream, map, mapsize, buffer, bufsiz);
> +
> +       /*
> +        * Check if entire header is unpacked in the first iteration.
> +        */

Nit: You could save some precious vertical screen real-estate by using
one-line /* comment style */.

> +       if (memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer))
> +               return 0;
> +
> @@ -1614,27 +1641,38 @@ static void *unpack_sha1_rest(git_zstream *stream, void *buffer, unsigned long s
>   * too permissive for what we want to check. So do an anal
>   * object header parse by hand.
>   */
> -int parse_sha1_header(const char *hdr, unsigned long *sizep)
> +static int parse_sha1_header_extended(const char *hdr, struct object_info *oi,
> +                              unsigned int flags)
>  {
> [...]
> +
> +       type = type_from_string_gently(type_buf, type_len, 1);
> +       if (oi->typename)
> +               strbuf_add(oi->typename, type_buf, type_len);
> +       /*
> +        * Set type to 0 if its an unknown object and
> +        * we're obtaining the type using '--allow-unkown-type'
> +        * option.
> +        */
> +       if ((flags & LOOKUP_UNKNOWN_OBJECT) && (type < 0))
> +               type = 0;

The comment says exactly what the code already says, thus it adds no
value. A better comment would explain _why_ type is set to 0 under
these conditions.

> +       else if (type < 0)
> +               die("invalid object type");
> +       if (oi->typep)
> +               *oi->typep = type;
>
>         /*
>          * The length must follow immediately, and be in canonical
> @@ -1652,12 +1690,24 @@ int parse_sha1_header(const char *hdr, unsigned long *sizep)
>                         size = size * 10 + c;
>                 }
>         }
> -       *sizep = size;
> +
> +       if (oi->sizep)
> +               *oi->sizep = size;
>
>         /*
>          * The length must be followed by a zero byte
>          */

Nit: Save precious vertical screen real-estate with one-line /*
comment style */.

> -       return *hdr ? -1 : type_from_string(type);
> +       return *hdr ? -1 : type;
> +}
> +
