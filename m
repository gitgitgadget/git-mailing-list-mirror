From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] push: respect --no-thin
Date: Sun, 11 Aug 2013 01:12:49 -0400
Message-ID: <CAPig+cSEUrKBg4e9Q+hdeJ1P=3ANwPJfZO6bohH79ZxxuO-PcQ@mail.gmail.com>
References: <1376129407-30590-1-git-send-email-pclouds@gmail.com>
	<1376184258-6784-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Martin Fick <mfick@codeaurora.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 11 07:12:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8NxX-0005O8-Vk
	for gcvg-git-2@plane.gmane.org; Sun, 11 Aug 2013 07:12:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029Ab3HKFMw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Aug 2013 01:12:52 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:52417 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963Ab3HKFMv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Aug 2013 01:12:51 -0400
Received: by mail-lb0-f170.google.com with SMTP id r10so4092217lbi.1
        for <git@vger.kernel.org>; Sat, 10 Aug 2013 22:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=GEcRThKAA+ojs3hxq3kqCr2fQifMR9vapZXyWQKeZNo=;
        b=FQVdzE3gjc35670D6U076XntqX2Q4UfLbAJGJZBtHZXQ65eeeHDL8RXhjL46FkTRRP
         HSprRzJ+NfM71aZh8yy6Y7vRVviUbTKCBtTVeNHpo0UCeP1NicfSAIp7B8qcnKM/W3VB
         ivSKRJws4af8n3u7xg0a00/1BGh1Y0/rJEDup/XB6HvNVnXwNScy5qG1VLBQQsr4eaXW
         V/Qk3DE+I4TaId1RDhMEOWu4bldk89KHhmd8bTWn9gUq0vtE6+7w1Q/ZUPVX2akKar0O
         eZOZAbTCmIhqEJnKz4EmplvByN9HUbaal3esU6vy+jT5mxHqUyCC8F3wjiRCOrOy0qWl
         l2Ug==
X-Received: by 10.112.200.135 with SMTP id js7mr7288405lbc.12.1376197969974;
 Sat, 10 Aug 2013 22:12:49 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Sat, 10 Aug 2013 22:12:49 -0700 (PDT)
In-Reply-To: <1376184258-6784-1-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: S8zZhLpdXIkb7-EQan3jQvpPaQs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232120>

On Sat, Aug 10, 2013 at 9:24 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Over the time the default value for --thin has been switched between
> on and off. As of now it's always on, even if --no-thin is given.
> Correct the code to respect --no-thin.
>
> receive-pack learns about --no-thin only for testing purposes, hence
> no document update.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 4691d51..e80247b 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -1172,4 +1172,16 @@ test_expect_success 'push --follow-tag only pu=
shes relevant tags' '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'push --no-thin must produce non-thin pack' '
> +       for i in `seq 100`; do echo modified >> path1; done &&

s/seq/test_seq/

d17cf5f3a32f07bf (tests: Introduce test_seq;  2012-08-03)

> +       git commit -am "path1 big enough to pass size heuristics in t=
ry_delta" &&
> +       git init no-thin &&
> +       git --git-dir=3Dno-thin/.git config receive.unpacklimit 0 &&
> +       git push no-thin/.git refs/heads/master:refs/heads/foo &&
> +       echo modified >> path1 &&
> +       git commit -am modified &&
> +       git repack -adf &&
> +       git push --no-thin --receive-pack=3D"git receive-pack --no-th=
in" no-thin/.git refs/heads/master:refs/heads/foo
> +'
> +
>  test_done
> --
> 1.8.2.83.gc99314b
