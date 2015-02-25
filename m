From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] sha1_file: Add sha1_object_type_literally and export it.
Date: Wed, 25 Feb 2015 16:55:35 -0500
Message-ID: <CAPig+cQDLU4CBQtE8vAKLyz4Xv=2DsDDMz787DVjrFwW2tiKXg@mail.gmail.com>
References: <54EDACC9.5080204@gmail.com>
	<1424862460-13514-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 22:55:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQjvn-0005bu-8t
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 22:55:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753882AbbBYVzj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2015 16:55:39 -0500
Received: from mail-yh0-f46.google.com ([209.85.213.46]:41151 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932299AbbBYVzh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2015 16:55:37 -0500
Received: by yhaf10 with SMTP id f10so2488621yha.8
        for <git@vger.kernel.org>; Wed, 25 Feb 2015 13:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=3iBnMIg0JxCCY6ozXAmzrS0IJc4K5832/MwGyNfQM98=;
        b=Rv32ExR/ldB7DovI9MuJTRiAZT572MwlHdEAmDnRC+hZ8npw1N0DZ4ZIUmxWpkp4T1
         W/m7upJP6UV+DlhJevYgoWeCVvBtTPnBQRNDHzoWishm96jFZ3eeIRswqVxNNp1Xcm0s
         n3ll9YClfJ94/Dkr7KPcUiod38UKOx4K+UaCRvfSOYvNF7rure2DkWUvZnBI+y76mbul
         aDpqGUnfKZApLK/xKvR+fNqyhXyPUeEjpDlEZ3ZCnbQRFAFZcdnzN97MZn8w2Y3hENew
         15SEx21yClwUZPILdZhADiOFlo0OKyEnbYmad9XxPoKkv24xR3Lz8SMgyi9aW2dbkb27
         58sg==
X-Received: by 10.170.41.5 with SMTP id 5mr4436275ykj.85.1424901335592; Wed,
 25 Feb 2015 13:55:35 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Wed, 25 Feb 2015 13:55:35 -0800 (PST)
In-Reply-To: <1424862460-13514-1-git-send-email-karthik.188@gmail.com>
X-Google-Sender-Auth: a9axXzQyjRPoMDW5LzlhYtUd_d8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264418>

I had written a longer review but was interrupted for a several hours,
and upon returning found that David and Junio covered many of the same
issues or overrode comments I was making, so the below review is pared
down quite a bit. Junio's proposed approach negates all of the below
review comments, but they may still be meaningful if kept in mind for
future submissions.

On Wed, Feb 25, 2015 at 6:07 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> sha1_file: Add sha1_object_type_literally and export it.

Style: downcase "Add"; drop terminating period.

> sha1_object_type_literally takes a sha value and
> gives the type of the given loose object, used by
> git cat-file -t --literally.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2635,6 +2635,33 @@ int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
>         return type;
>  }
>
> +int sha1_object_type_literally(const unsigned char *sha1, char *type)

This functionality is very specific to the --literally option you're
adding to cat-file, so it would make more sense to make it private to
builtin/cat-file.c rather than publishing it globally.

Also, this is an unsafe contract. The caller does not know how many
bytes to allocate for 'type', and this new function may write past the
end of the buffer. It is more common to also pass in the size of the
'type' buffer and ensure that you do not write beyond that. Or, if
this is intended for wider consumption, pass in a strbuf instead.

> +{
> +       int status = 0;
> +       unsigned long mapsize;
> +       void *map;
> +       git_zstream stream;
> +       char hdr[32];
> +       int i;
> +
> +       map = map_sha1_file(sha1, &mapsize);
> +       if (!map)
> +               return -1;
> +       if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
> +               status = error("unable to unpack %s header",
> +                              sha1_to_hex(sha1));

Since 'hdr' unpacking failed, shouldn't you be returning at this point
rather than continuing to the 'hdr' processing loop?

> +       for (i = 0; i < 32; i++) {
> +               if (hdr[i] == ' ') {
> +                       type[i] = '\0';
> +                       break;
> +               }
> +               type[i] = hdr[i];
> +       }

David already mentioned that this loop is suspect. Perhaps take a look
at, sha1_file.c:parse_sha1_header() for an example of cleaner logic.

> +
> +       return status;
> +}
> +
>  static void *read_packed_sha1(const unsigned char *sha1,
>                               enum object_type *type, unsigned long *size)
>  {
> --
> 2.3.1.129.g11acff1.dirty
