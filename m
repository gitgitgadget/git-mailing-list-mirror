From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] web--browse: Use powershell on Windows
Date: Sun, 16 Feb 2014 11:07:30 -0500
Message-ID: <CAPig+cSJZE9dedQY2YToJ62kFBtjZhpU9b8qjtMDJqGcZvkBSQ@mail.gmail.com>
References: <1392535347-3008-1-git-send-email-svnpenn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Steven Penny <svnpenn@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 16 17:07:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WF4Fk-0000Px-Pn
	for gcvg-git-2@plane.gmane.org; Sun, 16 Feb 2014 17:07:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801AbaBPQHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Feb 2014 11:07:33 -0500
Received: from mail-la0-f54.google.com ([209.85.215.54]:46417 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049AbaBPQHc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Feb 2014 11:07:32 -0500
Received: by mail-la0-f54.google.com with SMTP id y1so10821575lam.27
        for <git@vger.kernel.org>; Sun, 16 Feb 2014 08:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=CysLc0e7bmxGYwLbll4hgHQW+TdPpcbc5lfKxKKlkGE=;
        b=Tal9XIY/z1zzgTAvLu88QYCMRLugKbyFhxZERozqNdfjWU8FmH8gtU7cv1OzQWkhad
         SvH4H9TJOeJRgpo91Wr5GgNtI3uzH4PMD/r2v6F600KOz2eamrPdLNTX351/KcogFZ1I
         Z5uA1qEutHbFUfX8QURp5VRBh9AS/D2W54c2Q4DG6dcZBbl7ANOaoOk1hVDIQuspPtCV
         aqcfcvRogMz0AuQn8zBZAeW7vQUMidvbdSF26RHYd0p705ilNF+UmIqB53XBTdTcJTXl
         WgBouIxdqUE9WGS2wd5K+FPxpAnUHYPHn7Hx127fayW4Nep/VVp+C1DuMJJYiXPsoaCD
         MttA==
X-Received: by 10.112.45.108 with SMTP id l12mr13194293lbm.21.1392566850594;
 Sun, 16 Feb 2014 08:07:30 -0800 (PST)
Received: by 10.114.181.228 with HTTP; Sun, 16 Feb 2014 08:07:30 -0800 (PST)
In-Reply-To: <1392535347-3008-1-git-send-email-svnpenn@gmail.com>
X-Google-Sender-Auth: -GMHk2O5Gy1PyKXrFwFNzFpNgn4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242232>

On Sun, Feb 16, 2014 at 2:22 AM, Steven Penny <svnpenn@gmail.com> wrote:
> On Windows you can have either MinGW or Cygwin. As has been shown in this script
> MinGW uses "start" while Cygwin uses "cygstart". The "cygstart" command is
> robust but the "start" command breaks on certain URLs
>
>     $ git web--browse 'http://wikipedia.org/wiki/Key_&_Peele'
>     '_Peele' is not recognized as an internal or external command,
>     operable program or batch file.
>
> An alternative is to use PowerShell. PowerShell is a component of Windows and
> will work with both MinGW and Cygwin.
>
> Signed-off-by: Steven Penny <svnpenn@gmail.com>
> ---
> diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
> index 2de575f..02cccf9 100644
> --- a/Documentation/git-web--browse.txt
> +++ b/Documentation/git-web--browse.txt
> @@ -33,8 +33,7 @@ The following browsers (or commands) are currently supported:
>  * lynx
>  * dillo
>  * open (this is the default under Mac OS X GUI)
> -* start (this is the default under MinGW)
> -* cygstart (this is the default under Cygwin)
> +* powershell (this is the default under Windows)
>  * xdg-open
>
>  Custom commands may also be specified.
> diff --git a/git-web--browse.sh b/git-web--browse.sh
> index ebdfba6..72fbe32 100755
> --- a/git-web--browse.sh
> +++ b/git-web--browse.sh
> @@ -34,7 +34,7 @@ valid_tool() {
>         firefox | iceweasel | seamonkey | iceape | \
>         chrome | google-chrome | chromium | chromium-browser | \
>         konqueror | opera | w3m | elinks | links | lynx | dillo | open | \
> -       start | cygstart | xdg-open)
> +       powershell | xdg-open)
>                 ;; # happy
>         *)
>                 valid_custom_tool "$1" || return 1
> @@ -124,13 +124,10 @@ if test -z "$browser" ; then
>         then
>                 browser_candidates="open $browser_candidates"
>         fi
> -       # /bin/start indicates MinGW
> -       if test -x /bin/start; then
> -               browser_candidates="start $browser_candidates"
> -       fi
> -       # /usr/bin/cygstart indicates Cygwin
> -       if test -x /usr/bin/cygstart; then
> -               browser_candidates="cygstart $browser_candidates"
> +       # OS indicates Windows
> +       if test -n "$OS"
> +       then
> +               browser_candidates="powershell $browser_candidates"
>         fi

Doesn't this penalize users who don't have powershell installed?

>         for i in $browser_candidates; do
> @@ -179,11 +176,11 @@ konqueror)
>                 ;;
>         esac
>         ;;
> -w3m|elinks|links|lynx|open|cygstart|xdg-open)
> +w3m|elinks|links|lynx|open|xdg-open)
>         "$browser_path" "$@"
>         ;;
> -start)
> -       exec "$browser_path" '"web-browse"' "$@"
> +powershell)
> +       "$browser_path" saps "'$@'"
>         ;;
>  opera|dillo)
>         "$browser_path" "$@" &
> --
> 1.8.5.3
