From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH 1/2] sha1_name: stop hard-coding 40-character hex checks
Date: Sun, 16 Jun 2013 09:28:20 -0400
Message-ID: <CABURp0qs7uPkczmS8EC-iNgCVh2eTaeCKsh7NwVuS4j92jMn+A@mail.gmail.com>
References: <1371317906-3991-1-git-send-email-artagnon@gmail.com> <1371317906-3991-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 16 15:29:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoD0t-0006XD-Du
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 15:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755161Ab3FPN2m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 09:28:42 -0400
Received: from mail-vc0-f177.google.com ([209.85.220.177]:60585 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754868Ab3FPN2l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 09:28:41 -0400
Received: by mail-vc0-f177.google.com with SMTP id hv10so1395193vcb.22
        for <git@vger.kernel.org>; Sun, 16 Jun 2013 06:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3vfclqDFUYLBbge3Ks4bv7K7l1z+rRBy5NkNtoJYal0=;
        b=Q+/RASWlFWoV2R/LUxlvVgvlf4zo29Y1wGFw+Xd6i6GE7ZrdSOo9Uj7oKcqUWB9cKB
         69pO7v9bEsz6Y+isUZ5M+2YgB4+fs5/Jq8HpDsAXlUIQcNukd5pw2Ufh6svlLQmaAEaq
         9iMV7TBqmOxU2vuWlGZBc6Y1wmGmHCiDrmVnc8MCtm2a8ASn3ZRPg16q20o8iCRFf8a0
         UiVT31NNy1H5Rw3BJRxpZd0WS1/P3t9lG6pOWd+jpfSoi90a7yMT/aEaD6daIs2XGgJU
         Pf7kqgwVsj4j0iuOQ2V63gYUXEmMfQp3P3G2J8yK0ZHNoDjQfarkfLCKR27EuqB16eid
         b93w==
X-Received: by 10.58.19.162 with SMTP id g2mr2862768vee.12.1371389321057; Sun,
 16 Jun 2013 06:28:41 -0700 (PDT)
Received: by 10.58.243.34 with HTTP; Sun, 16 Jun 2013 06:28:20 -0700 (PDT)
In-Reply-To: <1371317906-3991-2-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228007>

On Sat, Jun 15, 2013 at 1:38 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> In two places, get_sha1_basic() assumes that strings are possibly sha1
> hexes if they are 40 characters long, and calls get_sha1_hex() in these
> two cases.  This 40-character check is ugly and wrong: there is nothing
> preventing a revision or branch name from being exactly 40 characters.
> Replace it with a call to the more robust get_short_sha1().

I share your disdain for the bare '40's in the code.  But I think this
code is less clear than the previous version with the magic number.

>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  sha1_name.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/sha1_name.c b/sha1_name.c
> index 90419ef..d862af3 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -451,7 +451,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
>         int refs_found = 0;
>         int at, reflog_len, nth_prior = 0;
>
> -       if (len == 40 && !get_sha1_hex(str, sha1)) {
> +       if (!get_short_sha1(str, strlen(str), sha1, GET_SHA1_QUIETLY)) {

Use len instead of strlen(str) here.  It's faster and more correct.

But also get_short_sha1 is much heavier than get_sha1_hex and does not
seem appropriate here.

>                 refs_found = dwim_ref(str, len, tmp_sha1, &real_ref);
>                 if (refs_found > 0 && warn_ambiguous_refs) {
>                         warning(warn_msg, len, str);
> @@ -492,9 +492,9 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
>                 int detached;
>
>                 if (interpret_nth_prior_checkout(str, &buf) > 0) {
> -                       detached = (buf.len == 40 && !get_sha1_hex(buf.buf, sha1));
> +                       detached = get_short_sha1(buf.buf, buf.len, sha1, GET_SHA1_QUIETLY);
>                         strbuf_release(&buf);
> -                       if (detached)
> +                       if (detached != SHORT_NAME_NOT_FOUND)

The semantic meaning of 'detached' seems less clear now if you have to
compare against an enumerated constant to determine the result.  But
also, I do not see why you have to test '!= SHORT_NAME_NOT_FOUND' here
but you did not have to in the other instance.

I think it would be improved if you did this comparison in the
assignment of detached so 'detached' could keep its original boolean
meaning.

But anyway, having looked inside get_short_sha1, it really does seem
to do much more than you want here.

>                                 return 0;
>                 }
>         }
> --
> 1.8.3.1.438.g96d34e8
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
