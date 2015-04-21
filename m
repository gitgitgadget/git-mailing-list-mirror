From: Stefan Saasen <ssaasen@atlassian.com>
Subject: Re: [PATCH 2/2] sha1_file: only freshen packs once per run
Date: Tue, 21 Apr 2015 10:45:01 +1000
Message-ID: <CADoxLGMrWXn+3qsGr2dYaDMmzLTKDW6wDthH6z1a_whOch9qPw@mail.gmail.com>
References: <20150420195337.GA15447@peff.net> <20150420195500.GB15760@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 21 02:45:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkMJw-0005rh-HF
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 02:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbbDUApn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 20:45:43 -0400
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:36957 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751386AbbDUApm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Apr 2015 20:45:42 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]) (using TLSv1) by na3sys009aob111.postini.com ([74.125.148.12]) with SMTP
	ID DSNKVTWdttKT/U6yvVgUw7E+DWn2mUT4wMLC@postini.com; Mon, 20 Apr 2015 17:45:42 PDT
Received: by iebrs15 with SMTP id rs15so2792535ieb.3
        for <git@vger.kernel.org>; Mon, 20 Apr 2015 17:45:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=3gQKXhh7hv7KiGC4mhjzOoA4GeZQDggPa3013aa6Q+Q=;
        b=H9PCNRTCfmj+oqz6pj+Nuy5UtVxuP96dGqoe4pVf3bB749rxuxo2xqP2+3dB5aoKpF
         S+2ausb7MoQzJwevyuL0OcICaWdCsDu4llolHi7XUC2LEo+t/SL0b58q5N7gJn1G1qXN
         vr39pGeh/z87otu2HHb+8rDrC/eywMWxdA5rVqh0XffvqQEPhNCJNBBppDuCbcoULJoB
         ItFSqXFsF+SAQJ/x1G2j8y3PR6k8ZJieM9XYUEhfTQJZyU+Vro8htv+O93788wrUCJZD
         q4KOKRwZFacRv8VwIvQhOKpFMDq9BlIluefVf8snM+BHGDR1m8SHxRLGjMaEwuqrdR+z
         bFew==
X-Received: by 10.43.60.14 with SMTP id wq14mr556641icb.60.1429577141957;
        Mon, 20 Apr 2015 17:45:41 -0700 (PDT)
X-Gm-Message-State: ALoCoQn2cUM1psPclKrS6zsnRJUzsCBFtd9gTR+2KWKoW2tHAfMxEsfpbZuXl2wUL+GkY7txUrLpaeRSfqm5TRNCjnD7ZfxX9c30LjxAZ6pfSv0z6gwq5dAkscJM/LlnLJWRbrvasEss3fKiPVa2kCjF3d9P4Ei4OQ==
X-Received: by 10.43.60.14 with SMTP id wq14mr556633icb.60.1429577141794; Mon,
 20 Apr 2015 17:45:41 -0700 (PDT)
Received: by 10.36.118.133 with HTTP; Mon, 20 Apr 2015 17:45:01 -0700 (PDT)
In-Reply-To: <20150420195500.GB15760@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267515>

I can confirm that this patch is equivalent to the previous one.

https://bitbucket.org/snippets/ssaasen/9AXg shows both the timing and
the NFS stats showing the effect of applying this patch.

Thanks for the fix Jeff!

Cheers,
Stefan

On 21 April 2015 at 05:55, Jeff King <peff@peff.net> wrote:
> Since 33d4221 (write_sha1_file: freshen existing objects,
> 2014-10-15), we update the mtime of existing objects that we
> would have written out (had they not existed). For the
> common case in which many objects are packed, we may update
> the mtime on a single packfile repeatedly. This can result
> in a noticeable performance problem if calling utime() is
> expensive (e.g., because your storage is on NFS).
>
> We can fix this by keeping a per-pack flag that lets us
> freshen only once per program invocation.
>
> An alternative would be to keep the packed_git.mtime flag up
> to date as we freshen, and freshen only once every N
> seconds. In practice, it's not worth the complexity. We are
> racing against prune expiration times here, which inherently
> must be set to accomodate reasonable program running times
> (because they really care about the time between an object
> being written and it becoming referenced, and the latter is
> typically the last step a program takes).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Hopefully I didn't botch the flag logic again. :) I tested with "strace
> -c" myself this time, so I think it is good.
>
>  cache.h     | 1 +
>  sha1_file.c | 9 ++++++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/cache.h b/cache.h
> index 3d3244b..72c6888 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1174,6 +1174,7 @@ extern struct packed_git {
>         int pack_fd;
>         unsigned pack_local:1,
>                  pack_keep:1,
> +                freshened:1,
>                  do_not_close:1;
>         unsigned char sha1[20];
>         /* something like ".git/objects/pack/xxxxx.pack" */
> diff --git a/sha1_file.c b/sha1_file.c
> index 822aaef..26b9b2b 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2999,7 +2999,14 @@ static int freshen_loose_object(const unsigned char *sha1)
>  static int freshen_packed_object(const unsigned char *sha1)
>  {
>         struct pack_entry e;
> -       return find_pack_entry(sha1, &e) && freshen_file(e.p->pack_name);
> +       if (!find_pack_entry(sha1, &e))
> +               return 0;
> +       if (e.p->freshened)
> +               return 1;
> +       if (!freshen_file(e.p->pack_name))
> +               return 0;
> +       e.p->freshened = 1;
> +       return 1;
>  }
>
>  int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *returnsha1)
> --
> 2.4.0.rc2.384.g7297a4a
