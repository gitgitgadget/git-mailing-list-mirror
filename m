From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] Rewrite strbuf.c:strbuf_cmp() replace memcmp() with starts_with()
Date: Sun, 23 Mar 2014 05:02:06 -0400
Message-ID: <CAPig+cRVRSDktaQhXNHZfWJ+G=k6XhP6HxjJ4iOxsUfrDcYmWg@mail.gmail.com>
References: <1395523516-10181-1-git-send-email-mustafaorkunacar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Mustafa Orkun Acar <mustafaorkunacar@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 23 10:02:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WReIJ-0003oI-Hw
	for gcvg-git-2@plane.gmane.org; Sun, 23 Mar 2014 10:02:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253AbaCWJCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2014 05:02:10 -0400
Received: from mail-yh0-f45.google.com ([209.85.213.45]:50939 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbaCWJCI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2014 05:02:08 -0400
Received: by mail-yh0-f45.google.com with SMTP id a41so4068212yho.4
        for <git@vger.kernel.org>; Sun, 23 Mar 2014 02:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Ar6pcA6MSi6MYcHPMG0SPZeYtF2Oy/HrInQxIW7q9GI=;
        b=I5em3oofz5dMOvOXaEiveRAeiDeX6r0nrnin3vz3luylkYkd9S/Xhd2axv4JGfntQz
         d2owT+U1c7Kc8MAx3TtO5m+ek7b3KI0UioLAbEnyVQ5qciOx2yCcq/TxXRH+E8dl0oQ0
         5Bj2kU3zhl17NhJ+KYgANSLPXc6Kf8yy8CckTYK+/BhjnDuWbSOgDqTgZCgpTctXbyXQ
         4DufmSypy3N0P7fRd3ThG+ogeZdnANCAfW2MienUMziE2YW8urZ2vnWPH6vuFI4U2o7L
         0B1m3W7YPRncbyb7PecfxDelRYUfcFrbL+38Qp1y+ecTe5h3k0bJ/dfdG3MhfpefFdY0
         gbFA==
X-Received: by 10.236.113.194 with SMTP id a42mr207yhh.116.1395565326361; Sun,
 23 Mar 2014 02:02:06 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Sun, 23 Mar 2014 02:02:06 -0700 (PDT)
In-Reply-To: <1395523516-10181-1-git-send-email-mustafaorkunacar@gmail.com>
X-Google-Sender-Auth: 8mTiKbTJjQCMEFPOT5-ky58EifY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244791>

In addition to the valuable review comments already provided by
Alexandru and David, see a few more below.

On Sat, Mar 22, 2014 at 5:25 PM, Mustafa Orkun Acar
<mustafaorkunacar@gmail.com> wrote:
> Subject: [PATCH v2] Rewrite strbuf.c:strbuf_cmp() replace memcmp() with starts_with()

This isn't actually v2. It would have been v2 if it was a reroll of
your original patch [1], but this patch is entirely distinct from that
attempt.

Take a close look at the example Subject I wrote [2] in the review of
your first patch. Try to emulate it when writing the subject for your
patches. (You seem to have ignored it for this patch.)

> I reviewed all functions using memcmp(). It generally makes code more understandable. But here it might be used for the sake of simplicity.

Likewise, re-read the review [2] of your original patch. In
particular, see the part about wrapping text to 65-70 characters
(which you also seem to have ignored).

The sentence "I reviewed all functions using memcmp()" is primarily
commentary that won't be meaningful to someone reading the official
project history months or years from now. Place it below the "---"
line under your sign-off.

The second and third sentences are somewhat weak. You might instead
want to say something about how starts_with() does a better job
conveying the intention of the logic than does memcmp().

[1]: http://thread.gmane.org/gmane.comp.version-control.git/244529
[2]: http://thread.gmane.org/gmane.comp.version-control.git/244529/focus=244643

> Signed-off-by: Mustafa Orkun Acar <mustafaorkunacar@gmail.com>
> ---
> I applied to GSoC 2014. I expect your feedbacks and comments!
>  strbuf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/strbuf.c b/strbuf.c
> index ee96dcf..50d0875 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -147,7 +147,7 @@ void strbuf_list_free(struct strbuf **sbs)
>  int strbuf_cmp(const struct strbuf *a, const struct strbuf *b)
>  {
>         int len = a->len < b->len ? a->len: b->len;
> -       int cmp = memcmp(a->buf, b->buf, len);
> +       int cmp = !starts_with(a->buf, b->buf);
>         if (cmp)
>                 return cmp;
>         return a->len < b->len ? -1: a->len != b->len;
> --
> 1.9.1.286.g5172cb3
>
