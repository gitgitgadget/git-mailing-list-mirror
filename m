From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] log: fix indentation for --graph --show-signature
Date: Tue, 8 Jul 2014 17:33:04 -0400
Message-ID: <CAPig+cT1xcpH7GzfGO8ZkNsN0=waS34p=Yejd-Mv7che1U0i2Q@mail.gmail.com>
References: <1404817948-7794-1-git-send-email-zoltan.klinger@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, jpyeron@pdinc.us,
	Junio C Hamano <gitster@pobox.com>
To: Zoltan Klinger <zoltan.klinger@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 23:33:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4d0h-0005kW-Sm
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 23:33:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965AbaGHVdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 17:33:07 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:58792 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940AbaGHVdG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2014 17:33:06 -0400
Received: by mail-lb0-f182.google.com with SMTP id c11so4437803lbj.13
        for <git@vger.kernel.org>; Tue, 08 Jul 2014 14:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=tSZPXIt12qymn6MfvYxhENf+J2Yagqj9uvGVawON+f0=;
        b=s0f1TLek3RcxfcpuxPd92isa2y2hOjEfxdINYkBq/rNCMsOnIqW+mhx/cR9JJTm5/O
         o+9Hjtz9jbJelILRK34pbx3kiPR+w0EfyV5GX0X0AhipzkTdqN9km0ZdTByksyUBseHP
         adepE+x69S1kSXIjryx1Qzu7JlZykSUf4gq2L0/hv/HAMoKDFA2ihSQDM++ADggpdgB+
         U9yVR4pyR9I2K7DxiNwjxUNLX5j87TV8itndW+idPQghL1bz0RgwjIdwFUbKWTD5np+D
         7gXLgU5VeUtOZMw2z80H3LNy+n1z5wexqqm3dAsjjYR8WQurqlVheE+f7ofibmvSBpqj
         HXnQ==
X-Received: by 10.112.161.71 with SMTP id xq7mr8808103lbb.57.1404855184109;
 Tue, 08 Jul 2014 14:33:04 -0700 (PDT)
Received: by 10.114.78.167 with HTTP; Tue, 8 Jul 2014 14:33:04 -0700 (PDT)
In-Reply-To: <1404817948-7794-1-git-send-email-zoltan.klinger@gmail.com>
X-Google-Sender-Auth: MURIz3aYkhafnQK5M2xvf0JZwEs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253050>

On Tue, Jul 8, 2014 at 7:12 AM, Zoltan Klinger <zoltan.klinger@gmail.com> wrote:
> The git log --graph --show-signature command incorrectly indents the gpg
> information about signed commits and merged signed tags. It does not
> follow the level of indentation of the current commit.
>
> Reported-by: Jason Pyeron <jpyeron@pdinc.us>
> Signed-off-by: Zoltan Klinger <zoltan.klinger@gmail.com>
> ---
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index cb03d28..b429aff 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -3,6 +3,7 @@
>  test_description='git log'
>
>  . ./test-lib.sh
> +. "$TEST_DIRECTORY/lib-gpg.sh"
>
>  test_expect_success setup '
>
> @@ -841,4 +842,32 @@ test_expect_success 'dotdot is a parent directory' '
>         test_cmp expect actual
>  '
>
> +test_expect_success GPG 'log --graph --show-signature' '
> +       git checkout -b signed master &&

Do you want

    test_when_finished 'git reset --hard && git checkout master' &&

here in case of failure in this test in order to restore sanity for
tests which might be added later?

> +       echo foo >foo &&
> +       git add foo &&
> +       git commit -S -m signed_commit &&
> +       git log --graph --show-signature -n1 signed >actual &&
> +       grep "^| gpg: Signature made" actual &&
> +       grep "^| gpg: Good signature" actual
> +'
> +
> +test_expect_success GPG 'log --graph --show-signature for merged tag' '
> +       git checkout -b plain master &&
> +       echo aaa >bar &&
> +       git add bar &&
> +       git commit -m bar_commit

Broken &&-chain.

> +       git checkout -b tagged master &&

Ditto regarding test_when_finished.

> +       echo bbb >baz &&
> +       git add baz &&
> +       git commit -m baz_commit

Broken &&-chain.

> +       git tag -s -m signed_tag_msg signed_tag &&
> +       git checkout plain &&
> +       git merge --no-ff -m msg signed_tag &&
> +       git log --graph --show-signature -n1 plain >actual &&
> +       grep "^|\\\  merged tag" actual &&
> +       grep "^| | gpg: Signature made" actual &&
> +       grep "^| | gpg: Good signature" actual
> +'
> +
>  test_done
> --
> 2.0.0
