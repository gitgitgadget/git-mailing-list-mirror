From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] merge-base: "--reflog" mode finds fork point from
 reflog entries
Date: Thu, 24 Oct 2013 17:01:56 -0400
Message-ID: <CAPig+cQrBMMqSmOk0GSZJ9PTHNt-t+vuOG2Aq=7VTR1EZSeLsw@mail.gmail.com>
References: <xmqqhac6o5hj.fsf@gitster.dls.corp.google.com>
	<1382641884-14756-1-git-send-email-gitster@pobox.com>
	<1382641884-14756-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 24 23:02:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZS2c-0006X1-2Z
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 23:02:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755954Ab3JXVB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 17:01:58 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:64813 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754665Ab3JXVB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 17:01:57 -0400
Received: by mail-la0-f54.google.com with SMTP id gx14so2351313lab.41
        for <git@vger.kernel.org>; Thu, 24 Oct 2013 14:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ss/BkKjuA9DvPHbBox+8jskjzOt8rEedVNutxaXMe9E=;
        b=wyRBmQ4VcV3RupeIUcJXYAJYoeZI0eZPmFLDaGYAzJs1OO53zeJ3x5dZj5RJXbStnD
         mbZ+2dD5HVn2IulflXvvF9MqEGBG5ZwnMYGD4/tG8FUolW2zfJrZZoLoidXXBKJ7urlk
         panYwSSIYJ7bznRdVtfW/5JBDk7OLtKUAYdM5W68uFWwWgeqBkomTmomelpQl3sYRpaB
         eA2k6oNArwLP6UJvupXfAvMcDE7OI6YrQhKeTlwl6i1VcK2mcVYUBGxE4f+4sPH2n7Fw
         qPOhzKpiZciH5dh00qTD33bb+KmmQ567o8jzy1ah+hNeRPFihToHNPVKPzlNnnZS/UWg
         aDOA==
X-Received: by 10.152.29.38 with SMTP id g6mr2997479lah.25.1382648516409; Thu,
 24 Oct 2013 14:01:56 -0700 (PDT)
Received: by 10.114.200.180 with HTTP; Thu, 24 Oct 2013 14:01:56 -0700 (PDT)
In-Reply-To: <1382641884-14756-3-git-send-email-gitster@pobox.com>
X-Google-Sender-Auth: uy0ixOTTeoRV0d0_owufQ_bxhvY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236622>

On Thu, Oct 24, 2013 at 3:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
> index f80bba8..3a1abee 100755
> --- a/t/t6010-merge-base.sh
> +++ b/t/t6010-merge-base.sh
> @@ -230,4 +230,31 @@ test_expect_success 'criss-cross merge-base for octopus-step' '
>         test_cmp expected.sorted actual.sorted
>  '
>
> +test_expect_success 'using reflog to find the fork point' '
> +       git reset --hard &&
> +       git checkout -b base $E &&
> +       (
> +               for count in 1 2 3 4 5
> +               do
> +                       git commit --allow-empty -m "Base commit #$count" &&
> +                       git rev-parse HEAD >expect$count &&
> +                       git checkout -B derived &&
> +                       git commit --allow-empty -m "Derived #$count" &&
> +                       git rev-parse HEAD >derived$count &&
> +                       git checkout base &&
> +                       count=$(( $count + 1 )) || exit 1
> +               done

Did you want && here?

> +
> +               for count in 1 2 3 4 5
> +               do
> +                       git merge-base --reflog base $(cat derived$count) >actual &&
> +                       test_cmp expect$count actual || exit 1
> +               done

And here?

> +
> +               # check defaulting to HEAD
> +               git merge-base --reflog base >actual &&
> +               test_cmp expect5 actual
> +       )
> +'
> +
>  test_done
