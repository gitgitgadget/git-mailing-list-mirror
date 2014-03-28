From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] patch-id-test: test new --stable and --unstable flags
Date: Thu, 27 Mar 2014 20:25:04 -0400
Message-ID: <CAPig+cQ4=joCcjyhOLGAiTV2WCLk7a1Vb5R=wNCLwX1gTp8V9A@mail.gmail.com>
References: <1395912239-29663-1-git-send-email-mst@redhat.com>
	<1395912239-29663-3-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 01:25:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTKbi-0006cQ-8N
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 01:25:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757055AbaC1AZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 20:25:07 -0400
Received: from mail-yk0-f175.google.com ([209.85.160.175]:45696 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756926AbaC1AZG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 20:25:06 -0400
Received: by mail-yk0-f175.google.com with SMTP id 131so3113521ykp.6
        for <git@vger.kernel.org>; Thu, 27 Mar 2014 17:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=6Mwt30n09HJdKxj+yrOoKyVbz957bvsrym86ouDTXO4=;
        b=v++P/0duGvBnjm/5hmpHmdasZTsMbIPJhFhQ3XpsQOWE2lOQgQZyNJg4BJzalBghBY
         S0c8Qaf1VkbQ0i61XuwUJe6knX7a3QKRSDkzcEmlOMVZd+XvzigOZpYQ2oQhmZzWpM2P
         j9v2bHFxRNgymNgvWLNq+xEzeKFel8vzQXxFHwRNysyBHgiJwITGsxjRd9ZwBw9/ZNVl
         q8AGMR8BIZguNCj/0uMHzFrH2wnoWtjxfMtWNpjpk/eekr9yxmp42zemUR7yzWpyUk8k
         1i5X2lcUARCbZJYAo8llHejtHS4QZ2A+wycWp6sSFtB8bTQj5mBYPDGOScowSdCYb0dt
         V5ng==
X-Received: by 10.236.97.102 with SMTP id s66mr6600841yhf.45.1395966304791;
 Thu, 27 Mar 2014 17:25:04 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Thu, 27 Mar 2014 17:25:04 -0700 (PDT)
In-Reply-To: <1395912239-29663-3-git-send-email-mst@redhat.com>
X-Google-Sender-Auth: tgPia6ql4dXMJfZSOY2AEpSla78
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245342>

On Thu, Mar 27, 2014 at 5:25 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> Verify that patch ID is now stable against hunk reordering.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  t/t4204-patch-id.sh | 68 +++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 63 insertions(+), 5 deletions(-)
>
> diff --git a/t/t4204-patch-id.sh b/t/t4204-patch-id.sh
> index d2c930d..75f77ef 100755
> --- a/t/t4204-patch-id.sh
> +++ b/t/t4204-patch-id.sh
> @@ -5,12 +5,27 @@ test_description='git patch-id'
>  . ./test-lib.sh
>
>  test_expect_success 'setup' '
> -       test_commit initial foo a &&
> -       test_commit first foo b &&
> +       test_commit initial-foo foo a &&
> +       test_commit initial-bar bar a &&
> +       echo b > foo &&
> +       echo b > bar &&
> +       git commit -a -m first &&
>         git checkout -b same HEAD^ &&
> -       test_commit same-msg foo b &&
> +       echo b > foo &&
> +       echo b > bar &&
> +       git commit -a -m same-msg &&
>         git checkout -b notsame HEAD^ &&
> -       test_commit notsame-msg foo c
> +       echo c > foo &&
> +       echo c > bar &&
> +       git commit -a -m notsame-msg &&
> +       cat > bar-then-foo <<EOF

Broken &&-chain.

If you use -EOF, you can indent the content rather than having to hang
it on the left margin. Better, use -\EOF to indicate that you're not
interested in interpolation within the block.

> +bar
> +foo
> +EOF
> +       cat > foo-then-bar <<EOF
> +foo
> +bar
> +EOF
>  '
>
>  test_expect_success 'patch-id output is well-formed' '
> @@ -23,11 +38,33 @@ calc_patch_id () {
>                 sed "s# .*##" > patch-id_"$1"
>  }
>
> +calc_patch_id_unstable () {
> +       git patch-id --unstable |
> +               sed "s# .*##" > patch-id_"$1"
> +}
> +
> +calc_patch_id_stable () {
> +       git patch-id --stable |
> +               sed "s# .*##" > patch-id_"$1"
> +}
> +
> +
>  get_patch_id () {
> -       git log -p -1 "$1" | git patch-id |
> +       git log -p -1 "$1" -O bar-then-foo -- | git patch-id |
> +               sed "s# .*##" > patch-id_"$1"
> +}
> +
> +get_patch_id_stable () {
> +       git log -p -1 "$1" -O bar-then-foo | git patch-id --stable |
> +               sed "s# .*##" > patch-id_"$1"
> +}
> +
> +get_patch_id_unstable () {
> +       git log -p -1 "$1" -O bar-then-foo | git patch-id --unstable |
>                 sed "s# .*##" > patch-id_"$1"
>  }
>
> +
>  test_expect_success 'patch-id detects equality' '
>         get_patch_id master &&
>         get_patch_id same &&
> @@ -56,6 +93,27 @@ test_expect_success 'whitespace is irrelevant in footer' '
>         test_cmp patch-id_master patch-id_same
>  '
>
> +test_expect_success 'file order is irrelevant by default' '
> +       get_patch_id master &&
> +       git checkout same &&
> +       git format-patch -1 --stdout -O foo-then-bar | calc_patch_id same &&
> +       test_cmp patch-id_master patch-id_same
> +'
> +
> +test_expect_success 'file order is irrelevant with --stable' '
> +       get_patch_id_stable master &&
> +       git checkout same &&
> +       git format-patch -1 --stdout -O foo-then-bar | calc_patch_id_stable same &&
> +       test_cmp patch-id_master patch-id_same
> +'
> +
> +test_expect_success 'file order is relevant with --unstable' '
> +       get_patch_id_unstable master &&
> +       git checkout same &&
> +       git format-patch -1 --stdout -O foo-then-bar | calc_patch_id_unstable notsame &&
> +       ! test_cmp patch-id_master patch-id_notsame
> +'
> +
>  test_expect_success 'patch-id supports git-format-patch MIME output' '
>         get_patch_id master &&
>         git checkout same &&
> --
> MST
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
