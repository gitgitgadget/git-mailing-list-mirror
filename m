From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/8] rebase: prepare to do generic housekeeping
Date: Fri, 10 May 2013 10:33:49 -0400
Message-ID: <CAPig+cTAEwA10JY56Fe7NyVMRfvtupbG7ThML33SNx4zcX2Ebw@mail.gmail.com>
References: <1368196005-5354-1-git-send-email-artagnon@gmail.com>
	<1368196005-5354-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 10 16:33:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaoOU-0008G1-Ik
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 16:33:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755772Ab3EJOdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 10:33:53 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:41090 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755278Ab3EJOdu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 10:33:50 -0400
Received: by mail-la0-f47.google.com with SMTP id fh20so3981061lab.6
        for <git@vger.kernel.org>; Fri, 10 May 2013 07:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=I+93UE7YO9N8Q4d7ApPkp01sWlZW7MbzleyNza6Cgyw=;
        b=oaCuSyFEvHHJ73Uubib1qgYjlnQhD01yGYkEywLT7Umsrf7QG9OJ5Fz3YJZ1hBLCC8
         7SRH5nqbaNTCaQyNs1AN69c098lJ3edOc4wuHazfGdme2R0q9qUck+a18lfceBPgqogz
         coPSLzT6q5HJjrynRlh5jHtV7VDlG717OUUBGJQTsG/FCG/3iQOB2bvmdhhnDP9wwRIv
         VXlxBfxnmYTbWyvQsszM+cO4qaVDCy06UCbVGn/4IXvLk1IqpFBGE1xatvIHVQ11dymk
         owYK0Idct4TOymKN1HiUz7e7uHxIrBrYuPpyI6GKy6RrmHnPYvxwHp/AM2iSE5Bck1nF
         FKpg==
X-Received: by 10.112.125.232 with SMTP id mt8mr4813419lbb.55.1368196429124;
 Fri, 10 May 2013 07:33:49 -0700 (PDT)
Received: by 10.114.181.3 with HTTP; Fri, 10 May 2013 07:33:49 -0700 (PDT)
In-Reply-To: <1368196005-5354-5-git-send-email-artagnon@gmail.com>
X-Google-Sender-Auth: 8_WFu4oalL3_b769Os7h3Pa-ZCY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223853>

On Fri, May 10, 2013 at 10:26 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> On successful completion of a rebase in git-rebase--$backend.sh, the
> $backend script cleans up on its own and exits.  The cleanup routine
> is however, independent of the $backend, and each $backend script
> unnecessarily duplicates this work:
>
>     rm -rf "$state_dir"
>     git gc --auto
>
> Prepare git-rebase.sh for later patches that return control from each
> $backend script back to us, for performing this generic cleanup
> routine.
>
> Another advantage is that git-rebase.sh can implement a generic
> finish_rebase() to possibly do additional tasks in addition to the
> cleanup.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  git-rebase.sh | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 2c692c3..84dc7b0 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -150,6 +150,13 @@ run_specific_rebase () {
>                 autosquash=
>         fi
>         . git-rebase--$type
> +       ret=$?
> +       if test $ret = 0

For numeric comparison, use '-eq' rather than '=', which is for strings.

> +       then
> +               git gc --auto &&
> +               rm -rf "$state_dir"
> +       fi
> +       exit $ret
>  }
>
>  run_pre_rebase_hook () {
