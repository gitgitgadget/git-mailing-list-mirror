From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/1] gitk: add --cwd=path commandline parameter to change path
Date: Tue, 3 Nov 2015 13:27:00 -0500
Message-ID: <CAPig+cSs0v88AiQwSrqm-wK7rY4RdykaVf5Axh5jFyij25rfvg@mail.gmail.com>
References: <1446562842-8478-1-git-send-email-juhapekka.heikkila@gmail.com>
	<1446562842-8478-2-git-send-email-juhapekka.heikkila@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 19:28:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtgIb-0000Yu-17
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 19:27:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754460AbbKCS1E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 13:27:04 -0500
Received: from mail-yk0-f171.google.com ([209.85.160.171]:35172 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbbKCS1B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 13:27:01 -0500
Received: by ykek133 with SMTP id k133so30652212yke.2
        for <git@vger.kernel.org>; Tue, 03 Nov 2015 10:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=azrhHjthGNTyLN/v/C8tBUmzceSDlH8rVytmmQkJ16w=;
        b=HY78iiogEL+Q9frxCLXPDNTYUB2kTAODkf1itwkn/6XR1XX25WdId8VtXk7wtB2Wln
         I7jlR6LU0ZNr40h9bMZG2el/8G8oTKkeNhCJ4AnNKM9erFQB5p9T0DP4qz0E1IR7+vHc
         /p/GD4qX8PMWKzIFVCUEHyfRaEO0M448pgu70gGbsn2NMcmVc8h0aOg97648TxJsIPAK
         X/ZyUBBXE/BdAE7eZs/5CMdDiJ0Vqp3gC2+rb9QfdRBlvJKtYSX7SeuLEICqW1KN41SV
         0ZrW/AmoIkpIelrnn1oKnrTVMa9GMKF410WqBvHzGn9dPjaI/EvKaAKRkoqhPNu14t6t
         e84A==
X-Received: by 10.31.160.79 with SMTP id j76mr554737vke.37.1446575220471; Tue,
 03 Nov 2015 10:27:00 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Tue, 3 Nov 2015 10:27:00 -0800 (PST)
In-Reply-To: <1446562842-8478-2-git-send-email-juhapekka.heikkila@gmail.com>
X-Google-Sender-Auth: s14gRI6Z08KT6lGUZ0EhU3OqTIg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280808>

On Tue, Nov 3, 2015 at 10:00 AM, Juha-Pekka Heikkila
<juhapekka.heikkila@gmail.com> wrote:
> This patch adds --cwd (change working directory) parameter to
> gitk. With this parameter, instead of need to cd to directory
> with .git folder, one can point the correct folder from
> commandline.

git itself supports this sort of functionality via -C, as does GNU
tar, which suggests such an option in gitk should be named -C, as
well.

> Signed-off-by: Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>
> ---
> diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
> @@ -146,6 +146,11 @@ gitk-specific options
>         Select the specified commit after loading the graph.
>         Default behavior is equivalent to specifying '--select-commit=HEAD'.
>
> +--cwd=<path>::
> +
> +       Change working direcoty to <path>. If the git tree exist elsewhere

s/direcoty/directory/

> +       gitk first cd to given path before start to operate.

Taking git's -C documentation as a template, perhaps this could be
written instead as:

    Run as if gitk was started in '<path>' instead of the current
    working directory. When multiple `-C` options are given, each
    subsequent non-absolute `-C <path>` is interpreted relative to
    the preceding `-C <path>`.

This description correctly reflects your implementation which allows
--cwd to be specified multiple times.

>  Examples
>  --------
>  gitk v2.6.12.. include/scsi drivers/scsi::
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index fcc606e..5fdf459 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -12279,12 +12279,6 @@ setui $uicolor
>
>  setoptions
>
> -# check that we can find a .git directory somewhere...
> -if {[catch {set gitdir [exec git rev-parse --git-dir]}]} {
> -    show_error {} . [mc "Cannot find a git repository here."]
> -    exit 1
> -}
> -
>  set selecthead {}
>  set selectheadid {}
>
> @@ -12305,6 +12299,9 @@ foreach arg $argv {
>         "--argscmd=*" {
>             set revtreeargscmd [string range $arg 10 end]
>         }
> +       "--cwd=*" {
> +           cd [string range $arg 6 end]
> +       }
>         default {
>             lappend revtreeargs $arg
>         }
> @@ -12312,6 +12309,12 @@ foreach arg $argv {
>      incr i
>  }
>
> +# check that we can find a .git directory somewhere...
> +if {[catch {set gitdir [exec git rev-parse --git-dir]}]} {
> +    show_error {} . [mc "Cannot find a git repository here."]
> +    exit 1
> +}
> +
>  if {$selecthead eq "HEAD"} {
>      set selecthead {}
>  }
> --
> 1.9.1
