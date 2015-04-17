From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v8 1/4] sha1_file.c: support reading from a loose object
 of unknown type
Date: Fri, 17 Apr 2015 19:31:07 -0400
Message-ID: <CAPig+cSiYsF6ioi+-P_BP=1bs-EAtNdAGjSqw6KmZyE39rKWBA@mail.gmail.com>
References: <552E9816.6040502@gmail.com>
	<1429117143-4882-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 18 01:31:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjFjG-0001fe-Fv
	for gcvg-git-2@plane.gmane.org; Sat, 18 Apr 2015 01:31:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbbDQXbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2015 19:31:09 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:35155 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679AbbDQXbI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 19:31:08 -0400
Received: by igbyr2 with SMTP id yr2so24085146igb.0
        for <git@vger.kernel.org>; Fri, 17 Apr 2015 16:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=t4PFYr94wfN9rnDuasWUmQ8+ssGt/syYonsCQuvq1NI=;
        b=eQ/hmEcANq2sjyOmPRb8SKdxkpCaiGFL9E/YpS04l4SdySYjG1hJhHlTEZuSfID81U
         mlnxnWSg21kkP60o0DWYQ3MTKwQMEnctXQNhdJxe3QuCDrjnFyL72ypdS6y7cZwSora+
         dAWRlzWuzUU9NOBh5xOZnd8tJq1bkc4Cu508geI15cZ4j+V6nBqAXkMl8Z56KmOuXL6V
         R0PF/Xq6qQl0Tw5U6/2IWEbNNpApZRaej7+Dct8byegnlSdYq/MVT5/Gyfz8EeUy201v
         ac+eILTaUkJTZWDhfiDKHmhtmtbHSVxQAoFIJ5u4nztbDT8MrkWSo5zjC7lMcxB0aBlR
         sCyA==
X-Received: by 10.42.250.70 with SMTP id mn6mr6426895icb.78.1429313467096;
 Fri, 17 Apr 2015 16:31:07 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Fri, 17 Apr 2015 16:31:07 -0700 (PDT)
In-Reply-To: <1429117143-4882-1-git-send-email-karthik.188@gmail.com>
X-Google-Sender-Auth: 96HEaZSvN6lJjW2ZfVKFRg5WX-Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267401>

On Wed, Apr 15, 2015 at 12:59 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Update sha1_loose_object_info() to optionally allow it to read
> from a loose object file of unknown/bogus type; as the function
> usually returns the type of the object it read in the form of enum
> for known types, add an optional "typename" field to receive the
> name of the type in textual form and a flag to indicate the reading
> of a loose object file of unknown/bogus type.
> [...]
> ---
> diff --git a/sha1_file.c b/sha1_file.c
> index 980ce6b..267399d 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2522,13 +2575,15 @@ struct packed_git *find_sha1_pack(const unsigned char *sha1,
>  }
>
>  static int sha1_loose_object_info(const unsigned char *sha1,
> -                                 struct object_info *oi)
> +                                 struct object_info *oi,
> +                                 int flags)
>  {
> -       int status;
> -       unsigned long mapsize, size;
> +       int status = 0;
> +       unsigned long mapsize;
>         void *map;
>         git_zstream stream;
>         char hdr[32];
> +       struct strbuf hdrbuf = STRBUF_INIT;
>
>         if (oi->delta_base_sha1)
>                 hashclr(oi->delta_base_sha1);
> @@ -2555,17 +2610,26 @@ static int sha1_loose_object_info(const unsigned char *sha1,
>                 return -1;
>         if (oi->disk_sizep)
>                 *oi->disk_sizep = mapsize;
> -       if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
> -               status = error("unable to unpack %s header",
> -                              sha1_to_hex(sha1));
> -       else if ((status = parse_sha1_header(hdr, &size)) < 0)
> -               status = error("unable to parse %s header", sha1_to_hex(sha1));
> -       else if (oi->sizep)
> -               *oi->sizep = size;
> +       if ((flags & LOOKUP_LITERALLY)) {
> +               if (unpack_sha1_header_to_strbuf(&stream, map, mapsize, &hdrbuf) < 0)
> +                       status = error("unable to unpack %s header with --literally",
> +                                      sha1_to_hex(sha1));
> +               else if ((status = parse_sha1_header_extended(hdrbuf.buf, oi, flags)) < 0)
> +                       status = error("unable to parse %s header with --literally",
> +                                      sha1_to_hex(sha1));
> +       } else {
> +               if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
> +                       status = error("unable to unpack %s header",
> +                                      sha1_to_hex(sha1));
> +               else if ((status = parse_sha1_header_extended(hdr, oi, flags)) < 0)
> +                       status = error("unable to parse %s header", sha1_to_hex(sha1));
> +       }
>         git_inflate_end(&stream);
>         munmap(map, mapsize);
> -       if (oi->typep)
> +       if (status && oi->typep)
>                 *oi->typep = status;
> +       if (hdrbuf.buf)
> +               strbuf_release(&hdrbuf);

Why is strbuf_release() protected by a conditional rather than being
called unconditionally? Am I missing something obvious?

>         return 0;
>  }
>
