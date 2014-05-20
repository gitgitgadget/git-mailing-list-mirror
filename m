From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] rebase -i: test "Nothing to do" case with autostash
Date: Tue, 20 May 2014 03:22:15 -0400
Message-ID: <CAPig+cSWrc-W+9CZQ9vF-E3xcLY3OFoRMpHLb3K8Vsx3iz1Mjw@mail.gmail.com>
References: <1400537120-9995-1-git-send-email-artagnon@gmail.com>
	<1400568913-1340-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	ether@cpan.org, Felipe Contreras <felipe.contreras@gmail.com>,
	philippe.vaucher@gmail.com,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue May 20 10:01:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmeNR-00035X-62
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 09:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460AbaETHWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 03:22:17 -0400
Received: from mail-yh0-f44.google.com ([209.85.213.44]:39794 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895AbaETHWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 03:22:16 -0400
Received: by mail-yh0-f44.google.com with SMTP id b6so47689yha.17
        for <git@vger.kernel.org>; Tue, 20 May 2014 00:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=KvTeIyqne+iBzHlp9gSAJKjBO9ZCUOqwQU+Q/ozYmDY=;
        b=c4zHeGc2WPOygnC5XZiJgFMwcO/S9j+3HkiORiMM3VW2JgoXYVtq3+7ceBb8HBT2aa
         JxJ/wxcRb9lMm86NA+Q5bE42Z8DNUZANthGZm5tNqFQqWRQmX23mGsylySeZiN/dvEVq
         R5SeG8HgAxI2BTDYrEGF7AyWZ3mxkqVHsPAXteIITWCIMkQu6lkbwpkkT3rZQ+eqpU3M
         jhidlf2x4+LSSGhfBE7wPtxWcTNcT/4UcDQE6xGA/tn0oilQtYbK1S0p8dkGByBI8IrE
         0uH3kSPdmJD+HfTiziUkQiOvNl5/JJ0X0X3cjVm/1B1yRhlbkaHGvAm1t4XbCWWZ9JGK
         1XOg==
X-Received: by 10.236.170.37 with SMTP id o25mr12539072yhl.145.1400570535965;
 Tue, 20 May 2014 00:22:15 -0700 (PDT)
Received: by 10.170.169.65 with HTTP; Tue, 20 May 2014 00:22:15 -0700 (PDT)
In-Reply-To: <1400568913-1340-1-git-send-email-Matthieu.Moy@imag.fr>
X-Google-Sender-Auth: f6ZX9yiv4y96dKp_vDYDEtq3ycs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249642>

On Tue, May 20, 2014 at 2:55 AM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> Ram's patch lacks a test. Here it is. Fails without Ram's patch, and
> passes with it.
>
> Can be squashed into Ram's patch.
>
>  t/t3420-rebase-autostash.sh | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
> index 90eb264..c2e9a4c 100755
> --- a/t/t3420-rebase-autostash.sh
> +++ b/t/t3420-rebase-autostash.sh
> @@ -167,4 +167,21 @@ testrebase "" .git/rebase-apply
>  testrebase " --merge" .git/rebase-merge
>  testrebase " --interactive" .git/rebase-merge
>
> +test_expect_success 'Abort rebase with --autostash' '
> +       git log &&
> +       echo new-content >file0 &&
> +       (
> +               write_script abort-editor.sh <<-\EOF &&
> +                       echo > "$1"
> +               EOF
> +               GIT_EDITOR=\"$(pwd)/abort-editor.sh\" &&
> +               export GIT_EDITOR &&

Simpler (replace above two lines):

    test_set_editor "$(pwd)/abort-editor.sh" &&

> +               test_must_fail git rebase -i --autostash HEAD^ &&
> +               rm -f abort-editor.sh
> +       ) &&
> +       git status &&
> +       echo new-content >expected &&
> +       test_cmp expected file0
> +'
> +
>  test_done
> --
> 2.0.0.rc3.499.gd6dc9ad
