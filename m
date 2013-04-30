From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] unpack_entry: invalidate newly added cache entry in case
 of error
Date: Tue, 30 Apr 2013 20:01:30 +0700
Message-ID: <CACsJy8DewY=fW+sF9Nrs1A7zEPzdVXr52kwCgnjAvaQy7qq3EQ@mail.gmail.com>
References: <1367288992-14979-1-git-send-email-pclouds@gmail.com>
 <87ppxcxw1i.fsf@linux-k42r.v.cablecom.net> <CACsJy8Bi6UpfA-0BCFY6H=BAKMmWYgwbf-94yJXEn5Zi4gwPCA@mail.gmail.com>
 <87d2tcw571.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Apr 30 15:02:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXAC8-0002jm-SY
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 15:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760624Ab3D3NCE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Apr 2013 09:02:04 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:61353 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760582Ab3D3NCA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Apr 2013 09:02:00 -0400
Received: by mail-oa0-f41.google.com with SMTP id g12so461570oah.14
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 06:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=GL8DjaLt1AJB59N7Zi8CLJ3FGsHAi6wHowQsFd058Z0=;
        b=TztjM89EtlRpIx2I/l9WHShaa1Ry1tFl/DffloWSsCTA/jIlSNWVFy0AZgkgQrb3HM
         GB2mMN4ZUW3ML0H6iQCrkcjed9pvNoL36Vggx5b2uVutkq61z8OkQBniyrVLHfT04iA/
         TXF4zY3dy+VKdSJd11tnF63cGyW89EgNEkCAi3TNlzs9pcISJFiaA5sBeZIuKUsC7LHB
         rkhW9qXj6cXV01JZMwKiIa3aeTgaxNe8jQGj90HOOjr3brzS3bu1TbWQRWRTOamNuhx/
         QnQ4gKYPU6RW+tBdZWje0H2NAu4MP/l3xhpe4yuvmbr65NXGrGZDtLTc+yIpEFafrqjZ
         hyhQ==
X-Received: by 10.60.57.3 with SMTP id e3mr3708281oeq.101.1367326920250; Tue,
 30 Apr 2013 06:02:00 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Tue, 30 Apr 2013 06:01:30 -0700 (PDT)
In-Reply-To: <87d2tcw571.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222935>

On Tue, Apr 30, 2013 at 7:53 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> Apply this patch on top of master (no need to apply full series) and=
 run t5303
>>
>> http://article.gmane.org/gmane.comp.version-control.git/222895
> [...]
>> OK since you know this code much better than me, I withdraw my patch
>> (consider it a bug report) and let you work on a proper fix. I see y=
ou
>> already have the commit message ready :) Happy to test it for you if
>> the above instruction is still not reproducible for you.
>
> Ok.  So I really think just dropping the free() is the way to go.  Ca=
n
> you test this?  Your series didn't apply cleanly on anything I had
> locally, and 'am -3' doesn't work.  A simpler reproducer, and using
> valgrind to detect the use-after-free, didn't get me anywhere either.

Confirmed the double free is gone. I also run it under valgrind and
found nothing special.

> -- >8 --
> Subject: [PATCH] unpack_entry: avoid freeing objects in base cache
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> In the !delta_data error path of unpack_entry(), we run free(base).
> This became a window for use-after-free() in abe601b (sha1_file:
> remove recursion in unpack_entry, 2013-03-27), as follows:
>
> Before abe601b, we got the 'base' from cache_or_unpack_entry(..., 0);
> keep_cache=3D0 tells it to also remove that entry.  So the 'base' is =
at
> this point not cached, and freeing it in the error path is the right
> thing.
>
> After abe601b, the structure changed: we use a three-phase approach
> where phase 1 finds the innermost base or a base that is already in
> the cache.  In phase 3 we therefore know that all bases we unpack are
> not part of the delta cache yet.  (Observe that we pop from the cache
> in phase 1, so this is also true for the very first base.)  So we mak=
e
> no further attempts to look up the bases in the cache, and just call
> add_delta_base_cache() on every base object we have assembled.
>
> But the !delta_data error path remained unchanged, and now calls
> free() on a base that has already been entered in the cache.  This
> means that there is a use-after-free if we later use the same base
> again.
>
> So remove that free().
>
> Reported-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
> Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
> ---
>  sha1_file.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 64228a2..67e815b 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2128,7 +2128,6 @@ void *unpack_entry(struct packed_git *p, off_t =
obj_offset,
>                         error("failed to unpack compressed delta "
>                               "at offset %"PRIuMAX" from %s",
>                               (uintmax_t)curpos, p->pack_name);
> -                       free(base);
>                         data =3D NULL;
>                         continue;
>                 }
> --
> 1.8.3.rc0.333.gdb39496



--
Duy
