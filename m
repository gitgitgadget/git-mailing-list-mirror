From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv6 1/3] git-rebase -i: add command "drop" to remove a commit
Date: Tue, 23 Jun 2015 14:24:46 -0400
Message-ID: <CAPig+cT+idnGkR0V-UfwbHwvjd_U=zbjHx+so7Jz+4o1XU5eHw@mail.gmail.com>
References: <1435009369-11496-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Galan_R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 23 20:24:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7SsO-0001Rq-Lb
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 20:24:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933149AbbFWSYs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Jun 2015 14:24:48 -0400
Received: from mail-yh0-f52.google.com ([209.85.213.52]:35684 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932974AbbFWSYr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Jun 2015 14:24:47 -0400
Received: by yhak3 with SMTP id k3so7226433yha.2
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 11:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=aiaT034I7quFv+fMGs7CqVAoaiqfjcD1vjfaoKHeDao=;
        b=X6BdlQ8JO0+q2uRtVMJL9TaNoQsQbPCY5tbvE8MXMT2Zi9AyaP3AK+jqCDUSVtK7hw
         AQVmTh9X0MDdVtfZSAaEd7VBqGa8DxHn4St3z4iLrpRvEvUA6tEgtQx0bjJljwwqx1v5
         VDMOz6Ej5wLMIbmFqwpu82pEeRAK1CSd0GYpxiyjnZ4jnDCNM1bfCgx6eNaeXqcZlBIT
         Badh/4F/koe3qzEaAtOtlHelv22RGk5geRJbmiQcAAqOkYHa0dDXmGL2O2dz0RTzHmkc
         ELB2Qwet13XFU5fr3+efTSsXVUA71EzvcnZmDC/sc8i2CcSxhP9MCDqJUxlLd9nbI3l5
         Uziw==
X-Received: by 10.129.50.207 with SMTP id y198mr44231201ywy.39.1435083887147;
 Tue, 23 Jun 2015 11:24:47 -0700 (PDT)
Received: by 10.37.36.214 with HTTP; Tue, 23 Jun 2015 11:24:46 -0700 (PDT)
In-Reply-To: <1435009369-11496-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-Google-Sender-Auth: Q_4vLFoRYI2yBzBMDx2ee1ZCYcI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272476>

On Mon, Jun 22, 2015 at 5:42 PM, Galan R=C3=A9mi
<remi.galan-alfonso@ensimag.grenoble-inp.fr> wrote:
> Instead of removing a line to remove the commit, you can use the
> command "drop" (just like "pick" or "edit"). It has the same effect a=
s
> deleting the line (removing the commit) except that you keep a visual
> trace of your actions, allowing a better control and reducing the
> possibility of removing a commit by mistake.
>
> Signed-off-by: Galan R=C3=A9mi <remi.galan-alfonso@ensimag.grenoble-i=
np.fr>
> ---
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interacti=
ve.sh
> index ac429a0..ecd277c 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1102,4 +1102,20 @@ test_expect_success 'rebase -i commits that ov=
erwrite untracked files (no ff)' '
>         test $(git cat-file commit HEAD | sed -ne \$p) =3D I
>  '
>
> +test_rebase_end () {
> +       test_when_finished "git checkout master &&
> +       git branch -D $1 &&
> +       test_might_fail git rebase --abort" &&
> +       git checkout -b $1 master
> +}

The way this is indented makes it difficult to see that lines 2 and 3
are continuations of 1. Perhaps format it like this instead?

    test_rebase_end () {
        test_when_finished "git checkout master &&
            git branch -D $1 &&
            test_might_fail git rebase --abort" &&
        git checkout -b $1 master
    }

> +
> +test_expect_success 'drop' '
> +       test_rebase_end dropTest &&
> +       set_fake_editor &&
> +       FAKE_LINES=3D"1 drop 2 3 drop 4 5" git rebase -i --root &&
> +       test E =3D $(git cat-file commit HEAD | sed -ne \$p) &&
> +       test C =3D $(git cat-file commit HEAD^ | sed -ne \$p) &&
> +       test A =3D $(git cat-file commit HEAD^^ | sed -ne \$p)
> +'
> +
>  test_done
> --
> 2.4.3.371.g8992f2a
