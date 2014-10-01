From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] sha1-lookup: fix handling of duplicates in sha1_pos()
Date: Wed, 1 Oct 2014 10:12:58 -0400
Message-ID: <CAPig+cQADVFECOev+ZW9W94=Xy5nHVd4je8kuTzS53MjhxaVEw@mail.gmail.com>
References: <542BCBFC.5000509@web.de>
	<542BCCB9.4050908@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Wed Oct 01 16:13:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZKeO-0008RJ-19
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 16:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbaJAOM7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Oct 2014 10:12:59 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:41761 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155AbaJAOM7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 10:12:59 -0400
Received: by mail-yk0-f170.google.com with SMTP id 20so156901yks.1
        for <git@vger.kernel.org>; Wed, 01 Oct 2014 07:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=aE5QuZOZMbYHYulm2LdJOPO3ZvKYwx0YkH7ezWBHB8I=;
        b=TPcfKHG0B2Nd51Ls4FKmBAGXbbOaO9bTTvT9Sx6D5AlVZvXBmOq+FYZwl2wkRaCsE7
         gjy6Fa0Y7kge5zcZeksvn9WWa1QwHRS9kvu6rtbeGeQVzbZktynxmRvz8XFVEj1k9dep
         5eIaVA76lHYLv+RnWAIbx+ckqGtU6L76ZnDrrJ+7ZYXi0uxT2Z8ErJKjc0fHK3CjAV4d
         wE3yesyA0VpBreu6RZ0rDO/6bQO6fkCpANUgA7gVZAHgrPi2yI3/lf7jOnm37mfl2j4e
         JsujcMcPUhwh72Nxlw3ttkXRjT6sd10be9YKVZDx2dEWrXUJKR2IIp7vQhpQ3O1Z1PxW
         ACOA==
X-Received: by 10.236.150.19 with SMTP id y19mr20526663yhj.94.1412172778447;
 Wed, 01 Oct 2014 07:12:58 -0700 (PDT)
Received: by 10.170.68.68 with HTTP; Wed, 1 Oct 2014 07:12:58 -0700 (PDT)
In-Reply-To: <542BCCB9.4050908@web.de>
X-Google-Sender-Auth: bcRz1dAHYLynFHgF8RuqzgAsYsQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257750>

On Wed, Oct 1, 2014 at 5:43 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> If the first 18 bytes of the SHA1's of all entries are the same then
> sha1_pos() dies and reports that the lower and upper limits of the
> binary search were the same that this wasn't supposed to happen.  Thi=
s
> is wrong because the remaining two bytes could still differ.
>
> Furthermore: It wouldn't be a problem if they actually were the same,
> i.e. if all entries have the same SHA1.  The code already handles
> duplicates just fine otherwise.  Simply remove the erroneous check.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  sha1-lookup.c         |  2 --
>  t/t0064-sha1-array.sh | 20 ++++++++++++++++++++
>  2 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/sha1-lookup.c b/sha1-lookup.c
> index 2dd8515..5f06921 100644
> --- a/sha1-lookup.c
> +++ b/sha1-lookup.c
> @@ -84,8 +84,6 @@ int sha1_pos(const unsigned char *sha1, void *table=
, size_t nr,
>                                 die("BUG: assertion failed in binary =
search");
>                         }
>                 }
> -               if (18 <=3D ofs)
> -                       die("cannot happen -- lo and hi are identical=
");
>         }
>
>         do {
> diff --git a/t/t0064-sha1-array.sh b/t/t0064-sha1-array.sh
> index bd68789..3fcb8d8 100755
> --- a/t/t0064-sha1-array.sh
> +++ b/t/t0064-sha1-array.sh
> @@ -61,4 +61,24 @@ test_expect_success 'lookup with duplicates' '
>         test "$n" -le 3
>  '
>
> +test_expect_success 'lookup with almost duplicate values' '
> +       {
> +               echo "append 5555555555555555555555555555555555555555=
" &&
> +               echo "append 555555555555555555555555555555555555555f=
" &&
> +               echo20 "lookup " 55
> +       } | test-sha1-array >actual &&
> +       n=3D$(cat actual) &&
> +       test "$n" -eq 0
> +'
> +
> +test_expect_success 'lookup with single duplicate value' '
> +       {
> +               echo20 "append " 55 55 &&
> +               echo20 "lookup " 55
> +       } | test-sha1-array >actual &&
> +       n=3D$(cat actual) &&
> +       test "$n" -ge 0 &&
> +       test "$n" -le 1
> +'

An alternative would be to introduce these two tests in patch 1/2 as
test_expect_failure and flip them to test_expect_success in this patch
which fixes the problem.

> +
>  test_done
> --
> 2.1.2
