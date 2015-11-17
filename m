From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 2/2] completion: add support for completing email aliases
Date: Tue, 17 Nov 2015 03:10:12 -0500
Message-ID: <CAPig+cT0VmKQm5x9Q2QUyLr=-e0VN53d-O5Cw2CPB=gYz6SUQA@mail.gmail.com>
References: <1447720166-9941-1-git-send-email-jacob.e.keller@intel.com>
	<1447720166-9941-2-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	"Shawn O . Pearce" <spearce@spearce.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Lee Marlow <lee.marlow@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 09:10:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZybLT-00070g-6o
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 09:10:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757AbbKQIKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 03:10:15 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:34588 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847AbbKQIKN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 03:10:13 -0500
Received: by vkgy188 with SMTP id y188so68058vkg.1
        for <git@vger.kernel.org>; Tue, 17 Nov 2015 00:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Ptdb95EsyG6KKEllsl//pi6kfgx3vzdtribALyHQJJU=;
        b=p+3Qn6ov5YOG7yPrMTgs+YnEIZndEqVLbTSfIh1HewScWqI/5aRB/sOifpeUozw8Cb
         WlyPCS2sY5oAN93pm+EYbMgdoH4dmpW9QM8jUM90rnGrAkaeh55i2eBFmt7OcM+cNNt7
         f3i3fVI3qOgQQvarhlA39tHjs7qFCCwq/RJX1RbNQ3zbJkjKapInkGceyRQYgkzg8F3/
         QC3+GUrj7Z3tuvVEp8yQjwYrQMXeLjFl+h47HoTHKfoVgusw9eVL/L+kYS6a8dBpQ2/0
         gWR8X88lWU7OCJ5N9SI5UK7zsoX9VdAvr0op0ZSh8xICEeQkgGTdUVuDl1tD/Mv9v5Ph
         jJUw==
X-Received: by 10.31.2.70 with SMTP id 67mr2091347vkc.19.1447747812765; Tue,
 17 Nov 2015 00:10:12 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Tue, 17 Nov 2015 00:10:12 -0800 (PST)
In-Reply-To: <1447720166-9941-2-git-send-email-jacob.e.keller@intel.com>
X-Google-Sender-Auth: YdzMIfC-8PFQ27xkJFcGltXvWmQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281385>

On Mon, Nov 16, 2015 at 7:29 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> Using the new --dump-alias-names option from git-send-email, add completion

s/dump-alias-names/dump-aliases/

> for --to, --cc, and --bcc with the available configured aliases.

"--from" is missing from this list.

> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> @@ -1709,8 +1710,25 @@ _git_reflog ()
>  __git_send_email_confirm_options="always never auto cc compose"
>  __git_send_email_suppresscc_options="author self cc bodycc sob cccmd body all"
>
> +__git_get_email_aliases ()
> +{
> +       git --git-dir="$(__gitdir)" send-email --dump-aliases 2>/dev/null | while read alias expansion
> +       do
> +               echo $alias
> +       done
> +}
> +
>  _git_send_email ()
>  {
> +       case "$prev" in
> +       --to|--cc|--bcc|--from)
> +               __gitcomp "
> +               $(__git_get_email_aliases)
> +               " "" ""
> +               return
> +               ;;
> +       esac
> +
>         case "$cur" in
>         --confirm=*)
>                 __gitcomp "
> @@ -1735,6 +1753,12 @@ _git_send_email ()
>                         " "" "${cur##--thread=}"
>                 return
>                 ;;
> +       --to=*|--cc=*|--bcc=*|--from=*)
> +               __gitcomp "
> +               $(__git_get_email_aliases)
> +               " "" "${cur#--*=}"
> +               return
> +               ;;
>         --*)
>                 __gitcomp "--annotate --bcc --cc --cc-cmd --chain-reply-to
>                         --compose --confirm= --dry-run --envelope-sender
> --
> 2.6.3.491.g3e3f6ce
