From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH V2 5/6] pack-bitmap: fix a memleak
Date: Fri, 27 Mar 2015 19:27:18 -0400
Message-ID: <CAPig+cREgQAx-CqBYT_ss0U-RN86ONWeZuv3VCb56eZA-VsuXQ@mail.gmail.com>
References: <1427495569-10863-1-git-send-email-sbeller@google.com>
	<1427495569-10863-6-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?UTF-8?Q?Vicent_Mart=C3=AD?= <tanoku@gmail.com>, blees@dcon.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Mar 28 00:29:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ybdgw-0000Ed-Kr
	for gcvg-git-2@plane.gmane.org; Sat, 28 Mar 2015 00:29:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbbC0X1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2015 19:27:21 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:34362 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbbC0X1U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2015 19:27:20 -0400
Received: by lagg8 with SMTP id g8so81642201lag.1
        for <git@vger.kernel.org>; Fri, 27 Mar 2015 16:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=tuaLjgFxXFVobh84OHTebkAYLJ0fujxT+q5XRG5lQUg=;
        b=pw5hOqFINT4d5zcoqLIRZq2H212qk8D5dB9XM9vJsK2+LmSsmsL8gIW9s1tisvsjdA
         6JxVv388fENV2cVf6B3shFVItzOTtN9YySeC1LLHf+HCunfcsoWQYVr+jWbCUCShjDK7
         5tVLZNHNk93l4WiY3aSKImbUcoM3G2bSJ3ERrQ14XfcAOBDc8Z/58NcnFwnjUzVVThAK
         i+YoamhtLIodGeC5rEiVHqfLjHTmJvk+WzMJceILVf8hkf4edVIqQHm1cw5K++/FQzvs
         T/rFS3sUQcC1+8py7eG/vu36LPD3wMWmtBkF0Dg8LQ+Uzr98B1lQIau+OGJyXCXF0Tit
         5MAg==
X-Received: by 10.152.219.2 with SMTP id pk2mr19278179lac.107.1427498838680;
 Fri, 27 Mar 2015 16:27:18 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Fri, 27 Mar 2015 16:27:18 -0700 (PDT)
In-Reply-To: <1427495569-10863-6-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: 5Eemw8645kEGDFB50Kaucshijg4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266403>

On Fri, Mar 27, 2015 at 6:32 PM, Stefan Beller <sbeller@google.com> wrote:
> `recent_bitmaps` is allocated in the function load_bitmap_entries_v1
> and it is not passed into any function, so it's safe to free it before
> leaving that function.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 365f9d9..34823e9 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -213,7 +213,7 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
>  {
>         static const size_t MAX_XOR_OFFSET = 160;
>
> -       uint32_t i;
> +       uint32_t i, ret = 0;
>         struct stored_bitmap **recent_bitmaps;
>
>         recent_bitmaps = xcalloc(MAX_XOR_OFFSET, sizeof(struct stored_bitmap));
> @@ -232,24 +232,31 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
>                 sha1 = nth_packed_object_sha1(index->pack, commit_idx_pos);
>
>                 bitmap = read_bitmap_1(index);
> -               if (!bitmap)
> -                       return -1;
> +               if (!bitmap) {
> +                       ret = -1;
> +                       goto out;
> +               }
>
> -               if (xor_offset > MAX_XOR_OFFSET || xor_offset > i)
> -                       return error("Corrupted bitmap pack index");
> +               if (xor_offset > MAX_XOR_OFFSET || xor_offset > i) {
> +                       ret = error("Corrupted bitmap pack index");
> +                       goto out;
> +               }
>
>                 if (xor_offset > 0) {
>                         xor_bitmap = recent_bitmaps[(i - xor_offset) % MAX_XOR_OFFSET];
>
> -                       if (xor_bitmap == NULL)
> -                               return error("Invalid XOR offset in bitmap pack index");
> +                       if (xor_bitmap == NULL) {
> +                               ret = error("Invalid XOR offset in bitmap pack index");
> +                               goto out;
> +                       }
>                 }
>
>                 recent_bitmaps[i % MAX_XOR_OFFSET] = store_bitmap(
>                         index, bitmap, sha1, xor_bitmap, flags);
>         }
> -
> -       return 0;
> +out:
> +       free(recent_bitmaps);
> +       return ret;
>  }
>
>  static char *pack_bitmap_filename(struct packed_git *p)
> @@ -986,6 +993,8 @@ void test_bitmap_walk(struct rev_info *revs)
>                 fprintf(stderr, "OK!\n");
>         else
>                 fprintf(stderr, "Mismatch!\n");
> +
> +       free(result);

This fix is not mentioned in the commit message.

>  }
>
>  static int rebuild_bitmap(uint32_t *reposition,
> --
> 2.3.0.81.gc37f363
