From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 4/5] t4202-log: add tests for --merges=
Date: Tue, 14 Apr 2015 02:52:49 -0400
Message-ID: <CAPig+cSfC0sUdsbYHBHk-GcT3zYDptq+7CpteCPQpz6JfHCRkw@mail.gmail.com>
References: <1428938968-19013-1-git-send-email-koosha@posteo.de>
	<1428938968-19013-4-git-send-email-koosha@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Koosha Khajehmoogahi <koosha@posteo.de>
X-From: git-owner@vger.kernel.org Tue Apr 14 08:52:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhuiP-0005C6-85
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 08:52:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbbDNGww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 02:52:52 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:34752 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664AbbDNGwv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 02:52:51 -0400
Received: by laat2 with SMTP id t2so563465laa.1
        for <git@vger.kernel.org>; Mon, 13 Apr 2015 23:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=FgG9aLXcQ4N03QKmhz/70IouQkaSB3m0KEiMFnmYxSg=;
        b=ks4IwdncSKknAJzHxxZjW7ZUqC+hEashnesmxWPS3DgjYZjlnReWWhY7ehPwKLbNMK
         xsBCMttJTVIC4CMDCgAD9VJaiBZisbmV9sr5DptonSJlGvXu9DSVMMuoUJ+lSqeDi7Mm
         pfpVcScM1aUjGgA6Aek2gpn+0IaGvhsUkliYzli61m/CsY9yIvTqwMv7TwRSmFjrpXrI
         jgEnFHFjEHUyFdLLscPfBf7ZOPWqFpu440+0QQ0ZoBjzFFGfnId6e0G8xbCkV0qzpw1D
         2K8QbC0MiwrYdMsZIhPMD7CPxMzktxWqRKP7r85jQQCerovH2xkb+DFH6tC8yYeJA0ZG
         5rGA==
X-Received: by 10.112.205.225 with SMTP id lj1mr7389609lbc.27.1428994369914;
 Mon, 13 Apr 2015 23:52:49 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Mon, 13 Apr 2015 23:52:49 -0700 (PDT)
In-Reply-To: <1428938968-19013-4-git-send-email-koosha@posteo.de>
X-Google-Sender-Auth: LMhqaitdCA-bbT2im2uETrSRICo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267118>

On Mon, Apr 13, 2015 at 11:29 AM, Koosha Khajehmoogahi <koosha@posteo.de> wrote:
> From: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Koosha Khajehmoogahi <koosha@posteo.de>

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>

> ---
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 1b2e981..3edcd81 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -270,6 +270,35 @@ cat > expect <<\EOF
>  * initial
>  EOF
>
> +test_expect_success 'setup merges=' '

This differs slightly from the version I posted[1], in which I had
intentionally dropped the '=' from "merges=" in the description to
normalize the output. (I think it looks slightly nicer without the
'='.)

[1]: http://article.gmane.org/gmane.comp.version-control.git/266902/

> +       git log --min-parents=2 --pretty=tformat:%s >expect_only &&
> +       git log --max-parents=1 --pretty=tformat:%s >expect_hide &&
> +       git log --min-parents=-1 --pretty=tformat:%s >expect_show
> +'
> +
> +test_log_merges() {
> +       expect=expect_$1
> +       config=${2:+-c log.merges=$2}
> +       option=${3:+--merges=$3}
> +       option=${4:-$option}
> +       test_expect_success "merges${config:+ $config}${option:+ $option}" "
> +               git $config log $option --pretty=tformat:%s >actual &&
> +               test_cmp $expect actual
> +       "
> +}
> +
> +states="show only hide"
> +for c in '' $states
> +do
> +       for o in '' $states
> +       do
> +               test_log_merges ${o:-${c:-show}} "$c" "$o"
> +       done
> +done
> +
> +test_log_merges hide show '' --no-merges
> +test_log_merges only hide '' '--merges --max-parents=2'
> +
>  test_expect_success 'log --graph with merge' '
>         git log --graph --date-order --pretty=tformat:%s |
>                 sed "s/ *\$//" >actual &&
> --
> 2.3.3.263.g095251d.dirty
