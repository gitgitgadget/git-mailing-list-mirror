From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFCv2 2/2] git rebase -i: warn about removed commits
Date: Wed, 3 Jun 2015 15:14:17 -0400
Message-ID: <CAPig+cR=xKy-WSZSRgC8UbEbyY+=t7yDZo3O-2GquWXWWPrGVA@mail.gmail.com>
References: <1433331859-24832-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<1433331859-24832-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
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
X-From: git-owner@vger.kernel.org Wed Jun 03 21:14:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0E7T-0005us-Av
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 21:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755610AbbFCTOX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Jun 2015 15:14:23 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:33939 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754576AbbFCTOS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jun 2015 15:14:18 -0400
Received: by igbhj9 with SMTP id hj9so120231516igb.1
        for <git@vger.kernel.org>; Wed, 03 Jun 2015 12:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=mSG4GV6cefITvwnMxEj2nC21fWttAPtVBxTsxa/dQbA=;
        b=T9DqNsDAwZVACEiDhIZprw+WzV4yQ691WBA5kfrEdaPaudB9DmX2nUIbfmgQkDVUPC
         rdEpkpCMunRbUINd95JijbkCrVVLWhVrV8+dYLyHv8TW93US8D4VUPqyvSw6+xoaBz2o
         d85F+ZChWnjOb2YvBBoHVpkBBB9mExsraXaDQpM0aiXZ35I4A7pFPRXt853jlbYRKiKR
         gcavxYkqX6vd7EubCRKd86TJ5KJXpNAxOQruUDxE60v2Yuh8P4phd0giMv07AsByoPns
         HZl3Ldw7xMQiTt38v77ZYipJjnMejjQifGnKXZh9H+VYvqFLE38DAwu6K4HZfZc21ckT
         uPYg==
X-Received: by 10.107.31.134 with SMTP id f128mr24546913iof.19.1433358857828;
 Wed, 03 Jun 2015 12:14:17 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Wed, 3 Jun 2015 12:14:17 -0700 (PDT)
In-Reply-To: <1433331859-24832-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-Google-Sender-Auth: c6L8Fc5kGGMHhpjYbGHn5-Yy7ys
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270725>

On Wednesday, June 3, 2015, Galan R=C3=A9mi
<remi.galan-alfonso@ensimag.grenoble-inp.fr> wrote:
> Check if commits were removed (i.e. a line was deleted) and print
> warnings or abort git rebase depending on the value of the
> configuration variable rebase.missingCommits.

A few comments below in addition to those already made by Matthieu...

> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interacti=
ve.sh
> index 8960083..f369d2c 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1112,4 +1112,67 @@ test_expect_success 'drop' '
>         test A =3D $(git cat-file commit HEAD^^ | sed -ne \$p)
>  '
>
> +cat >expect <<EOF
> +Successfully rebased and updated refs/heads/tmp2.
> +EOF
> +
> +test_expect_success 'rebase -i respects rebase.missingCommitsCheck=3D=
ignore' '
> +       test_config rebase.missingCommitsCheck ignore &&
> +       test_when_finished "git checkout master &&
> +               git branch -D tmp2" &&

Strange indentation.

> +       git checkout -b tmp2 master &&
> +       set_fake_editor &&
> +       FAKE_LINES=3D"1 2 3 4" \
> +               git rebase -i --root 2>warning &&

The file containing the actual output is usually spelled "actual".

> +       test D =3D $(git cat-file commit HEAD | sed -ne \$p) &&
> +       test_cmp warning expect

The arguments to test_cmp are usually reversed so that 'expect' comes
before 'actual', which results in a more natural-feeling diff when
test_cmp detects that the files differ.

These comments apply to remaining new tests, as well.

> +'
> +
> +cat >expect <<EOF
> +Warning: some commits may have been dropped accidentally.
> +Dropped commits (newer to older):
> + - $(git rev-list --pretty=3Doneline --abbrev-commit -1 master)
> +
> +To avoid this message, use "drop" to explicitly remove a commit.
> +Use git --config rebase.missingCommitsCheck to change the level of w=
arnings (ignore, warn, error).
> +
> +Successfully rebased and updated refs/heads/tmp2.
> +EOF
> +
> +test_expect_success 'rebase -i respects rebase.missingCommitsCheck=3D=
warn' '
> +       test_config rebase.missingCommitsCheck warn &&
> +       test_when_finished "git checkout master &&
> +               git branch -D tmp2" &&
> +       git checkout -b tmp2 master &&
> +       set_fake_editor &&
> +       FAKE_LINES=3D"1 2 3 4" \
> +               git rebase -i --root 2>warning &&
> +       test D =3D $(git cat-file commit HEAD | sed -ne \$p) &&
> +       test_cmp warning expect
> +'
> +
> +cat >expect <<EOF
> +Warning: some commits may have been dropped accidentally.
> +Dropped commits (newer to older):
> + - $(git rev-list --pretty=3Doneline --abbrev-commit -1 master)
> + - $(git rev-list --pretty=3Doneline --abbrev-commit -1 master~2)
> +
> +To avoid this message, use "drop" to explicitly remove a commit.
> +Use git --config rebase.missingCommitsCheck to change the level of w=
arnings (ignore, warn, error).
> +
> +Rebase aborted due to dropped commits.
> +EOF
> +
> +test_expect_success 'rebase -i respects rebase.missingCommitsCheck=3D=
error' '
> +       test_config rebase.missingCommitsCheck error &&
> +       test_when_finished "git checkout master &&
> +               git branch -D tmp2" &&
> +       git checkout -b tmp2 master &&
> +       set_fake_editor &&
> +       test_must_fail env FAKE_LINES=3D"1 2 4" \
> +               git rebase -i --root 2>warning &&
> +       test E =3D $(git cat-file commit HEAD | sed -ne \$p) &&
> +       test_cmp warning expect
> +'
> +
>  test_done
> --
> 2.4.2.389.geaf7ccf
