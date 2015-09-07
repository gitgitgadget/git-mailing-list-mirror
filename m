From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] filter-branch: add passed/remaining seconds on progress
Date: Mon, 7 Sep 2015 16:54:56 -0400
Message-ID: <CAPig+cRRMUhWwxAgVHKpMMne7XiOuYGTi_zgQMB=A+XNGUzLqQ@mail.gmail.com>
References: <1441379798-15453-1-git-send-email-bernat@primeranks.net>
	<1441633928-18035-1-git-send-email-bernat@primeranks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Mikael Magnusson <mikachu@gmail.com>, cbailey32@bloomberg.net,
	Lee.Carver@servicenow.com, Michael Witten <mfwitten@gmail.com>,
	Gabor Bernat <gabor.bernat@gravityrd.com>
To: =?UTF-8?B?R8OhYm9yIEJlcm7DoXQ=?= <bernat@primeranks.net>
X-From: git-owner@vger.kernel.org Mon Sep 07 22:55:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZ3RO-000387-QS
	for gcvg-git-2@plane.gmane.org; Mon, 07 Sep 2015 22:55:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066AbbIGUy7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Sep 2015 16:54:59 -0400
Received: from mail-yk0-f194.google.com ([209.85.160.194]:32993 "EHLO
	mail-yk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180AbbIGUy5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Sep 2015 16:54:57 -0400
Received: by ykdg206 with SMTP id g206so8763190ykd.0
        for <git@vger.kernel.org>; Mon, 07 Sep 2015 13:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=7f6b/HgL4rgeLZlIBaWIfnG8hbCSX+2QKw1E7Cl6yfU=;
        b=mvLaNNICTQf++2L0ae0Is3s1XQT9iV7RzjPC/vz2GQkOBBUUIxCTc4SNVavV49+nN6
         y17PO/dDQQdGnGfmnJS9xe8HoLgX6xGKzFceyV0o8z9n7OGJFnFGzYgry+4A/oQ6JmpV
         ilm1jwrGPOHU+HJXXuDLjt04chaoBQ52yUg5pvvpTAugm/2rocet9byccwfvFuug/RGB
         3UpnY5ruOkcJQKkUwZuEdgKE56aoOeJai0jmpxSnkl8o4lIXCSb4jSSstVIfPqpflk6L
         CRztlQqkIoVogulU3WX3YrQqXNVL5/sv9ZEyd8FxFURxVuccQLEmBNkMdsESP7BvYkpx
         ppeQ==
X-Received: by 10.170.161.85 with SMTP id c82mr22624646ykd.13.1441659296913;
 Mon, 07 Sep 2015 13:54:56 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Mon, 7 Sep 2015 13:54:56 -0700 (PDT)
In-Reply-To: <1441633928-18035-1-git-send-email-bernat@primeranks.net>
X-Google-Sender-Auth: vL7pUcN7B0EO-jjpC-dUJ6LqQWw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277477>

On Mon, Sep 7, 2015 at 9:52 AM, G=C3=A1bor Bern=C3=A1t <bernat@primeran=
ks.net> wrote:
> From: Gabor Bernat <gabor.bernat@gravityrd.com>
>
> adds seconds progress and estimated seconds time if getting the curre=
nt
> timestamp is supported by the date +%s command
>
> Signed-off-by: Gabor Bernat <gabor.bernat@gravityrd.com>
> ---
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index 5b3f63d..565144a 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -275,11 +275,41 @@ commits=3D$(wc -l <../revs | tr -d " ")
>  test $commits -eq 0 && die "Found nothing to rewrite"
>
>  # Rewrite the commits
> +report_progress ()
> +{
> +if test -n "$progress"
> +then

Indent code within the function...

> +       if test $git_filter_branch__commit_count -gt $next_sample_at
> +       then
> +               now_timestamp=3D$(date +%s)
> +               elapsed_seconds=3D$(($now_timestamp - $start_timestam=
p))
> +               remaining_second=3D$(( ($commits - $git_filter_branch=
__commit_count) * $elapsed_seconds / $git_filter_branch__commit_count )=
)
> +               if test $elapsed_seconds -gt 0
> +               then
> +                       next_sample_at=3D$(( ($elapsed_seconds + 1) *=
 $git_filter_branch__commit_count / $elapsed_seconds ))
> +               else
> +                       next_sample_at=3D$(($next_sample_at + 1))
> +               fi
> +               progress=3D" ($elapsed_seconds seconds passed, remain=
ing $remaining_second predicted)"
> +       fi
> +fi
> +printf "\rRewrite $commit ($git_filter_branch__commit_count/$commits=
)$progress"

The "\r" causes this status line to be overwritten each time through,
and since the processed commit count always increases, we know that
the original (without ETA) will never leave junk at the end of the
line. However, with estimated seconds also being displayed, does this
still hold? While it's true that elapsed seconds will increase,
estimated seconds may jump around, requiring different numbers of
digits to display. This may leave "garbage" digits at the end of line
from previous iterations, can't it?

> +}
>
>  git_filter_branch__commit_count=3D0
> +
> +progress=3D start_timestamp=3D
> +if date '+%s' 2>/dev/null | grep -q '^[0-9][0-9]*$'
> +then
> +               next_sample_at=3D0
> +               progress=3D"dummy to ensure this is not empty"
> +               start_timestamp=3D$(date '+%s')
> +fi
> +
>  while read commit parents; do
>         git_filter_branch__commit_count=3D$(($git_filter_branch__comm=
it_count+1))
> -       printf "\rRewrite $commit ($git_filter_branch__commit_count/$=
commits)"
> +
> +       report_progress
>
>         case "$filter_subdir" in
>         "")
> --
> 2.6.0.rc0.3.gb3280a4
