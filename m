From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] ref-filter: fallback on alphabetical comparison
Date: Sat, 24 Oct 2015 20:18:19 -0400
Message-ID: <CAPig+cRnDNFCQs6qspKDEz6C0Rum8W0tSMxejw+WOBD=XHrDxw@mail.gmail.com>
References: <562B3807.2030203@kdbg.org>
	<1445697770-29331-1-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 25 02:19:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zq91Y-00057o-6H
	for gcvg-git-2@plane.gmane.org; Sun, 25 Oct 2015 02:19:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752641AbbJYASV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2015 20:18:21 -0400
Received: from mail-vk0-f54.google.com ([209.85.213.54]:35720 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752572AbbJYASU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2015 20:18:20 -0400
Received: by vkfw189 with SMTP id w189so80893909vkf.2
        for <git@vger.kernel.org>; Sat, 24 Oct 2015 17:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=KwYKpLMtOc1nlDQoxIc8laicxRsVpY5CPHPQLAlVCts=;
        b=zksZlkfYTMRszjFIt+9ni222WZj8ufMyHAYNhcRplNloQnMl8spjhoMLC8BWFczF2r
         ILjxN6zTPzd53Sul+CS82gyOK9dJf5+7IbIEThXfGW8BQnO5hR1f47CDCWce1p4mn5GW
         mHq8tm7leYNAFlU2VJhjOcsDhPo0mJb60C4Levv0mA/cWGA69aKWL+ssitcSGiy2ski+
         u7IY0HFLMr+hLM8kwmcJgErYtjjMN/4LOv2Aolj5s/dQArilrqRr3B4aqd0C3X7qXcWy
         TGIMHT1ViSGr4s/GBqGS5ULMQhrORebzMcQ60++6bynygyQJDs70wFYlosLcjVXl2Daw
         lG7Q==
X-Received: by 10.31.153.129 with SMTP id b123mr18408963vke.117.1445732299579;
 Sat, 24 Oct 2015 17:18:19 -0700 (PDT)
Received: by 10.31.159.204 with HTTP; Sat, 24 Oct 2015 17:18:19 -0700 (PDT)
In-Reply-To: <1445697770-29331-1-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: nz9XZeMAbs9AfdvLsgytWydt-Kc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280134>

On Sat, Oct 24, 2015 at 10:42 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> In ref-filter.c the comparison of refs while sorting is handled by
> cmp_ref_sorting() function. When sorting as per numerical values
> (e.g. --sort=objectsize) there is no fallback comparison when both refs
> hold the same value. This can cause unexpected results as pointed out
> by Johannes Sixt ($gmane/280117).

Please make the commit message self-contained by describing the
"unexpected results" here rather than directing readers to chase down
the information elsewhere themselves.

> Hence, fallback to alphabetical comparison based on the refname whenever
> the other criterion is equal. Fix the test in t3203 in this regard.
>
> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>

It would not be amiss to add a Reported-by: to credit j6t.

> ---
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
