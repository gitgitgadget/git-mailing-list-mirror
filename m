From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 08/10] t6050: add tests for listing with --format
Date: Sun, 8 Dec 2013 22:19:39 -0500
Message-ID: <CAPig+cTcacoNGstYeYRd3_WKAP6=ga7gV4puSsr7c2sO_OMNTQ@mail.gmail.com>
References: <20131207160514.21478.72966.chriscool@tuxfamily.org>
	<20131207162106.21478.8850.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Joey Hess <joey@kitenet.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Dec 09 04:19:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VprNp-000395-6o
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 04:19:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138Ab3LIDTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Dec 2013 22:19:41 -0500
Received: from mail-la0-f47.google.com ([209.85.215.47]:49332 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932109Ab3LIDTk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Dec 2013 22:19:40 -0500
Received: by mail-la0-f47.google.com with SMTP id ep20so1122736lab.20
        for <git@vger.kernel.org>; Sun, 08 Dec 2013 19:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=J5UAs6/EVKMZn+QL1nszu1BuZRmVawoiItAeVjgha1I=;
        b=mKvwIhMskhRHfGp8uyQhLWQivyPeINO337dh+vT7/frN384CT0yNAnFsgNBdwJadvX
         H8B0/jIbDwe6SLmIOLXYFAZdldeFoDf2gwzq79QNNAtjFPANUwZuSVZSIsODoIZlnJXK
         YEoBWbi8/TwFPiOKyd83fnfys0K/+uIDKPqACr3zVNpOMy8qcz6OF6H4lZNrcBBJSgVc
         Xz36D/QUOUqPbDhD/eRYmbk2fuHDrnej2V6I1TWq9SCvXhfyNmfARNbHFeLsCwYf6ep0
         YtN8ii4B8aSteoqplDfE1FWYMMybHWTS5f0xTwMTlNyYBqOfBKXrHCkGNjEqyRaaRJms
         /87g==
X-Received: by 10.152.197.67 with SMTP id is3mr1122105lac.61.1386559179086;
 Sun, 08 Dec 2013 19:19:39 -0800 (PST)
Received: by 10.114.175.130 with HTTP; Sun, 8 Dec 2013 19:19:39 -0800 (PST)
In-Reply-To: <20131207162106.21478.8850.chriscool@tuxfamily.org>
X-Google-Sender-Auth: -EkQktUbV9exS2MW5uGBz-c9sAg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239059>

On Sat, Dec 7, 2013 at 11:21 AM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> This patch adds tests for "git replace -l --format=<fmt>".
> Only tests when <fmt> is 'medium' and 'full' are needed
> because 'short' is the same as with no --format option.

Nevertheless, don't you want to test that it behaves in the expected
manner when given --format=short and other legal or illegal
combinations?

  --format
  --format short
  --format bogus
  ...etc...

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  t/t6050-replace.sh | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
> index bb785ec..3627b4c 100755
> --- a/t/t6050-replace.sh
> +++ b/t/t6050-replace.sh
> @@ -281,6 +281,33 @@ test_expect_success 'git cat-file --batch works on replace objects' '
>         echo $PARA3 | git cat-file --batch
>  '
>
> +test_expect_success 'test --format medium' '
> +       H1=$(git --no-replace-objects rev-parse HEAD~1) &&
> +       HT=$(git --no-replace-objects rev-parse HEAD^{tree}) &&
> +       MYTAG=$(git --no-replace-objects rev-parse mytag) &&
> +       {
> +               echo "$H1 -> $BLOB" &&
> +               echo "$BLOB -> $REPLACED" &&
> +               echo "$HT -> $H1" &&
> +               echo "$PARA3 -> $S" &&
> +               echo "$MYTAG -> $HASH1"
> +       } | sort >expected &&
> +       git replace -l --format medium | sort > actual &&
> +       test_cmp expected actual
> +'
> +
> +test_expect_failure 'test --format full' '
> +       {
> +               echo "$H1 (commit) -> $BLOB (blob)" &&
> +               echo "$BLOB (blob) -> $REPLACED (blob)" &&
> +               echo "$HT (tree) -> $H1 (commit)" &&
> +               echo "$PARA3 (commit) -> $S (commit)" &&
> +               echo "$MYTAG (tag) -> $HASH1 (commit)"
> +       } | sort >expected &&
> +       git replace --format=full | sort > actual &&
> +       test_cmp expected actual
> +'
> +
>  test_expect_success 'replace ref cleanup' '
>         test -n "$(git replace)" &&
>         git replace -d $(git replace) &&
> --
> 1.8.5.1.102.g090758b
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
