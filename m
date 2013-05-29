From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [RFC/PATCH v2 2/8] rebase: cherry-pick: fix mode storage
Date: Tue, 28 May 2013 22:38:23 -0700
Message-ID: <CANiSa6jMb0D0ZYDMHtWD3u9tsY+kuX4Gcxu7L-=ZU3X3WPJzJg@mail.gmail.com>
References: <1369801000-3705-1-git-send-email-felipe.contreras@gmail.com>
	<1369801000-3705-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 07:38:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhZ5i-0001nT-0Y
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 07:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754572Ab3E2FiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 01:38:25 -0400
Received: from mail-we0-f176.google.com ([74.125.82.176]:51565 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754427Ab3E2FiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 01:38:25 -0400
Received: by mail-we0-f176.google.com with SMTP id p58so6067184wes.35
        for <git@vger.kernel.org>; Tue, 28 May 2013 22:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jgLyU44PA0hopLHdQ1v1l58A0qzbOkD1rKpl+8UBF9M=;
        b=PFDpwvkBvcgvINLkKaYt+X9FeAG94h4AN+7/JBp5kifTncaNgG9ho+clPz+l6W1Uqr
         2DbbNDXkkZJ2scqKvvD0zSH98rtJKNXC1PQ4AuUr2Hj8As4jSlBnc5p2vsE26ZI86Ziw
         qMonOhFlHoLBFuhXwDA/KZvKGr0lef7UukH2XFVDauz7FUfoYv/0J8Lj/0uAQKG7wVRR
         AW9vWC/CE4m2F3rRAS3OWj/scorL9dH8q+kTVZUxattUhMb1j0nwRjYvVRcMkW7xOhav
         HLFGieop1TKsVoPZnZGZouXNeOWs59jwBMzSse1l1oiB0BJK+gchGaBpPbFw1HwRZQ8u
         NfhQ==
X-Received: by 10.180.206.77 with SMTP id lm13mr828177wic.18.1369805903887;
 Tue, 28 May 2013 22:38:23 -0700 (PDT)
Received: by 10.180.7.99 with HTTP; Tue, 28 May 2013 22:38:23 -0700 (PDT)
In-Reply-To: <1369801000-3705-3-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225740>

Actually, are all of 2/8 - 7/8 fixes for things that broke in patch 1/8?

On Tue, May 28, 2013 at 9:16 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> We don't use the 'rebase-apply'.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  git-rebase--cherrypick.sh | 4 ++++
>  git-rebase.sh             | 5 ++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/git-rebase--cherrypick.sh b/git-rebase--cherrypick.sh
> index cbf80f9..51354af 100644
> --- a/git-rebase--cherrypick.sh
> +++ b/git-rebase--cherrypick.sh
> @@ -18,6 +18,9 @@ esac
>
>  test -n "$rebase_root" && root_flag=--root
>
> +mkdir "$state_dir" || die "Could not create temporary $state_dir"
> +: > "$state_dir"/cherrypick || die "Could not mark as cherrypick"
> +
>  # we have to do this the hard way.  git format-patch completely squashes
>  # empty commits and even if it didn't the format doesn't really lend
>  # itself well to recording empty patches.  fortunately, cherry-pick
> @@ -32,3 +35,4 @@ then
>  fi
>
>  move_to_original_branch
> +rm -rf "$state_dir"
> diff --git a/git-rebase.sh b/git-rebase.sh
> index f929ca3..76900a0 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -174,6 +174,9 @@ then
>         then
>                 type=interactive
>                 interactive_rebase=explicit
> +       elif test -f "$merge_dir"/cherrypick
> +       then
> +               type=cherrypick
>         else
>                 type=merge
>         fi
> @@ -382,7 +385,7 @@ then
>  elif test -n "$keep_empty"
>  then
>         type=cherrypick
> -       state_dir="$apply_dir"
> +       state_dir="$merge_dir"
>  else
>         type=am
>         state_dir="$apply_dir"
> --
> 1.8.3.rc3.312.g47657de
>
