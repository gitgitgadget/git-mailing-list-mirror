From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] git-prompt.zsh: introduce thin ZSH wrapper
Date: Sat, 11 May 2013 16:26:52 -0500
Message-ID: <CAMP44s1pO+ytNWEV6ykRn671yf50+oMZQMnrcTN+s5ykPRpumg@mail.gmail.com>
References: <1368289513-8700-1-git-send-email-artagnon@gmail.com>
	<1368289513-8700-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 11 23:27:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbHJi-0008TJ-Jv
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 23:26:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754532Ab3EKV0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 17:26:54 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:48539 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754482Ab3EKV0y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 17:26:54 -0400
Received: by mail-la0-f47.google.com with SMTP id fh20so4946408lab.6
        for <git@vger.kernel.org>; Sat, 11 May 2013 14:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=sSnrpXO/NFL2XBhGMChfk+CgYK7ktLmTAHUUX6MQA6s=;
        b=ZVUQQ3dwLvIRbtnB/POflwlLrQMCbxrBkm39s8Tae5RI09/dLVfkrZwWAQ16cv+1BO
         n5elpFB67NKrd9rp95vXlqDfP3tBqEbQ+VpTMP1SKCKHT9vBjr9+bE69l0sQ5xFnOAZu
         sFQPEqBtwxKwBTm5fLCDldpY8IOEm61Yw0OQowyp5QgfLuzs31WcgPDTcMhsV2fNF9gM
         13NpG51Grs3ScqTz2a2Jd4LuAq4GA15uFc0+ISM9HqlFVTQ1b9fCCRIU/armgF2FHP1C
         844fD6iXT13WvrPuJWBfrH6mO2Pf0juFZKeWTExVBIEjkDM4YgWYliNc+cr/AKvwiGUN
         pDgg==
X-Received: by 10.112.135.70 with SMTP id pq6mr10178561lbb.82.1368307612505;
 Sat, 11 May 2013 14:26:52 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Sat, 11 May 2013 14:26:52 -0700 (PDT)
In-Reply-To: <1368289513-8700-3-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224013>

On Sat, May 11, 2013 at 11:25 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> To facilitate a colored prompt in ZSH, write a thin wrapper around
> git-prompt.sh, factoring out and overriding the coloring logic.  Since
> ZSH lacks a PROMPT_COMMAND, instruct the user to execute __git_ps1
> inside precmd().

I think this is two logical changes into one.

> --- /dev/null
> +++ b/contrib/completion/git-prompt.zsh
> @@ -0,0 +1,59 @@
> +# git prompt support for zsh: wrapper around git-prompt.sh
> +#
> +# To enable:
> +#
> +#    1) Copy this file and git-prompt.sh to ~/.zsh/prompt
> +#    2) Add the following lines to your .zshrc:
> +#
> +#          source ~/.zsh/prompt/git-prompt.zsh
> +#          GIT_PS1_SHOWCOLORHINTS=true
> +#          precmd () { __git_ps1 "%n|" ":%~$ " "%s" }
> +#
> +#    3) You can now add the following to ~/.zshrc and expect the
> +#       characters to be displayed in color:
> +#
> +#          GIT_PS1_DESCRIBE_STYLE=branch
> +#          GIT_PS1_SHOWUPSTREAM=auto
> +#          GIT_PS1_SHOWDIRTYSTATE=true
> +#          GIT_PS1_SHOWUNTRACKEDFILES=true
> +
> +test -z "$script" && script="$(dirname ${funcsourcetrace[1]%:*})"/git-prompt.sh
> +ZSH_VERSION='' . "$script"

I've been thinking that this method of loading the script is not the
best; we should probably have a list of locations where distributions
usually put this file. So if we could avoid the creation of of a new
file, that would be great.

> +autoload colors
> +colors
> +
> +__git_ps1_colorize_gitstring ()
> +{
> +       local c_red='%F{red}'
> +       local c_green='%F{green}'
> +       local c_lblue='%F{blue}'
> +       local c_clear='%f'
> +       local bad_color=$c_red
> +       local ok_color=$c_green
> +       local branch_color="$c_clear"
> +       local flags_color="$c_lblue"
> +       local branchstring="$c${b##refs/heads/}"

This is the only real difference with bash colors, no? I think it's
overkill to create a new file, and load the old one, only to override
part of a function. We should probably start with everything in the
same file, and only later if we find it's necessary, split.

> +       if [ $detached = no ]; then
> +               branch_color="$ok_color"
> +       else
> +               branch_color="$bad_color"
> +       fi
> +
> +       gitstring="$branch_color$branchstring$c_clear"
> +
> +       if [ "$w" = "*" ]; then
> +               gitstring="$gitstring$bad_color$w"
> +       fi
> +       if [ -n "$i" ]; then
> +               gitstring="$gitstring$ok_color$i"
> +       fi
> +       if [ -n "$s" ]; then
> +               gitstring="$gitstring$flags_color$s"
> +       fi
> +       if [ -n "$u" ]; then
> +               gitstring="$gitstring$bad_color$u"
> +       fi
> +       gitstring="$gitstring$c_clear$r$p"
> +}
> --

-- 
Felipe Contreras
