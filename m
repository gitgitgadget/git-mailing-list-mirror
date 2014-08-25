From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 5/5] fast-import: stop using lock_ref_sha1
Date: Mon, 25 Aug 2014 10:22:48 -0700
Message-ID: <CAL=YDW=k4QpejdqPgnVy+05hjsVHw35BBbKmsAEOP-9gBMjCJw@mail.gmail.com>
References: <20140823052334.GA17813@peff.net>
	<20140823053322.GE18075@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 25 19:22:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLxyp-0003Wm-2E
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 19:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933095AbaHYRWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 13:22:50 -0400
Received: from mail-vc0-f173.google.com ([209.85.220.173]:42757 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933093AbaHYRWt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 13:22:49 -0400
Received: by mail-vc0-f173.google.com with SMTP id hy10so15523570vcb.18
        for <git@vger.kernel.org>; Mon, 25 Aug 2014 10:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mr7CblZxRyB5i8G8YFmsIPleSEZNxNCxIgcNP1Dpm1U=;
        b=eldaZTOQhkL3pZIDLe+q9iUNp6G10NGFcFvrkxM5CT5bQfMugAlkRn3apQK9pboxCj
         b5UHJ4r4toNkGpciVblF3aCE1+m3/JbxgaFgCK8vj/aBuqAzK1567EzPxAlTibQPXJY5
         Y0zFfdIMSKlwAZUf1y0hh80lZD7itZDr/oDfAkWozgaHSzMNGtoexySC23HwgyOdY47V
         DNHLiM1UPyB6U/i05PKA+sSzcIwYN2TdlbVaQU6XV+0minZTS29mRu/FxRx730JShUvw
         JLCYlNK910W8uB9zDFb2lEci1LKAgybZ4yCG2/0hrY57IGZzFxx+/AaQVNAjc0/BSvyR
         s+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=mr7CblZxRyB5i8G8YFmsIPleSEZNxNCxIgcNP1Dpm1U=;
        b=G8NV4WL46YLu0Yz323epby4QLAwcdK+OjA6pmIgswlMxAedLa3MCTdPIZmC2EJm1p8
         mWok6SCCKUzWVf0Ek2iPwVAnS5TLQAGezY0kFZOBSZ12+Hk08tkyHcdsI4ntYnnF1/ao
         eqeUn95CDCvFLbdABTgLoAGh233I161/F21+/4n4+EX2JyE6roV+YoqhN4pIgi4VvHTM
         WiBdON5hFNgoOFW0CcOKod084g5WIhK6WdEa0MSUrvBgjrWzczmjRgQQq7yvaRtCUuLv
         WRaic4Y2hUZWz4BRxDMfRzPiYjHkQQ9kQszewwCjmKuMddk36IOsUZjRXicaDzFyWcxa
         n2CQ==
X-Gm-Message-State: ALoCoQmQYe2twdA/cBFeEDxtT/+Lxem4Q5TnGkovd+bJQMHLmXSTOO1WwnGG+YqmqMzSXAyge/8r
X-Received: by 10.53.12.225 with SMTP id et1mr16439986vdd.5.1408987368504;
 Mon, 25 Aug 2014 10:22:48 -0700 (PDT)
Received: by 10.52.69.136 with HTTP; Mon, 25 Aug 2014 10:22:48 -0700 (PDT)
In-Reply-To: <20140823053322.GE18075@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255840>

The next ref transaction series does a similar change and ends up
removing the function lock_ref_sha1() completely.
https://code-review.googlesource.com/#/c/1017/19/refs.c

So I think we can drop this patch.


ronnie sahlberg


On Fri, Aug 22, 2014 at 10:33 PM, Jeff King <peff@peff.net> wrote:
> We can use lock_any_ref_for_update instead. Besides being
> more flexible, the only difference between the two is that
> lock_ref_sha1 does not allow "top-level" refs like
> "refs/foo" to be updated. However, we know that we do not
> have such a ref, because we explicitly add the "tags/"
> prefix ourselves.
>
> Note that we now must feed the whole name "refs/tags/X"
> instead of just "tags/X" to the function. As a result, our
> failure error message is uses the longer name. This is
> probably a good thing, though.
>
> As an interesting side note, if we forgot to switch this
> input to the function, the tests do not currently catch it.
> We import a tag "X" and then check that we can access it at
> "tags/X". If we accidentally created "tags/X" at the
> top-level $GIT_DIR instead of under "refs/", we would still
> find it due to our ref lookup procedure!
>
> We do not make such a mistake in this patch, of course, but
> while we're thinking about it, let's make the fast-import
> tests more robust by checking for fully qualified
> refnames.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> As I mentioned, I'd be OK with dropping this one in favor of just
> waiting for Ronnie's transaction patches to graduate.
>
>  fast-import.c          | 4 ++--
>  t/t9300-fast-import.sh | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/fast-import.c b/fast-import.c
> index a1479e9..04a85a4 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -1738,8 +1738,8 @@ static void dump_tags(void)
>
>         for (t = first_tag; t; t = t->next_tag) {
>                 strbuf_reset(&ref_name);
> -               strbuf_addf(&ref_name, "tags/%s", t->name);
> -               lock = lock_ref_sha1(ref_name.buf, NULL);
> +               strbuf_addf(&ref_name, "refs/tags/%s", t->name);
> +               lock = lock_any_ref_for_update(ref_name.buf, NULL, 0, NULL);
>                 if (!lock || write_ref_sha1(lock, t->sha1, msg) < 0)
>                         failure |= error("Unable to update %s", ref_name.buf);
>         }
> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> index 5fc9ef2..f4c6673 100755
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -153,7 +153,7 @@ tag series-A
>  An annotated tag without a tagger
>  EOF
>  test_expect_success 'A: verify tag/series-A' '
> -       git cat-file tag tags/series-A >actual &&
> +       git cat-file tag refs/tags/series-A >actual &&
>         test_cmp expect actual
>  '
>
> @@ -165,7 +165,7 @@ tag series-A-blob
>  An annotated tag that annotates a blob.
>  EOF
>  test_expect_success 'A: verify tag/series-A-blob' '
> -       git cat-file tag tags/series-A-blob >actual &&
> +       git cat-file tag refs/tags/series-A-blob >actual &&
>         test_cmp expect actual
>  '
>
> @@ -232,8 +232,8 @@ EOF
>  test_expect_success \
>         'A: tag blob by sha1' \
>         'git fast-import <input &&
> -       git cat-file tag tags/series-A-blob-2 >actual &&
> -       git cat-file tag tags/series-A-blob-3 >>actual &&
> +       git cat-file tag refs/tags/series-A-blob-2 >actual &&
> +       git cat-file tag refs/tags/series-A-blob-3 >>actual &&
>         test_cmp expect actual'
>
>  test_tick
> --
> 2.1.0.346.ga0367b9
