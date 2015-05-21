From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] rebase -i: demonstrate incorrect behavior of
 post-rewrite hook with exec
Date: Thu, 21 May 2015 17:12:35 -0400
Message-ID: <CAPig+cRFwruC8DwPhH_=Jb8YAZPB5J2e0F2NBob3zLPGoMLWgA@mail.gmail.com>
References: <1432231982-31314-1-git-send-email-Matthieu.Moy@imag.fr>
	<1432231982-31314-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	antoine.delaite@ensimag.grenoble-inp.fr,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	remi.lespinet@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu May 21 23:12:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvXlg-0004FF-GW
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 23:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbbEUVMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 17:12:36 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:34567 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964782AbbEUVMf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 17:12:35 -0400
Received: by ieczm2 with SMTP id zm2so18002624iec.1
        for <git@vger.kernel.org>; Thu, 21 May 2015 14:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=CsB6emILXX7I5i0BXVLrm5ZNfsrCiTxhb0I+d4lMAHM=;
        b=Y5LVm77iSug1IDqfTbSQ+os1PbmvXy2+bSqy6ztov3OhvcUYzOSr85Yc4miVOHSliI
         lc5EDX68xBsm9ouYW5BG7eYvpzwTn30kknZgh5ihSOuJ7eRQIn1dB8FE6A0Tk1z9rf1v
         8CLQuQ+h6rninm9puazh3njDJXb1sBs5mwUplIIbcoIetHDgRM65SJOzyUmFvd4F3YQ5
         7cSDoBI6U5lDuw7fSiebUwuCK6IJWZHnSpJZsprp07NKGc3qevqDK+XJBo9ceamAyTAU
         DZd54xc5FYUtKj+k19Byt31nGGp6drUXwYb6ifnfeYkAOtdCFFlcQxyEyzmn0ZljtHWt
         iJpQ==
X-Received: by 10.50.36.9 with SMTP id m9mr921451igj.15.1432242755217; Thu, 21
 May 2015 14:12:35 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Thu, 21 May 2015 14:12:35 -0700 (PDT)
In-Reply-To: <1432231982-31314-2-git-send-email-Matthieu.Moy@imag.fr>
X-Google-Sender-Auth: GsyYrLV_TvliSMmVBOgmIzRXFc8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269662>

On Thu, May 21, 2015 at 2:13 PM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> The 'exec' command is sending the current commit to stopped-sha, which is
> supposed to contain the original commit (before rebase). As a result, if
> an 'exec' command fails, the next 'git rebase --continue' will send the
> current commit as <old-sha1> to the post-rewrite hook.
> [...]
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
> index ea2e0d4..ecef820 100755
> --- a/t/t5407-post-rewrite-hook.sh
> +++ b/t/t5407-post-rewrite-hook.sh
> @@ -212,4 +212,21 @@ EOF
>         verify_hook_input
>  '
>
> +test_expect_failure 'git rebase -i (exec)' '
> +       git reset --hard D &&
> +       clear_hook_input &&
> +       FAKE_LINES="edit 1 exec_false 2" git rebase -i B

Broken &&-chain.

> +       echo something >bar &&
> +       git add bar &&
> +       # Fail because of exec false
> +       test_must_fail git rebase --continue &&
> +       git rebase --continue &&
> +       echo rebase >expected.args &&
> +       cat >expected.data <<EOF &&
> +$(git rev-parse C) $(git rev-parse HEAD^)
> +$(git rev-parse D) $(git rev-parse HEAD)
> +EOF
> +       verify_hook_input
> +'
> +
>  test_done
> --
> 2.4.1.171.g060e6ae.dirty
