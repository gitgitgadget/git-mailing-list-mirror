From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFCv2 2/2] git rebase -i: warn about removed commits
Date: Mon, 1 Jun 2015 19:16:11 -0400
Message-ID: <CAPig+cRGT4qgCNgVi_x-==GKze7VUPVbVPGHYui7y5ZXie72Qw@mail.gmail.com>
References: <1433159523-6596-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<1433159523-6596-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
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
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Philip Oakley <philipoakley@iee.org>,
	Stephen Kelly <steveire@gmail.com>
To: =?UTF-8?Q?Galan_R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 02 01:16:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzYwL-0006QA-Sb
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 01:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447AbbFAXQO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Jun 2015 19:16:14 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:36774 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633AbbFAXQM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Jun 2015 19:16:12 -0400
Received: by ieclw1 with SMTP id lw1so25687342iec.3
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 16:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=GMNXNLkHhaL2n3vUskw+Z0N3dz4953T3GHqsddlJBao=;
        b=owREFJxi2f4knrAIe6EDrUpn2nP0Zlne5FCxqoCK3+ZUtrrOqSiUCxKqkJhLaB/6W9
         +679e9FlJXxtKSW5coHgJs/D3MaAJ0FmWHG/WNUn8E+FqRB28CNl0MBKXcfeTGYrfBIL
         sJdKisKabUcAp12bhRXv4lPccTUpiN5Fqel+e/59l+IJ2+P1TyRGulPdA8lrMyFkvaSn
         Byi2FYq1q5ruEFsUz5cekKXLR78K1K7ldtIRnj9XgKQTmaTVhSZCBuamFzs0OWHRnjLu
         dUXRPkDQgeHf5aZKuHifET0DyXlLbs3h7mG2FXooIC+XV5uUW8/H4locIBt+RgD6Qdye
         iIKg==
X-Received: by 10.107.137.80 with SMTP id l77mr28898801iod.92.1433200571371;
 Mon, 01 Jun 2015 16:16:11 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Mon, 1 Jun 2015 16:16:11 -0700 (PDT)
In-Reply-To: <1433159523-6596-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-Google-Sender-Auth: s60ekbWrK26RUwOyLX8ylfD3nqQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270480>

On Mon, Jun 1, 2015 at 7:52 AM, Galan R=C3=A9mi
<remi.galan-alfonso@ensimag.grenoble-inp.fr> wrote:
> Check if commits were removed (i.e. a line was deleted) and print
> warnings or abort git rebase according to the value of the
> configuration variable rebase.checkLevel.
>
> Add the configuration variable rebase.checkLevel.
>     - When unset or set to "ignore", no checking is done.
>     - When set to "warn", the commits are checked, warnings are
>       displayed but git rebase still proceeds.
>     - When set to "error", the commits are checked, warnings are
>       displayed and the rebase is aborted.
>
> rebase.checkLevel defaults to "ignore".
>
> Signed-off-by: Galan R=C3=A9mi <remi.galan-alfonso@ensimag.grenoble-i=
np.fr>
> ---
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 5f76e8c..e2e5554 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2160,6 +2160,15 @@ rebase.autoStash::
>         successful rebase might result in non-trivial conflicts.
>         Defaults to false.
>
> +rebase.checkLevel::
> +       If set to "warn", git rebase -i will print a warning if some
> +       commits are removed (i.e. a line was deleted) or if some
> +       commits appear more than one time (e.g. the same commit is
> +       picked twice), however the rebase will still proceed. If set

The cover letter says that v2 no longer checks for a duplicate,
however, this documentation still mentions it.

> +       to "error", it will print the previous warnings and abort the
> +       rebase. If set to "ignore", no checking is done.  Defaults to
> +       "ignore".
> +
>  receive.advertiseAtomic::
>         By default, git-receive-pack will advertise the atomic push
>         capability to its clients. If you don't want to this capabili=
ty
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.=
txt
> index 9cf3760..d348ca2 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -213,6 +213,12 @@ rebase.autoSquash::
>  rebase.autoStash::
>         If set to true enable '--autostash' option by default.
>
> +rebase.checkLevel::
> +       If set to "warn" print warnings about removed commits and
> +       duplicated commits in interactive mode. If set to "error"

Same here.

> +       print the warnings and abort the rebase. If set to "ignore" n=
o
> +       checking is done. "ignore" by default.
> +
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interacti=
ve.sh
> index 1bad068..d3a9ed5 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1103,7 +1103,6 @@ test_expect_success 'rebase -i commits that ove=
rwrite untracked files (no ff)' '
>  '
>
>  test_expect_success 'drop' '
> -       git checkout master &&
>         test_when_finished "git checkout master" &&
>         git checkout -b dropBranchTest master &&

This "cleanup" change might deserve its own test (or at least a
mention in the commit message).

>         set_fake_editor &&
> @@ -1113,4 +1112,13 @@ test_expect_success 'drop' '
>         test A =3D $(git cat-file commit HEAD^^ | sed -ne \$p)
>  '
>
> +test_expect_success 'rebase -i respects rebase.checkLevel' '
> +       test_config rebase.checkLevel error &&
> +       test_when_finished "git checkout master" &&
> +       git checkout -b tmp2 master &&
> +       set_fake_editor &&
> +       test_must_fail env FAKE_LINES=3D"1 2 3 4" git rebase -i --roo=
t &&
> +       test E =3D $(git cat-file commit HEAD | sed -ne \$p)
> +'

Shouldn't you also explicitly test "warn" and "ignore" modes?
