From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] ref-filter: fallback on alphabetical comparison
Date: Sun, 25 Oct 2015 21:13:41 -0400
Message-ID: <CAPig+cRRB5MNxuBc-5rM_8cJh69PjH5-OSmkRNw_6OFQdQOoTw@mail.gmail.com>
References: <1445790540-22764-1-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 02:13:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqWM6-0005cq-SY
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 02:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505AbbJZBNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2015 21:13:43 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:33124 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbbJZBNm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2015 21:13:42 -0400
Received: by vkgy127 with SMTP id y127so90312647vkg.0
        for <git@vger.kernel.org>; Sun, 25 Oct 2015 18:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=W4QbXiIF+Ce651FdApu088woGIvqWKW2swJfScoS608=;
        b=K73zIRxacdaK4L6qn7DZv9giRdPwKwYk4nAV1jzwjPvBle0WN6uXOJfFDOBk+3CnRH
         2iuAn0l0aBwOJDUM7Nw4ChkGV62zUBelhwm0jYG1qwNetbsypdEJAXGNH2wYQZWuViHs
         P8LO0YY7juo2Z59Zj5pX7yAEANEeFkJJcTNPTxdLUW9X4kDRwhgVuH+/mnUcmDFKZmFR
         D5mYY2hKWfbh8xQ7LwTH5DZVSEmtbKuIAJL2rzZNzep8O3MqxCJhXOM/dCdD3UbZlwJK
         +wTwP7gwO2Lsp1eJGT5/fpMmk6b7R6CvjzHRLXF7NJsP53sjGH10kCJmrrkoVE3htSvj
         YuQw==
X-Received: by 10.31.56.15 with SMTP id f15mr423574vka.84.1445822021775; Sun,
 25 Oct 2015 18:13:41 -0700 (PDT)
Received: by 10.31.159.204 with HTTP; Sun, 25 Oct 2015 18:13:41 -0700 (PDT)
In-Reply-To: <1445790540-22764-1-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: ixAnR8ml2syEbCejxkA4JOYp4eE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280169>

On Sun, Oct 25, 2015 at 12:29 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> In ref-filter.c the comparison of refs while sorting is handled by
> cmp_ref_sorting() function. When sorting as per numerical values
> (e.g. --sort=objectsize) there is no fallback comparison when both
> refs hold the same value. This can cause unexpected results (i.e. the
> order of listting refs with equal values cannot be pre-determined) as

s/listting/listing/

> pointed out by Johannes Sixt ($gmane/280117).
>
> Hence, fallback to alphabetical comparison based on the refname
> whenever the other criterion is equal. Fix the test in t3203 in this
> regard.
>
> Reported-by: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---
>  ref-filter.c             | 2 +-
>  t/t3203-branch-output.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 046e73b..7b33cb8 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1698,7 +1698,7 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
>                 if (va->ul < vb->ul)
>                         cmp = -1;
>                 else if (va->ul == vb->ul)
> -                       cmp = 0;
> +                       cmp = strcmp(a->refname, b->refname);
>                 else
>                         cmp = 1;
>         }
> diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
> index f77971c..9f2d482 100755
> --- a/t/t3203-branch-output.sh
> +++ b/t/t3203-branch-output.sh
> @@ -158,8 +158,8 @@ EOF
>
>  test_expect_success 'git branch `--sort` option' '
>         cat >expect <<-\EOF &&
> -         branch-two
>         * (HEAD detached from fromtag)
> +         branch-two
>           branch-one
>           master
>         EOF
> --
> 2.6.2
